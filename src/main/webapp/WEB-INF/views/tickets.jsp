<%-- tickets.jsp - Versión limpia --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:include page="header.jsp">
    <jsp:param name="pageTitle" value="Lista de Tickets"/>
</jsp:include>

<!-- Alertas -->
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

<!-- Título y botón nuevo -->
<div class="d-flex justify-content-between align-items-center mb-4">
    <h2><i class="bi bi-ticket-detailed"></i> Tickets</h2>
    <a href="/tickets/new" class="btn btn-primary">
        <i class="bi bi-plus-circle"></i> Nuevo Ticket
    </a>
</div>

<!-- ESTADÍSTICAS -->
<div class="card p-4 mb-4">
    <div class="row g-3 mb-4">
        <div class="col-6 col-md-3 text-center">
            <h4>${openCount}</h4>
            <h6 class="text-muted">Abiertos</h6>
        </div>
        <div class="col-6 col-md-3 text-center">
            <h4>${inProgressCount}</h4>
            <h6 class="text-muted">En Progreso</h6>
        </div>
        <div class="col-6 col-md-3 text-center">
            <h4>${resolvedCount}</h4>
            <h6 class="text-muted">Resueltos</h6>
        </div>
        <div class="col-6 col-md-3 text-center">
            <h4>${totalCount}</h4>
            <h6 class="text-muted">Total</h6>
        </div>
    </div>

    <hr class="my-3">

    <div class="row g-3">
        <div class="col-6 col-md-3 text-center">
            <h4 class="card-title mb-1">${openByPriority.LOW}</h4>
            <span class="badge badge-priority-low">Baja</span>
        </div>
        <div class="col-6 col-md-3 text-center">
            <h4 class="card-title mb-1">${openByPriority.MEDIUM}</h4>
            <span class="badge badge-priority-medium">Media</span>
        </div>
        <div class="col-6 col-md-3 text-center">
            <h4 class="card-title mb-1">${openByPriority.HIGH}</h4>
            <span class="badge badge-priority-high">Alta</span>
        </div>
        <div class="col-6 col-md-3 text-center">
            <h4 class="card-title mb-1">${openByPriority.CRITICAL}</h4>
            <span class="badge badge-priority-critical">Crítica</span>
        </div>
    </div>
</div>

<!-- Filtros mejorados -->
<div class="card mb-4">
    <div class="card-body">
        <form method="get" action="/tickets" class="row g-3">
            <input type="hidden" name="size" value="${pageSize}">
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
                <div class="input-group">
                    <input type="text" name="search" class="form-control" 
                           placeholder="Buscar por título, descripción, cliente..." 
                           value="${param.search}"
                           aria-label="Buscar tickets">
                    <c:if test="${not empty param.search}">
                        <a href="/tickets" class="btn btn-outline-secondary" title="Limpiar búsqueda">
                            <i class="bi bi-x"></i>
                        </a>
                    </c:if>
                </div>
            </div>
            <div class="col-md-2">
                <div class="d-grid gap-2 d-md-flex">
                    <button type="submit" class="btn btn-primary">
                        <i class="bi bi-funnel"></i> Filtrar
                    </button>
                    <a href="/tickets" class="btn btn-outline-secondary" title="Restablecer filtros">
                        <i class="bi bi-arrow-clockwise"></i>
                    </a>
                </div>
            </div>
        </form>
    </div>
</div>

<!-- Controles de vista -->
<div class="d-flex justify-content-between align-items-center mb-3">
    <div class="tickets-count text-muted">
        <i class="bi bi-info-circle"></i> Mostrando ${fn:length(tickets)} tickets
    </div>
    <div class="btn-group view-toggle" role="group">
        <button type="button" class="btn btn-outline-secondary active" id="gridViewBtn" data-view="grid">
            <i class="bi bi-grid"></i> Cuadrícula
        </button>
        <button type="button" class="btn btn-outline-secondary" id="tableViewBtn" data-view="table">
            <i class="bi bi-list"></i> Tabla
        </button>
    </div>
</div>

<!-- Paginación -->
<!-- Paginación SIEMPRE VISIBLE -->
<c:if test="${totalItems > 0}">
    <!-- Construir parámetros de filtro -->
    <c:set var="filterParams" value="" />
    <c:if test="${not empty param.status}">
        <c:set var="filterParams" value="${filterParams}&status=${param.status}" />
    </c:if>
    <c:if test="${not empty param.priority}">
        <c:set var="filterParams" value="${filterParams}&priority=${param.priority}" />
    </c:if>
    <c:if test="${not empty param.search}">
        <c:set var="filterParams" value="${filterParams}&search=${fn:escapeXml(param.search)}" />
    </c:if>
    <c:if test="${not empty param.view}">
        <c:set var="filterParams" value="${filterParams}&view=${param.view}" />
    </c:if>
    
    <div class="d-flex justify-content-between align-items-center mt-4 mb-3 p-3 border rounded bg-light">
        <!-- IZQUIERDA: Filas por página + Input personalizado -->
        <div class="d-flex align-items-center gap-2">
            <span class="text-muted small">Filas por página:</span>
            <select class="form-select form-select-sm w-auto" 
                    onchange="location.href='?page=0&size='+this.value+'${filterParams}'">
                <option value="5" ${pageSize == 5 ? 'selected' : ''}>5</option>
                <option value="10" ${pageSize == 10 ? 'selected' : ''}>10</option>
                <option value="15" ${pageSize == 15 ? 'selected' : ''}>15</option>
                <option value="25" ${pageSize == 25 ? 'selected' : ''}>25</option>
                <option value="50" ${pageSize == 50 ? 'selected' : ''}>50</option>
            </select>
            
            <div class="input-group input-group-sm" style="width: 120px;">
                <input type="number" id="customPageSize" class="form-control" 
                       min="1" max="200" placeholder="Personalizado" value="${pageSize}">
                <button class="btn btn-outline-secondary" type="button"
                        onclick="applyCustomPageSize()">
                    OK
                </button>
            </div>
        </div>
        
        <!-- CENTRO: Contador de registros -->
        <div class="text-muted small text-center">
            Mostrando <strong>${currentPage * pageSize + 1} - ${currentPage * pageSize + fn:length(tickets)}</strong> 
            de <strong>${totalItems}</strong> tickets
        </div>
        
        <!-- DERECHA: Navegación avanzada -->
        <div class="d-flex align-items-center gap-2">
            <!-- Botón Anterior -->
            <button class="btn btn-outline-secondary btn-sm ${currentPage == 0 ? 'disabled' : ''}"
                    onclick="location.href='?page=${currentPage - 1}&size=${pageSize}${filterParams}'"
                    ${currentPage == 0 ? 'disabled' : ''}>
                <i class="bi bi-chevron-left"></i>
            </button>
            
            <!-- Select de página -->
            <select class="form-select form-select-sm w-auto" 
                    onchange="location.href='?page='+(this.value-1)+'&size=${pageSize}${filterParams}'">
                <c:forEach begin="1" end="${totalPages}" var="pageNum">
                    <option value="${pageNum}" ${currentPage + 1 == pageNum ? 'selected' : ''}>
                        Pág. ${pageNum}
                    </option>
                </c:forEach>
            </select>
            
            <!-- Botón Siguiente -->
            <button class="btn btn-outline-secondary btn-sm ${currentPage == totalPages - 1 ? 'disabled' : ''}"
                    onclick="location.href='?page=${currentPage + 1}&size=${pageSize}${filterParams}'"
                    ${currentPage == totalPages - 1 ? 'disabled' : ''}>
                <i class="bi bi-chevron-right"></i>
            </button>
            
            <!-- Input Ir a + OK -->
            <div class="input-group input-group-sm" style="width: 140px;">
                <input type="number" id="goToPage" class="form-control" 
                    min="1" max="${totalPages}" placeholder="Ir a página"
                    data-max-pages="${totalPages}">
                <button class="btn btn-outline-primary" type="button"
                        onclick="goToCustomPage()">
                    Ir
                </button>
            </div>
        </div>
    </div>
    
    <!-- JavaScript para funcionalidades extra -->
    <script>
        function applyCustomPageSize() {
            const customSize = document.getElementById('customPageSize').value;
            if (customSize && customSize >= 1 && customSize <= 200) {
                location.href = '?page=0&size=' + customSize + '${filterParams}';
            }
        }
        
        function goToCustomPage() {
            const goToInput = document.getElementById('goToPage');
            if (!goToInput) return;
            
            const pageNum = goToInput.value;
            const maxPages = goToInput.getAttribute('data-max-pages');
            
            if (pageNum && pageNum >= 1 && pageNum <= maxPages) {
                location.href = '?page=' + (pageNum - 1) + '&size=${pageSize}${filterParams}';
            } else {
                alert('Por favor ingresa un número entre 1 y ' + maxPages);
            }
        }
        
        // Enter key support
        const customSizeInput = document.getElementById('customPageSize');
        const goToPageInput = document.getElementById('goToPage');
        
        if (customSizeInput) {
            customSizeInput.addEventListener('keypress', function(e) {
                if (e.key === 'Enter') applyCustomPageSize();
            });
        }
        
        if (goToPageInput) {
            goToPageInput.addEventListener('keypress', function(e) {
                if (e.key === 'Enter') goToCustomPage();
            });
        }
    </script>
</c:if>

<!-- Vista Tabla -->
<div id="tableView" class="view-container d-none">
    <div class="table-responsive">
        <table class="table table-hover align-middle tickets-table">
            <thead class="table-light">
                <tr>
                    <th style="width: 80px;">ID</th>
                    <th>Título</th>
                    <th style="width: 120px;">Cliente</th>
                    <th style="width: 120px;">Prioridad</th>
                    <th style="width: 120px;">Estado</th>
                    <th style="width: 180px;">Fecha</th>
                    <th style="width: 100px;" class="text-center">Acciones</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="ticket" items="${tickets}">
                    <tr class="priority-${ticket.priority.toLowerCase()}">
                    <td class="fw-bold">#${ticket.id}</td>
                        <td>
                            <div class="fw-semibold text-truncate" title="${ticket.title}">
                                ${ticket.title}
                            </div>
                            <div class="text-muted small text-truncate" title="${ticket.description}">
                                ${ticket.description}
                            </div>
                        </td>
                        <td>
                            <div>${ticket.clientName}</div>
                            <div class="text-muted small">${ticket.clientEmail}</div>
                        </td>
                        <td>
                            <span class="badge badge-priority-${fn:toLowerCase(ticket.priority)}">
                                <c:choose>
                                    <c:when test="${ticket.priority == 'LOW'}">Baja</c:when>
                                    <c:when test="${ticket.priority == 'MEDIUM'}">Media</c:when>
                                    <c:when test="${ticket.priority == 'HIGH'}">Alta</c:when>
                                    <c:when test="${ticket.priority == 'CRITICAL'}">Crítica</c:when>
                                    <c:otherwise>${ticket.priority}</c:otherwise>
                                </c:choose>
                            </span>
                        </td>
                        <td>
                            <span class="badge badge-status-${fn:toLowerCase(ticket.status)}">
                                <c:choose>
                                    <c:when test="${ticket.status == 'OPEN'}">Abierto</c:when>
                                    <c:when test="${ticket.status == 'IN_PROGRESS'}">En Progreso</c:when>
                                    <c:when test="${ticket.status == 'RESOLVED'}">Resuelto</c:when>
                                    <c:when test="${ticket.status == 'CLOSED'}">Cerrado</c:when>
                                    <c:otherwise>${ticket.status}</c:otherwise>
                                </c:choose>
                            </span>
                        </td>
                        <td>
                            <div class="small">${ticket.createdAt}</div>
                            <c:if test="${not empty ticket.updatedAt && ticket.updatedAt != ticket.createdAt}">
                                <div class="text-muted smaller">
                                    <i class="bi bi-arrow-repeat"></i> Actualizado
                                </div>
                            </c:if>
                        </td>
                        <td class="text-center">
                            <a href="/tickets/${ticket.id}" class="btn btn-sm btn-outline-primary table-action-btn" title="Ver detalles">
                                <i class="bi bi-eye"></i>
                            </a>
                            <a href="/tickets/${ticket.id}/edit" class="btn btn-sm btn-outline-secondary table-action-btn" title="Editar">
                                <i class="bi bi-pencil"></i>
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<!-- Vista Grid -->
<div id="gridView" class="view-container">
    <c:choose>
        <c:when test="${empty tickets}">
            <div class="alert alert-info">
                No hay tickets disponibles. <a href="/tickets/new">Crear el primero</a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
                <c:forEach var="ticket" items="${tickets}">
                    <div class="col">
                        <div class="card ticket-card priority-${ticket.priority.toLowerCase()} h-100">
                            <div class="card-body">
                                <!-- Título solo -->
                                <div class="d-flex justify-content-between align-items-start mb-2">
                                    <h5 class="card-title" title="#${ticket.id} - ${ticket.title}">
                                        #${ticket.id} - ${ticket.title}
                                    </h5>
                                </div>
                                
                                <!-- Badges debajo del título -->
                                <div class="ticket-badges-container">
                                    <!-- Estado -->
                                    <span class="badge badge-status-${fn:toLowerCase(ticket.status)}">
                                        <c:choose>
                                            <c:when test="${ticket.status == 'OPEN'}">Abierto</c:when>
                                            <c:when test="${ticket.status == 'IN_PROGRESS'}">En Progreso</c:when>
                                            <c:when test="${ticket.status == 'RESOLVED'}">Resuelto</c:when>
                                            <c:when test="${ticket.status == 'CLOSED'}">Cerrado</c:when>
                                            <c:otherwise>${ticket.status}</c:otherwise>
                                        </c:choose>
                                    </span>
                                    <!-- Prioridad -->
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
                                
                                <!-- Resto del contenido DENTRO del card-body -->
                                <p class="card-text text-muted small mb-2">
                                    <i class="bi bi-person"></i> ${ticket.clientName}
                                    <span class="mx-2">•</span>
                                    <i class="bi bi-envelope"></i> ${ticket.clientEmail}
                                </p>
                                
                                <p class="card-text">
                                    ${fn:substring(ticket.description, 0, 100)}...
                                </p>
                                
                                <div class="d-flex justify-content-between align-items-center mt-3">
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
                            </div> <!-- ← card-body -->
                        </div> <!-- ← card -->
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="footer.jsp"/>