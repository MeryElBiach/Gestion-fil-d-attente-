<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HealthCare - Clinique Moderne & Connectée</title>
    <meta name="description" content="Prenez rendez-vous en ligne avec les meilleurs médecins. Simple, rapide, sécurisé.">

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">


    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

  
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>
        :root {
            --primary: #2563eb;
            --primary-light: #3b82f6;
            --secondary: #10b981;
            --dark: #1e293b;
            --light: #f8fafc;
            --gray: #64748b;
            --gray-light: #f1f5f9;
            --success: #10b981;
            --danger: #ef4444;
            --yellow: #facc15;       
            --yellow-hover: #eab308;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Inter', sans-serif;
            background: var(--light);
            color: var(--dark);
            line-height: 1.6;
        }

        /* Navbar */
        .navbar {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            padding: 1rem 0;
            transition: all 0.3s;
            position: fixed;
            width: 100%;
            z-index: 1000;
        }
        .navbar.scrolled {
            padding: 0.7rem 0;
            background: rgba(255, 255, 255, 0.98);
        }
        .navbar-brand {
            font-weight: 800;
            font-size: 1.8rem;
            color: var(--primary) !important;
        }
        .navbar-brand i { color: var(--secondary); }
        .nav-link {
            font-weight: 500;
            color: var(--dark) !important;
            margin: 0 10px;
            transition: color 0.3s;
        }
        .nav-link:hover { color: var(--primary) !important; }

        /* Hero */
        .hero {
            height: 100vh;
            background: linear-gradient(rgba(0,0,0,0.4), rgba(0,0,0,0.6)), url('${pageContext.request.contextPath}/images/accueil.jpg');
            background-size: cover;
            background-position: center;
            display: flex;
            align-items: center;
            color: white;
            position: relative;
        }
        .hero h1 {
            font-size: 4.5rem;
            font-weight: 800;
            line-height: 1.1;
        }
        .hero p {
            font-size: 1.4rem;
            font-weight: 300;
            max-width: 700px;
            margin: 1.5rem auto;
        }

        /* BOUTON JAUNE (seul changement réel) */
        .btn-yellow {
            background: var(--yellow);
            color: var(--dark);
            border: none;
            padding: 16px 40px;
            border-radius: 50px;
            font-weight: 600;
            font-size: 1.1rem;
            box-shadow: 0 10px 30px rgba(250, 204, 21, 0.4);
            transition: all 0.3s;
        }
        .btn-yellow:hover {
            background: var(--yellow-hover);
            transform: translateY(-3px);
            color: var(--dark);
        }
        .btn-yellow i {
            color: var(--dark);
        }

        /* Roles Section */
        .role-card {
            background: white;
            border-radius: 24px;
            padding: 50px 30px;
            text-align: center;
            box-shadow: 0 20px 50px rgba(0,0,0,0.08);
            transition: all 0.4s;
            border: 1px solid #e2e8f0;
            height: 100%;
        }
        .role-card:hover {
            transform: translateY(-15px);
            box-shadow: 0 30px 80px rgba(0,0,0,0.15);
        }
        .role-icon {
            width: 120px;
            height: 120px;
            margin: 0 auto 25px;
            background: linear-gradient(135deg, #e0f2fe, #bae6fd);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3.5rem;
            color: var(--primary);
        }
        .role-card.medecin .role-icon {
            background: linear-gradient(135deg, #d1fae5, #a7f3d0);
            color: var(--secondary);
        }
        .role-card h3 {
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 15px;
        }
        .role-card p {
            color: var(--gray);
            font-size: 1.05rem;
            margin-bottom: 25px;
        }

        /* Services */
        .service-card {
            background: white;
            padding: 35px 25px;
            border-radius: 20px;
            text-align: center;
            height: 100%;
            box-shadow: 0 10px 30px rgba(0,0,0,0.06);
            transition: 0.3s;
        }
        .service-card:hover {
            transform: translateY(-10px);
        }
        .service-icon {
            font-size: 3.5rem;
            margin-bottom: 20px;
            color: var(--primary);
        }

        /* About */
        .about-img {
            border-radius: 24px;
            overflow: hidden;
            box-shadow: 0 20px 50px rgba(0,0,0,0.15);
        }
        .about-img img {
            width: 100%;
            height: 500px;
            object-fit: cover;
        }

        /* Footer */
        footer {
            background: var(--dark);
            color: white;
            padding: 80px 0 30px;
        }
        .footer-title {
            font-size: 2rem;
            font-weight: 800;
            margin-bottom: 20px;
        }
        .social-links a {
            width: 45px;
            height: 45px;
            background: rgba(255,255,255,0.1);
            border-radius: 50%;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            margin-right: 10px;
            transition: 0.3s;
        }
        .social-links a:hover {
            background: var(--secondary);
            transform: translateY(-5px);
        }
        .logo-heart-yellow i {
        color: #facc15 !important;   /* cœur en jaune vif */
    }
    .logo-text-black {
        color: #1e293b !important;   /* texte HealthCare en noir/gris très foncé */
    }
    </style>
</head>
<body>

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg fixed-top">
        <div class="container">
          <a class="navbar-brand logo-heart-yellow logo-text-black" href="#">
    <i class="fas fa-heartbeat me-2"></i> HealthCare
</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="#home">Accueil</a></li>
                    <li class="nav-item"><a class="nav-link" href="#roles">Espace</a></li>
                    <li class="nav-item"><a class="nav-link" href="#services">Services</a></li>
                    <li class="nav-item"><a class="nav-link" href="#about">À propos</a></li>
                    <li class="nav-item"><a class="nav-link" href="#contact">Contact</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero -->
    <section id="home" class="hero text-center">
        <div class="container">
            <h1>Votre santé,<br>nous en prenons soin</h1>
            <p>Prenez rendez-vous en quelques clics avec des médecins qualifiés.<br>Une expérience fluide, moderne et sécurisée.</p>
            
            <!-- BOUTON JAUNE (seule modification visible) -->
            <a href="#roles" class="btn-yellow mt-4">
                <i class="fas fa-calendar-check me-2"></i> Prendre rendez-vous
            </a>
        </div>
        <div class="scroll-down">
            <i class="fas fa-chevron-down"></i>
        </div>
    </section>

    <!-- Roles -->
    <section id="roles" class="py-5">
        <div class="container py-5">
            <div class="text-center mb-5">
                <h2 class="display-5 fw-bold">Accédez à votre espace</h2>
                <p class="lead text-muted">Choisissez votre profil pour commencer</p>
            </div>
            <div class="row g-5">
                <div class="col-lg-6">
                    <div class="role-card">
                        <div class="role-icon">
                            <i class="fas fa-user-injured"></i>
                        </div>
                        <h3>Je suis patient</h3>
                        <p>Prenez rendez-vous, consultez vos résultats et suivez votre historique médical en toute simplicité.</p>
                        <div class="mt-4">
                            <a href="${pageContext.request.contextPath}/Login" class="btn btn-outline-primary me-3">Se connecter</a>
                            <a href="${pageContext.request.contextPath}/views/inscriptionPatient.jsp" class="btn btn-primary">S'inscrire</a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="role-card medecin">
                        <div class="role-icon">
                            <i class="fas fa-user-md"></i>
                        </div>
                        <h3>Je suis médecin</h3>
                        <p>Gérez votre planning, consultez vos patients et rédigez vos rapports en toute sérénité.</p>
                        <div class="mt-4">
                            <a href="${pageContext.request.contextPath}/Login" class="btn btn-outline-success me-3">Se connecter</a>
                            <a href="${pageContext.request.contextPath}/inscription-medecin" class="btn btn-success">S'inscrire</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Services -->
    <section id="services" class="py-5 bg-white">
        <div class="container py-5">
            <div class="text-center mb-5">
                <h2 class="display-5 fw-bold">Nos services</h2>
                <p class="lead text-muted">Tout ce dont vous avez besoin, au même endroit</p>
            </div>
            <div class="row g-4">
                <div class="col-md-3">
                    <div class="service-card">
                        <div class="service-icon"><i class="fas fa-calendar-plus"></i></div>
                        <h5>Prise de RDV en ligne</h5>
                        <p>24h/24, 7j/7</p>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="service-card">
                        <div class="service-icon"><i class="fas fa-file-medical"></i></div>
                        <h5>Rapports & Résultats</h5>
                        <p>Accès instantané</p>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="service-card">
                        <div class="service-icon"><i class="fas fa-bell"></i></div>
                        <h5>Notifications</h5>
                        <p>SMS & Email</p>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="service-card">
                        <div class="service-icon"><i class="fas fa-shield-alt"></i></div>
                        <h5>Sécurité maximale</h5>
                        <p>Données cryptées</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- About -->
    <section id="about" class="py-5">
        <div class="container py-5">
            <div class="row align-items-center">
                <div class="col-lg-6">
                    <h2 class="display-5 fw-bold mb-4">Une clinique moderne,<br>à votre écoute</h2>
                    <p class="lead text-muted mb-4">
                        Nous combinons expertise médicale et technologie de pointe pour vous offrir le meilleur suivi possible.
                    </p>
                    <p class="mb-4">
                        Notre mission : simplifier l’accès aux soins, réduire les délais et améliorer la communication entre patients et médecins.
                    </p>
                    <div class="row text-center mt-5">
                        <div class="col-4">
                            <h3 class="fw-bold text-primary">500+</h3>
                            <p class="text-muted">Patients</p>
                        </div>
                        <div class="col-4">
                            <h3 class="fw-bold text-primary">50+</h3>
                            <p class="text-muted">Médecins</p>
                        </div>
                        <div class="col-4">
                            <h3 class="fw-bold text-primary">24/7</h3>
                            <p class="text-muted">Disponible</p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="about-img">
                        <img src="${pageContext.request.contextPath}/images/acc.png" alt="Notre clinique">
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer id="contact" class="text-white">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 mb-4">
                    <h3 class="footer-title"><i class="fas fa-heartbeat me-2"></i> HealthCare</h3>
                    <p>Votre santé mérite le meilleur. Nous sommes là pour vous accompagner à chaque étape.</p>
                </div>
                <div class="col-lg-4 mb-4">
                    <h5>Liens rapides</h5>
                    <ul class="list-unstyled">
                        <li><a href="#" class="text-white-50">Accueil</a></li>
                        <li><a href="#" class="text-white-50">Services</a></li>
                        <li><a href="#" class="text-white-50">À propos</a></li>
                        <li><a href="#" class="text-white-50">Contact</a></li>
                    </ul>
                </div>
                <div class="col-lg-4">
                    <h5>Contact</h5>
                    <p><i class="fas fa-map-marker-alt me-2"></i> Casablanca, Maroc</p>
                    <p><i class="fas fa-phone me-2"></i> +212 5 22 00 00 00</p>
                    <p><i class="fas fa-envelope me-2"></i> contact@healthcare.ma</p>
                    <div class="social-links mt-3">
                        <a href="#"><i class="fab fa-facebook-f"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                        <a href="#"><i class="fab fa-linkedin-in"></i></a>
                    </div>
                </div>
            </div>
            <hr class="my-4">
            <p class="text-center text-white-50">© 2025 HealthCare. Tous droits réservés.</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Navbar scroll effect
        window.addEventListener('scroll', () => {
            document.querySelector('.navbar').classList.toggle('scrolled', window.scrollY > 50);
        });
    </script>
</body>
</html>