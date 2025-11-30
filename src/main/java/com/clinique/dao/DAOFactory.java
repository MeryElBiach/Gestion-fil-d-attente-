package com.clinique.dao;
import java.util.Properties;
import com.clinique.fascade.UserDAO;      
import com.clinique.daoImpl.UserDAOImpl;
import com.clinique.fascade.MedecinDAO;
import com.clinique.fascade.PatientDAO;
import com.clinique.fascade.RapportDAO;
import com.clinique.fascade.RendezVousDAO;
import com.clinique.fascade.SpecialiteDAO;
import com.clinique.daoImpl.MedecinDAOImpl;
import com.clinique.daoImpl.PatientDAOImpl;
import com.clinique.daoImpl.RapportDAOImpl;
import com.clinique.daoImpl.RendezVousDAOImpl;
import com.clinique.daoImpl.SpecialiteDAOImpl;

import java.sql.*;
import java.util.Properties;
import java.io.InputStream;
import java.io.IOException;
import java.util.Properties;
public class DAOFactory {

	private static final String FILE_PROPERTIES = "dao.properties";
    private static final String PROPERTY_URL = "url";
    private static final String PROPERTY_DRIVER = "driver";
    private static final String PROPERTY_USER = "username";
    private static final String PROPERTY_PASSWORD = "password";
    
    private String url;
    private String username;
    private String password;

    private DAOFactory(String url, String username, String password) {
        this.url = url;
        this.username = username;
        this.password = password;
    }

    public static DAOFactory getInstance() throws DAOConfigurationException {
        Properties props = new Properties();
        try (InputStream file = Thread.currentThread().getContextClassLoader().getResourceAsStream(FILE_PROPERTIES)) {
            if (file == null) throw new DAOConfigurationException("dao.properties not found");
            props.load(file);
        } catch (IOException e) {
            throw new DAOConfigurationException("Error loading dao.properties", e);
        }

        String url = props.getProperty(PROPERTY_URL);
        String driver = props.getProperty(PROPERTY_DRIVER);
        String user = props.getProperty(PROPERTY_USER);
        String password = props.getProperty(PROPERTY_PASSWORD);

        try {
            Class.forName(driver);
        } catch (ClassNotFoundException e) {
            throw new DAOConfigurationException("JDBC Driver not found", e);
        }

        return new DAOFactory(url, user, password);
    }

    public Connection getConnection() throws SQLException {
        return DriverManager.getConnection(url, username, password);
    }

    public UserDAO getUserDAO() {
        return new UserDAOImpl(this);
    }
    public PatientDAO getPatientDAO() {
        return new PatientDAOImpl(this);
    }
    public MedecinDAO getMedecinDAO() {
        return new MedecinDAOImpl(this);
    }
    

    public RapportDAO getRapportDAO() {
        return new RapportDAOImpl(this);
    }
    

    public SpecialiteDAO getSpecialiteDAO() {
        return new SpecialiteDAOImpl(this);
    }
    public RendezVousDAO getRendezVousDAO() {
        return new RendezVousDAOImpl(this);
    }

    
}