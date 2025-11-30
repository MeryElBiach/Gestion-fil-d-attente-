<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Médecin - HealthCare</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/patient.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/medecin/dash.css">
    <style>
        .welcome-medecin {
            display: flex;
            align-items: center;  
        }
        .welcome-medecin i {
            margin-right: 1rem;  
        }
        .lead-date {
            font-family: 'Georgia', serif;  
            font-style: italic;
            font-size: 1.1rem;
            color: #495057;
        }
        .card-body {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            padding: 1.5rem;
        }
        .card-title {
            margin-bottom: 0.5rem; 
        }
        .card-text {
            margin-bottom: 1rem;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
    <%@ include file="/views/medecin/partials/header.jsp" %>
    <%@ include file="/views/medecin/partials/sidebar.jsp" %>

    <main class="main-content">
    
      <div class="row g-3 mb-4">
            <div class="col-12">
                <div class="welcome-medecin">
                    <i class="fas fa-stethoscope fa-2x text-success"></i> 
                        <h1 class="mb-1">Bonjour Dr. <c:out value="${user.prenom} ${user.nom}"/> !</h1>  
                        <p class="lead mb-0 lead-date">15 novembre 2025 – 1 RDV au total, 1 en attente.</p>  
                    </div>
                </div>
            </div>
        </div>

        <div class="row g-3 mb-4">
            <div class="col-lg-3 col-md-6">
                <div class="card stat-card h-100">
                    <div class="card-body">
                        <i class="fas fa-calendar-alt fa-2x text-primary mb-2"></i>
                        <h4 class="card-title mb-1"><c:out value="${totalRdv}"/></h4> 
                        <p class="card-text mb-0">RDV Total</p>
                        <a href="${pageContext.request.contextPath}/medecin/mes-rdv" class="btn btn-outline-primary btn-sm mt-2">Voir RDV</a>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="card stat-card h-100">
                    <div class="card-body">
                        <i class="fas fa-clock fa-2x text-success mb-2"></i>
                        <h4 class="card-title mb-1"><c:out value="${rdvEnAttente}"/></h4>  
                        <p class="card-text mb-0">RDV en Attente</p>
                        <a href="${pageContext.request.contextPath}/medecin/mes-rdv" class="btn btn-outline-success btn-sm mt-2">Gérer</a>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="card stat-card h-100">
                    <div class="card-body">
                        <i class="fas fa-users fa-2x text-info mb-2"></i>
                        <h4 class="card-title mb-1"><c:out value="${nbPatientsSuivis}"/></h4>  
                        <p class="card-text mb-0">Patients Suivis</p>
                        <a href="${pageContext.request.contextPath}/medecin/patients" class="btn btn-outline-info btn-sm mt-2">Voir Patients</a>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="card stat-card h-100">
                    <div class="card-body">
                        <i class="fas fa-file-medical fa-2x text-warning mb-2"></i>
                        <h4 class="card-title mb-1"><c:out value="${nbRapportsAttente}"/></h4>  <!-- Nb Rapports en Attente -->
                        <p class="card-text mb-0">Rapports Attente</p>
                        <a href="${pageContext.request.contextPath}/medecin/rapports" class="btn btn-outline-warning btn-sm mt-2">Rédiger un</a>
                    </div>
                </div>
            </div>
        </div>

        <!-- RDV Prochains (Tableau) -->
        <div class="row g-3 mb-4">
            <div class="col-12">
                <div class="card rdv-card">
                    <div class="card-header">
                        <h3 class="card-title mb-0"><i class="fas fa-calendar-alt me-2"></i> Prochains RDV (<c:out value="${nbProchains}"/>)</h3>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${nbProchains > 0}">
                                <table class="table table-striped table-hover">
                                    <thead class="table-dark">
                                        <tr>
                                            <th>Date/Heure</th>
                                            <th>Patient</th>
                                            <th>État</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="rdv" items="${rdvs}">  <!-- Utilise rdvs de servlet, filtré prochains -->
                                            <tr>
                                                <td><fmt:formatDate value="${rdv.date}" pattern="dd/MM"/> <c:out value="${rdv.heure}"/></td>
                                                <td><c:out value="${rdv.patientNom} ${rdv.patientPrenom}"/>  <!-- Assume enrichi en DAO ou boucle patients --></td>
                                                <td>
                                                    <span class="badge <c:choose><c:when test="${rdv.etat == 'EN_ATTENTE'}">bg-warning</c:when><c:when test="${rdv.etat == 'CONFIRME'}">bg-success</c:when><c:otherwise>bg-secondary</c:otherwise></c:choose>">
                                                        <c:out value="${rdv.etat}"/>
                                                    </span>
                                                </td>
                                                <td>
                                                    <a href="${pageContext.request.contextPath}/medecin/mes-rdv?confirm=<c:out value="${rdv.idRdv}"/>" class="btn btn-sm btn-success me-1"><i class="fas fa-check"></i></a>
                                                    <a href="${pageContext.request.contextPath}/medecin/rapports?rdv=<c:out value="${rdv.idRdv}"/>" class="btn btn-sm btn-primary me-1"><i class="fas fa-file-medical"></i></a>
                                                    <a href="${pageContext.request.contextPath}/medecin/mes-rdv?annuler=<c:out value="${rdv.idRdv}"/>" class="btn btn-sm btn-danger"><i class="fas fa-times"></i></a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </c:when>
                            <c:otherwise>
                                <p class="text-center text-muted py-4">Aucun RDV prochain. <a href="${pageContext.request.contextPath}/medecin/mes-rdv">Gérez vos RDV</a>.</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>

        <!-- Quick Actions (3 boutons, sans "Nouveau RDV") -->
        <div class="row g-3">
            <div class="col-lg-4 col-md-6">
                <a href="${pageContext.request.contextPath}/medecin/mes-rdv" class="btn btn-primary w-100 h-100 d-flex align-items-center justify-content-center">
                    <i class="fas fa-calendar-check me-2"></i> Gérer RDV
                </a>
            </div>
            <div class="col-lg-4 col-md-6">
                <a href="${pageContext.request.contextPath}/medecin/rapports" class="btn btn-success w-100 h-100 d-flex align-items-center justify-content-center">
                    <i class="fas fa-file-prescription me-2"></i> Rédiger Rapport
                </a>
            </div>
            <div class="col-lg-4 col-md-6">
                <a href="${pageContext.request.contextPath}/medecin/patients" class="btn btn-info w-100 h-100 d-flex align-items-center justify-content-center">
                    <i class="fas fa-users me-2"></i> Voir Patients
                </a>
            </div>
        </div>
    </main>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>