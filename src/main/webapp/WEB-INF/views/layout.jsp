<%-- src/main/webapp/WEB-INF/views/layout.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ticket System - ${pageTitle}</title>
    
    <!-- Bootstrap 5 CSS (lo cambiarás luego por tu CSS) -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    
    <!-- CSS temporal, luego pondrás el tuyo -->
    <style>
        body {
            background-color: #f8f9fa;
            padding-top: 20px;
        }
        .navbar-brand {
            font-weight: bold;
        }
        .ticket-card {
            transition: transform 0.2s;
            margin-bottom: 15px;
        }
        .ticket-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        .priority-high { border-left: 4px solid #dc3545; }
        .priority-medium { border-left: 4px solid #ffc107; }
        .priority-low { border-left: 4px solid #198754; }
        .status-badge {
            font-size: 0.8em;
            padding: 4px 8px;
        }
    </style>
</head>
<body>
    <!-- Navbar simple -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
        <div class="container">
            <a class="navbar-brand" href="/">
                <i class="bi bi-ticket-perforated"></i> Ticket System
            </a>
            <div class="navbar-nav">
                <a class="nav-link" href="/tickets"><i class="bi bi-list"></i> Todos los Tickets</a>
                <a class="nav-link" href="/tickets/new"><i class="bi bi-plus-circle"></i> Nuevo Ticket</a>
            </div>
        </div>
    </nav>
    
    <!-- Contenido principal -->
    <div class="container">
        <c:if test="${not empty message}">
            <div class="alert alert-info alert-dismissible fade show" role="alert">
                ${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        
        <!-- Aquí va el contenido específico de cada página -->
        <jsp:include page="${contentPage}" />
    </div>
    
    <!-- Footer -->
    <footer class="mt-5 py-3 bg-light">
        <div class="container text-center">
            <span class="text-muted">Ticket System v1.0 - Sistema de Gestión de Tickets</span>
        </div>
    </footer>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- JavaScript simple para interacciones -->
    <script>
        // Confirmación para eliminar
        function confirmDelete(message) {
            return confirm(message || '¿Está seguro de eliminar este registro?');
        }
        
        // Auto-cierre de alerts después de 5 segundos
        setTimeout(() => {
            document.querySelectorAll('.alert').forEach(alert => {
                bootstrap.Alert.getInstance(alert)?.close();
            });
        }, 5000);
    </script>
</body>
</html>