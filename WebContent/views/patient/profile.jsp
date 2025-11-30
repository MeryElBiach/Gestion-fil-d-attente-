<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mon Profil - HealthCare</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/profil.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/patient.css">
</head>
<body>

    <%@ include file="/views/patient/partials/header.jsp" %>
    <%@ include file="/views/patient/partials/sidebar.jsp" %>

    <main class="main-content p-4">
        <div class="container">
            <div class="text-center mb-5">
                <h1 class="text-gradient">
                    <i class="fas fa-user-circle me-3"></i> Mon Profil
                </h1>
            </div>

            <!-- Messages -->
            <c:if test="${not empty success}">
                <div class="alert alert-success alert-dismissible fade show text-center" role="alert">
                    <i class="fas fa-check-circle me-2"></i> ${success}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show text-center" role="alert">
                    <i class="fas fa-exclamation-triangle me-2"></i> ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <div class="profile-card">
                <!-- En-tête avec avatar -->
                <div class="profile-header">
                    <div class="avatar-placeholder">
                        <i class="fas fa-user-md"></i>
                    </div>
                    <h2>${patient.prenom} ${patient.nom}</h2>
                    <p><i class="fas fa-stethoscope me-2"></i>Patient</p>
                </div>

                <!-- Formulaire -->
                <div class="profile-body">
                    <form action="${pageContext.request.contextPath}/patient/profile" method="post">

                        <div class="row g-4">
                            <div class="col-md-6">
                                <label class="form-label">Nom <span class="text-danger">*</span></label>
                                <input type="text" name="nom" value="${patient.nom}" class="form-control" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Prénom <span class="text-danger">*</span></label>
                                <input type="text" name="prenom" value="${patient.prenom}" class="form-control" required>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Email <span class="text-danger">*</span></label>
                                <input type="email" name="email" value="${patient.email}" class="form-control" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Téléphone</label>
                                <input type="tel" name="tel" value="${patient.tel}" class="form-control">
                            </div>

                            <div class="col-12">
                                <label class="form-label">Adresse</label>
                                <input type="text" name="adresse" value="${patient.adresse}" class="form-control">
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">CIN <span class="text-danger">*</span></label>
                                <input type="text" name="cin" value="${patient.cin}" class="form-control" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Date de naissance <span class="text-danger">*</span></label>
                                <input type="date" name="dateNaissance" value="${patient.dateDeNaissance}" class="form-control" required>
                            </div>
                        </div>

                        <hr class="my-5">

                        <h5 class="mb-4 text-primary">
                            <i class="fas fa-lock me-2"></i> Changer le mot de passe (facultatif)
                        </h5>
                        <div class="row g-4">
                            <div class="col-md-6">
                                <label class="form-label">Nouveau mot de passe</label>
                                <input type="password" name="password" class="form-control" placeholder="Laisser vide pour ne pas changer">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Confirmer le mot de passe</label>
                                <input type="password" name="passwordConfirm" class="form-control">
                            </div>
                        </div>

                        <div class="text-center mt-5">
                            <button type="submit" class="btn-save">
                                <i class="fas fa-save me-2"></i> Enregistrer les modifications
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>