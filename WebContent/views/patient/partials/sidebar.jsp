
<aside class="sidebar">
    <div class="logo">
        <i class="fas fa-heartbeat"></i>
        <span>HealthCare</span>
    </div>
    <nav>
        <ul>
            <li>
                 <a href="${pageContext.request.contextPath}/patient/dashboard" class="active">
                    <i class="fas fa-tachometer-alt"></i>
                    <span>Dashboard</span>
                </a>
            </li>
            <li>
                      <a href="${pageContext.request.contextPath}/patient/mes-rdv">  
                    <i class="fas fa-calendar-check"></i>
                    <span>Mes Rendez-vous</span>
                </a>
            </li>
            <li>
<a href="${pageContext.request.contextPath}/patient/resultats">
    <i class="fas fa-file-medical-alt"></i>
    <span>Mes Résultats Médicaux</span>
</a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/patient/profile">
                    <i class="fas fa-user"></i>
                    <span>Mon Profil</span>
                </a>
            </li>
<li>
    <a href="${pageContext.request.contextPath}/patient/contact">
        <i class="fas fa-address-book"></i>
        <span>Contactez-nous</span>
    </a>
</li>
        </ul>
    </nav>
    
    <div class="logout">
        <a href="${pageContext.request.contextPath}/patient/logout">
            <i class="fas fa-sign-out-alt"></i>
            <span>Déconnexion</span>
        </a>
    </div>
    
    <button class="sidebar-toggle" onclick="toggleSidebar()" aria-label="Toggle Sidebar">
        <i class="fas fa-chevron-right"></i> 
    </button>
    
<script>
function toggleSidebar() {
    const sidebar = document.querySelector('.sidebar');
    const toggleIcon = document.querySelector('.sidebar-toggle i');
    
    if (sidebar.classList.contains('collapsed')) {
        sidebar.classList.remove('collapsed');
        toggleIcon.classList.remove('fa-chevron-left');
        toggleIcon.classList.add('fa-chevron-right');
    } else {
        sidebar.classList.add('collapsed');
        toggleIcon.classList.remove('fa-chevron-right');
        toggleIcon.classList.add('fa-chevron-left');
    }
}
</script>
</aside>