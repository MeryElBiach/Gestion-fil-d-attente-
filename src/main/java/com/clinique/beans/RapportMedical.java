package com.clinique.beans;

import java.sql.Date;
import java.time.LocalDate;

public class RapportMedical {
    private Long id;
    private int patientId;
    private int medecinId;

    private LocalDate dateRapport;
    private String description;
    private String pdfPath;

    private String nomPatient;
    private String prenomPatient;

    private Date updatedAt;
    private String patientCin;
    private String patientTel;

    private String nomMedecin;
    private String prenomMedecin;
    private String specialite;

    public String getNomMedecin() { return nomMedecin != null ? nomMedecin : ""; }
    public void setNomMedecin(String nomMedecin) { this.nomMedecin = nomMedecin; }
    public String getPrenomMedecin() { return prenomMedecin != null ? prenomMedecin : ""; }
    public void setPrenomMedecin(String prenomMedecin) { this.prenomMedecin = prenomMedecin; }
    public String getSpecialite() { return specialite != null ? specialite : "Non spécifiée"; }
    public void setSpecialite(String specialite) { this.specialite = specialite; }

    // Getters et setters
    public String getPatientCin() { return patientCin == null ? "" : patientCin; }
    public void setPatientCin(String patientCin) { this.patientCin = patientCin; }

    public String getPatientTel() { return patientTel == null ? "" : patientTel; }
    public void setPatientTel(String patientTel) { this.patientTel = patientTel; }

    public RapportMedical() {}

    // Getters & Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public int getPatientId() { return patientId; }
    public void setPatientId(int patientId) { this.patientId = patientId; }

    public int getMedecinId() { return medecinId; }
    public void setMedecinId(int medecinId) { this.medecinId = medecinId; }

    public LocalDate getDateRapport() { return dateRapport; }
    public void setDateRapport(LocalDate dateRapport) { this.dateRapport = dateRapport; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getPdfPath() { return pdfPath; }
    public void setPdfPath(String pdfPath) { this.pdfPath = pdfPath; }

    public Date getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Date updatedAt) { this.updatedAt = updatedAt; }

    // Infos Patient (pas en DB)
    public String getNomPatient() { return nomPatient; }
    public void setNomPatient(String nomPatient) { this.nomPatient = nomPatient; }

    public String getPrenomPatient() { return prenomPatient; }
    public void setPrenomPatient(String prenomPatient) { this.prenomPatient = prenomPatient; }

}
