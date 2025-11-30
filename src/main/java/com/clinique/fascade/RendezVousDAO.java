package com.clinique.fascade;

import com.clinique.beans.RendezVous;
import com.clinique.dao.DAOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

public interface RendezVousDAO {

    void ajouter(RendezVous rdv) throws DAOException;

    boolean estDisponible(int idMedecin, LocalDate date, LocalTime heure) throws DAOException;

    List<RendezVous> getByPatient(int idPatient) throws DAOException; 

    List<RendezVous> getByMedecin(int idMedecin) throws DAOException; //

    RendezVous getById(int id) throws DAOException;

    void annuler(int id) throws DAOException;

    void setEtat(int idRdv, String etat) throws DAOException;

    int countByPatient(int patientId) throws DAOException; //

    int countByDate(LocalDate date) throws DAOException;
 
    RendezVous getNextRdv(LocalDate date) throws DAOException;

    List<RendezVous> getAllWithDetails() throws DAOException;
    int countAll() throws DAOException;

	List<RendezVous> getDerniersRdv(int limit) throws DAOException;
}