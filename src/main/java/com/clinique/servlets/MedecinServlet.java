package com.clinique.servlets;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.clinique.beans.*;
import com.clinique.dao.DAOFactory;
import com.clinique.daoImpl.MedecinDAOImpl;
import com.clinique.daoImpl.PatientDAOImpl;
import com.clinique.daoImpl.RendezVousDAOImpl;
import com.clinique.daoImpl.SpecialiteDAOImpl;
import com.clinique.fascade.RapportDAO;


@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,   
    maxFileSize = 1024 * 1024 * 10,        
    maxRequestSize = 1024 * 1024 * 50      
)
@WebServlet(urlPatterns = {"/medecin/*"})
public class MedecinServlet extends HttpServlet {

    private RendezVousDAOImpl rdvDAO;
    private PatientDAOImpl patientDAO;
    private RapportDAO rapportDAO;
    private MedecinDAOImpl medecinDAO;
    private SpecialiteDAOImpl specialiteDAO;

    @Override
    public void init() {
        DAOFactory daoFactory = DAOFactory.getInstance();
        rdvDAO = new RendezVousDAOImpl(daoFactory);
        patientDAO = new PatientDAOImpl(daoFactory);
        rapportDAO = daoFactory.getRapportDAO();
        medecinDAO = new MedecinDAOImpl(daoFactory);     
        specialiteDAO = new SpecialiteDAOImpl(daoFactory); 
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/Login");
            return;
        }

        String action = request.getPathInfo();

        if ("/logout".equals(action)) {
            if (session != null) session.invalidate();
            response.sendRedirect(request.getContextPath() + "/Acceuil");
            return;
        }

        if (action == null || "/".equals(action) || "/dashboard".equals(action)) {
            try {
                List<RendezVous> rdvs = rdvDAO.getByMedecin(user.getId());
                long totalRdv = rdvs.size();
                long rdvConfirme = rdvs.stream().filter(r -> "CONFIRME".equalsIgnoreCase(r.getEtat())).count();
                long rdvEnAttente = rdvs.stream().filter(r -> "EN_ATTENTE".equalsIgnoreCase(r.getEtat())).count();
                List<Patient> patients = patientDAO.getAllPatients();

                request.setAttribute("rdvs", rdvs);
                request.setAttribute("patients", patients);
                request.setAttribute("totalRdv", totalRdv);
                request.setAttribute("rdvConfirme", rdvConfirme);
                request.setAttribute("rdvEnAttente", rdvEnAttente);
                request.getRequestDispatcher("/views/medecin/dashboard.jsp").forward(request, response);
                return;
            } catch (Exception e) {
                e.printStackTrace();
                response.sendError(500, "Erreur lors de la récupération des rendez-vous.");
                return;
            }
        }

    
        if ("/mes-rdv".equals(action)) {
            try {
                List<RendezVous> rdvs = rdvDAO.getByMedecin(user.getId());
                List<Patient> patients = patientDAO.getAllPatients();
                request.setAttribute("rdvs", rdvs);
                request.setAttribute("patients", patients);
                request.getRequestDispatcher("/views/medecin/mes-rdv.jsp").forward(request, response);
                return;
            } catch (Exception e) {
                e.printStackTrace();
                response.sendError(500, "Erreur lors de la récupération des rendez-vous.");
                return;
            }
        }
        
        

        if ("/patients".equals(action)) {
            try {
                List<Patient> patients = patientDAO.getByMedecin(user.getId());
                for (Patient p : patients) {
                    int nb = rdvDAO.countByPatient(p.getId());
                    p.setNbRdv(nb);
                }
                request.setAttribute("patients", patients);
                request.setAttribute("totalPatients", patients.size());
                request.getRequestDispatcher("/views/medecin/patients.jsp").forward(request, response);
                return;
            } catch (Exception e) {
                e.printStackTrace();
                response.sendError(500, "Erreur lors de la récupération des patients.");
                return;
            }
        }

        if ("/rapports".equals(action)) {
            try {
                List<RapportMedical> rapports = rapportDAO.getByMedecin(user.getId());
                request.setAttribute("rapports", rapports);
                request.setAttribute("totalRapports", rapports.size());
                request.getRequestDispatcher("/views/medecin/rapports.jsp").forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Impossible de charger les rapports");

            }
            return;
        }



        if ("/rediger-rapport".equals(action) && "GET".equals(request.getMethod())) {
            try {
                List<Patient> patients = patientDAO.getAllPatients(); // ou userDAO.getByRole("PATIENT")
                request.setAttribute("patients", patients);
            } catch (Exception e) {
                e.printStackTrace();
            }
            request.getRequestDispatcher("/views/medecin/rediger-rapport.jsp").forward(request, response);
            return;
        }  
        if ("/profile".equals(action)) {
            Medecin medecin = medecinDAO.findByIdMedecin(user.getId());
            
       
            if (medecin != null && medecin.getIdSpecialite() > 0) {
                Specialite spec = specialiteDAO.getById(medecin.getIdSpecialite());
                medecin.setNomSpecialite(spec != null ? spec.getNom() : "Non spécifiée");
            }
            
            request.setAttribute("medecin", medecin);
            request.getRequestDispatcher("/views/medecin/profile.jsp").forward(request, response);
            return;
        }
        
        response.sendError(HttpServletResponse.SC_NOT_FOUND);
    }
    
    

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/Login");
            return;
        }

        String action = request.getPathInfo();


        if ("/rediger-rapport".equals(action)) {
            try {
                String patientIdStr = request.getParameter("patient_id");
                String dateRapportStr = request.getParameter("dateRapport");
                String description = request.getParameter("description");


                if (patientIdStr == null || patientIdStr.trim().isEmpty()) {
                    request.setAttribute("error", "Veuillez sélectionner un patient.");
                    request.setAttribute("patients", patientDAO.getAllPatients());
                    request.getRequestDispatcher("/views/medecin/rediger-rapport.jsp").forward(request, response);
                    return;
                }

                if (description == null || description.trim().isEmpty()) {
                    request.setAttribute("error", "Le compte-rendu médical est obligatoire.");
                    request.setAttribute("patients", patientDAO.getAllPatients());
                    request.getRequestDispatcher("/views/medecin/rediger-rapport.jsp").forward(request, response);
                    return;
                }

                if (dateRapportStr == null || dateRapportStr.isEmpty()) {
                    request.setAttribute("error", "La date du rapport est obligatoire.");
                    request.setAttribute("patients", patientDAO.getAllPatients());
                    request.getRequestDispatcher("/views/medecin/rediger-rapport.jsp").forward(request, response);
                    return;
                }

                RapportMedical rapport = new RapportMedical();
                rapport.setPatientId(Integer.parseInt(patientIdStr));
                rapport.setMedecinId(user.getId());
                rapport.setDateRapport(LocalDate.parse(dateRapportStr));
                rapport.setDescription(description.trim());
                rapport.setPdfPath(null);

                rapportDAO.create(rapport);

           
                session.setAttribute("successMessage", "Rapport médical enregistré avec succès !");

                response.sendRedirect(request.getContextPath() + "/medecin/rapports");

            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Erreur lors de l'enregistrement : " + e.getMessage());
                try {
                    request.setAttribute("patients", patientDAO.getAllPatients());
                } catch (Exception ex) { /* ignore */ }
                request.getRequestDispatcher("/views/medecin/rediger-rapport.jsp").forward(request, response);
            }
            return; 
            }
        if ("/profile".equals(action)) {
            Medecin medecin = medecinDAO.findByIdMedecin(user.getId());

            medecin.setNom(request.getParameter("nom"));
            medecin.setPrenom(request.getParameter("prenom"));
            medecin.setEmail(request.getParameter("email"));
            medecin.setTel(request.getParameter("tel"));
            medecin.setAdresse(request.getParameter("adresse"));
            medecin.setCin(request.getParameter("cin"));

            String newPass = request.getParameter("password");
            if (newPass != null && !newPass.trim().isEmpty()) {
                String confirm = request.getParameter("passwordConfirm");
                if (!newPass.equals(confirm)) {
                    request.setAttribute("error", "Les mots de passe ne correspondent pas.");
                } else {
                    medecin.setPassword(newPass); 
                }
            }

            medecinDAO.updateMedecin(medecin);
            session.setAttribute("user", medecin);

            if (medecin.getIdSpecialite() > 0) {
                Specialite spec = specialiteDAO.getById(medecin.getIdSpecialite());
                medecin.setNomSpecialite(spec != null ? spec.getNom() : "Non spécifiée");
            }

            request.setAttribute("success", "Profil mis à jour avec succès !");
            request.setAttribute("medecin", medecin);
            request.getRequestDispatcher("/views/medecin/profile.jsp").forward(request, response);
            return;
        }
               response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
    }

	private String generatePdfRapport(String nomPatient, String prenomPatient, String cinPatient, String telPatient,
			LocalDate dateRapport, String description, User user, String contextPath) {
		// TODO Auto-generated method stub
		return null;
	}
}