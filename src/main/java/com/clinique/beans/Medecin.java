package com.clinique.beans;

public class Medecin extends User {
	private int medecinId;


    private int idSpecialite; 

    public Medecin() {
        setRole(Role.MEDECIN);
    }


    private String nomSpecialite;  
	public int getMedecinId() {
	    return medecinId;
	}

	public void setMedecinId(int medecinId) {
	    this.medecinId = medecinId;
	}
    public String getNomSpecialite() {
        return nomSpecialite != null ? nomSpecialite : "Aucune spécialité";
    }

    public void setNomSpecialite(String nomSpecialite) {
        this.nomSpecialite = nomSpecialite;
    }
    public Medecin(String nom, String prenom, String email, String tel, String adresse,
                   String login, String password, java.sql.Date dateNaissance, String cin,
                   int idSpecialite) {
        super(nom, prenom, email, tel, adresse, login, password, Role.MEDECIN, dateNaissance, cin);
        this.idSpecialite = idSpecialite;
    }

    public int getIdSpecialite() {
        return idSpecialite;
    }

    public void setIdSpecialite(int idSpecialite) {
        this.idSpecialite = idSpecialite;
    }
}
