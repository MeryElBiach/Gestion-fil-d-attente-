<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Spécialités - Secrétaire</title>
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
        
        /* Header avec titre et bouton sur la même ligne */
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            flex-wrap: wrap;
            gap: 15px;
        }
        
        .page-title {
            font-size: 2rem;
            font-weight: 700;
            color: #1e293b;
            margin: 0;
        }
        
        .page-title i { 
            color: #00b4d8 !important; 
            font-size: 2.2rem;
        }
        
        .card-header-custom {
            background: linear-gradient(135deg, #00b4d8 0%, #0077b6 100%) !important;
            color: white;
            padding: 15px 20px;
        }
        
        .btn-add, .btn-return-custom {
            background: linear-gradient(135deg, #00b4d8 0%, #0077b6 100%);
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 50px;
            font-weight: 600;
            box-shadow: 0 5px 18px rgba(0, 180, 216, 0.3);
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }
        
        .btn-add:hover, .btn-return-custom:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(0, 180, 216, 0.4);
            color: white;
        }
        
        /* Icônes de spécialités - pas de bordure ni background */
        .spec-icon {
            font-size: 1.5rem;
            margin-right: 12px;
            color: #00b4d8;
        }
        
        .spec-name {
            font-size: 1.1rem;
            font-weight: 600;
            color: #2c3e50;
            display: flex;
            align-items: center;
        }
        
        /* Boutons d'action avec texte */
        .action-buttons {
            display: flex;
            gap: 10px;
            justify-content: center;
        }
        
        .btn-action {
            padding: 8px 20px;
            border-radius: 8px;
            font-size: 0.9rem;
            font-weight: 600;
            border: none;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 6px;
        }
        
        .btn-edit {
            background-color: #ffc107;
            color: #000;
        }
        
        .btn-edit:hover {
            background-color: #ffb300;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(255, 193, 7, 0.4);
        }
        
        .btn-delete {
            background-color: #dc3545;
            color: white;
        }
        
        .btn-delete:hover {
            background-color: #c82333;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(220, 53, 69, 0.4);
        }
        
        /* Table */
        .table {
            font-size: 0.95rem;
        }
        
        .table thead th {
            background-color: #2c3e50;
            color: white;
            padding: 15px 12px;
            font-weight: 600;
        }
        
        .table tbody td {
            padding: 18px 12px;
            vertical-align: middle;
        }
        
        .table tbody tr:hover {
            background-color: #f8f9fa;
        }
        
        .empty-state {
            padding: 80px 20px;
            text-align: center;
            color: #6c757d;
        }
        
        .empty-state i {
            font-size: 5rem;
            opacity: 0.4;
            margin-bottom: 20px;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .main-content { 
                max-width: 100% !important; 
                margin-top: 70px !important; 
            }
            .page-title { 
                font-size: 1.7rem; 
            }
            .page-header {
                flex-direction: column;
                align-items: flex-start;
            }
            .btn-add {
                width: 100%;
                text-align: center;
            }
            .action-buttons {
                flex-direction: column;
                width: 100%;
            }
            .btn-action {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <%@ include file="/views/secretaire/partials/header.jsp" %>
    <%@ include file="/views/secretaire/partials/sidebar.jsp" %>

    <main class="main-content">
        <div class="container-fluid">

            <!-- Header avec titre et bouton -->
            <div class="page-header">
                <h1 class="page-title">
                    <i class="fas fa-stethoscope me-3"></i> Gestion des Spécialités
                </h1>
                <button class="btn btn-add" data-bs-toggle="modal" data-bs-target="#addModal">
                    <i class="fas fa-plus me-2"></i> Ajouter une spécialité
                </button>
            </div>

            <!-- Messages -->
            <c:if test="${not empty sessionScope.successMessage}">
                <div class="alert alert-success alert-dismissible fade show">
                    <i class="fas fa-check-circle me-2"></i> ${sessionScope.successMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <% session.removeAttribute("successMessage"); %>
            </c:if>
            <c:if test="${not empty sessionScope.errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show">
                    <i class="fas fa-exclamation-triangle me-2"></i> ${sessionScope.errorMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <% session.removeAttribute("errorMessage"); %>
            </c:if>

            <!-- Carte principale -->
            <div class="card shadow-lg border-0">
                <div class="card-header card-header-custom">
                    <h5 class="mb-0"><i class="fas fa-list-alt me-2"></i> Liste des spécialités (${specialites.size()})</h5>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead>
                                <tr>
                                    <th style="width: 8%;">#</th>
                                    <th>Nom de la spécialité</th>
                                    <th style="width: 30%;" class="text-center">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="spec" items="${specialites}" varStatus="status">
                                    <tr>
                                        <td><strong>${status.index + 1}</strong></td>
                                        <td>
                                            <div class="spec-name">
                                                <c:choose>
                                                    <c:when test="${spec.nom == 'Cardiologie'}">
                                                        <i class="fas fa-heartbeat spec-icon"></i>
                                                    </c:when>
                                                    <c:when test="${spec.nom == 'Dermatologie'}">
                                                        <i class="fas fa-user-md spec-icon"></i>
                                                    </c:when>
                                                    <c:when test="${spec.nom == 'Gastro-entérologie' || spec.nom == 'Gastroentérologie'}">
                                                        <i class="fas fa-hospital spec-icon"></i>
                                                    </c:when>
                                                    <c:when test="${spec.nom == 'Gynécologie'}">
                                                        <i class="fas fa-female spec-icon"></i>
                                                    </c:when>
                                                    <c:when test="${spec.nom == 'Neurologie'}">
                                                        <i class="fas fa-brain spec-icon"></i>
                                                    </c:when>
                                                    <c:when test="${spec.nom == 'Ophtalmologie'}">
                                                        <i class="fas fa-eye spec-icon"></i>
                                                    </c:when>
                                                    <c:when test="${spec.nom == 'Pédiatrie'}">
                                                        <i class="fas fa-child spec-icon"></i>
                                                    </c:when>
                                                    <c:when test="${spec.nom == 'Psychiatrie'}">
                                                        <i class="fas fa-user-nurse spec-icon"></i>
                                                    </c:when>
                                                    <c:when test="${spec.nom == 'Radiologie'}">
                                                        <i class="fas fa-x-ray spec-icon"></i>
                                                    </c:when>
                                                    <c:when test="${spec.nom == 'Dentisterie' || spec.nom == 'Dentiste'}">
                                                        <i class="fas fa-tooth spec-icon"></i>
                                                    </c:when>
                                                    <c:when test="${spec.nom == 'Orthopédie'}">
                                                        <i class="fas fa-bone spec-icon"></i>
                                                    </c:when>
                                                    <c:when test="${spec.nom == 'ORL' || spec.nom == 'Oto-rhino-laryngologie'}">
                                                        <i class="fas fa-deaf spec-icon"></i>
                                                    </c:when>
                                                    <c:when test="${spec.nom == 'Pneumologie'}">
                                                        <i class="fas fa-lungs spec-icon"></i>
                                                    </c:when>
                                                    <c:when test="${spec.nom == 'Rhumatologie'}">
                                                        <i class="fas fa-walking spec-icon"></i>
                                                    </c:when>
                                                    <c:when test="${spec.nom == 'Urologie'}">
                                                        <i class="fas fa-procedures spec-icon"></i>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <i class="fas fa-stethoscope spec-icon"></i>
                                                    </c:otherwise>
                                                </c:choose>
                                                <c:out value="${spec.nom}"/>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="action-buttons">
                                                <button class="btn-action btn-edit" data-bs-toggle="modal"
                                                        data-bs-target="#editModal${spec.idSpecialite}">
                                                    <i class="fas fa-edit"></i> Modifier
                                                </button>
                                                <a href="${pageContext.request.contextPath}/secretaire/specialites?action=supprimer&id=${spec.idSpecialite}"
                                                   class="btn-action btn-delete"
                                                   onclick="return confirm('Supprimer la spécialité « ${spec.nom} » ?')">
                                                    <i class="fas fa-trash-alt"></i> Supprimer
                                                </a>
                                            </div>
                                        </td>
                                    </tr>

                                    <!-- Modal Modifier -->
                                    <div class="modal fade" id="editModal${spec.idSpecialite}">
                                        <div class="modal-dialog modal-dialog-centered">
                                            <div class="modal-content">
                                                <form action="${pageContext.request.contextPath}/secretaire/specialites" method="post">
                                                    <div class="modal-header bg-warning">
                                                        <h5 class="modal-title text-dark"><i class="fas fa-edit"></i> Modifier la spécialité</h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <input type="hidden" name="action" value="modifier">
                                                        <input type="hidden" name="id" value="${spec.idSpecialite}">
                                                        <div class="mb-3">
                                                            <label class="form-label fw-bold">Nom de la spécialité</label>
                                                            <input type="text" name="nomSpecialite" class="form-control form-control-lg"
                                                                   value="<c:out value='${spec.nom}'/>" required>
                                                        </div>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
                                                        <button type="submit" class="btn btn-warning text-dark fw-bold">Enregistrer</button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </tbody>
                        </table>

                        <c:if test="${empty specialites}">
                            <div class="empty-state">
                                <i class="fas fa-stethoscope"></i>
                                <p class="mb-0 fs-4">Aucune spécialité enregistrée pour le moment.</p>
                                <small class="text-muted">Commencez par en ajouter une !</small>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>

            <!-- Modal Ajouter -->
            <div class="modal fade" id="addModal">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <form action="${pageContext.request.contextPath}/secretaire/specialites" method="post">
                            <div class="modal-header card-header-custom">
                                <h5 class="modal-title"><i class="fas fa-plus"></i> Nouvelle spécialité</h5>
                                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body">
                                <input type="hidden" name="action" value="ajouter">
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Nom de la spécialité</label>
                                    <input type="text" name="nomSpecialite" class="form-control form-control-lg"
                                           placeholder="Ex : Cardiologie, Pédiatrie..." required>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
                                <button type="submit" class="btn btn-add">Ajouter</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Bouton Retour -->
            <div class="text-center mt-5">
                <a href="${pageContext.request.contextPath}/secretaire/dashboard" class="btn-return-custom">
                    <i class="fas fa-arrow-left me-2"></i> Retour au tableau de bord
                </a>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>