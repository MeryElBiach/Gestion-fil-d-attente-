package com.clinique.daoImpl;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.clinique.beans.Medecin;
import com.clinique.beans.User.Role;
import com.clinique.dao.DAOException;
import com.clinique.dao.DAOFactory;
import com.clinique.fascade.MedecinDAO;

public class MedecinDAOImpl implements MedecinDAO {
    private DAOFactory daoFactory;

    public MedecinDAOImpl(DAOFactory daoFactory) {
        this.daoFactory = daoFactory;
    }

    @Override
    public void createMedecin(Medecin medecin) throws DAOException {
        String sqlUser = "INSERT INTO user(nom, prenom, email, tel, adresse, login, password, role, date_de_naissance, cin) VALUES(?,?,?,?,?,?,?,?,?,?)";

        String sqlMedecin = "INSERT INTO medecin(id, specialite_id) VALUES(?,?)";
        Connection connection = null; 
        try {
            connection = daoFactory.getConnection();
            connection.setAutoCommit(false); 
            try (PreparedStatement stmtUser = connection.prepareStatement(sqlUser, Statement.RETURN_GENERATED_KEYS)) {
                stmtUser.setString(1, medecin.getNom());
                stmtUser.setString(2, medecin.getPrenom());
                stmtUser.setString(3, medecin.getEmail());
                stmtUser.setString(4, medecin.getTel());
                stmtUser.setString(5, medecin.getAdresse());
                stmtUser.setString(6, medecin.getLogin());
                stmtUser.setString(7, medecin.getPassword());
                stmtUser.setString(8, "MEDECIN"); 
                stmtUser.setDate(9, medecin.getDateDeNaissance());
                stmtUser.setString(10, medecin.getCin());
                stmtUser.executeUpdate();
                try (ResultSet rs = stmtUser.getGeneratedKeys()) { 
                    if (rs.next()) {
                        int id = rs.getInt(1);
                        medecin.setId(id);
                        try (PreparedStatement stmtMedecin = connection.prepareStatement(sqlMedecin)) {
                            stmtMedecin.setInt(1, id);
                            stmtMedecin.setInt(2, medecin.getIdSpecialite());
                            stmtMedecin.executeUpdate();
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
            throw new DAOException("Erreur lors de la création du médecin", e);
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
    public Medecin findByIdMedecin(int id) throws DAOException {

        String sql = "SELECT u.id, u.nom, u.prenom, u.email, u.tel, u.adresse, u.login, u.password, u.date_de_naissance, u.cin, m.specialite_id " +
                     "FROM user u JOIN medecin m ON u.id = m.id WHERE u.id = ?";
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
            throw new DAOException("Erreur lors de la recherche du médecin par ID", e);
        }
    }

    @Override
    public Medecin findByLoginMedecin(String login, String password) throws DAOException {

        String sql = "SELECT u.id, u.nom, u.prenom, u.email, u.tel, u.adresse, u.login, u.password, u.date_de_naissance, u.cin, m.specialite_id " +
                     "FROM user u JOIN medecin m ON u.id = m.id WHERE u.login = ? AND u.password = ?";
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
            throw new DAOException("Erreur lors de la recherche du médecin par login", e);
        }
    }
    @Override
    public List<Medecin> getAllMedecins() throws DAOException {
        List<Medecin> medecins = new ArrayList<>();
        String sql = """
            SELECT u.*, m.specialite_id 
            FROM medecin m 
            JOIN user u ON m.id = u.id
            ORDER BY u.nom, u.prenom
            """;

        try (Connection conn = daoFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                medecins.add(map(rs)); 
            }
        } catch (SQLException e) {
            throw new DAOException("Erreur getAllMedecins", e);
        }
        return medecins;
    }
    
     @Override
    public List<Medecin> getBySpecialite(int idSpec) throws DAOException {
        List<Medecin> medecins = new ArrayList<>();
        String sql = "SELECT u.id, u.nom, u.prenom, u.email, u.tel, u.adresse, u.login, u.password, u.date_de_naissance, u.cin, m.specialite_id "
                   + "FROM user u "
                   + "JOIN medecin m ON u.id = m.id "
                   + "WHERE m.specialite_id = ?";

        try (Connection connection = daoFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setInt(1, idSpec);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Medecin m = map(rs); 
                    medecins.add(m);
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Erreur lors de la récupération des médecins par spécialité", e);
        }
        return medecins;
    }


    @Override
    public void updateMedecin(Medecin medecin) throws DAOException {
        String sqlUser = "UPDATE user SET nom = ?, prenom = ?, email = ?, tel = ?, adresse = ?, login = ?, password = ?, date_de_naissance = ?, cin = ? WHERE id = ?";

        String sqlMedecin = "UPDATE medecin SET specialite_id = ? WHERE id = ?";
        Connection connection = null; 
        try {
            connection = daoFactory.getConnection();
            connection.setAutoCommit(false); 
            try (PreparedStatement stmtUser = connection.prepareStatement(sqlUser)) {
                stmtUser.setString(1, medecin.getNom());
                stmtUser.setString(2, medecin.getPrenom());
                stmtUser.setString(3, medecin.getEmail());
                stmtUser.setString(4, medecin.getTel());
                stmtUser.setString(5, medecin.getAdresse());
                stmtUser.setString(6, medecin.getLogin());
                stmtUser.setString(7, medecin.getPassword());
                stmtUser.setDate(8, medecin.getDateDeNaissance());
                stmtUser.setString(9, medecin.getCin()); 
                stmtUser.setInt(10, medecin.getId());
                stmtUser.executeUpdate();
            }
            try (PreparedStatement stmtMedecin = connection.prepareStatement(sqlMedecin)) {
                stmtMedecin.setInt(1, medecin.getIdSpecialite());
                stmtMedecin.setInt(2, medecin.getId());
                stmtMedecin.executeUpdate();
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
            throw new DAOException("Erreur lors de la mise à jour du médecin", e);
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
    public void deleteMedecin(int id) throws DAOException {
 
        String sql = "DELETE FROM user WHERE id = ?";
        try (Connection connection = daoFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new DAOException("Erreur lors de la suppression du médecin", e);
        }
    }


    private Medecin map(ResultSet rs) throws SQLException {
        Medecin medecin = new Medecin();
        medecin.setId(rs.getInt("id"));
        medecin.setNom(rs.getString("nom"));
        medecin.setPrenom(rs.getString("prenom"));
        medecin.setEmail(rs.getString("email"));
        medecin.setTel(rs.getString("tel"));
        medecin.setAdresse(rs.getString("adresse"));
        medecin.setLogin(rs.getString("login"));
        medecin.setPassword(rs.getString("password"));
        medecin.setDateDeNaissance(rs.getDate("date_de_naissance"));
        medecin.setCin(rs.getString("cin")); 
        medecin.setIdSpecialite(rs.getInt("specialite_id"));
        medecin.setRole(Medecin.Role.MEDECIN); 
        return medecin;
    }
    @Override
    public List<Medecin> getAllMedecinsWithSpecialite() throws DAOException {
        List<Medecin> medecins = new ArrayList<>();
        
        String sql = """
            SELECT 
                u.id,
                u.nom,
                u.prenom,
                u.tel,
                u.email,
                u.adresse,
                u.login,
                u.date_de_naissance,
                u.cin,
                m.specialite_id,
                s.nom AS nom_specialite
            FROM medecin m
            JOIN user u ON m.id = u.id
            LEFT JOIN specialite s ON m.specialite_id = s.idSpecialite
            ORDER BY u.nom, u.prenom
            """;

        try (Connection conn = daoFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Medecin med = new Medecin();
                
                med.setId(rs.getInt("id"));
                med.setNom(rs.getString("nom"));
                med.setPrenom(rs.getString("prenom"));
                med.setTel(rs.getString("tel"));
                med.setEmail(rs.getString("email"));
                med.setAdresse(rs.getString("adresse"));
                med.setLogin(rs.getString("login"));
                med.setDateDeNaissance(rs.getDate("date_de_naissance"));
                med.setCin(rs.getString("cin"));
                med.setRole(Role.MEDECIN);

                int specId = rs.getInt("specialite_id");
                if (rs.wasNull()) specId = 0; // au cas où NULL
                med.setIdSpecialite(specId);

                String nomSpec = rs.getString("nom_specialite");
                med.setNomSpecialite(nomSpec != null ? nomSpec : "Non spécifiée");

                medecins.add(med);
            }
        } catch (SQLException e) {
            throw new DAOException("Erreur lors du chargement des médecins avec spécialité", e);
        }
        return medecins;
    }
    @Override
    public int countAll() throws DAOException {
        String sql = "SELECT COUNT(*) FROM medecin";
        try (Connection conn = daoFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            throw new DAOException("Erreur lors du comptage total des médecins", e);
        }
        return 0;
    }
}