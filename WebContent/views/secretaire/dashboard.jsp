<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tableau de bord - Secrétaire</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/secretaire/stylesidesecretaire.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/secretaire/dashboard.css">
</head>
<body>

    <%@ include file="/views/secretaire/partials/header.jsp" %>
    <%@ include file="/views/secretaire/partials/sidebar.jsp" %>

    <div class="content-wrapper">
        <div class="container-fluid">

            <!-- Titre avec style cohérent -->
            <h1 class="page-title">
                <i class="fas fa-tachometer-alt me-3"></i> Tableau de bord
            </h1>
            <p class="text-muted mb-3">
                <fmt:formatDate value="<%= new java.util.Date() %>" pattern="EEEE dd MMMM yyyy" />
            </p>

            <!-- 4 CARTES STATISTIQUES avec couleurs cohérentes -->
            <div class="row g-3 mb-4">
                <div class="col-lg-3 col-md-6">
                    <div class="card stat-card stat-card-blue">
                        <div class="card-body text-center">
                            <i class="fas fa-calendar-check"></i>
                            <h2>${totalRdv}</h2>
                            <p>Total rendez-vous</p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="card stat-card stat-card-green">
                        <div class="card-body text-center">
                            <i class="fas fa-users"></i>
                            <h2>${totalPatients}</h2>
                            <p>Patients</p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="card stat-card stat-card-cyan">
                        <div class="card-body text-center">
                            <i class="fas fa-user-md"></i>
                            <h2>${totalMedecins}</h2>
                            <p>Médecins</p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="card stat-card stat-card-yellow">
                        <div class="card-body text-center">
                            <i class="fas fa-stethoscope"></i>
                            <h2>${totalSpecialites}</h2>
                            <p>Spécialités</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 5 DERNIERS RENDEZ-VOUS -->
            <div class="card shadow-lg border-0">
                <div class="card-header card-header-custom">
                    <h5 class="mb-0">
                        <i class="fas fa-list me-2"></i> 5 derniers rendez-vous
                    </h5>
                </div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${empty derniersRdv}">
                            <div class="text-center py-5 text-muted empty-state">
                                <i class="fas fa-calendar-times fa-4x mb-3"></i>
                                <p>Aucun rendez-vous enregistré pour le moment</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="r" items="${derniersRdv}">
                                <div class="rdv-item">
                                    <div>
                                        <strong class="text-primary">${r.patientNom}</strong> 
                                        <i class="fas fa-arrow-right mx-2 text-muted"></i> 
                                        Dr. ${r.medecinNom}
                                        <br>
                                        <small class="text-muted">
                                            <i class="far fa-calendar-alt"></i> ${r.date}
                                            <i class="far fa-clock ms-3"></i> ${r.heure}
                                        </small>
                                    </div>
                                    <span class="badge badge-etat
                                        ${r.etat == 'CONFIRME' ? 'badge-confirme' : 
                                          r.etat == 'TERMINE' ? 'badge-termine' : 
                                          r.etat == 'ANNULE' ? 'badge-annule' : 'badge-attente'}">
                                        ${r.etat}
                                    </span>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>