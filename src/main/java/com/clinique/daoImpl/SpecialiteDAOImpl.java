// src/main/java/com/clinique/daoImpl/SpecialiteDAOImpl.java
package com.clinique.daoImpl;

import com.clinique.beans.Specialite;
import com.clinique.dao.DAOException;
import com.clinique.dao.DAOFactory;
import com.clinique.fascade.SpecialiteDAO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SpecialiteDAOImpl implements SpecialiteDAO {

    private DAOFactory daoFactory;

    public SpecialiteDAOImpl(DAOFactory daoFactory) {
        this.daoFactory = daoFactory;
    }

    @Override
    public void ajouter(Specialite specialite) throws DAOException {
        String sql = "INSERT INTO specialite (nom) VALUES (?)";
        try (Connection conn = daoFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, specialite.getNom());
            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    specialite.setIdSpecialite(rs.getInt(1));
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Erreur lors de l'ajout de la spécialité : " + e.getMessage(), e);
        }
    }

    @Override
    public void modifier(Specialite specialite) throws DAOException {
        String sql = "UPDATE specialite SET nom = ? WHERE idSpecialite = ?";
        try (Connection conn = daoFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, specialite.getNom());
            ps.setInt(2, specialite.getIdSpecialite());

            int rows = ps.executeUpdate();
            if (rows == 0) {
                throw new DAOException("Spécialité non trouvée (ID: " + specialite.getIdSpecialite() + ")");
            }
        } catch (SQLException e) {
            throw new DAOException("Erreur lors de la modification de la spécialité", e);
        }
    }

    @Override
    public void supprimer(int idSpecialite) throws DAOException {
        String sql = "DELETE FROM specialite WHERE idSpecialite = ?";
        try (Connection conn = daoFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, idSpecialite);
            int rows = ps.executeUpdate();
            if (rows == 0) {
                throw new DAOException("Spécialité non trouvée pour suppression (ID: " + idSpecialite + ")");
            }
        } catch (SQLException e) {
            // Attention : si des médecins ont cette spécialité → erreur FK
            if (e.getSQLState().equals("23000")) { // Code MySQL pour contrainte FK
                throw new DAOException("Impossible de supprimer : des médecins utilisent cette spécialité.");
            }
            throw new DAOException("Erreur lors de la suppression de la spécialité", e);
        }
    }

    @Override
    public List<Specialite> getAll() throws DAOException {
        List<Specialite> specialites = new ArrayList<>();
        String sql = "SELECT * FROM specialite ORDER BY nom";

        try (Connection conn = daoFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Specialite s = new Specialite();
                s.setIdSpecialite(rs.getInt("idSpecialite"));
                s.setNom(rs.getString("nom"));
                specialites.add(s);
            }
        } catch (SQLException e) {
            throw new DAOException("Erreur lors du chargement des spécialités", e);
        }
        return specialites;
    }

    @Override
    public Specialite getById(int id) throws DAOException {
        String sql = "SELECT * FROM specialite WHERE idSpecialite = ?";
        try (Connection conn = daoFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Specialite s = new Specialite();
                    s.setIdSpecialite(rs.getInt("idSpecialite"));
                    s.setNom(rs.getString("nom"));
                    return s;
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Erreur lors de la récupération de la spécialité", e);
        }
        return null;
    }
    @Override
    public int countAll() throws DAOException {
        String sql = "SELECT COUNT(*) FROM specialite";  
        try (Connection conn = daoFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            return rs.next() ? rs.getInt(1) : 0;

        } catch (SQLException e) {
            throw new DAOException("Erreur lors du comptage total des spécialités", e);
        }
    }
}