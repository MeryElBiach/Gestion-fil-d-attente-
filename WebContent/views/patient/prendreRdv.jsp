<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.clinique.beans.Patient" %>
<%@ page import="com.clinique.beans.Specialite" %>
<%@ page import="com.clinique.beans.Medecin" %>

<%
    Patient patient = (Patient) request.getAttribute("patient");
    List<Specialite> specialites = (List<Specialite>) request.getAttribute("specialites");
    List<Medecin> medecins = (List<Medecin>) request.getAttribute("medecins");
    Integer selectedSpecialite = (Integer) request.getAttribute("selectedSpecialite");
    String error = (String) request.getAttribute("error");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Prendre un Rendez-Vous</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/patient.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/patient/rdv.css">.
</head>
<body>
    <%@ include file="/views/patient/partials/header.jsp" %>
    <%@ include file="/views/patient/partials/sidebar.jsp" %>

    <main class="main-content">
        <div class="container">
            <h2>Prendre un rendez-vous</h2>

            <% if (error != null) { %>
                <div class="alert alert-danger"><%= error %></div>
            <% } %>

            <!-- Informations personnelles -->
            <fieldset class="mb-3">
                <legend>Informations personnelles</legend>
                <p><strong>Nom :</strong> <%= patient.getNom() %></p>
                <p><strong>Prénom :</strong> <%= patient.getPrenom() %></p>
                <p><strong>Email :</strong> <%= patient.getEmail() %></p>
                <p><strong>Téléphone :</strong> <%= patient.getTel() %></p>
            </fieldset>

            <!-- Choix de la spécialité -->
            <form method="get" action="<%=request.getContextPath()%>/patient/prendre-rdv" class="mb-3">
                <fieldset>
                    <legend>Choisir la spécialité</legend>
                    <% for (Specialite s : specialites) { %>
                        <label class="form-check-label me-3">
                            <input type="radio" class="form-check-input" name="specialiteId" value="<%=s.getIdSpecialite()%>" 
                                   <% if (selectedSpecialite != null && selectedSpecialite == s.getIdSpecialite()) { %> checked <% } %> 
                                   onchange="this.form.submit()">
                            <%= s.getNom() %>
                        </label>
                    <% } %>
                </fieldset>
            </form>

            <% if (selectedSpecialite != null && medecins != null && !medecins.isEmpty()) { %>
                <form method="post" action="<%=request.getContextPath()%>/patient/prendre-rdv">
                    <input type="hidden" name="specialiteId" value="<%= selectedSpecialite %>">

                    <!-- Choix du médecin -->
                    <fieldset class="mb-3">
                        <legend>Choisir le médecin</legend>
                        <select name="medecinId" class="form-select" required>
                            <option value="">-- Sélectionnez un médecin --</option>
                            <% for (Medecin m : medecins) { %>
                                <option value="<%= m.getId() %>"><%= m.getNom() %> <%= m.getPrenom() %></option>
                            <% } %>
                        </select>
                    </fieldset>

                    <!-- Date et Heure -->
                    <fieldset class="mb-3">
                        <legend>Date et Heure</legend>
                        <label class="form-label">Date :
                            <input type="date" name="dateRdv" class="form-control" required min="<%= java.time.LocalDate.now() %>">
                        </label><br>

                        <label class="form-label">Heure :
                            <select name="heureRdv" class="form-select" required>
                                <option value="">-- Sélectionnez une heure --</option>
                                <% 
                                    // Plage 8h à 14h
                                    for (int h = 8; h <= 14; h++) {
                                        String hh = (h < 10) ? "0" + h : String.valueOf(h);
                                        out.println("<option value=\"" + hh + ":00\">"+ hh + ":00</option>");
                                        out.println("<option value=\"" + hh + ":30\">"+ hh + ":30</option>");
                                    }
                                    // Plage 16h à 19h
                                    for (int h = 16; h <= 19; h++) {
                                        String hh = String.valueOf(h);
                                        out.println("<option value=\"" + hh + ":00\">"+ hh + ":00</option>");
                                        out.println("<option value=\"" + hh + ":30\">"+ hh + ":30</option>");
                                    }
                                %>
                            </select>
                        </label>
                    </fieldset>

                    <button type="submit" class="btn btn-primary">Réserver</button>
                </form>
            <% } %>
        </div>
    </main>
</body>
</html>
