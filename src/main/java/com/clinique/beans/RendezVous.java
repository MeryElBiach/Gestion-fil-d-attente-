package com.clinique.beans;

import java.time.LocalDate;
import java.time.LocalTime;

public class RendezVous {

    private int id;
    private int idPatient;
    private int idMedecin;
    private LocalDate date;
    private LocalTime heure;
    private String etat;

    private String patientNom;
    private String medecinNom;
    private String specialite;

    public String getPatientNom() { 
        return patientNom != null ? patientNom : "Inconnu"; 
    }
    public void setPatientNom(String patientNom) { this.patientNom = patientNom; }

    public String getMedecinNom() { 
        return medecinNom != null ? medecinNom : "Dr. Inconnu"; 
    }
    public void setMedecinNom(String medecinNom) { this.medecinNom = medecinNom; }

    public String getSpecialite() { 
        return specialite != null ? specialite : "Non spécifiée"; 
    }
    public void setSpecialite(String specialite) { this.specialite = specialite; }


    public RendezVous() {}

    public RendezVous(int idPatient, int idMedecin, LocalDate date, LocalTime heure, String etat) {
        this.idPatient = idPatient;
        this.idMedecin = idMedecin;
        this.date = date;
        this.heure = heure;
        this.etat = etat;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdPatient() {
        return idPatient;
    }

    public void setIdPatient(int idPatient) {
        this.idPatient = idPatient;
    }

    public int getIdMedecin() {
        return idMedecin;
    }

    public void setIdMedecin(int idMedecin) {
        this.idMedecin = idMedecin;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public LocalTime getHeure() {
        return heure;
    }

    public void setHeure(LocalTime heure) {
        this.heure = heure;
    }

    public String getEtat() {
        return etat;
    }

    public void setEtat(String etat) {
        this.etat = etat;
    }



}
