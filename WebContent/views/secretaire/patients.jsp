<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Patients - Secrétaire</title>
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
        }
    </style>
</head>
<body>
    <%@ include file="/views/secretaire/partials/header.jsp" %>
    <%@ include file="/views/secretaire/partials/sidebar.jsp" %>

    <main class="main-content">
        <div class="container-fluid">

            <h1 class="page-title">
                <i class="fas fa-users me-3"></i> Gestion des Patients
            </h1>

            <!-- Messages flash -->
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

            <!-- Liste des patients -->
            <div class="card shadow-lg border-0">
                <div class="card-header card-header-custom">
                    <h5 class="mb-0">
                        <i class="fas fa-clipboard-list me-2"></i>
                        Liste des patients <span class="badge bg-light text-dark ms-2">${patients.size()}</span>
                    </h5>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="table-dark">
                                <tr>
                                    <th style="width: 6%;">#</th>
                                    <th>Patient</th>
                                    <th>Téléphone</th>
                                    <th>Email</th>
                                    <th>CIN</th>
                                    <th style="width: 15%;" class="text-center">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="p" items="${patients}" varStatus="status">
                                    <tr>
                                        <td><strong>${status.index + 1}</strong></td>
                                        <td class="fw-bold text-primary">
                                            ${p.prenom} ${p.nom}
                                        </td>
                                        <td>
                                            <i class="fas fa-phone me-1 text-muted"></i> ${p.tel}
                                        </td>
                                        <td>
                                            <i class="fas fa-envelope me-1 text-muted"></i> ${p.email}
                                        </td>
                                        <td>
                                            <span class="badge bg-secondary">${p.cin}</span>
                                        </td>
                                        <td class="text-center">
                                            <a href="${pageContext.request.contextPath}/secretaire/patients?action=supprimer&id=${p.id}"
                                               class="btn-delete-custom"
                                               onclick="return confirm('Supprimer définitivement le patient ${p.prenom} ${p.nom} ?\nTous ses rendez-vous seront aussi supprimés.')">
                                                <i class="fas fa-trash-alt"></i> Supprimer
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>

                        <c:if test="${empty patients}">
                            <div class="text-center py-5">
                                <div class="empty-state">
                                    <i class="fas fa-users"></i>
                                    <p class="mt-3 text-muted fs-5">Aucun patient enregistré pour le moment.</p>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>

            <!-- Bouton retour -->
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