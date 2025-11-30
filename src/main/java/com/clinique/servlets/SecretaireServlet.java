package com.clinique.servlets;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.clinique.beans.*;
import com.clinique.dao.DAOException;
import com.clinique.dao.DAOFactory;
import com.clinique.daoImpl.*;

@WebServlet(urlPatterns = { "/secretaire/*" })
public class SecretaireServlet extends HttpServlet {

    private PatientDAOImpl patientDAO;
    private MedecinDAOImpl medecinDAO;
    private RendezVousDAOImpl rdvDAO;
    private SpecialiteDAOImpl specialiteDAO;
    private UserDAOImpl userDAO;

    @Override
    public void init() {
        DAOFactory daoFactory = DAOFactory.getInstance();
        patientDAO = new PatientDAOImpl(daoFactory);
        medecinDAO = new MedecinDAOImpl(daoFactory);
        rdvDAO = new RendezVousDAOImpl(daoFactory);
        specialiteDAO = new SpecialiteDAOImpl(daoFactory);
        userDAO = new UserDAOImpl(daoFactory);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        String action = request.getPathInfo();

        // ======== Déconnexion ========
        if ("/logout".equals(action)) {
            if (session != null) session.invalidate();
            response.sendRedirect(request.getContextPath() + "/Acceuil");
            return;
        }


       if ("".equals(action) || "/dashboard".equals(action) || action == null) {

            try {
                request.setAttribute("totalRdv",         rdvDAO.countAll());
                request.setAttribute("totalPatients",    patientDAO.countAll());
                request.setAttribute("totalMedecins",    medecinDAO.countAll());
                request.setAttribute("totalSpecialites", specialiteDAO.countAll());
                request.setAttribute("derniersRdv",      rdvDAO.getDerniersRdv(3)); 

            } catch (Exception e) {
                e.printStackTrace();
            }

            request.getRequestDispatcher("/views/secretaire/dashboard.jsp").forward(request, response);
            return;
        }
       
        if ("/rendezvous".equals(action)) {

            String subAction = request.getParameter("action");
            String idRdvStr = request.getParameter("idRdv");


            if (subAction != null && idRdvStr != null) {
                try {
                    int rdvId = Integer.parseInt(idRdvStr);

                    switch (subAction) {
                        case "confirmer":
                            rdvDAO.setEtat(rdvId, "CONFIRME");
                            session.setAttribute("successMessage", "Rendez-vous confirmé avec succès !");
                            break;
                        case "annuler":
                            rdvDAO.setEtat(rdvId, "ANNULE");
                            session.setAttribute("successMessage", "Rendez-vous annulé.");
                            break;
                        case "terminer":
                            rdvDAO.setEtat(rdvId, "TERMINE");
                            session.setAttribute("successMessage", "Rendez-vous marqué comme terminé.");
                            break;
                        default:
                            session.setAttribute("errorMessage", "Action inconnue.");
                            break;
                    }

               
                    response.sendRedirect(request.getContextPath() + "/secretaire/rendezvous");
                    return;

                } catch (NumberFormatException e) {
                    session.setAttribute("errorMessage", "ID du rendez-vous invalide.");
                    response.sendRedirect(request.getContextPath() + "/secretaire/rendezvous");
                    return;
                } catch (DAOException e) {
                    session.setAttribute("errorMessage", "Erreur base de données : " + e.getMessage());
                    response.sendRedirect(request.getContextPath() + "/secretaire/rendezvous");
                    return;
                } catch (Exception e) {
                    session.setAttribute("errorMessage", "Une erreur est survenue.");
                    response.sendRedirect(request.getContextPath() + "/secretaire/rendezvous");
                    return;
                }
            }

            // === 2. Affichage normal de la liste ===
            try {
                List<RendezVous> rdvs = rdvDAO.getAllWithDetails();
                request.setAttribute("rdvs", rdvs);
            } catch (DAOException e) {
                session.setAttribute("errorMessage", "Impossible de charger les rendez-vous.");
                request.setAttribute("rdvs", new ArrayList<RendezVous>()); 
            }

       
            request.getRequestDispatcher("/views/secretaire/rendezvous.jsp").forward(request, response);
            return;
        }
        if ("/specialites".equals(action)) {

            String subAction = request.getParameter("action");
            String idStr = request.getParameter("id");

         
            if (subAction != null) {
                try {
                    if ("supprimer".equals(subAction) && idStr != null) {
                        specialiteDAO.supprimer(Integer.parseInt(idStr));
                        session.setAttribute("successMessage", "Spécialité supprimée avec succès.");
                    }
                    else if ("ajouter".equals(subAction)) {
                        String nom = request.getParameter("nomSpecialite");
                        if (nom != null && !nom.trim().isEmpty()) {
                            Specialite s = new Specialite();
                            s.setNom(nom.trim());
                            specialiteDAO.ajouter(s);
                            session.setAttribute("successMessage", "Spécialité ajoutée avec succès !");
                        }
                    }
                    else if ("modifier".equals(subAction) && idStr != null) {
                        String nom = request.getParameter("nomSpecialite");
                        if (nom != null && !nom.trim().isEmpty()) {
                            Specialite s = new Specialite();
                            s.setIdSpecialite(Integer.parseInt(idStr));
                            s.setNom(nom.trim());
                            specialiteDAO.modifier(s);
                            session.setAttribute("successMessage", "Spécialité modifiée avec succès !");
                        }
                    }

                    response.sendRedirect(request.getContextPath() + "/secretaire/specialites");
                    return;

                } catch (Exception e) {
                    session.setAttribute("errorMessage", "Erreur : " + e.getMessage());
                    response.sendRedirect(request.getContextPath() + "/secretaire/specialites");
                    return;
                }
            }

            try {
                request.setAttribute("specialites", specialiteDAO.getAll());
            } catch (DAOException e) {
                session.setAttribute("errorMessage", "Impossible de charger les spécialités.");
            }

            request.getRequestDispatcher("/views/secretaire/specialites.jsp").forward(request, response);
            return;
        }


        if ("/patients".equals(action)) {

        
            String subAction = request.getParameter("action");
            String idStr = request.getParameter("id");

            if ("supprimer".equals(subAction) && idStr != null) {
                try {
                    int patientId = Integer.parseInt(idStr);
                    patientDAO.deletePatient(patientId);
                    session.setAttribute("successMessage", "Patient supprimé avec succès.");
                } catch (NumberFormatException e) {
                    session.setAttribute("errorMessage", "ID patient invalide.");
                } catch (DAOException e) {
                    session.setAttribute("errorMessage", "Erreur lors de la suppression : " + e.getMessage());
                }
                response.sendRedirect(request.getContextPath() + "/secretaire/patients");
                return;
            }

      
            try {
                List<Patient> patients = patientDAO.getAllPatients();
                request.setAttribute("patients", patients);
            } catch (DAOException e) {
                session.setAttribute("errorMessage", "Impossible de charger la liste des patients.");
                request.setAttribute("patients", new ArrayList<Patient>());
            }

            request.getRequestDispatcher("/views/secretaire/patients.jsp").forward(request, response);
            return;
        }
      
        if ("/medecins".equals(action)) {

            String subAction = request.getParameter("action");
            if ("ajouter".equals(subAction) && request.getMethod().equals("POST")) {
                try {
                    Medecin medecin = new Medecin();
                    medecin.setPrenom(request.getParameter("prenom").trim());
                    medecin.setNom(request.getParameter("nom").trim());
                    medecin.setTel(request.getParameter("telephone").trim());
                    
                  
                    medecin.setEmail(medecin.getPrenom().toLowerCase() + "." + medecin.getNom().toLowerCase() + "@clinique.com");
                    medecin.setLogin(medecin.getPrenom().toLowerCase().charAt(0) + "." + medecin.getNom().toLowerCase());
                    medecin.setPassword("12345678"); // Mot de passe par défaut (à changer après)
                    medecin.setAdresse("Non renseignée");
                    medecin.setDateDeNaissance(null);
                    medecin.setCin(null);

                    String specIdStr = request.getParameter("specialite");
                    if (specIdStr != null && !specIdStr.isEmpty()) {
                        medecin.setIdSpecialite(Integer.parseInt(specIdStr));
                    }

                    medecinDAO.createMedecin(medecin); 
                    session.setAttribute("successMessage", "Médecin ajouté avec succès ! Login : " + medecin.getLogin() + " | MDP : 12345678");

                    response.sendRedirect(request.getContextPath() + "/secretaire/medecins");
                    return;

                } catch (Exception e) {
                    session.setAttribute("errorMessage", "Erreur lors de l'ajout du médecin : " + e.getMessage());
                    response.sendRedirect(request.getContextPath() + "/secretaire/medecins");
                    return;
                }
            }

            List<Medecin> medecins = medecinDAO.getAllMedecinsWithSpecialite();
            request.setAttribute("medecins", medecins);
            request.setAttribute("specialites", specialiteDAO.getAll());
            request.getRequestDispatcher("/views/secretaire/medecins.jsp").forward(request, response);
            return;
        }

        if ("/profil".equals(action)) {

            User secretaire = (User) session.getAttribute("user");

          
            request.getRequestDispatcher("/views/secretaire/profil.jsp").forward(request, response);
            return;
        }

        response.sendError(HttpServletResponse.SC_NOT_FOUND);
    }
  


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String action = request.getPathInfo();

      
        if ("/profil".equals(action)) {

            User secretaire = (User) session.getAttribute("user");
            if (secretaire == null) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            try {
              
                secretaire.setPrenom(request.getParameter("prenom").trim());
                secretaire.setNom(request.getParameter("nom").trim());
                secretaire.setEmail(request.getParameter("email").trim());
                secretaire.setTel(request.getParameter("telephone").trim());
                
                String adresse = request.getParameter("adresse");
                secretaire.setAdresse(adresse != null ? adresse.trim() : "");

              
                userDAO.update(secretaire);

       
                session.setAttribute("user", secretaire);

                session.setAttribute("successMessage", "Profil mis à jour avec succès !");

            } catch (Exception e) {
                session.setAttribute("errorMessage", "Erreur lors de la mise à jour du profil : " + e.getMessage());
            }

         
            response.sendRedirect(request.getContextPath() + "/secretaire/profil");
            return;
        }

   
        doGet(request, response);
    }
}