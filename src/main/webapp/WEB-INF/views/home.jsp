<%-- src/main/webapp/WEB-INF/views/home.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="header.jsp">
    <jsp:param name="pageTitle" value="Lista de Tickets"/>
</jsp:include>
    
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
    
<jsp:include page="footer.jsp"/>