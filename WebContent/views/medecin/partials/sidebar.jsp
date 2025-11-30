<aside class="sidebar">
    <div class="logo">
        <i class="fas fa-stethoscope"></i>  
        <span>HealthCare </span>  
    </div>
    <nav>
        <ul>
            <li>
                 <a href="${pageContext.request.contextPath}/medecin/dashboard" class="active">  
                    <i class="fas fa-tachometer-alt"></i>  
                    <span>Dashboard</span>
                </a>
            </li>
            <li>
                      <a href="${pageContext.request.contextPath}/medecin/mes-rdv">  
                    <i class="fas fa-calendar-check"></i>  
                    <span>Mes rendez-vous</span> 
                </a>
            </li>
            <li>
<a href="${pageContext.request.contextPath}/medecin/patients">  
    <i class="fas fa-users"></i> 
    <span>Mes patients</span> 
</a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/medecin/rapports">  
                    <i class="fas fa-file-prescription"></i>  
                    <span>Liste des rapports</span>  
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/medecin/profile"> 
                    <i class="fas fa-user-md"></i>  
                    <span>Mon profil</span>
                </a>
            </li>
        </ul>
    </nav>

    <div class="logout">
        <a href="${pageContext.request.contextPath}/medecin/logout">  
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