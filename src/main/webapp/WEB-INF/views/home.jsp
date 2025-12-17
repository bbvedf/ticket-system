<%-- src/main/webapp/WEB-INF/views/home.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ticket System - Dashboard</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    
    <style>
        body {
            background-color: #f8f9fa;
            padding-top: 20px;
        }
        .navbar-brand {
            font-weight: bold;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
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

        <div class="text-center mb-5">
            <h1 class="display-4">Ticket System</h1>
            <p class="lead">Sistema de gestión de tickets y soporte técnico</p>
        </div>

        <div class="row mb-5">
            <div class="col-md-3">
                <div class="card text-white bg-primary mb-3">
                    <div class="card-body text-center">
                        <h2 class="card-title">${totalTickets}</h2>
                        <p class="card-text">Total Tickets</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card text-white bg-warning mb-3">
                    <div class="card-body text-center">
                        <h2 class="card-title">${openTickets}</h2>
                        <p class="card-text">Abiertos</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card text-white bg-info mb-3">
                    <div class="card-body text-center">
                        <h2 class="card-title">${inProgressTickets}</h2>
                        <p class="card-text">En Progreso</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card text-white bg-success mb-3">
                    <div class="card-body text-center">
                        <h2 class="card-title">${resolvedTickets}</h2>
                        <p class="card-text">Resueltos</p>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">
                        <h5>Acciones Rápidas</h5>
                    </div>
                    <div class="card-body">
                        <a href="/tickets/new" class="btn btn-primary btn-lg w-100 mb-3">
                            <i class="bi bi-plus-circle"></i> Crear Nuevo Ticket
                        </a>
                        <a href="/tickets" class="btn btn-outline-secondary btn-lg w-100">
                            <i class="bi bi-list"></i> Ver Todos los Tickets
                        </a>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">
                        <h5>Estadísticas</h5>
                    </div>
                    <div class="card-body">
                        <p>Gestiona y sigue el progreso de todos los tickets de soporte.</p>
                        <ul>
                            <li>Creación y asignación de tickets</li>
                            <li>Seguimiento de estado y prioridad</li>
                            <li>Comentarios y actualizaciones</li>
                            <li>Filtros y búsqueda avanzada</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Footer -->
    <footer class="mt-5 py-3 bg-light">
        <div class="container text-center">
            <span class="text-muted">Ticket System v1.0 - Sistema de Gestión de Tickets</span>
        </div>
    </footer>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        setTimeout(() => {
            document.querySelectorAll('.alert').forEach(alert => {
                bootstrap.Alert.getInstance(alert)?.close();
            });
        }, 5000);
    </script>
</body>
</html>