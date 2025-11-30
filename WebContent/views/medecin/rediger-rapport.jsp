<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rédiger un Rapport Médical - HealthCare</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/patient.css">
    <style>
        .form-label { font-weight: 600; color: #2c3e50; }
        .card { border: none; }
        .patient-info { background: #f8f9fa; padding: 15px; border-radius: 10px; margin-top: 15px; }
    </style>
</head>
<body>
    <%@ include file="/views/medecin/partials/header.jsp" %>
    <%@ include file="/views/medecin/partials/sidebar.jsp" %>

    <main class="main-content">
        <div class="d-flex align-items-center justify-content-between mb-4">
            <div class="d-flex align-items-center">
                <i class="fas fa-file-medical text-primary me-3" style="font-size: 2.4rem;"></i>
                <h1 class="mb-0">Rédiger un Rapport Médical</h1>
            </div>
            <a href="${pageContext.request.contextPath}/medecin/rapports" class="btn btn-secondary btn-lg">
                <i class="fas fa-arrow-left me-2"></i> Retour à la liste
            </a>
        </div>

        <!-- Message d'erreur -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show">
                <strong>Erreur :</strong> ${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <!-- Message de succès -->
        <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show">
                <i class="fas fa-check-circle me-2"></i> ${success}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <div class="card shadow-lg">
            <div class="card-body p-5">
                <form action="${pageContext.request.contextPath}/medecin/rediger-rapport" method="post" enctype="multipart/form-data">

                    <!-- ==================== SÉLECTION DU PATIENT (OBLIGATOIRE) ==================== -->
                   <h4 class="mb-4 text-primary">Sélectionner le patient</h4>
<div class="row g-4 mb-5">
 <div class="col-md-12">
 <label class="form-label">Patient <span class="text-danger">*</span></label>
 <select name="patient_id" class="form-select form-select-lg" required>
 <option value="">-- Choisir un patient --</option>
 <c:forEach var="p" items="${patients}">
 <option value="${p.id}">
 ${p.prenom} ${p.nom} (CIN: ${p.cin}) - Tél: ${p.tel != null ? p.tel : 'Non renseigné'}
 </option>
 </c:forEach>
 </select>
 </div>
</div>

                    <!-- Affichage des infos du patient sélectionné -->
                    <div id="patientInfo" class="patient-info d-none">
                        <h5><i class="fas fa-id-card text-primary"></i> Informations du patient</h5>
                        <div class="row">
                            <div class="col-md-6"><strong>Nom :</strong> <span id="infoNom">-</span></div>
                            <div class="col-md-6"><strong>Prénom :</strong> <span id="infoPrenom">-</span></div>
                            <div class="col-md-6"><strong>CIN :</strong> <span id="infoCin">-</span></div>
                            <div class="col-md-6"><strong>Téléphone :</strong> <span id="infoTel">-</span></div>
                            <div class="col-md-6"><strong>Date de naissance :</strong> <span id="infoDate">-</span></div>
                        </div>
                    </div>

                    <hr class="my-5">

                
                    <h4 class="mb-(Debug4 text-primary">
                        <i class="fas fa-file-alt me-2"></i> Contenu du rapport médical
                    </h4>

                    <div class="mb-4">
                        <label class="form-label">Date du rapport</label>
                        <input type="date" class="form-control form-control-lg" name="dateRapport"
                               value="<fmt:formatDate pattern='yyyy-MM-dd' value='${today}'/>" required>
                    </div>

                    <div class="mb-4">
                        <label class="form-label">Compte-rendu médical</label>
                        <textarea class="form-control" name="description" rows="20" required
                                  placeholder="Motif de consultation, antécédents, examen clinique, diagnostic, traitement prescrit, recommandations, suivi..."></textarea>
                    </div>

                    <div class="d-grid">
                        <button type="submit" class="btn btn-success btn-lg">
                            <i class="fas fa-save me-2"></i> Enregistrer le rapport et générer le PDF
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </main>

    <jsp:useBean id="today" class="java.util.Date"/>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function showPatientInfo() {
            const select = document.getElementById("patientSelect");
            const selected = select.options[select.selectedIndex];
            const infoDiv = document.getElementById("patientInfo");

            if (selected.value) {
                document.getElementById("infoNom").textContent = selected.dataset.nom;
                document.getElementById("infoPrenom").textContent = selected.dataset.prenom;
                document.getElementById("infoCin").textContent = selected.dataset.cin;
                document.getElementById("infoTel").textContent = selected.dataset.tel;
                document.getElementById("infoDate").textContent = selected.dataset.date;
                infoDiv.classList.remove("d-none");
            } else {
                infoDiv.classList.add("d-none");
            }
        }

        // Si un patient est pré-sélectionné (en cas d'erreur de validation)
        window.onload = function() {
            if (document.getElementById("patientSelect").value) {
                showPatientInfo();
            }
        };
    </script>
</body>
</html>