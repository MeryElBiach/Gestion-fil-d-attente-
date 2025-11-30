<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="com.clinique.beans.Patient" %>
<%@ page import="com.clinique.beans.RendezVous" %>
<%@ page import="com.clinique.beans.Medecin" %>
<%
    Patient patient = (Patient) request.getAttribute("patient");
    List<RendezVous> rdvs = (List<RendezVous>) request.getAttribute("rdvs");
    String success = (String) request.getAttribute("success");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Mes Rendez-Vous - HealthCare</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/patient.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/patient/rdv.css"> <!-- Ton CSS pour style -->
</head>
<body>
    <%@ include file="/views/patient/partials/header.jsp" %>
    <%@ include file="/views/patient/partials/sidebar.jsp" %>

    <main class="main-content">
        <div class="container">
            <h2>Mes Rendez-Vous</h2>

            <!-- Success Message after Creation -->
            <% if ("1".equals(success)) { %>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle"></i> Rendez-vous réservé avec succès !
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            <% } %>

            <!-- Infos Patient Quick voit whatsp -->
           
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead class="table-dark">
                        <tr>
                            <th>Date</th>
                            <th>Heure</th>
                            <th>Médecin</th>
                            <th>État</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (rdvs != null && !rdvs.isEmpty()) { %>
                            <c:forEach var="rdv" items="${rdvs}">
                                <tr class="align-middle">
                                    <!-- Utilisation directe des propriétés du bean RendezVous -->
                                    <td><i class="fas fa-calendar-alt text-info me-2"></i> ${rdv.date}</td>
                                    <td><i class="fas fa-clock text-warning me-2"></i> ${rdv.heure}</td>
                                    <td>
    <i class="fas fa-user-md text-success me-2"></i>
    <c:forEach var="m" items="${medecins}">
        <c:if test="${m.id == rdv.idMedecin}">
            Dr. ${m.nom} ${m.prenom}
        </c:if>
    </c:forEach>
</td>

                                    <td>
                                        <span class="badge ${rdv.etat == 'EN_ATTENTE' ? 'bg-warning' : rdv.etat == 'CONFIRME' ? 'bg-success' : rdv.etat == 'ANNULE' ? 'bg-danger' : 'bg-secondary'}">
                                            <i class="fas ${rdv.etat == 'EN_ATTENTE' ? 'fa-clock' : rdv.etat == 'CONFIRME' ? 'fa-check' : rdv.etat == 'ANNULE' ? 'fa-times' : 'fa-info'} me-1"></i>
                                            ${rdv.etat}
                                        </span>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${rdv.etat == 'ANNULE'}">
                                                <span class="text-muted">Annulé</span>
                                            </c:when>
                                            <c:when test="${rdv.etat == 'EN_ATTENTE'}">
                                                <a href="${pageContext.request.contextPath}/patient/rdv/annuler?id=${rdv.id}" class="btn btn-sm btn-outline-danger" onclick="return confirm('Annuler ce RDV ?')">
                                                    <i class="fas fa-times"></i> Annuler
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="${pageContext.request.contextPath}/patient/rdv/details?id=${rdv.id}" class="btn btn-sm btn-outline-primary">
                                                    <i class="fas fa-eye"></i> Voir
                                                </a>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        <% } else { %>
                            <tr>
                                <td colspan="5" class="text-center text-muted py-4">
                                    <i class="fas fa-calendar-times fa-3x mb-3"></i>
                                    <p>Aucun rendez-vous pour le moment.</p>
                                    <a href="${pageContext.request.contextPath}/patient/prendre-rdv" class="btn btn-primary">
                                        <i class="fas fa-plus"></i> Prendre un RDV
                                    </a>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
            <nav aria-label="Pagination RDV" class="mt-4">
                <ul class="pagination justify-content-center">
                    <li class="page-item disabled">
                        <a class="page-link" href="#">Précédent</a>
                    </li>
                    <li class="page-item active"><a class="page-link" href="#">1</a></li>
                    <li class="page-item"><a class="page-link" href="#">Suivant</a></li>
                </ul>
            </nav>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Confirm annulation
        function confirmAnnuler(id) {
            return confirm('Êtes-vous sûr d\'annuler ce rendez-vous ?');
        }
    </script>
</body>
</html>