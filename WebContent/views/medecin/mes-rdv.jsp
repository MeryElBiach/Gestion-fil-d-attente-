<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mes Rendez-vous - HealthCare</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/patient.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/medecin/rdv.css">
</head>
<body>
    <%@ include file="/views/medecin/partials/header.jsp" %>
    <%@ include file="/views/medecin/partials/sidebar.jsp" %>

    <main class="main-content">
        <div class="row g-3 mb-4">
            <div class="col-12">
                <h1 class="mb-3"><i class="fas fa-calendar-check me-2 text-primary"></i> Mes Rendez-vous</h1>
                <p class="lead mb-3">Gérez vos consultations : <c:out value="${rdvs.size()}"/> RDV au total.</p>
            </div>
        </div>

        <!-- Messages Success/Error -->
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success alert-dismissible fade show col-12 mb-3" role="alert">
                <c:out value="${successMessage}"/>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger alert-dismissible fade show col-12 mb-3" role="alert">
                <c:out value="${errorMessage}"/>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <!-- Tableau RDV -->
        <div class="row g-3">
            <div class="col-12">
                <div class="card rdv-table-card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h3 class="card-title mb-0"><i class="fas fa-list me-2"></i> Liste des Rendez-vous</h3>
                        <div class="d-flex">
                            <select class="form-select me-2" onchange="filterRdvs(this.value)">
                                <option value="tous">Tous</option>
                                <option value="en_attente">En Attente</option>
                                <option value="confirme">Confirmés</option>
                            </select>
                            <input type="text" class="form-control me-2" placeholder="Rechercher patient/date" id="searchInput" onkeyup="filterRdvs()">
                        </div>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${not empty rdvs}">
                                <div class="table-responsive">
                                    <table class="table table-striped table-hover">
                                        <thead class="table-dark">
                                            <tr>
                                                <th>Date</th>
                                                <th>Heure</th>
                                                <th>Patient</th>
                                                <th>État</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody id="rdvTableBody">
                                            <c:forEach var="rdv" items="${rdvs}">
                                                <tr data-patient="Patient #${rdv.idPatient}" data-etat="<c:out value='${rdv.etat}'/>" data-date="<c:out value='${rdv.date}'/>">
                                                    <td><c:out value="${rdv.date}"/></td>
                                                    <td><c:out value="${rdv.heure}"/></td>
                                                    <td>
                                                        <c:forEach var="p" items="${patients}">
                                                            <c:if test="${p.id == rdv.idPatient}">
                                                                <c:out value="${p.prenom} ${p.nom}"/> 
                                                            </c:if>
                                                        </c:forEach>
                                                    </td>
                                                    <td>
                                                        <span class="badge <c:choose><c:when test="${rdv.etat == 'EN_ATTENTE'}">bg-warning</c:when><c:when test="${rdv.etat == 'CONFIRME'}">bg-success</c:when><c:when test="${rdv.etat == 'ANNULE'}">bg-danger</c:when><c:otherwise>bg-secondary</c:otherwise></c:choose>">
                                                            <c:out value="${rdv.etat}"/>
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${rdv.etat == 'EN_ATTENTE'}">
                                                                <a href="${pageContext.request.contextPath}/medecin/mes-rdv?action=confirm&idRdv=${rdv.id}" class="btn btn-sm btn-success me-1" onclick="return confirm('Confirmer ce RDV ?')">
                                                                    <i class="fas fa-check"></i> Confirmer
                                                                </a>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-success">Confirmé</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <a href="${pageContext.request.contextPath}/medecin/mes-rdv?action=annuler&idRdv=${rdv.id}" class="btn btn-sm btn-danger me-1" onclick="return confirm('Annuler ce RDV ?')">
                                                            <i class="fas fa-times"></i> Annuler
                                                        </a>
                                                        <a href="${pageContext.request.contextPath}/medecin/rapports?rdvId=${rdv.id}" class="btn btn-sm btn-primary">
                                                            <i class="fas fa-file-medical"></i> Rapport
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <p class="text-center text-muted py-4">Aucun rendez-vous trouvé. <a href="${pageContext.request.contextPath}/medecin/mes-rdv?refresh">Actualiser</a>.</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="row g-3 mb-4">
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
            <div class="col-lg-4 col-md-6">
                <a href="${pageContext.request.contextPath}/medecin/dashboard" class="btn btn-secondary w-100 h-100 d-flex align-items-center justify-content-center">
                    <i class="fas fa-arrow-left me-2"></i> Retour Dashboard
                </a>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Filtre simple JS pour état/recherche
        function filterRdvs(value) {
            const tableBody = document.getElementById('rdvTableBody');
            const rows = tableBody.getElementsByTagName('tr');
            const searchTerm = document.getElementById('searchInput').value.toLowerCase();
            const filterEtat = value;

            for (let row of rows) {
                const patientText = row.getAttribute('data-patient').toLowerCase();
                const etatText = row.getAttribute('data-etat').toLowerCase();
                const dateText = row.getAttribute('data-date');

                const matchesSearch = patientText.includes(searchTerm) || dateText.includes(searchTerm);
                const matchesEtat = filterEtat === 'tous' || etatText.includes(filterEtat);

                row.style.display = matchesSearch && matchesEtat ? '' : 'none';
            }
        }

        document.getElementById('searchInput').addEventListener('keyup', function() {
            filterRdvs(document.querySelector('select').value);
        });
    </script>
</body>
</html>