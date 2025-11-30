<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inscription Médecin - HealthCare</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/inscription.css"> 
    <style>
        .specialite-select {
            width: 100%;
            padding: 12px 15px 12px 45px !important;
            border: 2px solid #e1e5e9 !important;
            border-radius: 8px !important;
            font-size: 16px !important;
            background-color: #f8f9fa !important;
            transition: all 0.3s ease !important;
            appearance: none !important;
            background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%23666' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e") !important;
            background-repeat: no-repeat !important;
            background-position: right 15px center !important;
            background-size: 20px !important;
            color: #333 !important;
            height: 48px !important;
            cursor: pointer !important;
        }

        .specialite-select:focus {
            outline: none !important;
            border-color: #4CAF50 !important;
            background-color: white !important;
            box-shadow: 0 0 0 3px rgba(76, 175, 80, 0.1) !important;
        }

        .specialite-select option {
            padding: 10px !important;
            background-color: white !important;
            color: #333 !important;
        }

        .debug-info {
            background-color: #fff3cd;
            border: 1px solid #ffeaa7;
            color: #856404;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 15px;
            font-size: 14px;
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <div class="login-wrapper">
        <div class="login-container">
            <div class="login-form-section">
                <h4>Inscription Médecin</h4>

              
                <c:if test="${not empty erreurSpecialites}">
                    <div class="alert alert-danger debug-info">${erreurSpecialites}</div>
                </c:if>

                <form action="${pageContext.request.contextPath}/InscriptionMedecinServlet" method="post"> <!-- Fix : Action absolu avec JSTL -->
                    <div class="form-group">
                        <label class="genre-label">Genre</label>
                        <div class="genre-group">
                            <label class="radio-label">
                                <input type="radio" name="genre" value="Homme" required>
                                <span>Homme</span>
                            </label>
                            <label class="radio-label">
                                <input type="radio" name="genre" value="Femme" required>
                                <span>Femme</span>
                            </label>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <div class="input-wrapper">
                                <span class="input-icon">👤</span>
                                <input type="text" name="nom" placeholder="Nom" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="input-wrapper">
                               <span class="input-icon">👤</span>
                                <input type="text" name="prenom" placeholder="Prénom" required>
                            </div>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <div class="input-wrapper">
                                <span class="input-icon">🆔</span>
                                <input type="text" name="cin" placeholder="CIN" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="input-wrapper">
                                <span class="input-icon">📱</span>
                                <input type="text" name="tel" placeholder="Téléphone" required>
                            </div>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <div class="input-wrapper">
                                 <span class="input-icon">📅</span>
                                <select name="specialiteId" class="specialite-select" required>
                                    <option value="">Sélectionner une spécialité</option>
                                    <c:forEach var="specialite" items="${specialites}">
                                        <option value="${specialite.idSpecialite}">${specialite.nom}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="input-wrapper">
                                <span class="input-icon">📍</span>
                                <input type="text" name="adresse" placeholder="Adresse" required>
                            </div>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <div class="input-wrapper">
                                <span class="input-icon">📅</span>
                                <input type="date" name="dateNaissance" placeholder="Date de Naissance" required>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="input-wrapper">
                    <span class="input-icon">📧</span>
                            <input type="email" name="email" placeholder="Adresse Email" required>
                        </div>
                    </div>

                  <div class="form-group">
                        <div class="input-wrapper">
                              <span class="input-icon">👤</span>
                            <input type="text" name="login" placeholder="Nom d'utilisateur" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <div class="input-wrapper">
                                <span class="input-icon">🔒</span>
                                <input type="password" name="password" id="password" placeholder="Mot de passe" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="input-wrapper">
                                <span class="input-icon">🔒</span>
                                <input type="password" name="confirmPassword" id="confirmPassword" placeholder="Confirmation" required>
                            </div>
                        </div>
                    </div>

                    <button type="submit" class="btn-login">S'inscrire</button>

                    <div class="create-account">
                        Vous avez déjà un compte? <a href="${pageContext.request.contextPath}/views/login.jsp">Se connecter</a> <!-- Fix : Lien absolu avec JSTL -->
                    </div>
                </form>
            </div>

            <div class="login-image-section">
                <img src="${pageContext.request.contextPath}/images/log.png" alt="Healthcare" class="login-image"> <!-- Fix : Path absolu avec JSTL -->
            </div>
        </div>
    </div>

    <script>
        document.querySelector('form').addEventListener('submit', function(e) {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;

            if (password !== confirmPassword) {
                e.preventDefault();
                alert('Les mots de passe ne correspondent pas!');
            }
        });
    </script>
</body>
</html>