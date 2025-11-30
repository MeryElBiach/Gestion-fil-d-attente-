package com.clinique.servlets;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

import com.clinique.beans.Medecin;
import com.clinique.beans.Specialite;
import com.clinique.dao.DAOConfigurationException;
import com.clinique.dao.DAOException;
import com.clinique.dao.DAOFactory;
import com.clinique.fascade.MedecinDAO;
import com.clinique.fascade.SpecialiteDAO; // Gardé pour futur, mais non utilisé

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/InscriptionMedecinServlet")
public class InscriptionMedecinServlet extends HttpServlet {
    private static final String VUE_INSCRIPTION = "/views/inscriptionMedecin.jsp";
    private MedecinDAO medecinDAO;
    private SpecialiteDAO specialiteDAO; 

    @Override
    public void init() throws ServletException {
        try {
            DAOFactory daoFactory = DAOFactory.getInstance();
            this.medecinDAO = daoFactory.getMedecinDAO();
            this.specialiteDAO = daoFactory.getSpecialiteDAO(); // Pour futur
        } catch (DAOConfigurationException e) {
            throw new ServletException("Erreur d'initialisation des DAOs", e);
        }
    }

    // Ajout : doGet pour charger form (si lien direct ou erreur)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Specialite> specialites = specialiteDAO.getAll();
            request.setAttribute("specialites", specialites);
        } catch (DAOException e) {
            request.setAttribute("erreur", "Erreur chargement spécialités : " + e.getMessage());
        }
        forwardToJSP(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
   
        if (medecinDAO == null) {
            request.setAttribute("erreur", "DAO non initialisé (redémarrez le serveur)");
            forwardToJSP(request, response);
            return;
        }

        Medecin medecin = new Medecin();
        medecin.setNom(request.getParameter("nom"));
        medecin.setPrenom(request.getParameter("prenom"));
        medecin.setEmail(request.getParameter("email"));
        medecin.setTel(request.getParameter("tel"));
        medecin.setAdresse(request.getParameter("adresse"));
        medecin.setLogin(request.getParameter("login"));
        medecin.setPassword(request.getParameter("password"));
        medecin.setCin(request.getParameter("cin"));
  
        if (medecin.getNom() == null || medecin.getNom().trim().isEmpty() ||
            medecin.getPrenom() == null || medecin.getPrenom().trim().isEmpty() ||
            medecin.getEmail() == null || medecin.getEmail().trim().isEmpty() ||
            medecin.getLogin() == null || medecin.getLogin().trim().isEmpty() ||
            medecin.getPassword() == null || medecin.getPassword().trim().isEmpty() ||
            medecin.getCin() == null || medecin.getCin().trim().isEmpty()) {
            request.setAttribute("erreur", "Tous les champs obligatoires doivent être remplis");
            forwardToJSP(request, response);
            return;
        }

      
        String dateNaissanceStr = request.getParameter("dateNaissance");
        if (dateNaissanceStr != null && !dateNaissanceStr.trim().isEmpty()) {
            medecin.setDateDeNaissance(Date.valueOf(dateNaissanceStr));
        } else {
            request.setAttribute("erreur", "Date de naissance obligatoire");
            forwardToJSP(request, response);
            return;
        }

        // Récupérer et set l'ID spécialité
        String specialiteIdStr = request.getParameter("specialiteId");
        if (specialiteIdStr == null || specialiteIdStr.trim().isEmpty()) {
            request.setAttribute("erreur", "Veuillez sélectionner une spécialité");
            forwardToJSP(request, response);
            return;
        }
        try {
            int idSpecialite = Integer.parseInt(specialiteIdStr);
            medecin.setIdSpecialite(idSpecialite);
        } catch (NumberFormatException e) {
            request.setAttribute("erreur", "ID spécialité invalide");
            forwardToJSP(request, response);
            return;
        }

        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        if (password == null || confirmPassword == null || !password.equals(confirmPassword)) {
            request.setAttribute("erreur", "Les mots de passe ne correspondent pas");
            forwardToJSP(request, response);
            return;
        }

    
        try {
            if (medecinDAO.findByLoginMedecin(medecin.getLogin(), "") != null) {
                request.setAttribute("erreur", "Ce login existe déjà");
                forwardToJSP(request, response);
                return;
            }
          
        } catch (DAOException e) {
          
        }

        try {
            medecinDAO.createMedecin(medecin);
            response.sendRedirect(request.getContextPath() + "/views/login.jsp"); 
        } catch (DAOException e) {
            System.err.println("Erreur DAO inscription médecin : " + e.getMessage()); 
            request.setAttribute("erreur", "Erreur lors de l'inscription : " + e.getMessage());
            forwardToJSP(request, response);
        }
    }

    private void forwardToJSP(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(VUE_INSCRIPTION);
        dispatcher.forward(request, response);
    }
}