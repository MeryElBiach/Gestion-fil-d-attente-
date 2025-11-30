<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Patient</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/patient.css">

    <style>
       
        body {
            background-color: #ffffff !important;
        }

        .main-content {
            margin-top: 90px !important;
            padding: 30px 20px !important;
            margin-left: auto !important;
            max-width: calc(100vw - 300px) !important;
            min-height: 100vh;
            background-color: #ffffff !important;  
        }

 
        .welcome-header {
            background: white;
            padding: 25px 35px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            margin-bottom: 40px;
            border-left: 5px solid #0d6efd;
        }

        .welcome-header h2 {
            font-size: 1.8rem;
            font-weight: 700;
            color: #2c3e50;
            margin: 0;
        }

        .welcome-header .user-name {
            color: #0d6efd;
            font-weight: 700;
        }

    
        .cards-container {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 30px;
            margin-bottom: 50px;
        }

        .image-card {
            background: white;
            border-radius: 18px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.12);
            height: 220px;
        }

        .image-card img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: block;
        }

        .image-card:hover {
            box-shadow: 0 15px 40px rgba(0,0,0,0.2);
            transform: translateY(-5px);
        }

  
        .buttons-container {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 30px;
        }

        .action-btn {
            height: 110px;
            border-radius: 18px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 18px;
            font-size: 1.2rem;
            font-weight: 600;
            color: white;
            text-decoration: none;
            box-shadow: 0 8px 25px rgba(0,0,0,0.18);
            transition: all 0.3s ease;
        }

        .action-btn:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.3);
            color: white;
        }

        .action-btn i {
            font-size: 2.8rem;
        }

  
        .btn-rdv       { background: linear-gradient(135deg, #0d6efd 0%, #0a58ca 100%); }
        .btn-mesrdv    { background: linear-gradient(135deg, #6610f2 0%, #5a0fc7 100%); }
        .btn-resultats { background: linear-gradient(135deg, #0dcaf0 0%, #0aa2c0 100%); }

  
        @media (max-width: 992px) {
            .main-content { max-width: 100% !important; margin-top: 70px !important; }
            .cards-container,
            .buttons-container { grid-template-columns: 1fr; gap: 20px; }
            .image-card { height: 180px; }
        }
    </style>
</head>
<body>

    <%@ include file="/views/patient/partials/header.jsp" %>
    <%@ include file="/views/patient/partials/sidebar.jsp" %>

    <div class="main-content">

        <!-- Bienvenue -->
        <div class="welcome-header">
            <h2>Bonjour <span class="user-name">${user.nom} ${user.prenom}</span></h2>
        </div>

        <!-- 3 images -->
        <div class="cards-container">
            <div class="image-card">
                <img src="${pageContext.request.contextPath}/images/image1.png" alt="Médical">
            </div>
            <div class="image-card">
                <img src="${pageContext.request.contextPath}/images/image3.png" alt="Consultation">
            </div>
            <div class="image-card">
                <img src="${pageContext.request.contextPath}/images/image2.png" alt="Soins">
            </div>
        </div>

        <!-- 3 boutons -->
        <div class="buttons-container">
            <a href="${pageContext.request.contextPath}/patient/prendre-rdv" class="action-btn btn-rdv">
                <i class="fas fa-calendar-plus"></i>
                <span>Prendre un rendez-vous</span>
            </a>
            <a href="${pageContext.request.contextPath}/patient/mes-rendezvous" class="action-btn btn-mesrdv">
                <i class="fas fa-calendar-check"></i>
                <span>Mes rendez-vous</span>
            </a>
            <a href="${pageContext.request.contextPath}/patient/resultats" class="action-btn btn-resultats">
                <i class="fas fa-file-medical"></i>
                <span>Résultats médicaux</span>
            </a>
        </div>

    </div>

</body>
</html>