package com.clinique.servlets;

import com.clinique.dao.DAOFactory;
import com.clinique.fascade.UserDAO; // Use the interface
import com.clinique.beans.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/Login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public LoginServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.getServletContext().getRequestDispatcher("/views/login.jsp").forward(request, response);  // Forward to login.jsp
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String login = request.getParameter("login");
        String password = request.getParameter("password");

        DAOFactory daoFactory = DAOFactory.getInstance(); 
        UserDAO userDAO = daoFactory.getUserDAO(); 

   
        User user = userDAO.findByLogin(login, password);  

        if (user == null) {
            request.setAttribute("errorMessage", "Identifiant ou mot de passe incorrect.");
            this.getServletContext().getRequestDispatcher("/views/login.jsp").forward(request, response);
            return;
        }

        HttpSession session = request.getSession();
        session.setAttribute("user", user);
        String contextPath = request.getContextPath();  

        switch (user.getRole()) {
            case PATIENT -> response.sendRedirect(contextPath + "/patient/dashboard");
            case MEDECIN -> response.sendRedirect(contextPath + "/medecin/dashboard");
            case SECRETAIRE -> response.sendRedirect(contextPath + "/secretaire/dashboard");
            default -> {
                request.setAttribute("errorMessage", "Rôle non supporté.");
                this.getServletContext().getRequestDispatcher("/views/login.jsp").forward(request, response);
            }
        }
    }
}
