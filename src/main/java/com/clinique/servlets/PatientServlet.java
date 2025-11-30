package com.clinique.servlets;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.clinique.beans.Patient;
import com.clinique.beans.RapportMedical;
import com.clinique.beans.User;
import com.clinique.beans.Medecin;
import com.clinique.beans.Specialite;
import com.clinique.beans.RendezVous;
import com.clinique.dao.DAOFactory;
import com.clinique.daoImpl.PatientDAOImpl;
import com.clinique.daoImpl.RapportDAOImpl;
import com.clinique.daoImpl.SpecialiteDAOImpl;
import com.clinique.daoImpl.MedecinDAOImpl;
import com.clinique.daoImpl.RendezVousDAOImpl;

@WebServlet(urlPatterns = {"/patient/*"})
public class PatientServlet extends HttpServlet {
    private PatientDAOImpl patientDAO;
    private SpecialiteDAOImpl specialiteDAO;
    private MedecinDAOImpl medecinDAO;
    private RendezVousDAOImpl rdvDAO;
    private RapportDAOImpl rapportDAO;

    @Override
    public void init() {
        DAOFactory daoFactory = DAOFactory.getInstance();
        patientDAO = new PatientDAOImpl(daoFactory);
        specialiteDAO = new SpecialiteDAOImpl(daoFactory);
        medecinDAO = new MedecinDAOImpl(daoFactory);
        rdvDAO = new RendezVousDAOImpl(daoFactory);
        rapportDAO = new RapportDAOImpl(daoFactory);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        String action = request.getPathInfo();
        if (user == null && !"/logout".equals(action)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        if ("/logout".equals(action)) {
            if (session != null) session.invalidate();
            response.sendRedirect(request.getContextPath() + "/Acceuil");
            return;
        }

        if (action == null || "/".equals(action) || "/dashboard".equals(action)) {
            request.setAttribute("user", user);
            request.getRequestDispatcher("/views/patient/dashboard.jsp").forward(request, response);
            return;
        }
   
        if ("/prendre-rdv".equals(action)) {
         
            List<Specialite> specialites = specialiteDAO.getAll();
            request.setAttribute("specialites", specialites);
     
            String specialiteId = request.getParameter("specialiteId");
            if (specialiteId != null && !specialiteId.isEmpty()) {
                int idSpec = Integer.parseInt(specialiteId);
                List<Medecin> medecins = medecinDAO.getBySpecialite(idSpec);
                request.setAttribute("medecins", medecins);
                request.setAttribute("selectedSpecialite", idSpec);
            }
            Patient p = patientDAO.findByIdPatient(user.getId());
            request.setAttribute("patient", p);
            request.getRequestDispatcher("/views/patient/prendreRdv.jsp").forward(request, response);
            return;
        }

        if ("/mes-rdv".equals(action)) {
            try {
                int patientId = user.getId();
         
                Patient p = patientDAO.findByIdPatient(patientId);
                List<RendezVous> rdvs = rdvDAO.getByPatient(patientId);
                List<Medecin> medecins = medecinDAO.getAllMedecins();
                List<Specialite> specialites = specialiteDAO.getAll();
                request.setAttribute("patient", p);
                request.setAttribute("rdvs", rdvs);
                request.setAttribute("medecins", medecins);
                request.setAttribute("specialites", specialites);
                request.getRequestDispatcher("/views/patient/mes-rdv.jsp").forward(request, response);
                return;
            } catch (Exception e) {
                e.printStackTrace();
                response.sendError(500, "Impossible d'afficher vos rendez-vous.");
                return;
            }
        }
        if ("/resultats".equals(action)) {
            try {
                int patientId = user.getId();
                List<RapportMedical> rapportsPatient = rapportDAO.getRapportsPatientAvecDetails(patientId);

                request.setAttribute("rapportsPatient", rapportsPatient);
                request.getRequestDispatcher("/views/patient/mes-resultats.jsp").forward(request, response);
                return;
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Impossible de charger vos résultats médicaux.");
                request.getRequestDispatcher("/views/patient/dashboard.jsp").forward(request, response);
                return;
            }
        }


        if ("/profile".equals(action)) {
            Patient patient = patientDAO.findByIdPatient(user.getId());
            request.setAttribute("patient", patient);
            request.getRequestDispatcher("/views/patient/profile.jsp").forward(request, response);
            return;
        }
        if ("/contact".equals(action)) {
            try {
            
                Patient p = patientDAO.findByIdPatient(user.getId());
                request.setAttribute("patient", p);
            
                System.out.println("DEBUG: Accès contact pour patient ID=" + (p != null ? p.getId() : "NULL"));
                request.getRequestDispatcher("/views/patient/contact.jsp").forward(request, response);
                return;
            } catch (Exception e) {
                e.printStackTrace();
                response.sendError(500, "Impossible d'accéder à la page contact.");
                return;
            }
        }

        response.sendError(HttpServletResponse.SC_NOT_FOUND);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    	HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        String action = request.getPathInfo();

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        if ("/profile".equals(action)) {
            Patient patient = patientDAO.findByIdPatient(user.getId());

            patient.setNom(request.getParameter("nom"));
            patient.setPrenom(request.getParameter("prenom"));
            patient.setEmail(request.getParameter("email"));
            patient.setTel(request.getParameter("tel"));
            patient.setAdresse(request.getParameter("adresse"));
            patient.setCin(request.getParameter("cin"));

            String dateStr = request.getParameter("dateNaissance");
            if (dateStr != null && !dateStr.isEmpty()) {
                patient.setDateDeNaissance(java.sql.Date.valueOf(dateStr));
            }

            String newPass = request.getParameter("password");
            if (newPass != null && !newPass.trim().isEmpty()) {
                String confirm = request.getParameter("passwordConfirm");
                if (!newPass.equals(confirm)) {
                    request.setAttribute("error", "Les mots de passe ne correspondent pas.");
                } else {
                    patient.setPassword(newPass);
                }
            }

            patientDAO.updatePatient(patient);
            session.setAttribute("user", patient);

            request.setAttribute("success", "Profil mis à jour avec succès !");
            request.setAttribute("patient", patient);
            request.getRequestDispatcher("/views/patient/profile.jsp").forward(request, response);
            return;
        }
        
        if ("/prendre-rdv".equals(action)) {
            try {
                int patientId = user.getId();
                int medecinId = Integer.parseInt(request.getParameter("medecinId"));
                LocalDate dateRdv = LocalDate.parse(request.getParameter("dateRdv"));
                LocalTime heureRdv = LocalTime.parse(request.getParameter("heureRdv"));
                // Vérification disponibilité
                boolean libre = rdvDAO.estDisponible(medecinId, dateRdv, heureRdv);
                if (!libre) {
                    request.setAttribute("error", "Ce créneau est déjà réservé pour ce médecin.");
                    doGet(request, response);
                    return;
                }
            
                RendezVous rdv = new RendezVous();
                rdv.setIdPatient(patientId);
                rdv.setIdMedecin(medecinId);
                rdv.setDate(dateRdv);
                rdv.setHeure(heureRdv);
                rdv.setEtat("EN_ATTENTE");
                rdvDAO.ajouter(rdv);
                response.sendRedirect(request.getContextPath() + "/patient/mes-rdv");
                return;
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Erreur lors de la prise du rendez-vous.");
                doGet(request, response);
                return;
            }
        }

        // TODO: Ajoutez ici doPost pour /contact si formulaire plus tard (ex. envoi email)

        response.sendError(HttpServletResponse.SC_NOT_FOUND);
    }
}