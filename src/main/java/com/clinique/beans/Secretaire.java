package com.clinique.beans;

public class Secretaire extends User {

    public Secretaire() {
        setRole(Role.SECRETAIRE);
    }

    public Secretaire(String nom, String prenom, String email, String tel, String adresse,
                      String login, String password, java.sql.Date dateNaissance, String cin) {
        super(nom, prenom, email, tel, adresse, login, password, Role.SECRETAIRE, dateNaissance, cin);
    }
}
