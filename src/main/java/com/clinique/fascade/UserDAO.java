package com.clinique.fascade;

import java.util.List;
import com.clinique.beans.User;
import com.clinique.dao.DAOException;

public interface UserDAO {

    void create(User user) throws DAOException;

    User findById(int id) throws DAOException;

    User findByLogin(String login, String password) throws DAOException;

    List<User> getAll() throws DAOException;

    void update(User user) throws DAOException;

    void delete(int id) throws DAOException;
}
