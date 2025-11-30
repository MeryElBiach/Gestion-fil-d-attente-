<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Médecins - Secrétaire</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/secretaire/stylesidesecretaire.css">
    <style>
       
        .main-content { 
            margin-top: 90px !important; 
            margin-left: 280px !important;
            padding: 20px 15px !important; 
            width: calc(100vw - 280px) !important; 
        }
        
        .page-title { 
            font-size: 2rem; 
            font-weight: 700; 
            color: #1e293b; 
            margin-bottom: 25px; 
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
        
        .btn-add-form { 
            background: linear-gradient(135deg, #00b4d8 0%, #0077b6 100%);
            color: white; 
            border: none; 
            padding: 12px 35px; 
            border-radius: 50px;
            font-weight: 600; 
            box-shadow: 0 5px 18px rgba(0,180,216,0.3); 
            transition: all 0.3s;
        }
        
        .btn-add-form:hover { 
            transform: translateY(-3px); 
            box-shadow: 0 8px 25px rgba(0,180,216,0.4); 
            color: white; 
        }
        
        .form-add { 
            background: #f8f9fa; 
            border-radius: 12px; 
            padding: 20px; 
            box-shadow: 0 4px 15px rgba(0,0,0,0.05); 
        }
        
      
        .spec-icon {
            font-size: 1.3rem;
            margin-right: 8px;
            color: #00b4d8;
        }
        
    
        .btn-delete-custom {
            background-color: #dc3545;
            color: white;
            padding: 8px 20px;
            border-radius: 8px;
            font-size: 0.9rem;
            font-weight: 600;
            border: none;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            text-decoration: none;
        }
        
        .btn-delete-custom:hover {
            background-color: #c82333;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(220, 53, 69, 0.4);
            color: white;
        }
        
        .empty-state i { 
            font-size: 4.5rem; 
            opacity: 0.4; 
            color: #00b4d8; 
        }
        
        @media (max-width: 768px) {
            .main-content { 
                margin-left: 0 !important;
                width: 100% !important; 
                margin-top: 70px !important; 
            }
            .page-title { 
                font-size: 1.7rem; 
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
                <i class="fas fa-user-md me-3"></i> Gestion des Médecins
            </h1>

           
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

         
            <div class="card mb-4 form-add">
                <div class="card-body">
                    <h5 class="mb-3 text-primary"><i class="fas fa-user-plus me-2"></i> Ajouter un nouveau médecin</h5>
                    <form action="${pageContext.request.contextPath}/secretaire/medecins" method="post" class="row g-3 align-items-end">
                        <input type="hidden" name="action" value="ajouter">
                        
                        <div class="col-lg-3 col-md-6">
                            <input type="text" name="prenom" class="form-control" placeholder="Prénom" required>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <input type="text" name="nom" class="form-control" placeholder="Nom de famille" required>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <select name="specialite" class="form-select" required>
                                <option value="">Sélectionner une spécialité</option>
                                <c:forEach var="s" items="${specialites}">
                                    <option value="${s.idSpecialite}">${s.nom}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-lg-2 col-md-6">
                            <input type="tel" name="telephone" class="form-control" placeholder="Téléphone" required>
                        </div>
                        <div class="col-lg-1 col-md-12">
                            <button type="submit" class="btn btn-success w-100">
                                <i class="fas fa-plus"></i>
                            </button>
                        </div>
                    </form>
                </div>
            </div>

     
            <div class="card shadow-lg border-0">
                <div class="card-header card-header-custom">
                    <h5 class="mb-0">
                        <i class="fas fa-users-md me-2"></i> 
                        Liste des médecins <span class="badge bg-light text-dark ms-2">${medecins.size()}</span>
                    </h5>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="table-dark">
                                <tr>
                                    <th style="width: 6%;">#</th>
                                    <th>Médecin</th>
                                    <th>Spécialité</th>
                                    <th>Téléphone</th>
                                    <th style="width: 15%;" class="text-center">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="med" items="${medecins}" varStatus="status">
                                    <tr>
                                        <td><strong>${status.index + 1}</strong></td>
                                        <td class="fw-bold text-primary">
                                            Dr. ${med.prenom} ${med.nom}
                                        </td>
                                        <td>
                                            <span class="d-flex align-items-center">
                                                <!-- Icônes exactes de specialites.jsp -->
                                                <c:choose>
                                                    <c:when test="${med.nomSpecialite == 'Cardiologie'}">
                                                        <i class="fas fa-heartbeat spec-icon"></i>
                                                    </c:when>
                                                    <c:when test="${med.nomSpecialite == 'Dermatologie'}">
                                                        <i class="fas fa-user-md spec-icon"></i>
                                                    </c:when>
                                                    <c:when test="${med.nomSpecialite == 'Gastro-entérologie' || med.nomSpecialite == 'Gastroentérologie'}">
                                                        <i class="fas fa-hospital spec-icon"></i>
                                                    </c:when>
                                                    <c:when test="${med.nomSpecialite == 'Gynécologie'}">
                                                        <i class="fas fa-female spec-icon"></i>
                                                    </c:when>
                                                    <c:when test="${med.nomSpecialite == 'Neurologie'}">
                                                        <i class="fas fa-brain spec-icon"></i>
                                                    </c:when>
                                                    <c:when test="${med.nomSpecialite == 'Ophtalmologie'}">
                                                        <i class="fas fa-eye spec-icon"></i>
                                                    </c:when>
                                                    <c:when test="${med.nomSpecialite == 'Pédiatrie'}">
                                                        <i class="fas fa-child spec-icon"></i>
                                                    </c:when>
                                                    <c:when test="${med.nomSpecialite == 'Psychiatrie'}">
                                                        <i class="fas fa-user-nurse spec-icon"></i>
                                                    </c:when>
                                                    <c:when test="${med.nomSpecialite == 'Radiologie'}">
                                                        <i class="fas fa-x-ray spec-icon"></i>
                                                    </c:when>
                                                    <c:when test="${med.nomSpecialite == 'Dentisterie' || med.nomSpecialite == 'Dentiste'}">
                                                        <i class="fas fa-tooth spec-icon"></i>
                                                    </c:when>
                                                    <c:when test="${med.nomSpecialite == 'Orthopédie'}">
                                                        <i class="fas fa-bone spec-icon"></i>
                                                    </c:when>
                                                    <c:when test="${med.nomSpecialite == 'ORL' || med.nomSpecialite == 'Oto-rhino-laryngologie'}">
                                                        <i class="fas fa-deaf spec-icon"></i>
                                                    </c:when>
                                                    <c:when test="${med.nomSpecialite == 'Pneumologie'}">
                                                        <i class="fas fa-lungs spec-icon"></i>
                                                    </c:when>
                                                    <c:when test="${med.nomSpecialite == 'Rhumatologie'}">
                                                        <i class="fas fa-walking spec-icon"></i>
                                                    </c:when>
                                                    <c:when test="${med.nomSpecialite == 'Urologie'}">
                                                        <i class="fas fa-procedures spec-icon"></i>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <i class="fas fa-stethoscope spec-icon"></i>
                                                    </c:otherwise>
                                                </c:choose>
                                                <span class="fw-semibold">${med.nomSpecialite}</span>
                                            </span>
                                        </td>
                                        <td>
                                            <i class="fas fa-phone me-1 text-muted"></i>
                                            ${med.tel}
                                        </td>
                                        <td class="text-center">
                                          
                                            <a href="${pageContext.request.contextPath}/secretaire/medecins?action=supprimer&id=${med.id}"
                                               class="btn-delete-custom"
                                               onclick="return confirm('Êtes-vous sûr de vouloir supprimer Dr. ${med.prenom} ${med.nom} ?\nAttention : tous ses rendez-vous seront aussi supprimés.')">
                                                <i class="fas fa-trash-alt"></i> Supprimer
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>

                        <!-- État vide -->
                        <c:if test="${empty medecins}">
                            <div class="text-center py-5">
                                <div class="empty-state">
                                    <i class="fas fa-user-md"></i>
                                    <p class="mt-3 text-muted fs-5">Aucun médecin enregistré pour le moment.</p>
                                    <small>Utilisez le formulaire ci-dessus pour en ajouter un.</small>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>

            <div class="text-center mt-5">
                <a href="${pageContext.request.contextPath}/secretaire/dashboard" class="btn btn-add-form">
                    <i class="fas fa-arrow-left me-2"></i> Retour au tableau de bord
                </a>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>