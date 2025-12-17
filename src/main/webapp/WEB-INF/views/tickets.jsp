<%-- src/main/webapp/WEB-INF/views/tickets.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ticket System - Lista de Tickets</title>
    
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
        .priority-critical { border-left: 4px solid #000; }
        .status-badge {
            font-size: 0.8em;
            padding: 4px 8px;
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

        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2><i class="bi bi-ticket-detailed"></i> Tickets</h2>
            <a href="/tickets/new" class="btn btn-primary">
                <i class="bi bi-plus-circle"></i> Nuevo Ticket
            </a>
        </div>

        <!-- Filtros -->
        <div class="card mb-4">
            <div class="card-body">
                <form method="get" action="/tickets" class="row g-3">
                    <div class="col-md-3">
                        <select name="status" class="form-select">
                            <option value="">Todos los estados</option>
                            <option value="OPEN" ${param.status == 'OPEN' ? 'selected' : ''}>Abierto</option>
                            <option value="IN_PROGRESS" ${param.status == 'IN_PROGRESS' ? 'selected' : ''}>En Progreso</option>
                            <option value="RESOLVED" ${param.status == 'RESOLVED' ? 'selected' : ''}>Resuelto</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <select name="priority" class="form-select">
                            <option value="">Todas las prioridades</option>
                            <option value="HIGH" ${param.priority == 'HIGH' ? 'selected' : ''}>Alta</option>
                            <option value="MEDIUM" ${param.priority == 'MEDIUM' ? 'selected' : ''}>Media</option>
                            <option value="LOW" ${param.priority == 'LOW' ? 'selected' : ''}>Baja</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <input type="text" name="search" class="form-control" placeholder="Buscar..." 
                               value="${param.search}">
                    </div>
                    <div class="col-md-2">
                        <button type="submit" class="btn btn-outline-secondary w-100">
                            <i class="bi bi-funnel"></i> Filtrar
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Lista de Tickets -->
        <c:choose>
            <c:when test="${empty tickets}">
                <div class="alert alert-info">
                    No hay tickets disponibles. <a href="/tickets/new">Crear el primero</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="row">
                    <c:forEach var="ticket" items="${tickets}">
                        <div class="col-md-6 col-lg-4">
                            <div class="card ticket-card priority-${ticket.priority.toLowerCase()}">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between align-items-start mb-2">
                                        <h5 class="card-title mb-0">#${ticket.id} - ${ticket.title}</h5>
                                        <span class="badge bg-${ticket.status == 'OPEN' ? 'danger' : ticket.status == 'IN_PROGRESS' ? 'warning' : 'success'} status-badge">
                                            ${ticket.status}
                                        </span>
                                    </div>
                                    
                                    <p class="card-text text-muted small mb-2">
                                        <i class="bi bi-person"></i> ${ticket.clientName}
                                        <span class="mx-2">•</span>
                                        <i class="bi bi-envelope"></i> ${ticket.clientEmail}
                                    </p>
                                    
                                    <p class="card-text">
                                        ${fn:substring(ticket.description, 0, 100)}...
                                    </p>
                                    
                                    <div class="d-flex justify-content-between align-items-center">
                                        <small class="text-muted">
                                            <i class="bi bi-calendar"></i> 
                                            ${ticket.createdAt}
                                        </small>
                                        <div>
                                            <a href="/tickets/${ticket.id}" class="btn btn-sm btn-outline-primary">
                                                <i class="bi bi-eye"></i> Ver
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
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
        function confirmDelete(message) {
            return confirm(message || '¿Está seguro de eliminar este registro?');
        }
        
        setTimeout(() => {
            document.querySelectorAll('.alert').forEach(alert => {
                bootstrap.Alert.getInstance(alert)?.close();
            });
        }, 5000);
    </script>
</body>
</html>