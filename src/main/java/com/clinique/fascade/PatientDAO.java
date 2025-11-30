package com.clinique.fascade;

import java.util.List;
import com.clinique.beans.Patient;
import com.clinique.dao.DAOException;

public interface PatientDAO {

    void createPatient(Patient patient) throws DAOException;

    Patient findByIdPatient(int id) throws DAOException;

    Patient findByLoginPatient(String login, String password) throws DAOException;


    List<Patient> getAllPatients() throws DAOException;
    List<Patient> getByMedecin(int medecinId) throws DAOException;
    public Patient findByCin(String cin) throws DAOException;

    void updatePatient(Patient patient) throws DAOException;

  
    void deletePatient(int id) throws DAOException;
    int countAll() throws DAOException;
}
