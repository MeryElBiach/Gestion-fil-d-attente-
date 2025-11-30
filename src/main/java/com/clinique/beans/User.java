package com.clinique.beans;

import java.sql.Date;

public class User {

    private int id;
    private String nom;
    private String prenom;
    private String email;
    private String tel;
    private String adresse;
    private String login;
    private String password;
    private Role role;
    private Date dateDeNaissance;
    private String cin;

    public enum Role {
        PATIENT,
        MEDECIN,
        SECRETAIRE
    }

    public User() {}

    public User(String nom, String prenom, String email, String tel, String adresse,
                String login, String password, Role role, Date dateDeNaissance, String cin) {
        this.nom = nom;
        this.prenom = prenom;
        this.email = email;
        this.tel = tel;
        this.adresse = adresse;
        this.login = login;
        this.password = password;
        this.role = role;
        this.dateDeNaissance = dateDeNaissance;
        this.cin = cin;
    }

    // Getters et setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }
    public String getPrenom() { return prenom; }
    public void setPrenom(String prenom) { this.prenom = prenom; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getTel() { return tel; }
    public void setTel(String tel) { this.tel = tel; }
    public String getAdresse() { return adresse; }
    public void setAdresse(String adresse) { this.adresse = adresse; }
    public String getLogin() { return login; }
    public void setLogin(String login) { this.login = login; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public Role getRole() { return role; }
    public void setRole(Role role) { this.role = role; }
    public Date getDateDeNaissance() { return dateDeNaissance; }
    public void setDateDeNaissance(Date dateDeNaissance) { this.dateDeNaissance = dateDeNaissance; }
    public String getCin() { return cin; }
    public void setCin(String cin) { this.cin = cin; }

    @Override
    public String toString() {
        return "User [id=" + id + ", nom=" + nom + ", prenom=" + prenom +
               ", email=" + email + ", tel=" + tel + ", adresse=" + adresse +
               ", login=" + login + ", role=" + role + ", dateDeNaissance=" + dateDeNaissance +
               ", cin=" + cin + "]";
    }
}
