<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="header.jsp">
    <jsp:param name="pageTitle" value="Gráficos y Reportes"/>
</jsp:include>

<div class="container-fluid mt-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2><i class="bi bi-graph-up"></i> Gráficos y Reportes</h2>
    </div>

    <!-- FILA 1: 4 gráficos -->
    <div class="row g-3 mb-4">
        <!-- 1. Tickets por Estado -->
        <div class="col-md-6 col-lg-3">
            <div class="card h-100">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h6 class="mb-0">Tickets por Estado</h6>
                    <button class="btn btn-sm btn-link" data-bs-toggle="modal" data-bs-target="#modal1" title="Expandir">
                        <i class="bi bi-arrows-fullscreen"></i>
                    </button>
                </div>
                <div class="card-body">
                    <canvas id="chart1"></canvas>
                </div>
            </div>
        </div>

        <!-- 2. Tickets por Prioridad -->
        <div class="col-md-6 col-lg-3">
            <div class="card h-100">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h6 class="mb-0">Tickets por Prioridad</h6>
                    <button class="btn btn-sm btn-link" data-bs-toggle="modal" data-bs-target="#modal2" title="Expandir">
                        <i class="bi bi-arrows-fullscreen"></i>
                    </button>
                </div>
                <div class="card-body">
                    <canvas id="chart2"></canvas>
                </div>
            </div>
        </div>

        <!-- 3. Asignados vs Sin Asignar -->
        <div class="col-md-6 col-lg-3">
            <div class="card h-100">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h6 class="mb-0">Asignación</h6>
                    <button class="btn btn-sm btn-link" data-bs-toggle="modal" data-bs-target="#modal3" title="Expandir">
                        <i class="bi bi-arrows-fullscreen"></i>
                    </button>
                </div>
                <div class="card-body">
                    <canvas id="chart3"></canvas>
                </div>
            </div>
        </div>

        <!-- 4. Tickets por Categoría -->
        <div class="col-md-6 col-lg-3">
            <div class="card h-100">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h6 class="mb-0">Tickets por Categoría</h6>
                    <button class="btn btn-sm btn-link" data-bs-toggle="modal" data-bs-target="#modal4" title="Expandir">
                        <i class="bi bi-arrows-fullscreen"></i>
                    </button>
                </div>
                <div class="card-body">
                    <canvas id="chart4"></canvas>
                </div>
            </div>
        </div>
    </div>

    <!-- FILA 2: 4 gráficos -->
    <div class="row g-3 mb-4">
        <!-- 5. Tasa de Resolución -->
        <div class="col-md-6 col-lg-3">
            <div class="card h-100">
                <div class="card-header">
                    <h6 class="mb-0">Tasa de Resolución</h6>
                </div>
                <div class="card-body text-center">
                    <div style="font-size: 3em; font-weight: bold; color: #2563eb;">
                        ${resolutionRate.rate}%
                    </div>
                    <small class="text-muted">
                        ${resolutionRate.resolved} de ${resolutionRate.total} tickets
                    </small>
                </div>
            </div>
        </div>

        <!-- 6. Tiempo Promedio por Prioridad -->
        <div class="col-md-6 col-lg-3">
            <div class="card h-100">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h6 class="mb-0">Tiempo Promedio (horas)</h6>
                    <button class="btn btn-sm btn-link" data-bs-toggle="modal" data-bs-target="#modal6" title="Expandir">
                        <i class="bi bi-arrows-fullscreen"></i>
                    </button>
                </div>
                <div class="card-body">
                    <canvas id="chart6"></canvas>
                </div>
            </div>
        </div>

        <!-- 7. Distribución Estado -->
        <div class="col-md-6 col-lg-3">
            <div class="card h-100">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h6 class="mb-0">Distribución Estado</h6>
                    <button class="btn btn-sm btn-link" data-bs-toggle="modal" data-bs-target="#modal7" title="Expandir">
                        <i class="bi bi-arrows-fullscreen"></i>
                    </button>
                </div>
                <div class="card-body">
                    <canvas id="chart7"></canvas>
                </div>
            </div>
        </div>

        <!-- 8. Evolución Temporal -->
        <div class="col-md-6 col-lg-3">
            <div class="card h-100">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h6 class="mb-0">Tickets Últimos 7 días</h6>
                    <button class="btn btn-sm btn-link" data-bs-toggle="modal" data-bs-target="#modal8" title="Expandir">
                        <i class="bi bi-arrows-fullscreen"></i>
                    </button>
                </div>
                <div class="card-body">
                    <canvas id="chart8"></canvas>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- MODALES PARA GRÁFICOS EXPANDIDOS -->
<div class="modal fade" id="modal1" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Tickets por Estado</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <canvas id="chart1Modal"></canvas>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modal2" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Tickets por Prioridad</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <canvas id="chart2Modal"></canvas>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modal3" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Asignación</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <canvas id="chart3Modal"></canvas>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modal4" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Tickets por Categoría</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <canvas id="chart4Modal"></canvas>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modal6" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Tiempo Promedio por Prioridad</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <canvas id="chart6Modal"></canvas>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modal7" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Distribución Estado</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <canvas id="chart7Modal"></canvas>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modal8" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Evolución Temporal</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <canvas id="chart8Modal"></canvas>
            </div>
        </div>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.9.1/chart.min.js"></script>

<script>
    // Datos desde el servidor (JSON)
    const ticketsByStatus = JSON.parse('${ticketsByStatusJson}');
    const ticketsByPriority = JSON.parse('${ticketsByPriorityJson}');
    const assignedVsUnassigned = JSON.parse('${assignedVsUnassignedJson}');
    const ticketsByCategory = JSON.parse('${ticketsByCategoryJson}');
    const avgTimeByPriority = JSON.parse('${avgTimeByPriorityJson}');
    const statusDistribution = JSON.parse('${statusDistributionJson}');
    const temporalEvolution = JSON.parse('${temporalEvolutionJson}');

    // Colores
    const colors = {
        blue: '#2563eb',
        green: '#198754',
        orange: '#fd7e14',
        red: '#dc3545',
        purple: '#6f42c1',
        cyan: '#0dcaf0'
    };

    // Función auxiliar para crear gráficos
    function createChart(elementId, type, data, options) {
        const ctx = document.getElementById(elementId);
        if (!ctx) return null;
        
        return new Chart(ctx, {
            type: type,
            data: data,
            options: options
        });
    }

    // Opciones por defecto
    const defaultPieOptions = {
        responsive: true,
        maintainAspectRatio: true,
        plugins: {
            legend: {
                position: 'bottom'
            }
        }
    };

    const defaultBarOptions = {
        responsive: true,
        indexAxis: 'y',
        plugins: {
            legend: {
                display: false
            }
        },
        scales: {
            x: {
                beginAtZero: true
            }
        }
    };

    // 1. Tickets por Estado (Pie)
    createChart('chart1', 'pie', {
        labels: ticketsByStatus.labels,
        datasets: [{
            data: ticketsByStatus.data,
            backgroundColor: ['#2563eb', '#fd7e14', '#198754', '#dc3545'],
            borderColor: '#fff',
            borderWidth: 2
        }]
    }, defaultPieOptions);

    // Modal 1
    document.getElementById('modal1').addEventListener('shown.bs.modal', function() {
        createChart('chart1Modal', 'pie', {
            labels: ticketsByStatus.labels,
            datasets: [{
                data: ticketsByStatus.data,
                backgroundColor: ['#2563eb', '#fd7e14', '#198754', '#dc3545'],
                borderColor: '#fff',
                borderWidth: 2
            }]
        }, defaultPieOptions);
    });

    // 2. Tickets por Prioridad (Bar)
    createChart('chart2', 'bar', {
        labels: ticketsByPriority.labels,
        datasets: [{
            label: 'Tickets',
            data: ticketsByPriority.data,
            backgroundColor: ['#198754', '#fd7e14', '#dc3545', '#000'],
            borderRadius: 4
        }]
    }, defaultBarOptions);

    document.getElementById('modal2').addEventListener('shown.bs.modal', function() {
        createChart('chart2Modal', 'bar', {
            labels: ticketsByPriority.labels,
            datasets: [{
                label: 'Tickets',
                data: ticketsByPriority.data,
                backgroundColor: ['#198754', '#fd7e14', '#dc3545', '#000'],
                borderRadius: 4
            }]
        }, defaultBarOptions);
    });

    // 3. Asignados vs Sin Asignar (Donut)
    createChart('chart3', 'doughnut', {
        labels: assignedVsUnassigned.labels,
        datasets: [{
            data: assignedVsUnassigned.data,
            backgroundColor: ['#2563eb', '#e9ecef'],
            borderColor: '#fff',
            borderWidth: 2
        }]
    }, defaultPieOptions);

    document.getElementById('modal3').addEventListener('shown.bs.modal', function() {
        createChart('chart3Modal', 'doughnut', {
            labels: assignedVsUnassigned.labels,
            datasets: [{
                data: assignedVsUnassigned.data,
                backgroundColor: ['#2563eb', '#e9ecef'],
                borderColor: '#fff',
                borderWidth: 2
            }]
        }, defaultPieOptions);
    });

    // 4. Tickets por Categoría (Bar)
    createChart('chart4', 'bar', {
        labels: ticketsByCategory.labels,
        datasets: [{
            label: 'Tickets',
            data: ticketsByCategory.data,
            backgroundColor: colors.blue,
            borderRadius: 4
        }]
    }, {
        responsive: true,
        plugins: {
            legend: {
                display: false
            }
        },
        scales: {
            y: {
                beginAtZero: true
            }
        }
    });

    document.getElementById('modal4').addEventListener('shown.bs.modal', function() {
        createChart('chart4Modal', 'bar', {
            labels: ticketsByCategory.labels,
            datasets: [{
                label: 'Tickets',
                data: ticketsByCategory.data,
                backgroundColor: colors.blue,
                borderRadius: 4
            }]
        }, {
            responsive: true,
            plugins: {
                legend: {
                    display: false
                }
            },
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        });
    });

    // 6. Tiempo Promedio por Prioridad (Bar)
    createChart('chart6', 'bar', {
        labels: avgTimeByPriority.labels,
        datasets: [{
            label: 'Horas',
            data: avgTimeByPriority.data,
            backgroundColor: ['#198754', '#fd7e14', '#dc3545', '#000'],
            borderRadius: 4
        }]
    }, defaultBarOptions);

    document.getElementById('modal6').addEventListener('shown.bs.modal', function() {
        createChart('chart6Modal', 'bar', {
            labels: avgTimeByPriority.labels,
            datasets: [{
                label: 'Horas',
                data: avgTimeByPriority.data,
                backgroundColor: ['#198754', '#fd7e14', '#dc3545', '#000'],
                borderRadius: 4
            }]
        }, defaultBarOptions);
    });

    // 7. Distribución Estado (Donut)
    createChart('chart7', 'doughnut', {
        labels: statusDistribution.labels,
        datasets: [{
            data: statusDistribution.data,
            backgroundColor: ['#2563eb', '#fd7e14', '#198754', '#dc3545'],
            borderColor: '#fff',
            borderWidth: 2
        }]
    }, defaultPieOptions);

    document.getElementById('modal7').addEventListener('shown.bs.modal', function() {
        createChart('chart7Modal', 'doughnut', {
            labels: statusDistribution.labels,
            datasets: [{
                data: statusDistribution.data,
                backgroundColor: ['#2563eb', '#fd7e14', '#198754', '#dc3545'],
                borderColor: '#fff',
                borderWidth: 2
            }]
        }, defaultPieOptions);
    });

    // 8. Evolución Temporal (Line)
    createChart('chart8', 'line', {
        labels: temporalEvolution.labels,
        datasets: [{
            label: 'Tickets creados',
            data: temporalEvolution.data,
            borderColor: colors.blue,
            backgroundColor: 'rgba(37, 99, 235, 0.1)',
            tension: 0.4,
            fill: true,
            borderWidth: 2
        }]
    }, {
        responsive: true,
        plugins: {
            legend: {
                display: true
            }
        },
        scales: {
            y: {
                beginAtZero: true
            }
        }
    });

    document.getElementById('modal8').addEventListener('shown.bs.modal', function() {
        createChart('chart8Modal', 'line', {
            labels: temporalEvolution.labels,
            datasets: [{
                label: 'Tickets creados',
                data: temporalEvolution.data,
                borderColor: colors.blue,
                backgroundColor: 'rgba(37, 99, 235, 0.1)',
                tension: 0.4,
                fill: true,
                borderWidth: 2
            }]
        }, {
            responsive: true,
            plugins: {
                legend: {
                    display: true
                }
            },
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        });
    });
</script>

<jsp:include page="footer.jsp"/>