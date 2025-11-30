package com.clinique.fascade;

import com.clinique.beans.RapportMedical;
import com.clinique.dao.DAOException;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public interface RapportDAO {
    void create(RapportMedical rapport) throws DAOException;
    RapportMedical findById(Long id) throws DAOException;
    List<RapportMedical> getByMedecin(int medecinId) throws DAOException;
    List<RapportMedical> getByPatient(int patientId) throws DAOException;
    void update(RapportMedical rapport) throws DAOException;
    void delete(Long id) throws DAOException;
    public List<RapportMedical> getByPatientWithMedecinInfo(int patientId) throws DAOException;
    public List<RapportMedical> getRapportsPatientAvecMedecin(int patientId) throws DAOException ;
    public List<RapportMedical> getRapportsPatientAvecDetails(int patientId) throws DAOException ;
}
