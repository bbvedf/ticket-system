<%-- src/main/webapp/WEB-INF/views/ticket-form.jsp --%>
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

        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h2>
                    <c:if test="${empty ticket.id}">Crear Nuevo Ticket</c:if>
                    <c:if test="${not empty ticket.id}">Editar Ticket #${ticket.id}</c:if>
                </h2>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="/">Inicio</a></li>
                        <li class="breadcrumb-item"><a href="/tickets">Tickets</a></li>
                        <li class="breadcrumb-item active" aria-current="page">
                            <c:if test="${empty ticket.id}">Nuevo</c:if>
                            <c:if test="${not empty ticket.id}">Editar</c:if>
                        </li>
                    </ol>
                </nav>
            </div>
        </div>

        <div class="row">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-body">
                        <form method="POST" action="<c:if test="${empty ticket.id}">/tickets</c:if><c:if test="${not empty ticket.id}">/tickets/${ticket.id}</c:if>">
                            
                            <!-- TÍTULO -->
                            <div class="mb-3">
                                <label for="title" class="form-label">Título *</label>
                                <input type="text" class="form-control" id="title" name="title" 
                                       value="${ticket.title}" required>
                            </div>
                            
                            <!-- DESCRIPCIÓN -->
                            <div class="mb-3">
                                <label for="description" class="form-label">Descripción *</label>
                                <textarea class="form-control" id="description" name="description" 
                                          rows="5" required>${ticket.description}</textarea>
                            </div>
                            
                            <!-- FILA: ESTADO, PRIORIDAD, CATEGORÍA -->
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="mb-3">
                                        <label for="status" class="form-label">Estado</label>
                                        <select class="form-select" id="status" name="status">
                                            <option value="OPEN" ${ticket.status == 'OPEN' ? 'selected' : ''}>Abierto</option>
                                            <option value="IN_PROGRESS" ${ticket.status == 'IN_PROGRESS' ? 'selected' : ''}>En Progreso</option>
                                            <option value="RESOLVED" ${ticket.status == 'RESOLVED' ? 'selected' : ''}>Resuelto</option>
                                            <option value="CLOSED" ${ticket.status == 'CLOSED' ? 'selected' : ''}>Cerrado</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="mb-3">
                                        <label for="priority" class="form-label">Prioridad</label>
                                        <select class="form-select" id="priority" name="priority">
                                            <option value="LOW" ${ticket.priority == 'LOW' ? 'selected' : ''}>Baja</option>
                                            <option value="MEDIUM" ${ticket.priority == 'MEDIUM' ? 'selected' : ''}>Media</option>
                                            <option value="HIGH" ${ticket.priority == 'HIGH' ? 'selected' : ''}>Alta</option>
                                            <option value="CRITICAL" ${ticket.priority == 'CRITICAL' ? 'selected' : ''}>Crítica</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="mb-3">
                                        <label for="category" class="form-label">Categoría</label>
                                        <input type="text" class="form-control" id="category" name="category" 
                                               value="${ticket.category}" placeholder="ej: Bug, Feature">
                                    </div>
                                </div>
                            </div>
                            
                            <!-- FILA: CLIENTE -->
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="clientName" class="form-label">Nombre del Cliente</label>
                                        <input type="text" class="form-control" id="clientName" name="clientName" 
                                               value="${ticket.clientName}">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="clientEmail" class="form-label">Email del Cliente</label>
                                        <input type="email" class="form-control" id="clientEmail" name="clientEmail" 
                                               value="${ticket.clientEmail}">
                                    </div>
                                </div>
                            </div>
                            
                            <!-- ASIGNADO A -->
                            <div class="mb-3">
                                <label for="assignedTo" class="form-label">Asignado a</label>
                                <input type="text" class="form-control" id="assignedTo" name="assignedTo" 
                                       value="${ticket.assignedTo}" placeholder="Nombre del responsable">
                            </div>
                            
                            <!-- BOTONES -->
                            <div class="d-flex gap-2">
                                <button type="submit" class="btn btn-primary">
                                    <i class="bi bi-check-circle"></i>
                                    <c:if test="${empty ticket.id}">Crear Ticket</c:if>
                                    <c:if test="${not empty ticket.id}">Guardar Cambios</c:if>
                                </button>
                                <a href="/tickets" class="btn btn-outline-secondary">
                                    <i class="bi bi-arrow-left"></i> Cancelar
                                </a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            
            <div class="col-md-4">
                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0">Ayuda</h5>
                    </div>
                    <div class="card-body">
                        <h6>Estados disponibles:</h6>
                        <ul class="small">
                            <li><strong>Abierto:</strong> Ticket nuevo sin asignar</li>
                            <li><strong>En Progreso:</strong> Se está trabajando en ello</li>
                            <li><strong>Resuelto:</strong> Problema solucionado</li>
                            <li><strong>Cerrado:</strong> Ticket finalizado</li>
                        </ul>
                        
                        <h6 class="mt-3">Prioridades:</h6>
                        <ul class="small">
                            <li><strong>Baja:</strong> Mejoras secundarias</li>
                            <li><strong>Media:</strong> Problemas normales</li>
                            <li><strong>Alta:</strong> Afecta a usuarios</li>
                            <li><strong>Crítica:</strong> Sistema no funciona</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
<jsp:include page="footer.jsp"/>