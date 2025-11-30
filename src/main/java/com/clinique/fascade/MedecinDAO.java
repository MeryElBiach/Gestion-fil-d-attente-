package com.clinique.fascade;

import java.util.List;
import com.clinique.beans.Medecin;
import com.clinique.dao.DAOException;

public interface MedecinDAO {

    void createMedecin(Medecin medecin) throws DAOException;

    Medecin findByIdMedecin(int id) throws DAOException;

    Medecin findByLoginMedecin(String login, String password) throws DAOException;

    List<Medecin> getAllMedecins() throws DAOException;

    void updateMedecin(Medecin medecin) throws DAOException;

    void deleteMedecin(int id) throws DAOException;


    List<Medecin> getBySpecialite(int idSpec) throws DAOException;
    List<Medecin> getAllMedecinsWithSpecialite() throws DAOException;
    int countAll() throws DAOException;
}
