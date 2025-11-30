<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mes Patients - HealthCare</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/patient.css">
</head>
<body>
    <%@ include file="/views/medecin/partials/header.jsp" %>
    <%@ include file="/views/medecin/partials/sidebar.jsp" %>

    <main class="main-content">
        <div class="row g-3 mb-4">
            <div class="col-12">
                <h1 class="mb-3"><i class="fas fa-users me-2 text-info"></i> Mes Patients</h1>
                <p class="lead mb-3">Suivi de vos patients : <c:out value="${totalPatients}"/> au total.</p>
            </div>
        </div>

        <!-- Tableau Patients -->
        <div class="row g-3">
            <div class="col-12">
                <div class="card patients-card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h3 class="card-title mb-0"><i class="fas fa-list me-2"></i> Liste des Patients Suivis</h3>
                        <div class="d-flex">
                            <input type="text" class="form-control" placeholder="Rechercher par nom/CIN/tel" id="searchPatient" onkeyup="filterPatients()">
                        </div>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${not empty patients}">
                                <div class="table-responsive">
                                    <table class="table table-striped table-hover">
                                        <thead class="table-dark">
                                            <tr>
                                                <th>Nom/Prénom</th>
                                                <th>CIN</th>  <!-- Colonne CIN séparée -->
                                                <th>Date de Naissance</th>
                                                <th>Téléphone</th>
                                                <th>Email</th>
                                                <th>Adresse</th>
                                                <th>Nombre de Rendez-vous</th>  <!-- Renommé -->
                                            </tr>
                                        </thead>
                                        <tbody id="patientsTableBody">
                                            <c:forEach var="p" items="${patients}">
                                                <tr data-name="<c:out value='${p.prenom} ${p.nom}'/>" data-cin="<c:out value='${p.cin}'/>" data-tel="<c:out value='${p.tel}'/>" data-email="<c:out value='${p.email}'/>">
                                                    <td><c:out value="${p.prenom} ${p.nom}"/></td>
                                                    <td><c:out value="${p.cin}"/></td>  <!-- CIN seul -->
                                                    <td><c:if test="${p.dateDeNaissance != null}"><fmt:formatDate value="${p.dateDeNaissance}" pattern="dd/MM/yyyy"/></c:if><c:if test="${p.dateDeNaissance == null}">-</c:if></td>
                                                    <td><c:out value="${p.tel}"/></td>
                                                    <td><c:out value="${p.email}"/></td>
                                                    <td><c:out value="${p.adresse}"/></td>
                                                    <td><c:out value="${p.nbRdv}"/></td>  <!-- Nombre de Rendez-vous -->
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <p class="text-center text-muted py-4">Aucun patient suivi. <a href="${pageContext.request.contextPath}/medecin/mes-rdv">Via RDV</a>.</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="row g-3 mb-4">
            <div class="col-lg-6 col-md-6">
                <a href="${pageContext.request.contextPath}/medecin/dashboard" class="btn btn-secondary w-100 h-100 d-flex align-items-center justify-content-center">
                    <i class="fas fa-arrow-left me-2"></i> Retour Dashboard
                </a>
            </div>
            <div class="col-lg-6 col-md-6">
                <a href="${pageContext.request.contextPath}/medecin/mes-rdv" class="btn btn-primary w-100 h-100 d-flex align-items-center justify-content-center">
                    <i class="fas fa-calendar-check me-2"></i> Gérer RDV
                </a>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Filtre recherche (adapté nom/CIN/tel/email/adresse)
        function filterPatients() {
            const tableBody = document.getElementById('patientsTableBody');
            const rows = tableBody.getElementsByTagName('tr');
            const searchTerm = document.getElementById('searchPatient').value.toLowerCase();

            for (let row of rows) {
                const nameText = row.getAttribute('data-name').toLowerCase();
                const cinText = row.getAttribute('data-cin').toLowerCase();
                const telText = row.getAttribute('data-tel').toLowerCase();
                const emailText = row.getAttribute('data-email').toLowerCase();
                row.style.display = nameText.includes(searchTerm) || cinText.includes(searchTerm) || telText.includes(searchTerm) || emailText.includes(searchTerm) ? '' : 'none';
            }
        }
    </script>
</body>
</html>