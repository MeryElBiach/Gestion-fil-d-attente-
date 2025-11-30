package com.clinique.daoImpl;

import com.clinique.beans.RapportMedical;
import com.clinique.dao.DAOException;
import com.clinique.dao.DAOFactory;
import com.clinique.fascade.RapportDAO;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class RapportDAOImpl implements RapportDAO {

    private final DAOFactory daoFactory;

    public RapportDAOImpl(DAOFactory daoFactory) {
        this.daoFactory = daoFactory;
    }

    @Override
    public void create(RapportMedical rapport) throws DAOException {
        String sql = "INSERT INTO rapportmedical (patient_id, medecin_id, date_rapport, description, pdf_path) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = daoFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, rapport.getPatientId());
            ps.setInt(2, rapport.getMedecinId());
            ps.setDate(3, rapport.getDateRapport() != null ? Date.valueOf(rapport.getDateRapport()) : null);
            ps.setString(4, rapport.getDescription());
            ps.setString(5, rapport.getPdfPath());

            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    rapport.setId(rs.getLong(1));
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Erreur lors de la création du rapport médical", e);
        }
    }

    @Override
    public RapportMedical findById(Long id) throws DAOException {
        String sql = """
            SELECT r.*,
                   pu.nom AS patient_nom, 
                   pu.prenom AS patient_prenom, 
                   pu.cin AS patient_cin,
                   pu.tel AS patient_tel,
                   mu.nom AS medecin_nom, 
                   mu.prenom AS medecin_prenom
            FROM rapportmedical r
            JOIN user pu ON r.patient_id = pu.id
            JOIN user mu ON r.medecin_id = mu.id
            WHERE r.id = ?
            """;

        try (Connection conn = daoFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return map(rs);
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Erreur lors de la recherche du rapport ID=" + id, e);
        }
        return null;
    }

    @Override
    public List<RapportMedical> getByMedecin(int medecinId) throws DAOException {
        List<RapportMedical> rapports = new ArrayList<>();
        String sql = """
            SELECT r.*,
                   pu.nom AS patient_nom, 
                   pu.prenom AS patient_prenom, 
                   pu.cin AS patient_cin,
                   pu.tel AS patient_tel,
                   mu.nom AS medecin_nom, 
                   mu.prenom AS medecin_prenom
            FROM rapportmedical r
            JOIN user pu ON r.patient_id = pu.id
            JOIN user mu ON r.medecin_id = mu.id
            WHERE r.medecin_id = ?
            ORDER BY r.date_rapport DESC
            """;

        try (Connection conn = daoFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, medecinId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    rapports.add(map(rs));
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Erreur récupération rapports du médecin ID=" + medecinId, e);
        }
        return rapports;
    }

    @Override
    public List<RapportMedical> getByPatient(int patientId) throws DAOException {
        List<RapportMedical> rapports = new ArrayList<>();
        String sql = """
            SELECT r.*,
                   pu.nom AS patient_nom, 
                   pu.prenom AS patient_prenom, 
                   pu.cin AS patient_cin,
                   pu.tel AS patient_tel,
                   mu.nom AS medecin_nom, 
                   mu.prenom AS medecin_prenom
            FROM rapportmedical r
            JOIN user pu ON r.patient_id = pu.id
            JOIN user mu ON r.medecin_id = mu.id
            WHERE r.patient_id = ?
            ORDER BY r.date_rapport DESC
            """;

        try (Connection conn = daoFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, patientId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    rapports.add(map(rs));
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Erreur récupération rapports du patient ID=" + patientId, e);
        }
        return rapports;
    }

    @Override
    public void update(RapportMedical rapport) throws DAOException {
        String sql = "UPDATE rapportmedical SET description = ?, pdf_path = ?, date_rapport = ? WHERE id = ?";
        try (Connection conn = daoFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, rapport.getDescription());
            ps.setString(2, rapport.getPdfPath());
            ps.setDate(3, rapport.getDateRapport() != null ? Date.valueOf(rapport.getDateRapport()) : null);
            ps.setLong(4, rapport.getId());

            ps.executeUpdate();
        } catch (SQLException e) {
            throw new DAOException("Erreur mise à jour rapport ID=" + rapport.getId(), e);
        }
    }

    @Override
    public void delete(Long id) throws DAOException {
        String sql = "DELETE FROM rapportmedical WHERE id = ?";
        try (Connection conn = daoFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new DAOException("Erreur suppression rapport ID=" + id, e);
        }
    }
 
    @Override
    public List<RapportMedical> getByPatientWithMedecinInfo(int patientId) throws DAOException {
        List<RapportMedical> rapports = new ArrayList<>();
        String sql = """
            SELECT r.*,
                   pu.nom AS patient_nom,
                   pu.prenom AS patient_prenom,
                   pu.cin AS patient_cin,
                   pu.tel AS patient_tel,
                   mu.nom AS medecin_nom,
                   mu.prenom AS medecin_prenom,
                   s.nom AS specialite
            FROM rapportmedical r
            JOIN user pu ON r.patient_id = pu.id
            JOIN user mu ON r.medecin_id = mu.id
            JOIN medecin m ON mu.id = m.id
            LEFT JOIN specialite s ON m.specialite_id = s.idSpecialite
            WHERE r.patient_id = ?
            ORDER BY r.date_rapport DESC
            """;

        try (Connection conn = daoFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, patientId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    RapportMedical r = mapWithSpecialite(rs); // on utilise une variante du map
                    rapports.add(r);
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Erreur récupération rapports patient avec info médecin", e);
        }
        return rapports;
    }

 
    private RapportMedical mapWithSpecialite(ResultSet rs) throws SQLException {
        RapportMedical r = map(rs); 
        String specialite = rs.getString("specialite");

        return r;
    }

    @Override 
    public List<RapportMedical> getRapportsPatientAvecMedecin(int patientId) throws DAOException {
        List<RapportMedical> rapports = new ArrayList<>();
        String sql = """
            SELECT r.*,
                   mu.nom AS medecin_nom,
                   mu.prenom AS medecin_prenom,
                   s.nom AS specialite
            FROM rapportmedical r
            JOIN user mu ON r.medecin_id = mu.id
            JOIN medecin m ON mu.id = m.id
            LEFT JOIN specialite s ON m.specialite_id = s.idSpecialite
            WHERE r.patient_id = ?
            ORDER BY r.date_rapport DESC
            """;

        try (Connection conn = daoFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, patientId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    RapportMedical r = new RapportMedical();
                    r.setId(rs.getLong("id"));
                    r.setPatientId(rs.getInt("patient_id"));
                    r.setMedecinId(rs.getInt("medecin_id"));
                    Date d = rs.getDate("date_rapport");
                    r.setDateRapport(d != null ? d.toLocalDate() : null);
                    r.setDescription(rs.getString("description"));
                    r.setPdfPath(rs.getString("pdf_path"));


                    r.setNomMedecin(rs.getString("medecin_nom"));
                    r.setPrenomMedecin(rs.getString("medecin_prenom"));
                    r.setSpecialite(rs.getString("specialite"));

                    rapports.add(r);
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Erreur getRapportsPatientAvecMedecin", e);
        }
        return rapports;
    }
    

    @Override
    public List<RapportMedical> getRapportsPatientAvecDetails(int patientId) throws DAOException {
        List<RapportMedical> rapports = new ArrayList<>();
        String sql = """
            SELECT r.*,
                   mu.nom AS medecin_nom,
                   mu.prenom AS medecin_prenom,
                   s.nom AS specialite
            FROM rapportmedical r
            JOIN user mu ON r.medecin_id = mu.id
            JOIN medecin m ON mu.id = m.id
            LEFT JOIN specialite s ON m.specialite_id = s.idSpecialite
            WHERE r.patient_id = ?
            ORDER BY r.date_rapport DESC
            """;

        try (Connection conn = daoFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, patientId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    RapportMedical r = new RapportMedical();
                    r.setId(rs.getLong("id"));
                    r.setPatientId(rs.getInt("patient_id"));
                    r.setMedecinId(rs.getInt("medecin_id"));
                    Date d = rs.getDate("date_rapport");
                    r.setDateRapport(d != null ? d.toLocalDate() : null);
                    r.setDescription(rs.getString("description"));
                    r.setPdfPath(rs.getString("pdf_path"));

                    // Champs temporaires pour affichage
                    r.setNomMedecin(rs.getString("medecin_nom"));
                    r.setPrenomMedecin(rs.getString("medecin_prenom"));
                    r.setSpecialite(rs.getString("specialite"));

                    rapports.add(r);
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Erreur getRapportsPatientAvecDetails", e);
        }
        return rapports;
    }

  
    private RapportMedical map(ResultSet rs) throws SQLException {
        RapportMedical r = new RapportMedical();

        r.setId(rs.getLong("id"));
        r.setPatientId(rs.getInt("patient_id"));
        r.setMedecinId(rs.getInt("medecin_id"));

        Date dateSql = rs.getDate("date_rapport");
        if (dateSql != null) {
            r.setDateRapport(dateSql.toLocalDate());
        }

        r.setDescription(rs.getString("description"));
        r.setPdfPath(rs.getString("pdf_path"));

 
        r.setNomPatient(rs.getString("patient_nom"));
        r.setPrenomPatient(rs.getString("patient_prenom"));
        r.setPatientCin(rs.getString("patient_cin"));
        r.setPatientTel(rs.getString("patient_tel"));

        return r;
    }
}