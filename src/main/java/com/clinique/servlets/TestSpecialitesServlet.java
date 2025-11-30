package com.clinique.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import com.clinique.beans.Specialite;
import com.clinique.dao.DAOConfigurationException;
import com.clinique.dao.DAOException;
import com.clinique.dao.DAOFactory;
import com.clinique.fascade.SpecialiteDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/test-specialites")
public class TestSpecialitesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        out.println("<h1>Test de connexion aux spécialités</h1>");
        
        try {
            out.println("<p>1. Initialisation DAOFactory...</p>");
            DAOFactory daoFactory = DAOFactory.getInstance();
            out.println("<p style='color:green'>✓ DAOFactory OK</p>");
            
            out.println("<p>2. Récupération SpecialiteDAO...</p>");
            SpecialiteDAO specialiteDAO = daoFactory.getSpecialiteDAO();
            out.println("<p style='color:green'>✓ SpecialiteDAO OK</p>");
            
            out.println("<p>3. Récupération des spécialités...</p>");
            List<Specialite> specialites = specialiteDAO.getAll();
            out.println("<p style='color:green'>✓ " + specialites.size() + " spécialité(s) trouvée(s)</p>");
            
            out.println("<h2>Liste des spécialités :</h2>");
            out.println("<ul>");
            for (Specialite spec : specialites) {
                out.println("<li>ID: " + spec.getIdSpecialite() + " - Nom: " + spec.getNom() + "</li>");
            }
            out.println("</ul>");
            
            out.println("<p><a href='inscription-medecin'>Retour au formulaire</a></p>");
            
        } catch (DAOConfigurationException e) {
            out.println("<p style='color:red'>✗ Erreur DAOFactory: " + e.getMessage() + "</p>");
            e.printStackTrace(out);
        } catch (DAOException e) {
            out.println("<p style='color:red'>✗ Erreur DAO: " + e.getMessage() + "</p>");
            e.printStackTrace(out);
        } catch (Exception e) {
            out.println("<p style='color:red'>✗ Erreur inattendue: " + e.getMessage() + "</p>");
            e.printStackTrace(out);
        }
    }
}
