<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<header class="header">
    <div class="header-content">

        <!-- Barre de recherche -->
        <div class="search-box">
            <i class="fas fa-search"></i>
            <input type="text" placeholder="Rechercher patient, médecin, RDV..." readonly>
        </div>

        <!-- Profil -->
        <div class="user-profile">
            <div class="avatar">S</div>
            <div class="user-info">
                <div class="user-name">Secrétaire</div>
                <div class="user-role">HealthCare</div>
            </div>
        </div>
    </div>
</header>

<style>
    /* Dégradé parfait : sombre dominant + une touche très légère de clair à droite */
    .header {
        position: fixed;
        top: 0;
        left: 280px;
        right: 0;
        height: 72px;
        background: linear-gradient(to right,
            #0b1622 0%,      /* ultra sombre */
            #0f1e2e 30%,
            #15273d 60%,
            #1c334d 85%,
            #2a4b6e 100%     /* juste un soupçon de bleu plus clair à l'extrémité droite */
        );
        border-bottom: 1px solid rgba(74, 144, 226, 0.25);
        z-index: 999;
        transition: left 0.4s ease;
        box-shadow: 0 6px 25px rgba(0,0,0,0.5);
    }
    .sidebar.collapsed ~ .header { left: 70px; }

    .header-content {
        height: 100%;
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 0 32px;
    }

    /* Barre de recherche */
    .search-box {
        position: relative;
        width: 370px;
    }
    .search-box i {
        position: absolute;
        left: 18px;
        top: 50%;
        transform: translateY(-50%);
        color: #5c9ce6;
        font-size: 19px;
    }
    .search-box input {
        width: 100%;
        padding: 14px 20px 14px 52px;
        background: rgba(255, 255, 255, 0.09);
        border: 1px solid rgba(92, 156, 230, 0.35);
        border-radius: 30px;
        color: #e0e0e0;
        font-size: 15px;
        transition: all 0.3s;
    }
    .search-box input:focus {
        outline: none;
        background: rgba(255, 255, 255, 0.14);
        border-color: #5c9ce6;
        box-shadow: 0 0 15px rgba(92, 156, 230, 0.3);
    }
    .search-box input::placeholder {
        color: rgba(255, 255, 255, 0.5);
    }

    /* Profil */
    .user-profile {
        display: flex;
        align-items: center;
        gap: 16px;
        color: #e0e0e0;
    }
    .avatar {
        width: 52px;
        height: 52px;
        background: #5c9ce6;
        color: white;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: bold;
        font-size: 21px;
        box-shadow: 0 0 20px rgba(92, 156, 230, 0.6);
    }
    .user-name {
        font-weight: 600;
        font-size: 17px;
    }
    .user-role {
        font-size: 13px;
        color: #a8c8ff;
    }
</style>