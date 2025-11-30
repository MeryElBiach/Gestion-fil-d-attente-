// src/main/java/com/clinique/fascade/SpecialiteDAO.java
package com.clinique.fascade;

import com.clinique.beans.Specialite;
import com.clinique.dao.DAOException;
import java.util.List;

public interface SpecialiteDAO {
    void ajouter(Specialite specialite) throws DAOException;
    void modifier(Specialite specialite) throws DAOException;
    void supprimer(int idSpecialite) throws DAOException;
    List<Specialite> getAll() throws DAOException;
    Specialite getById(int id) throws DAOException;
    int countAll() throws DAOException;
}