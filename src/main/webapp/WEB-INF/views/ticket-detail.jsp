<%-- src/main/webapp/WEB-INF/views/ticket-detail.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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

        <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="mb-0">Ticket #${ticket.id}</h2>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/">Inicio</a></li>
                    <li class="breadcrumb-item"><a href="/tickets">Tickets</a></li>
                    <li class="breadcrumb-item active" aria-current="page">#${ticket.id}</li>
                </ol>
            </nav>
        </div>
        
        <div>
            <a href="/tickets" class="btn btn-outline-secondary">
                <i class="bi bi-arrow-left"></i> Volver a la lista
            </a>
            <a href="/tickets/${ticket.id}/edit" class="btn btn-primary">
                <i class="bi bi-pencil"></i> Editar
            </a>
            <button type="button" class="btn btn-danger" id="deleteButtonTrigger">
                <i class="bi bi-trash"></i> Eliminar
            </button>
        </div>
    </div>

        <div class="row">
            <div class="col-md-8">
                <!-- Información del Ticket -->
                <div class="card mb-4">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">${ticket.title}</h5>
                        <span class="badge badge-priority-${fn:toLowerCase(ticket.priority)}">
                            <c:choose>
                                <c:when test="${ticket.priority == 'LOW'}">Baja</c:when>
                                <c:when test="${ticket.priority == 'MEDIUM'}">Media</c:when>
                                <c:when test="${ticket.priority == 'HIGH'}">Alta</c:when>
                                <c:when test="${ticket.priority == 'CRITICAL'}">Crítica</c:when>
                                <c:otherwise>${ticket.priority}</c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                    <div class="card-body">
                        <p class="card-text">${fn:replace(ticket.description, '
', '<br>')}</p>
                        
                        <div class="row mt-4">
                            <div class="col-md-6">
                                <h6>Información del Cliente</h6>
                                <p><i class="bi bi-person"></i> ${ticket.clientName}</p>
                                <p><i class="bi bi-envelope"></i> ${ticket.clientEmail}</p>
                            </div>
                            <div class="col-md-6">
                                <h6>Metadatos</h6>
                                <p><i class="bi bi-tag"></i> ${ticket.category}</p>
                                <p><i class="bi bi-clock"></i> ${ticket.createdAt}</p>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer">
                        <div class="btn-group" role="group">
                            <c:forEach var="statusOption" items="${['OPEN', 'IN_PROGRESS', 'RESOLVED', 'CLOSED']}">
                                <a href="/tickets/${ticket.id}/status?status=${statusOption}" 
                                   class="btn btn-${ticket.status == statusOption ? 'primary' : 'outline-secondary'} btn-sm">                                    
                                    <c:choose>
                                        <c:when test="${statusOption == 'OPEN'}">Abierto</c:when>
                                        <c:when test="${statusOption == 'IN_PROGRESS'}">En Progreso</c:when>
                                        <c:when test="${statusOption == 'RESOLVED'}">Resuelto</c:when>
                                        <c:when test="${statusOption == 'CLOSED'}">Cerrado</c:when>
                                        <c:otherwise>${statusOption}</c:otherwise>
                                    </c:choose>
                                </a>
                            </c:forEach>
                        </div>
                    </div>
                </div>
                
                <!-- Comentarios -->
                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0">Comentarios</h5>
                    </div>
                    <div class="card-body">
                        <!-- Formulario para nuevo comentario -->
                        <form action="/tickets/${ticket.id}/comments" method="post" class="mb-4">
                            <div class="mb-3">
                                <label for="authorName" class="form-label">Tu nombre</label>
                                <input type="text" class="form-control" id="authorName" name="authorName" required>
                            </div>
                            <div class="mb-3">
                                <label for="commentText" class="form-label">Comentario</label>
                                <textarea class="form-control" id="commentText" name="commentText" rows="3" required></textarea>
                            </div>
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-chat-left-text"></i> Añadir Comentario
                            </button>
                        </form>
                        
                        <!-- Lista de comentarios -->
                        <c:if test="${not empty ticket.comments}">
                            <h6>Comentarios anteriores:</h6>
                            <c:forEach var="comment" items="${ticket.comments}">
                                <div class="card mb-3">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between">
                                            <strong>${comment.authorName}</strong>
                                            <small class="text-muted">${comment.createdAt}</small>
                                        </div>
                                        <p class="mt-2 mb-0">${comment.commentText}</p>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:if>
                    </div>
                </div>
            </div>
            
            <div class="col-md-4">
                <!-- Panel lateral -->
                <div class="card mb-4">
                    <div class="card-header">
                        <h5 class="mb-0">Estado</h5>
                    </div>
                    <div class="card-body text-center">
                        <span class="badge badge-status-${fn:toLowerCase(ticket.status)} fs-5 p-3">
                            <c:choose>
                                <c:when test="${ticket.status == 'OPEN'}">Abierto</c:when>
                                <c:when test="${ticket.status == 'IN_PROGRESS'}">En Progreso</c:when>
                                <c:when test="${ticket.status == 'RESOLVED'}">Resuelto</c:when>
                                <c:when test="${ticket.status == 'CLOSED'}">Cerrado</c:when>
                                <c:otherwise>${ticket.status}</c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                </div>
                                
                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0">Información</h5>
                    </div>
                    <div class="card-body">
                        <dl class="row">
                            <dt class="col-sm-6">Creado:</dt>
                            <dd class="col-sm-6">${ticket.createdAt}</dd>
                            
                            <dt class="col-sm-6">Última actualización:</dt>
                            <dd class="col-sm-6">${ticket.updatedAt}</dd>
                            
                            <c:if test="${not empty ticket.resolvedAt}">
                                <dt class="col-sm-6">Resuelto:</dt>
                                <dd class="col-sm-6">${ticket.resolvedAt}</dd>
                            </c:if>
                            
                            <c:if test="${not empty ticket.assignedTo}">
                                <dt class="col-sm-6">Asignado a:</dt>
                                <dd class="col-sm-6">${ticket.assignedTo}</dd>
                            </c:if>
                        </dl>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal de confirmación para eliminar -->
    <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title text-danger" id="deleteModalLabel">
                        <i class="bi bi-exclamation-triangle me-2"></i>Confirmar Eliminación
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>¿Estás seguro de que deseas eliminar este ticket?</p>
                    <div class="alert alert-warning">
                        <i class="bi bi-info-circle me-2"></i>
                        <strong>Atención:</strong> Esta acción no se puede deshacer. Se eliminará:
                        <ul class="mt-2 mb-0">
                            <li>Ticket #${ticket.id}: ${ticket.title}</li>
                            <li>${fn:length(ticket.comments)} comentario(s) asociado(s)</li>
                        </ul>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                        <i class="bi bi-x-circle me-1"></i>Cancelar
                    </button>
                    <button type="button" class="btn btn-danger" id="confirmDeleteBtn" 
                            data-ticket-id="${ticket.id}">
                        <i class="bi bi-trash me-1"></i>Sí, eliminar ticket
                    </button>
                </div>
            </div>
        </div>
    </div>

<jsp:include page="footer.jsp"/>

<!-- Incluir JavaScript específico de tickets -->
<script src="/js/tickets.js"></script>