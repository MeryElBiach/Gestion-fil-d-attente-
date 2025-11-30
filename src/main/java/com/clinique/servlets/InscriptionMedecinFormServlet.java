package com.clinique.servlets;

import java.io.IOException;
import java.util.List;

import com.clinique.beans.Specialite;
import com.clinique.dao.DAOConfigurationException;
import com.clinique.dao.DAOException;
import com.clinique.dao.DAOFactory;
import com.clinique.fascade.SpecialiteDAO;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/inscription-medecin")
public class InscriptionMedecinFormServlet extends HttpServlet {
    private static final String VUE_FORMULAIRE = "/views/inscriptionMedecin.jsp";
    private SpecialiteDAO specialiteDAO;

    @Override
    public void init() throws ServletException {
        try {
            DAOFactory daoFactory = DAOFactory.getInstance();
            this.specialiteDAO = daoFactory.getSpecialiteDAO();
        } catch (DAOConfigurationException e) {
            throw new ServletException("Erreur d'initialisation du SpecialiteDAO", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        
        try {
            if (specialiteDAO == null) {
                System.out.println("ERREUR: specialiteDAO est null!");
                request.setAttribute("erreurSpecialites", "specialiteDAO non initialisé");
                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(VUE_FORMULAIRE);
                dispatcher.forward(request, response);
                return;
            }
            
            System.out.println("specialiteDAO initialisé correctement");
        
            List<Specialite> specialites = specialiteDAO.getAll();
            
            System.out.println("Nombre de spécialités trouvées: " + specialites.size());
            
           
            for (Specialite spec : specialites) {
                System.out.println("Spécialité: " + spec.getIdSpecialite() + " - " + spec.getNom());
            }
         
            request.setAttribute("specialites", specialites);
            
          
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(VUE_FORMULAIRE);
            dispatcher.forward(request, response);
            
        } catch (DAOException e) {
            System.out.println("ERREUR DAOException: " + e.getMessage());
            e.printStackTrace();
         
            request.setAttribute("erreurSpecialites", "Impossible de charger les spécialités : " + e.getMessage());
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(VUE_FORMULAIRE);
            dispatcher.forward(request, response);
        } catch (Exception e) {
            System.out.println("ERREUR Exception: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("erreurSpecialites", "Erreur inattendue : " + e.getMessage());
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(VUE_FORMULAIRE);
            dispatcher.forward(request, response);
        }
    }
}
