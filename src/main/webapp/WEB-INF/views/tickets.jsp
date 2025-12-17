<%-- src/main/webapp/WEB-INF/views/tickets.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="contentPage" value="tickets.jsp" scope="request"/>
<jsp:include page="layout.jsp"/>

<%-- Override content --%>
<script>
    document.title = "Ticket System - Lista de Tickets";
</script>

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
                                    <fmt:formatDate value="${ticket.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
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