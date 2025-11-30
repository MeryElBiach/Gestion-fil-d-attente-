package com.clinique.daoImpl;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.clinique.beans.Patient;
import com.clinique.dao.DAOException;
import com.clinique.dao.DAOFactory;
import com.clinique.fascade.PatientDAO;

public class PatientDAOImpl implements PatientDAO {
    private DAOFactory daoFactory;

    public PatientDAOImpl(DAOFactory daoFactory) {
        this.daoFactory = daoFactory;
    }

    @Override
    public void createPatient(Patient patient) throws DAOException {
        String sqlUser = "INSERT INTO user(nom, prenom, email, tel, adresse, login, password, role, date_de_naissance, cin) VALUES(?,?,?,?,?,?,?,?,?,?)";
        String sqlPatient = "INSERT INTO patient(id) VALUES(?)";
        Connection connection = null; 
        try {
            connection = daoFactory.getConnection();
            connection.setAutoCommit(false); 
            try (PreparedStatement stmtUser = connection.prepareStatement(sqlUser, Statement.RETURN_GENERATED_KEYS)) {
                stmtUser.setString(1, patient.getNom());
                stmtUser.setString(2, patient.getPrenom());
                stmtUser.setString(3, patient.getEmail());
                stmtUser.setString(4, patient.getTel());
                stmtUser.setString(5, patient.getAdresse());
                stmtUser.setString(6, patient.getLogin());
                stmtUser.setString(7, patient.getPassword());
                stmtUser.setString(8, "PATIENT"); 
                stmtUser.setDate(9, patient.getDateDeNaissance());
                stmtUser.setString(10, patient.getCin());
                stmtUser.executeUpdate();
                try (ResultSet rs = stmtUser.getGeneratedKeys()) { 
                    if (rs.next()) {
                        int id = rs.getInt(1);
                        patient.setId(id);
                        try (PreparedStatement stmtPatient = connection.prepareStatement(sqlPatient)) {
                            stmtPatient.setInt(1, id);
                            stmtPatient.executeUpdate();
                        }
                    }
                }
            }
            connection.commit(); 
        } catch (SQLException e) {
            if (connection != null) {
                try {
                    connection.rollback(); 
                    System.err.println("Rollback exécuté suite à : " + e.getMessage());
                } catch (SQLException rollbackEx) {
                    System.err.println("Rollback échoué : " + rollbackEx.getMessage());
                }
            }
            String details = "SQLState=" + e.getSQLState() + ", ErrorCode=" + e.getErrorCode() + ", Message=" + e.getMessage();
            throw new DAOException("Erreur lors de la création du patient: " + details, e);
        } finally {
            if (connection != null) {
                try {
                    connection.setAutoCommit(true);
                    connection.close();
                } catch (SQLException closeEx) {
                    System.err.println("Erreur fermeture connection : " + closeEx.getMessage());
                }
            }
        }
    }

    @Override
    public Patient findByIdPatient(int id) throws DAOException {
        // Fix : Ajout date_de_naissance et cin dans SELECT
        String sql = "SELECT u.id, u.nom, u.prenom, u.email, u.tel, u.adresse, u.login, u.password, u.date_de_naissance, u.cin " +
                     "FROM user u JOIN patient p ON u.id = p.id WHERE u.id = ?";
        try (Connection connection = daoFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) { 
                if (rs.next()) {
                    return map(rs); 
                }
            }
            return null;
        } catch (SQLException e) {
            throw new DAOException("Erreur lors de la recherche du patient par ID", e);
        }
    }

    @Override
    public Patient findByLoginPatient(String login, String password) throws DAOException {
       
        String sql = "SELECT u.id, u.nom, u.prenom, u.email, u.tel, u.adresse, u.login, u.password, u.date_de_naissance, u.cin " +
                     "FROM user u JOIN patient p ON u.id = p.id WHERE u.login = ? AND u.password = ?";
        try (Connection connection = daoFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, login);
            stmt.setString(2, password);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return map(rs); 
                }
            }
            return null;
        } catch (SQLException e) {
            throw new DAOException("Erreur lors de la recherche du patient par login", e);
        }
    }

    @Override
    public List<Patient> getAllPatients() throws DAOException {
        List<Patient> patients = new ArrayList<>();
             String sql = "SELECT u.id, u.nom, u.prenom, u.email, u.tel, u.adresse, u.login, u.password, u.date_de_naissance, u.cin " +
                     "FROM user u JOIN patient p ON u.id = p.id";
        try (Connection connection = daoFactory.getConnection();
             Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                patients.add(map(rs)); 
            }
        } catch (SQLException e) {
            throw new DAOException("Erreur lors de la récupération de tous les patients", e);
        }
        return patients;
    }

    @Override
    public void updatePatient(Patient patient) throws DAOException {
  
        String sql = "UPDATE user SET nom = ?, prenom = ?, email = ?, tel = ?, adresse = ?, login = ?, password = ?, date_de_naissance = ?, cin = ? WHERE id = ?";
        try (Connection connection = daoFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, patient.getNom());
            stmt.setString(2, patient.getPrenom());
            stmt.setString(3, patient.getEmail());
            stmt.setString(4, patient.getTel());
            stmt.setString(5, patient.getAdresse());
            stmt.setString(6, patient.getLogin());
            stmt.setString(7, patient.getPassword());
            stmt.setDate(8, patient.getDateDeNaissance()); 
            stmt.setString(9, patient.getCin()); 
            stmt.setInt(10, patient.getId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new DAOException("Erreur lors de la mise à jour du patient", e);
        }
    }

    @Override
    public void deletePatient(int id) throws DAOException {
        
        String sql = "DELETE FROM user WHERE id = ?";
        try (Connection connection = daoFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new DAOException("Erreur lors de la suppression du patient", e);
        }
    }

    private Patient map(ResultSet rs) throws SQLException {
        Patient patient = new Patient();
        patient.setId(rs.getInt("id"));
        patient.setNom(rs.getString("nom"));
        patient.setPrenom(rs.getString("prenom"));
        patient.setEmail(rs.getString("email"));
        patient.setTel(rs.getString("tel"));
        patient.setAdresse(rs.getString("adresse"));
        patient.setLogin(rs.getString("login"));
        patient.setPassword(rs.getString("password"));
        patient.setDateDeNaissance(rs.getDate("date_de_naissance"));
        patient.setCin(rs.getString("cin"));

        patient.setRole(Patient.Role.PATIENT);
        return patient;
    }
    @Override
    public List<Patient> getByMedecin(int medecinId) throws DAOException {
        List<Patient> patients = new ArrayList<>();
        String sql = "SELECT DISTINCT u.id, u.nom, u.prenom, u.email, u.tel, u.adresse, u.login, u.password, u.date_de_naissance, u.cin " +
                     "FROM user u JOIN rendezvous r ON u.id = r.patient_id WHERE r.medecin_id = ? AND u.role = 'PATIENT' ORDER BY u.nom, u.prenom";
        try (Connection connection = daoFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, medecinId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    patients.add(map(rs)); 
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Erreur lors de la récupération des patients par médecin", e);
        }
        return patients;
    }
    @Override
    public Patient findByCin(String cin) throws DAOException {
        String sql = "SELECT u.id, u.nom, u.prenom, u.email, u.tel, u.adresse, " +
                     "u.login, u.password, u.date_de_naissance, u.cin " +
                     "FROM user u JOIN patient p ON u.id = p.id WHERE u.cin = ?";
        
        try (Connection connection = daoFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
             
            stmt.setString(1, cin);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return map(rs); 
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Erreur lors de la recherche du patient par CIN: " + cin, e);
        }
        return null; 
    }
    @Override
    public int countAll() throws DAOException {
        String sql = "SELECT COUNT(*) FROM patient";
        try (Connection conn = daoFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            throw new DAOException("Erreur lors du comptage total des patients", e);
        }
        return 0;
    }
}