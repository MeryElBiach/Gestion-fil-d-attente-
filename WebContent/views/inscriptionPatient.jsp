<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inscription Patient - HealthCare</title>
    <link rel="stylesheet" type="text/css" href="../css/inscription.css">
</head>
<body>
    <div class="login-wrapper">
        <div class="login-container">
           
            <div class="login-form-section">
                <h4 style=>Créez votre compte pour prendre rendez-vous<h4/>
                <form action="${pageContext.request.contextPath}/InscriptionPatientServlet" method="post">
               
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
                                <input type="date" name="dateNaissance" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="input-wrapper">
                                <span class="input-icon">📍</span>
                                <input type="text" name="adresse" placeholder="Adresse" required>
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

                    <p class="create-account">
                        Vous avez déjà un compte? <a href="login.jsp">Se connecter</a>
                    </p>
                </form>
            </div>

    
            <div class="login-image-section">
                <img src="../images/log.png" alt="HealthCare" class="login-image">
            </div>
        </div>
    </div>

    <script>
        // Validation du mot de passe
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