<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset Snake="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mes Résultats Médicaux - HealthCare</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/patient.css">
    <style>
        .badge-specialite {
            font-size: 0.8rem;
            padding: 0.4em 0.8em;
        }
        .rapport-card {
            transition: all 0.3s ease;
            border-left: 5px solid #007bff;
        }
        .rapport-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
        }
        .empty-state i {
            font-size: 5rem;
            color: #adb5bd;
        }
    </style>
</head>
<body>

    <%@ include file="/views/patient/partials/header.jsp" %>
    <%@ include file="/views/patient/partials/sidebar.jsp" %>

    <main class="main-content p-4">

        <!-- Titre + icône -->
        <div class="d-flex align-items-center mb-4">
            <i class="fas fa-file-medical-alt text-primary me-3" style="font-size: 2.8rem;"></i>
            <h1 class="mb-0 fw-bold">Mes Résultats Médicaux</h1>
        </div>

        <p class="lead text-muted mb-5">
            Retrouvez tous les rapports rédigés par vos médecins après vos consultations.
        </p>

        <!-- Barre de recherche -->
        <div class="card shadow-sm mb-5">
            <div class="card-body">
                <div class="input-group input-group-lg">
                    <span class="input-group-text bg-white"><i class="fas fa-search text-muted"></i></span>
                    <input type="text" class="form-control" id="searchInput"
                           placeholder="Rechercher par médecin, spécialité ou mot-clé..." onkeyup="filterCards()">
                    <button class="btn btn-outline-secondary" type="button" onclick="clearSearch()">
                        <i class="fas fa-times"></i>
                    </button>
                </div>
            </div>
        </div>

        <!-- Liste des rapports -->
        <c:choose>
            <c:when test="${not empty rapportsPatient}">
                <div class="row g-4" id="rapportsContainer">
                    <c:forEach var="r" items="${rapportsPatient}">
                        <div class="col-md-6 col-lg-4 rapport-item"
                             data-medecin="${r.prenomMedecin} ${r.nomMedecin}"
                             data-specialite="${r.specialite}"
                             data-description="${r.description}">

                            <div class="card h-100 rapport-card shadow-sm">
                                <div class="card-body d-flex flex-column">
                                    <div class="d-flex justify-content-between align-items-start mb-3">
                                        <div>
                                            <h5 class="card-title mb-1 fw-bold">
                                                Dr. ${r.prenomMedecin} ${r.nomMedecin}
                                            </h5>
                                            <span class="badge bg-primary badge-specialite">
                                                <i class="fas fa-stethoscope me-1"></i>
                                                ${r.specialite != null ? r.specialite : 'Non spécifiée'}
                                            </span>
                                        </div>
                                        <small class="text-muted">
    <c:choose>
        <c:when test="${not empty r.dateRapport}">
            ${r.dateRapport.dayOfMonth}/
            <c:if test="${r.dateRapport.monthValue < 10}">0</c:if>${r.dateRapport.monthValue}/${r.dateRapport.year}
        </c:when>
        <c:otherwise>
            Date non renseignée
        </c:otherwise>
    </c:choose>
</small>
                                    </div>

                                    <p class="card-text text-muted flex-grow-1 mb-4">
                                        <c:out value="${r.description}" escapeXml="true" />
                                    </p>

                                    <div class="mt-auto">
                                        <a href="${pageContext.request.contextPath}/patient/rapport-detail?id=${r.id}"
                                           class="btn btn-outline-primary btn-sm me-2">
                                            <i class="fas fa-eye me-1"></i> Voir le rapport
                                        </a>
                                        <c:if test="${not empty r.pdfPath}">
                                            <a href="${pageContext.request.contextPath}/download-rapport?id=${r.id}"
                                               class="btn btn-success btn-sm" title="Télécharger PDF">
                                                <i class="fas fa-file-pdf"></i>
                                            </a>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>

            <c:otherwise>
                <!-- État vide -->
                <div class="text-center py-5">
                    <div class="empty-state mb-4">
                        <i class="fas fa-folder-open"></i>
                    </div>
                    <h3 class="text-muted fw-normal">Aucun résultat médical disponible</h3>
                    <p class="text-muted lead">
                        Vos rapports apparaîtront ici dès qu’un médecin en rédigera un après votre consultation.
                    </p>
                    <a href="${pageContext.request.contextPath}/patient/prendre-rdv"
                       class="btn btn-primary btn-lg mt-4">
                        <i class="fas fa-calendar-plus me-2"></i> Prendre un rendez-vous
                    </a>
                </div>
            </c:otherwise>
        </c:choose>

        <!-- Boutons du bas -->
        <div class="row g-3 mt-5">
            <div class="col-md-4">
                <a href="${pageContext.request.contextPath}/patient/dashboard" class="btn btn-secondary w-100">
                    <i class="fas fa-arrow-left me-2"></i> Retour Dashboard
                </a>
            </div>
            <div class="col-md-4">
                <a href="${pageContext.request.contextPath}/patient/mes-rdv" class="btn btn-primary w-100">
                    <i class="fas fa-calendar-check me-2"></i> Mes Rendez-vous
                </a>
            </div>
            <div class="col-md-4">
                <a href="${pageContext.request.contextPath}/patient/prendre-rdv" class="btn btn-success w-100">
                    <i class="fas fa-plus me-2"></i> Prendre RDV
                </a>
            </div>
        </div>

    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function filterCards() {
            const query = document.getElementById('searchInput').value.toLowerCase();
            const cards = document.querySelectorAll('.rapport-item');

            cards.forEach(card => {
                const text = (
                    card.getAttribute('data-medecin') +
                    card.getAttribute('data-specialite') +
                    card.getAttribute('data-description')
                ).toLowerCase();

                card.style.display = text.includes(query) ? '' : 'none';
            });
        }

        function clearSearch() {
            document.getElementById('searchInput').value = '';
            filterCards();
        }
    </script>
</body>
</html>