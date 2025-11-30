<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<aside class="sidebar">
    <div class="logo">
        <i class="fas fa-user-tie"></i>
        <span>HealthCare</span>
    </div>

    <nav>
        <ul>
            <!-- Dashboard -->
            <li>
                <a href="${pageContext.request.contextPath}/secretaire/dashboard">
                    <i class="fas fa-tachometer-alt"></i>
                    <span>Dashboard</span>
                </a>
            </li>

            <!-- Liste des rendez-vous -->
            <li>
                <a href="${pageContext.request.contextPath}/secretaire/rendezvous">
                    <i class="fas fa-calendar-check"></i>
                    <span>Liste des rendez-vous</span>
                </a>
            </li>

            <!-- Gestion des spécialités -->
            <li>
                <a href="${pageContext.request.contextPath}/secretaire/specialites">
                    <i class="fas fa-stethoscope"></i>
                    <span>Gestion des spécialités</span>
                </a>
            </li>

            <!-- Gestion médecins -->
            <li>
                <a href="${pageContext.request.contextPath}/secretaire/medecins">
                    <i class="fas fa-user-md"></i>
                    <span>Gestion médecins</span>
                </a>
            </li>

            <!-- Gestion patients -->
            <li>
                <a href="${pageContext.request.contextPath}/secretaire/patients">
                    <i class="fas fa-users-cog"></i>
                    <span>Liste des patients</span>
                </a>
            </li>

            <!-- Mon profil -->
            <li>
                <a href="${pageContext.request.contextPath}/secretaire/profil">
                    <i class="fas fa-user"></i>
                    <span>Mon profil</span>
                </a>
            </li>
        </ul>
    </nav>

    <!-- Déconnexion -->
    <div class="logout">
        <a href="${pageContext.request.contextPath}/secretaire/logout">
            <i class="fas fa-sign-out-alt"></i>
            <span>Déconnexion</span>
        </a>
    </div>

    <!-- Bouton replier/déplier -->
    <button class="sidebar-toggle" onclick="toggleSidebar()" aria-label="Réduire/Agrandir le menu">
        <i class="fas fa-chevron-right"></i>
    </button>
</aside>

<script>
function toggleSidebar() {
    const sidebar = document.querySelector('.sidebar');
    const icon = document.querySelector('.sidebar-toggle i');
    
    sidebar.classList.toggle('collapsed');

    if (sidebar.classList.contains('collapsed')) {
        icon.classList.replace('fa-chevron-right', 'fa-chevron-left');
    } else {
        icon.classList.replace('fa-chevron-left', 'fa-chevron-right');
    }
}
</script>