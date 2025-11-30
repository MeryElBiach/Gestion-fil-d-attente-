<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tous les Rendez-vous - Secrétaire</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/secretaire/stylesidesecretaire.css">
    <style>
       
        .main-content {
            margin-top: 90px !important;
            padding: 20px 15px !important;
            margin-left: auto !important;
            max-width: calc(100vw - 300px) !important;
        }
        
        .container-fluid {
            max-width: 100%;
            padding: 0 10px;
        }
     
        .page-title {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 15px;
            color: #1e293b !important;
        }
        
        .page-title i {
            color: #00b4d8 !important;
        }
        
        .lead {
            font-size: 1rem;
            margin-bottom: 20px;
        }
        

        .card-header-custom {
            background: linear-gradient(135deg, #00b4d8 0%, #0077b6 100%) !important;
            color: white;
            padding: 15px 20px;
            border-radius: 10px 10px 0 0;
        }
        
        .card-header-custom h5 {
            margin: 0;
            font-size: 1.1rem;
            font-weight: 600;
        }
        
       
        .card {
            border-radius: 10px;
            border: none;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
        }
       
        .table-responsive {
            max-height: 500px;
            overflow-y: auto;
        }
        
        .table {
            font-size: 0.9rem;
            margin-bottom: 0;
        }
        
        .table thead th {
            position: sticky;
            top: 0;
            background-color: #2c3e50;
            color: white;
            z-index: 10;
            padding: 12px 10px;
            font-size: 0.9rem;
            font-weight: 600;
        }
        
        .table tbody td {
            padding: 12px 10px;
            vertical-align: middle;
        }
        
        /* Badges */
        .badge-etat {
            font-size: 0.85em;
            padding: 0.4em 0.8em;
            min-width: 110px;
            text-align: center;
            font-weight: 600;
        }
        
        .badge.bg-info {
            background-color: #17a2b8 !important;
        }
        
  
        .btn-group-sm .btn {
            padding: 0.35rem 0.6rem;
            font-size: 0.85rem;
        }
        
        .btn-sm i {
            margin-right: 0;
        }
        
       
        .btn-return-custom {
            background: linear-gradient(135deg, #00b4d8 0%, #0077b6 100%);
            color: white;
            border: none;
            padding: 12px 35px;
            border-radius: 50px;
            font-weight: 600;
            font-size: 1rem;
            transition: all 0.3s ease;
            box-shadow: 0 5px 18px rgba(0, 180, 216, 0.3);
            text-decoration: none;
            display: inline-block;
        }
        
        .btn-return-custom:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(0, 180, 216, 0.4);
            color: white;
        }
        
        .btn-return-custom i {
            margin-right: 8px;
        }
        
   
        .alert {
            font-size: 0.95rem;
            padding: 12px 20px;
            border-radius: 8px;
        }
        
     
        .empty-state {
            padding: 60px 20px;
            text-align: center;
            color: #6c757d;
        }
        
        .empty-state i {
            font-size: 4rem;
            margin-bottom: 20px;
            opacity: 0.5;
        }
        
    
        @media (max-width: 768px) {
            .main-content {
                max-width: 100% !important;
                margin-top: 70px !important;
                padding: 15px 10px !important;
            }
            
            .table {
                font-size: 0.8rem;
            }
            
            .page-title {
                font-size: 1.6rem;
            }
            
            .badge-etat {
                min-width: 90px;
                font-size: 0.75em;
            }
        }
    </style>
</head>
<body>
    <%@ include file="/views/secretaire/partials/header.jsp" %>
    <%@ include file="/views/secretaire/partials/sidebar.jsp" %>

    <main class="main-content">
        <div class="container-fluid">
            <h1 class="page-title">
                <i class="fas fa-calendar-check me-2"></i> Tous les Rendez-vous
            </h1>
            <p class="lead">Total : <strong>${rdvs.size()}</strong> rendez-vous</p>

            <!-- Messages -->
            <c:if test="${not empty sessionScope.successMessage}">
                <div class="alert alert-success alert-dismissible fade show">
                    <i class="fas fa-check-circle me-2"></i>
                    ${sessionScope.successMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <% session.removeAttribute("successMessage"); %>
            </c:if>

            <div class="card">
                <div class="card-header card-header-custom">
                    <h5><i class="fas fa-list-ul me-2"></i> Liste complète des rendez-vous</h5>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="table-dark">
                                <tr>
                                    <th>Date</th>
                                    <th>Heure</th>
                                    <th>Patient</th>
                                    <th>Médecin</th>
                                    <th>Spécialité</th>
                                    <th>État</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="rdv" items="${rdvs}">
                                    <tr>
                                        <td><strong><c:out value="${rdv.date}"/></strong></td>
                                        <td><c:out value="${rdv.heure}"/></td>
                                        <td><c:out value="${rdv.patientNom}"/></td>
                                        <td>Dr. <c:out value="${rdv.medecinNom}"/></td>
                                        <td>
                                            <span class="badge bg-info text-white">
                                                <c:out value="${rdv.specialite}"/>
                                            </span>
                                        </td>

                                        <!-- État avec couleur + icône -->
                                        <td>
                                            <span class="badge badge-etat
                                                <c:choose>
                                                    <c:when test="${rdv.etat == 'EN_ATTENTE'}">bg-warning text-dark</c:when>
                                                    <c:when test="${rdv.etat == 'CONFIRME'}">bg-success</c:when>
                                                    <c:when test="${rdv.etat == 'TERMINE'}">bg-secondary</c:when>
                                                    <c:when test="${rdv.etat == 'ANNULE'}">bg-danger</c:when>
                                                    <c:otherwise>bg-light text-dark</c:otherwise>
                                                </c:choose>">
                                                <c:choose>
                                                    <c:when test="${rdv.etat == 'EN_ATTENTE'}">
                                                        <i class="fas fa-clock me-1"></i> En attente
                                                    </c:when>
                                                    <c:when test="${rdv.etat == 'CONFIRME'}">
                                                        <i class="fas fa-check-circle me-1"></i> Confirmé
                                                    </c:when>
                                                    <c:when test="${rdv.etat == 'TERMINE'}">
                                                        <i class="fas fa-check-double me-1"></i> Terminé
                                                    </c:when>
                                                    <c:when test="${rdv.etat == 'ANNULE'}">
                                                        <i class="fas fa-times-circle me-1"></i> Annulé
                                                    </c:when>
                                                    <c:otherwise>
                                                        <i class="fas fa-question-circle me-1"></i> Inconnu
                                                    </c:otherwise>
                                                </c:choose>
                                            </span>
                                        </td>

                                        <!-- Actions -->
                                        <td>
                                            <div class="btn-group btn-group-sm" role="group">
                                                <c:choose>
                                                    <c:when test="${rdv.etat == 'EN_ATTENTE'}">
                                                        <a href="${pageContext.request.contextPath}/secretaire/rendezvous?action=confirmer&idRdv=${rdv.id}"
                                                           class="btn btn-success" title="Confirmer"
                                                           onclick="return confirm('Confirmer ce rendez-vous ?')">
                                                            <i class="fas fa-check"></i>
                                                        </a>
                                                        <a href="${pageContext.request.contextPath}/secretaire/rendezvous?action=annuler&idRdv=${rdv.id}"
                                                           class="btn btn-danger" title="Annuler"
                                                           onclick="return confirm('Annuler ce rendez-vous ?')">
                                                            <i class="fas fa-times"></i>
                                                        </a>
                                                    </c:when>

                                                    <c:when test="${rdv.etat == 'CONFIRME'}">
                                                        <a href="${pageContext.request.contextPath}/secretaire/rendezvous?action=terminer&idRdv=${rdv.id}"
                                                           class="btn btn-secondary" title="Marquer comme terminé"
                                                           onclick="return confirm('Clôturer ce rendez-vous ?')">
                                                            <i class="fas fa-check-double"></i>
                                                        </a>
                                                    </c:when>

                                                    <c:when test="${rdv.etat == 'TERMINE'}">
                                                        <button class="btn btn-outline-secondary" disabled>
                                                            <i class="fas fa-check-double"></i>
                                                        </button>
                                                    </c:when>

                                                    <c:when test="${rdv.etat == 'ANNULE'}">
                                                        <button class="btn btn-outline-danger" disabled>
                                                            <i class="fas fa-times"></i>
                                                        </button>
                                                    </c:when>
                                                </c:choose>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>

                        <c:if test="${empty rdvs}">
                            <div class="empty-state">
                                <i class="fas fa-calendar-times"></i>
                                <p class="mb-0">Aucun rendez-vous pour le moment.</p>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>

            <div class="text-center mt-4">
                <a href="${pageContext.request.contextPath}/secretaire/dashboard" class="btn-return-custom">
                    <i class="fas fa-arrow-left"></i> Retour au tableau de bord
                </a>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>