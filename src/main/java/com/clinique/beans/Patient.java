package com.clinique.beans;

public class Patient extends User {

    private int id;  
    private int nbRdv;  



    public Patient() {
        setRole(Role.PATIENT);
    }

    public Patient(String nom, String prenom, String email, String tel, String adresse,
                   String login, String password, java.sql.Date dateNaissance, String cin) {
        super(nom, prenom, email, tel, adresse, login, password, Role.PATIENT, dateNaissance, cin);
    }


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
    public int getNbRdv() {
        return nbRdv;
    }

    public void setNbRdv(int nbRdv) {
        this.nbRdv = nbRdv;
    }
}