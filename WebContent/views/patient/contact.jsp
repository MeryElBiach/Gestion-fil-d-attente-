<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contactez-nous - HealthCare</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/patient.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/patient/contact.css">
</head>
<body>
    <%@ include file="/views/patient/partials/header.jsp" %>
    <%@ include file="/views/patient/partials/sidebar.jsp" %>

 
    <main class="main-content">
        <div class="container-fluid">
        
            <div class="text-center mb-4">
                <h2 class="main-title">
                    <i class="fas fa-phone-volume title-icon"></i>
                    Contactez-nous
                </h2>
            </div>

       
            <div class="welcome-box text-center mb-5">
                <p class="greeting-line">
                    <c:if test="${not empty patient}">
                        Bonjour <span class="patient-name">${patient.prenom} ${patient.nom}</span>,
                    </c:if>
                </p>
                <p class="intro-text">
                    Notre équipe est à votre écoute pour répondre à toutes vos questions
                    <br>
                    et vous accompagner dans la gestion de vos rendez-vous médicaux.
                </p>
            </div>

    
            <div class="contact-grid">

                <!-- Adresse -->
                <div class="contact-item">
                    <div class="contact-icon-circle">
                        <i class="fas fa-map-marker-alt"></i>
                    </div>
                    <div class="contact-content">
                        <h5 class="contact-title">Adresse</h5>
                        <p class="contact-details">
                            123 Rue de la Santé<br>
                            Casablanca, Maroc<br>
                            <span class="extra-info">Accès tram ligne 1</span>
                        </p>
                    </div>
                </div>

                <!-- Téléphone -->
                <div class="contact-item">
                    <div class="contact-icon-circle">
                        <i class="fas fa-phone-alt"></i>
                    </div>
                    <div class="contact-content">
                        <h5 class="contact-title">Téléphone</h5>
                        <p class="contact-details">
                            +212 522 00 00 00<br>
                            <span class="extra-info">Urgences:</span> +212 522 00 00 01<br>
                            <span class="extra-info">Lun-Ven: 8h-20h</span>
                        </p>
                    </div>
                </div>

                <!-- Email -->
                <div class="contact-item">
                    <div class="contact-icon-circle">
                        <i class="fas fa-envelope"></i>
                    </div>
                    <div class="contact-content">
                        <h5 class="contact-title">Email</h5>
                        <p class="contact-details">
                            contact@healthcare.ma<br>
                            <span class="extra-info">Réponse en 24h</span><br>
                            <span class="extra-info">Support patient</span>
                        </p>
                    </div>
                </div>

                <!-- Horaires -->
                <div class="contact-item">
                    <div class="contact-icon-circle">
                        <i class="fas fa-clock"></i>
                    </div>
                    <div class="contact-content">
                        <h5 class="contact-title">Horaires</h5>
                        <p class="contact-details">
                            <span class="extra-info">Consultations:</span> 8h-18h<br>
                            <span class="extra-info">Laboratoire:</span> 9h-17h<br>
                            <span class="extra-info">Ouvert 7j/7</span>
                        </p>
                    </div>
                </div>

            </div>

            <!-- Bouton Retour -->
            <div class="text-center mt-5">
                <a href="${pageContext.request.contextPath}/patient/dashboard" class="btn-return">
                    <i class="fas fa-arrow-left"></i> Retour au Dashboard
                </a>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>