<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profil Médecin - Dr ${medecin.prenom} ${medecin.nom}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/profil.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/patient.css">
</head>
<body>
    <%@ include file="/views/medecin/partials/header.jsp" %>
    <%@ include file="/views/medecin/partials/sidebar.jsp" %>

    <main class="main-content p-4">
        <div class="container">
            <h1 class="text-center mb-5 text-gradient">
                <i class="fas fa-user-md"></i> Mon Profil Médecin
            </h1>

            <c:if test="${not empty success}">
                <div class="alert alert-success text-center">${success}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger text-center">${error}</div>
            </c:if>

            <div class="profile-card">
                <div class="profile-header">
                    <div class="avatar-placeholder">
                        <i class="fas fa-user-md"></i>
                    </div>
                    <h2>Dr. ${medecin.prenom} ${medecin.nom}</h2>
                    <p><i class="fas fa-stethoscope"></i> ${medecin.nomSpecialite}</p>
                </div>

                <div class="profile-body">
                    <form action="${pageContext.request.contextPath}/medecin/profile" method="post">
                        <div class="row g-4">
                            <div class="col-md-6"><label>Nom *</label><input name="nom" value="${medecin.nom}" class="form-control" required></div>
                            <div class="col-md-6"><label>Prénom *</label><input name="prenom" value="${medecin.prenom}" class="form-control" required></div>
                            <div class="col-md-6"><label>Email *</label><input type="email" name="email" value="${medecin.email}" class="form-control" required></div>
                            <div class="col-md-6"><label>Téléphone</label><input type="tel" name="tel" value="${medecin.tel}" class="form-control"></div>
                            <div class="col-12"><label>Adresse</label><input name="adresse" value="${medecin.adresse}" class="form-control"></div>
                            <div class="col-md-6"><label>CIN *</label><input name="cin" value="${medecin.cin}" class="form-control" required></div>
                            <div class="col-md-6"><label>Spécialité</label><input value="${medecin.nomSpecialite}" class="form-control" disabled></div>
                        </div>

                        <hr class="my-5">
                        <h5>Changer le mot de passe</h5>
                        <div class="row g-4">
                            <div class="col-md-6"><label>Nouveau mot de passe</label><input type="password" name="password" class="form-control"></div>
                            <div class="col-md-6"><label>Confirmer</label><input type="password" name="passwordConfirm" class="form-control"></div>
                        </div>

                        <div class="text-center mt-5">
                            <button type="submit" class="btn-save">Enregistrer</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </main>
</body>
</html>