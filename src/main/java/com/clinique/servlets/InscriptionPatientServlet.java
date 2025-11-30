package com.clinique.servlets;

import java.io.IOException;
import java.sql.Date;
import com.clinique.beans.Patient;
import com.clinique.daoImpl.PatientDAOImpl;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.clinique.beans.Patient;
import com.clinique.daoImpl.PatientDAOImpl;
import com.clinique.dao.DAOConfigurationException;
import com.clinique.dao.DAOFactory;

/**
 * Servlet implementation class InscriptionPatientServlet
 */
@WebServlet("/InscriptionPatientServlet")
public class InscriptionPatientServlet extends HttpServlet {

    private PatientDAOImpl patientDAO;

    @Override
    public void init() throws ServletException {
        try {
            DAOFactory daoFactory = DAOFactory.getInstance();
            patientDAO = new PatientDAOImpl(daoFactory);
        } catch (DAOConfigurationException e) {
            throw new ServletException("Erreur d'initialisation du PatientDAO", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Patient patient = new Patient();
        patient.setNom(request.getParameter("nom"));
        patient.setPrenom(request.getParameter("prenom"));
        patient.setEmail(request.getParameter("email"));
        patient.setTel(request.getParameter("tel"));
        patient.setAdresse(request.getParameter("adresse"));
        patient.setLogin(request.getParameter("login"));
        patient.setPassword(request.getParameter("password"));
        patient.setCin(request.getParameter("cin"));
        patient.setDateDeNaissance(Date.valueOf(request.getParameter("dateNaissance")));

        patientDAO.createPatient(patient);
        response.sendRedirect("views/Login.jsp");
    }}