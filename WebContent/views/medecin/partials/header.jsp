<header class="header">
    <div class="search-bar ms-3"> 
        <input type="search" placeholder="Search for anything" class="form-control">
    </div>
    
  
    <div class="header-actions">
   
        <div class="notification position-relative" data-bs-toggle="dropdown">
            <i class="fas fa-bell"></i>
            <span class="badge bg-danger position-absolute top-0 start-100 translate-middle">3</span>
        </div>
        <ul class="dropdown-menu dropdown-menu-end">
            <li><a class="dropdown-item" href="#">Nouvelle notification</a></li>
            <li><a class="dropdown-item" href="#">Autre alerte</a></li>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item text-danger" href="#">Marquer comme lues</a></li>
        </ul>
        
   
        <div class="dropdown user-dropdown ms-3">
            <a href="#" role="button" data-bs-toggle="dropdown" class="d-flex align-items-center text-decoration-none">
           
                <img src="https://via.placeholder.com/40?text=Avatar" alt="Avatar" class="rounded-circle me-2">
                <div class="user-info">
              
                    <div class="user-name fw-semibold">${user.nom} ${user.prenom}</div>
                    <div class="user-role small text-muted">${user.role}</div>
                </div>
                <i class="fas fa-chevron-down ms-2"></i>
            </a>
            <ul class="dropdown-menu dropdown-menu-end">
                <li><a class="dropdown-item" href="/profile"><i class="fas fa-user me-2"></i>Profil</a></li>
                <li><a class="dropdown-item" href="/settings"><i class="fas fa-cog me-2"></i>Paramètres</a></li>
                <li><hr class="dropdown-divider"></li>
                <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/patient/logout"><i class="fas fa-sign-out-alt me-2"></i>Logout</a></li>
            </ul>
        </div>
    </div>
</header>

<script>
/* JS pour Dropdowns Bootstrap (pas de toggle ici) */
document.addEventListener('DOMContentLoaded', function() {
    var dropdowns = document.querySelectorAll('.dropdown');
    dropdowns.forEach(function(dropdown) {
        new bootstrap.Dropdown(dropdown);
    });
});
</script>
