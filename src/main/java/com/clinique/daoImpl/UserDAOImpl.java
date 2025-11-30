package com.clinique.daoImpl;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.clinique.beans.User;
import com.clinique.dao.DAOException;
import com.clinique.dao.DAOFactory;
import com.clinique.fascade.UserDAO;

public class UserDAOImpl implements UserDAO {
    private DAOFactory daoFactory;

    public UserDAOImpl(DAOFactory daoFactory) {
        this.daoFactory = daoFactory;
    }

    @Override
    public void create(User user) throws DAOException {

        String sql = "INSERT INTO user (nom, prenom, email, tel, adresse, login, password, role, date_de_naissance, cin) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
       
        try (Connection conn = daoFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, user.getNom());
            stmt.setString(2, user.getPrenom());
            stmt.setString(3, user.getEmail());
            stmt.setString(4, user.getTel());
            stmt.setString(5, user.getAdresse());
            stmt.setString(6, user.getLogin());
            stmt.setString(7, user.getPassword());
            stmt.setString(8, user.getRole().name());
            // Ajout des champs manquants
            stmt.setDate(9, (Date) user.getDateDeNaissance()); // Cast java.sql.Date
            stmt.setString(10, user.getCin());
            stmt.executeUpdate();
            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    user.setId(generatedKeys.getInt(1));
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Error inserting user", e);
        }
    }

    @Override
    public User findById(int id) throws DAOException {
        // Corrigé : Table "user"
        String sql = "SELECT * FROM user WHERE id = ?";
        User user = null;
        try (Connection conn = daoFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) { 
                if (rs.next()) user = map(rs);
            }
        } catch (SQLException e) {
            throw new DAOException("Error finding user by ID", e);
        }
        return user;
    }

    @Override
    public User findByLogin(String login, String password) throws DAOException {
        // Corrigé : Table "user"
        String sql = "SELECT * FROM user WHERE login = ? AND password = ?";
        User user = null;
        try (Connection conn = daoFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, login);
            stmt.setString(2, password);
            try (ResultSet rs = stmt.executeQuery()) { 
                if (rs.next()) user = map(rs);
            }
        } catch (SQLException e) {
            throw new DAOException("Error finding user by login", e);
        }
        return user;
    }

    @Override
    public List<User> getAll() throws DAOException {
        List<User> users = new ArrayList<>();
        // Corrigé : Table "user"
        String sql = "SELECT * FROM user";
        try (Connection conn = daoFactory.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) users.add(map(rs));
        } catch (SQLException e) {
            throw new DAOException("Error fetching all users", e);
        }
        return users;
    }

    @Override
    public void update(User user) throws DAOException {

        String sql = "UPDATE user SET nom=?, prenom=?, email=?, tel=?, adresse=?, login=?, password=?, role=?, date_de_naissance=?, cin=? WHERE id=?";
        try (Connection conn = daoFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, user.getNom());
            stmt.setString(2, user.getPrenom());
            stmt.setString(3, user.getEmail());
            stmt.setString(4, user.getTel());
            stmt.setString(5, user.getAdresse());
            stmt.setString(6, user.getLogin());
            stmt.setString(7, user.getPassword());
            stmt.setString(8, user.getRole().name());
        
            stmt.setDate(9, (Date) user.getDateDeNaissance());
            stmt.setString(10, user.getCin());
            stmt.setInt(11, user.getId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new DAOException("Error updating user", e);
        }
    }

    @Override
    public void delete(int id) throws DAOException {
     
        String sql = "DELETE FROM user WHERE id=?";
        try (Connection conn = daoFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new DAOException("Error deleting user", e);
        }
    }

    private User map(ResultSet rs) throws SQLException {
        User user = new User(); 
        user.setId(rs.getInt("id"));
        user.setNom(rs.getString("nom"));
        user.setPrenom(rs.getString("prenom"));
        user.setEmail(rs.getString("email"));
        user.setTel(rs.getString("tel"));
        user.setAdresse(rs.getString("adresse"));
        user.setLogin(rs.getString("login"));
        user.setPassword(rs.getString("password"));
        user.setRole(User.Role.valueOf(rs.getString("role")));

        user.setDateDeNaissance(rs.getDate("date_de_naissance"));
        user.setCin(rs.getString("cin"));
        return user;
    }
}