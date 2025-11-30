<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Rapports - HealthCare</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/patient.css">
</head>
<body>

    <%@ include file="/views/medecin/partials/header.jsp" %>
    <%@ include file="/views/medecin/partials/sidebar.jsp" %>

    <main class="main-content">

        <div class="d-flex align-items-center justify-content-between mb-4">
            <div class="d-flex align-items-center">
                <i class="fas fa-file-medical text-primary me-3" style="font-size: 2.2rem;"></i>
                <h1 class="mb-0">Liste des Rapports Médicaux</h1>
            </div>
            <a href="${pageContext.request.contextPath}/medecin/rediger-rapport" 
               class="btn btn-primary btn-lg px-4">
                <i class="fas fa-plus me-2"></i> Rédiger un nouveau rapport
            </a>
        </div>

        <p class="lead text-muted mb-4">
            Vous avez rédigé <strong>${totalRapports != null ? totalRapports : '0'}</strong> rapport(s).
        </p>

        <!-- Filtres -->
        <div class="card mb-4 shadow-sm">
            <div class="card-body">
                <div class="row g-3 align-items-center">
                    <div class="col-lg-5">
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-search"></i></span>
                            <input type="text" class="form-control form-control-lg" 
                                   id="searchInput" placeholder="Rechercher par nom, CIN ou téléphone..." 
                                   onkeyup="filterTable()">
                        </div>
                    </div>
                    <div class="col-lg-3">
                        <input type="date" class="form-control form-control-lg" id="dateDebut" onchange="filterTable()">
                    </div>
                    <div class="col-lg-3">
                        <input type="date" class="form-control form-control-lg" id="dateFin" onchange="filterTable()">
                    </div>
                    <div class="col-lg-1">
                        <button class="btn btn-primary btn-lg w-100" onclick="filterTable()">
                            <i class="fas fa-filter"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Tableau des rapports -->
        <div class="card shadow">
            <div class="card-header">
                <h3 class="card-title mb-0"><i class="fas fa-list me-2"></i> Rapports rédigés</h3>
            </div>
            <div class="card-body p-0">
                <c:choose>
                    <c:when test="${not empty rapports}">
                        <div class="table-responsive">
                            <table class="table table-hover mb-0 align-middle">
                                <thead class="table-dark">
                                    <tr>
                                        <th>Date Rapport</th>
                                        <th>Patient</th>
                                        <th>CIN</th>
                                        <th>Téléphone</th>
                                        <th>Description</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="r" items="${rapports}">
                                        <tr data-date="${r.dateRapport}"
                                            data-patient="${r.prenomPatient} ${r.nomPatient}"
                                            data-cin="${r.patientCin}"
                                            data-tel="${r.patientTel}">
                                            
                                            <td>${r.dateRapport}</td>
                                            <td><strong>${r.prenomPatient} ${r.nomPatient}</strong></td>
                                            <td>${r.patientCin}</td>
                                            <td>${r.patientTel != null && !r.patientTel.isEmpty() ? r.patientTel : 'Non renseigné'}</td>
                             <td>${r.description}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-5">
                            <i class="fas fa-file-medical fa-4x text-muted mb-3"></i>
                            <p class="text-muted">Aucun rapport médical rédigé pour le moment.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Boutons rapides -->
        <div class="row g-3 mt-4">
            <div class="col-md-4">
                <a href="${pageContext.request.contextPath}/medecin/dashboard" 
                   class="btn btn-secondary w-100 h-100 d-flex align-items-center justify-content-center">
                    <i class="fas fa-arrow-left me-2"></i> Retour Dashboard
                </a>
            </div>
            <div class="col-md-4">
                <a href="${pageContext.request.contextPath}/medecin/mes-rdv" 
                   class="btn btn-primary w-100 h-100 d-flex align-items-center justify-content-center">
                    <i class="fas fa-calendar-check me-2"></i> Gérer RDV
                </a>
            </div>
            <div class="col-md-4">
                <a href="${pageContext.request.contextPath}/medecin/patients" 
                   class="btn btn-info w-100 h-100 d-flex align-items-center justify-content-center">
                    <i class="fas fa-users me-2"></i> Mes Patients
                </a>
            </div>
        </div>

    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function filterTable() {
            const search = document.getElementById("searchInput").value.toLowerCase();
            const debut = document.getElementById("dateDebut").value;
            const fin = document.getElementById("dateFin").value;
            const rows = document.querySelectorAll("tbody tr");

            rows.forEach(row => {
                const patient = row.getAttribute("data-patient").toLowerCase();
                const cin = row.getAttribute("data-cin").toLowerCase();
                const tel = row.getAttribute("data-tel") ? row.getAttribute("data-tel").toLowerCase() : "";
                const date = row.getAttribute("data-date");

                let show = true;

                if (search && !patient.includes(search) && !cin.includes(search) && !tel.includes(search)) {
                    show = false;
                }
                if (debut && date < debut) show = false;
                if (fin && date > fin) show = false;

                row.style.display = show ? "" : "none";
            });
        }
    </script>

</body>
</html>