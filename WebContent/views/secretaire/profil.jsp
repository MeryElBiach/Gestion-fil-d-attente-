<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mon Profil - Secrétaire</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/secretaire/stylesidesecretaire.css">
    <style>
        .main-content {
            margin-top: 90px !important;
            margin-left: 280px !important;
            padding: 40px 20px !important;
            min-height: calc(100vh - 90px);
            background: #f8f9fa; 
        }

        .profil-container {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            gap: 30px;
            align-items: flex-start;
        }

       
        .avatar-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
            padding: 40px 30px;
            text-align: center;
            min-width: 300px;
            flex-shrink: 0;
        }

        .avatar-large {
            width: 140px;
            height: 140px;
            background: #5DADE2; 
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 70px;
            font-weight: bold;
            margin: 0 auto 20px;
            box-shadow: 0 8px 20px rgba(93, 173, 226, 0.3);
        }

        .avatar-card h2 {
            font-size: 1.8rem;
            margin-bottom: 8px;
            color: #2c3e50;
            font-weight: 700;
        }

        .avatar-card p {
            color: #5DADE2;
            font-size: 1.1rem;
            font-weight: 600;
        }

        /* Formulaire à droite */
        .form-card {
            background: white; /* Fond blanc simple */
            border-radius: 20px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
            padding: 40px;
            flex: 1;
        }

        .form-card h3 {
            font-size: 1.8rem;
            color: #2c3e50;
            margin-bottom: 30px;
            font-weight: 700;
        }

        .form-label {
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 8px;
        }

        .form-control {
            border-radius: 12px;
            padding: 12px 16px;
            border: 1.5px solid #ced4da;
            transition: all 0.3s;
        }

        .form-control:focus {
            border-color: #5DADE2; 
            box-shadow: 0 0 0 0.25rem rgba(93, 173, 226, 0.25);
        }

        .btn-save {
            background: #5DADE2; 
            color: white;
            border: none;
            padding: 14px 40px;
            border-radius: 50px;
            font-size: 1.1rem;
            font-weight: 600;
            transition: all 0.3s;
            box-shadow: 0 4px 15px rgba(93, 173, 226, 0.3);
        }

        .btn-save:hover {
            background: #4A9CD6;
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(93, 173, 226, 0.4);
        }

        @media (max-width: 992px) {
            .profil-container {
                flex-direction: column;
            }
            .avatar-card {
                width: 100%;
                min-width: auto;
            }
        }

        @media (max-width: 768px) {
            .main-content { 
                margin-left: 0 !important; 
                padding: 20px !important; 
            }
            .form-card {
                padding: 25px;
            }
        }
    </style>
</head>
<body>
    <%@ include file="/views/secretaire/partials/header.jsp" %>
    <%@ include file="/views/secretaire/partials/sidebar.jsp" %>

    <main class="main-content">
        <div class="profil-container">
            
            <!-- Carte Avatar à gauche -->
            <div class="avatar-card">
                <div class="avatar-large">S</div>
                <h2>${user.prenom} ${user.nom}</h2>
                <p><i class="fas fa-user-tie me-2"></i>Secrétaire - HealthCare</p>
            </div>

            <!-- Formulaire à droite -->
            <div class="form-card">
                <h3><i class="fas fa-user-edit me-2 text-primary"></i>Modifier mon profil</h3>

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

                <!-- Formulaire -->
                <form action="${pageContext.request.contextPath}/secretaire/profil" method="post">
                    <div class="row g-4">
                        <div class="col-md-6">
                            <label class="form-label">Prénom</label>
                            <input type="text" name="prenom" class="form-control" value="${user.prenom}" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Nom</label>
                            <input type="text" name="nom" class="form-control" value="${user.nom}" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Email</label>
                            <input type="email" name="email" class="form-control" value="${user.email}" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Téléphone</label>
                            <input type="tel" name="telephone" class="form-control" value="${user.tel}" required>
                        </div>
                        <div class="col-12">
                            <label class="form-label">Adresse</label>
                            <input type="text" name="adresse" class="form-control" value="${user.adresse}">
                        </div>
                        <div class="col-12 text-center mt-4">
                            <button type="submit" class="btn btn-save">
                                <i class="fas fa-save me-2"></i> Enregistrer les modifications
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>