
package com.clinique.beans;

public class Specialite {
    private int idSpecialite;
    private String nom;


    public Specialite() {}


    public Specialite(int idSpecialite, String nom) {
        this.idSpecialite = idSpecialite;
        this.nom = nom;
    }


    public int getIdSpecialite() {
        return idSpecialite;
    }

    public void setIdSpecialite(int idSpecialite) {
        this.idSpecialite = idSpecialite;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    @Override
    public String toString() {
        return "Specialite{" +
                "idSpecialite=" + idSpecialite +
                ", nom='" + nom + '\'' +
                '}';
    }
}