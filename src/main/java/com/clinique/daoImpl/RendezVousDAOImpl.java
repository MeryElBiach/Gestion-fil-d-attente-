package com.clinique.daoImpl;

import com.clinique.beans.RendezVous;
import com.clinique.dao.DAOException;
import com.clinique.dao.DAOFactory;
import com.clinique.fascade.RendezVousDAO;

import java.sql.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

public class RendezVousDAOImpl implements RendezVousDAO {
    private DAOFactory daoFactory;

    public RendezVousDAOImpl(DAOFactory daoFactory) {
        this.daoFactory = daoFactory;
    }

    @Override
    public void ajouter(RendezVous rdv) throws DAOException {
   
        String sql = "INSERT INTO rendezvous (patient_id, medecin_id, dateRdv, heureRdv, etat, numRdv) VALUES (?, ?, ?, ?, 'EN_ATTENTE', NULL)";
        try (Connection conn = daoFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, rdv.getIdPatient());
            ps.setInt(2, rdv.getIdMedecin());
            ps.setDate(3, java.sql.Date.valueOf(rdv.getDate()));
            ps.setTime(4, java.sql.Time.valueOf(rdv.getHeure()));
      
            ps.executeUpdate();
        
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    rdv.setId(rs.getInt(1));
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Erreur ajout RDV", e);
        }
    }

    @Override
    public boolean estDisponible(int idMedecin, LocalDate date, LocalTime heure) throws DAOException {
        String sql = "SELECT COUNT(*) FROM rendezvous WHERE medecin_id = ? AND dateRdv = ? AND heureRdv = ?";
        try (Connection conn = daoFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idMedecin);
            ps.setDate(2, java.sql.Date.valueOf(date));
            ps.setTime(3, java.sql.Time.valueOf(heure));
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) == 0; 
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Erreur check disponibilité", e);
        }
        return false; 
    }

    @Override
    public List<RendezVous> getByPatient(int idPatient) throws DAOException {
        List<RendezVous> rdvs = new ArrayList<>();
        String sql = "SELECT * FROM rendezvous WHERE patient_id = ? ORDER BY dateRdv, heureRdv";
        try (Connection conn = daoFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idPatient);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    rdvs.add(map(rs));
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Erreur liste RDV patient", e);
        }
        return rdvs;
    }

    @Override
    public RendezVous getById(int id) throws DAOException {
        String sql = "SELECT * FROM rendezvous WHERE idRdv = ?";
        try (Connection conn = daoFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return map(rs);
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Erreur RDV par ID", e);
        }
        return null;
    }

    @Override
    public void annuler(int id) throws DAOException {
        setEtat(id, "ANNULE");
    }

    @Override
    public void setEtat(int idRdv, String etat) throws DAOException {
        String sql = "UPDATE rendezvous SET etat = ? WHERE idRdv = ?";
        try (Connection conn = daoFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, etat);
            ps.setInt(2, idRdv);
            int rows = ps.executeUpdate();
            if (rows == 0) {
                throw new DAOException("RDV non trouvé pour update état (ID: " + idRdv + ")");
            }
            System.out.println("DEBUG: État RDV " + idRdv + " mis à jour en '" + etat + "'");  // Log pour test
        } catch (SQLException e) {
            throw new DAOException("Erreur update état RDV", e);
        }
    }

    @Override
    public int countByPatient(int patientId) throws DAOException {
        String sql = "SELECT COUNT(*) FROM rendezvous WHERE patient_id = ?";
        try (Connection conn = daoFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, patientId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Erreur count RDV patient", e);
        }
        return 0;  // Fallback
    }

    // Nouvel ajout : liste des rendez-vous par médecin (tous RDV, triés par date/heure)
    public List<RendezVous> getByMedecin(int idMedecin) throws DAOException {
        List<RendezVous> rdvs = new ArrayList<>();
        String sql = "SELECT * FROM rendezvous WHERE medecin_id = ? ORDER BY dateRdv, heureRdv";
        try (Connection conn = daoFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idMedecin);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    rdvs.add(map(rs));
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Erreur liste RDV médecin", e);
        }
        return rdvs;
    }

    private RendezVous map(ResultSet rs) throws SQLException {
        RendezVous rdv = new RendezVous();
        rdv.setId(rs.getInt("idRdv"));
        rdv.setIdPatient(rs.getInt("patient_id"));
        rdv.setIdMedecin(rs.getInt("medecin_id"));

    
        java.sql.Date sqlDate = rs.getDate("dateRdv");
        if (sqlDate != null) {
            rdv.setDate(sqlDate.toLocalDate());
        }

        java.sql.Time sqlTime = rs.getTime("heureRdv");
        if (sqlTime != null) {
            rdv.setHeure(sqlTime.toLocalTime());
        }

        rdv.setEtat(rs.getString("etat"));

        
        System.out.println("DEBUG RDV map: id=" + rdv.getId() + ", patient=" + rdv.getIdPatient() +
                ", medecin=" + rdv.getIdMedecin() + ", date=" + rdv.getDate() +
                ", heure=" + rdv.getHeure() + ", etat=" + rdv.getEtat());

        return rdv;
    }


 public int countByDate(LocalDate date) throws DAOException {
     String sql = "SELECT COUNT(*) FROM rendezvous WHERE dateRdv = ?";
     try (Connection conn = daoFactory.getConnection();
          PreparedStatement ps = conn.prepareStatement(sql)) {
         ps.setDate(1, java.sql.Date.valueOf(date));
         try (ResultSet rs = ps.executeQuery()) {
             if (rs.next()) return rs.getInt(1);
         }
     } catch (SQLException e) {
         throw new DAOException("Erreur count RDV du jour", e);
     }
     return 0;
 }
 @Override
 public List<RendezVous> getDerniersRdv(int limit) throws DAOException {
     List<RendezVous> rdvs = new ArrayList<>();
     
     String sql = """
         SELECT 
             r.idRdv,
             r.patient_id,
             r.medecin_id,
             r.dateRdv,
             r.heureRdv,
             r.etat,
             CONCAT(up.nom, ' ', up.prenom) AS patient_nom_complet,
             CONCAT(um.nom, ' ', um.prenom) AS medecin_nom_complet
         FROM rendezvous r
         JOIN patient p ON r.patient_id = p.id
         JOIN user up ON p.id = up.id
         JOIN medecin m ON r.medecin_id = m.id
         JOIN user um ON m.id = um.id
         ORDER BY r.dateRdv DESC, r.heureRdv DESC
         LIMIT ?
         """;

     try (Connection conn = daoFactory.getConnection();
          PreparedStatement ps = conn.prepareStatement(sql)) {

         ps.setInt(1, limit);

         try (ResultSet rs = ps.executeQuery()) {
             while (rs.next()) {
                 RendezVous rdv = new RendezVous();

                 rdv.setId(rs.getInt("idRdv"));
                 rdv.setIdPatient(rs.getInt("patient_id"));
                 rdv.setIdMedecin(rs.getInt("medecin_id"));

                 // Date
                 java.sql.Date sqlDate = rs.getDate("dateRdv");
                 if (sqlDate != null) {
                     rdv.setDate(sqlDate.toLocalDate());
                 }

                 // Heure
                 java.sql.Time sqlTime = rs.getTime("heureRdv");
                 if (sqlTime != null) {
                     rdv.setHeure(sqlTime.toLocalTime());
                 }

                 rdv.setEtat(rs.getString("etat"));

                 // Champs temporaires pour affichage
                 rdv.setPatientNom(rs.getString("patient_nom_complet"));
                 rdv.setMedecinNom(rs.getString("medecin_nom_complet"));

                 rdvs.add(rdv);
             }
         }
     } catch (SQLException e) {
         throw new DAOException("Erreur lors de la récupération des derniers rendez-vous", e);
     }

     return rdvs;
 }

 public RendezVous getNextRdv(LocalDate date) throws DAOException {
	// TODO Auto-generated method stub
	return null;
 }

 @Override
 public List<RendezVous> getAllWithDetails() throws DAOException {
     List<RendezVous> rdvs = new ArrayList<>();
     
     String sql = """
         SELECT 
             r.idRdv,
             r.dateRdv,
             r.heureRdv,
             r.etat,
             CONCAT(p.nom, ' ', p.prenom) AS patientNom,
             CONCAT(m.nom, ' ', m.prenom) AS medecinNom,
             COALESCE(s.nom, 'Non spécifiée') AS specialite
         FROM rendezvous r
         JOIN patient pat ON r.patient_id = pat.id
         JOIN user p ON pat.id = p.id
         JOIN medecin med ON r.medecin_id = med.id
         JOIN user m ON med.id = m.id
         LEFT JOIN specialite s ON med.specialite_id = s.idSpecialite
         ORDER BY r.dateRdv DESC, r.heureRdv DESC
         """;

     try (Connection conn = daoFactory.getConnection();
          PreparedStatement ps = conn.prepareStatement(sql);
          ResultSet rs = ps.executeQuery()) {

         while (rs.next()) {
             RendezVous rdv = new RendezVous();
             rdv.setId(rs.getInt("idRdv"));
             
             java.sql.Date d = rs.getDate("dateRdv");
             if (d != null) rdv.setDate(d.toLocalDate());
             
             java.sql.Time t = rs.getTime("heureRdv");
             if (t != null) rdv.setHeure(t.toLocalTime());
             
             rdv.setEtat(rs.getString("etat"));
             rdv.setPatientNom(rs.getString("patientNom"));
             rdv.setMedecinNom(rs.getString("medecinNom"));
             rdv.setSpecialite(rs.getString("specialite"));

             rdvs.add(rdv);
         }
     } catch (SQLException e) {
         throw new DAOException("Erreur lors du chargement des rendez-vous avec détails", e);
     }
     return rdvs;
 }

@Override
public int countAll() throws DAOException {
  String sql = "SELECT COUNT(*) FROM rendezvous";
  try (Connection c = daoFactory.getConnection();
       PreparedStatement ps = c.prepareStatement(sql);
       ResultSet rs = ps.executeQuery()) {
      return rs.next() ? rs.getInt(1) : 0;
  } catch (SQLException e) {
      throw new DAOException("Erreur countAll RDV", e);
  }
}
}