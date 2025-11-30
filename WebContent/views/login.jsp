<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Se connecter - HealthCare</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/login.css">
</head>
<body>
    <div class="login-wrapper">
        <div class="login-container">
           
            <div class="login-form-section">     
                <h2>Connectez-vous à HealthCare.</h2>
                <p class="subtitle">Entrez vos informations ci-dessous.</p>
                <c:if test="${not empty errorMessage}">
                    <div class="message error">${errorMessage}</div>
                </c:if>
                
               <form action="${pageContext.request.contextPath}/Login" method="post">
                    <div class="form-group">
                        <div class="input-wrapper">
                            <span class="input-icon">👤</span>
                            <input type="text" id="login" name="login" placeholder="Nom d'utilisateur" required>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <div class="input-wrapper">
                            <span class="input-icon">🔒</span>
                            <input type="password" id="password" name="password" placeholder="Mot de passe" required>
                        </div>
                    </div>
                    
                    <button type="submit" class="btn-login">Se connecter</button>
                    
                    <a href="#" class="forgot-password">Mot de passe oublié ?</a>
                    
                    <div class="divider">
                        <span>Connectez-vous avec un compte social</span>
                    </div>
                    
                    <div class="social-buttons">
                        <button type="button" class="btn-facebook">
                            Se connecter avec Facebook
                        </button>
                        <button type="button" class="btn-google">
                            Se connecter avec Google+
                        </button>
                    </div>
                    
                    <p class="create-account">
                        <a href="register.jsp">Créer un nouveau compte.</a>
                    </p>
                </form>
            </div>
            
            <!-- Right Side - Image -->
            <div class="login-image-section">
                <img src="${pageContext.request.contextPath}/images/log.png" alt="HealthCare" class="login-image">
            </div>
        </div>
    </div>
</body>
</html>