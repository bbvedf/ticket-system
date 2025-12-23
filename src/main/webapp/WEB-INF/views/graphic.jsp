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
        <!-- 1. Tickets por Estado (Pie) -->
        <div class="col-md-6 col-lg-3">
            <div class="card h-100">
                <div class="card-header">
                    <h6 class="mb-0">Tickets por Estado</h6>
                </div>
                <div class="card-body">
                    <canvas id="chart1"></canvas>
                </div>
            </div>
        </div>

        <!-- 2. Tickets por Prioridad (Bar) -->
        <div class="col-md-6 col-lg-3">
            <div class="card h-100">
                <div class="card-header">
                    <h6 class="mb-0">Tickets por Prioridad</h6>
                </div>
                <div class="card-body">
                    <canvas id="chart2"></canvas>
                </div>
            </div>
        </div>

        <!-- 3. Asignados vs Sin Asignar (Donut) -->
        <div class="col-md-6 col-lg-3">
            <div class="card h-100">
                <div class="card-header">
                    <h6 class="mb-0">Asignación</h6>
                </div>
                <div class="card-body">
                    <canvas id="chart3"></canvas>
                </div>
            </div>
        </div>

        <!-- 4. Tickets por Categoría (Bar) -->
        <div class="col-md-6 col-lg-3">
            <div class="card h-100">
                <div class="card-header">
                    <h6 class="mb-0">Tickets por Categoría</h6>
                </div>
                <div class="card-body">
                    <canvas id="chart4"></canvas>
                </div>
            </div>
        </div>
    </div>

    <!-- FILA 2: 4 gráficos -->
    <div class="row g-3 mb-4">
        <!-- 5. Tasa de Resolución (Métrica) -->
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

        <!-- 6. Tiempo Promedio por Prioridad (Bar) -->
        <div class="col-md-6 col-lg-3">
            <div class="card h-100">
                <div class="card-header">
                    <h6 class="mb-0">Tiempo Promedio (horas)</h6>
                </div>
                <div class="card-body">
                    <canvas id="chart6"></canvas>
                </div>
            </div>
        </div>

        <!-- 7. Distribución Estado (Donut) -->
        <div class="col-md-6 col-lg-3">
            <div class="card h-100">
                <div class="card-header">
                    <h6 class="mb-0">Distribución Estado</h6>
                </div>
                <div class="card-body">
                    <canvas id="chart7"></canvas>
                </div>
            </div>
        </div>

        <!-- 8. Evolución Temporal (Line) -->
        <div class="col-md-6 col-lg-3">
            <div class="card h-100">
                <div class="card-header">
                    <h6 class="mb-0">Tickets Últimos 7 días</h6>
                </div>
                <div class="card-body">
                    <canvas id="chart8"></canvas>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.9.1/chart.min.js"></script>

<script>
    // Datos desde el servidor (JSON) - GLOBALES    
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

    // 1. Tickets por Estado (Pie)
    new Chart(document.getElementById('chart1'), {
        type: 'pie',
        data: {
            labels: ticketsByStatus.labels,
            datasets: [{
                data: ticketsByStatus.data,
                backgroundColor: ['#2563eb', '#fd7e14', '#198754', '#dc3545'],
                borderColor: '#fff',
                borderWidth: 2
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: true,
            plugins: {
                legend: {
                    position: 'bottom'
                }
            }
        }
    });

    // 2. Tickets por Prioridad (Bar)
    new Chart(document.getElementById('chart2'), {
        type: 'bar',
        data: {
            labels: ticketsByPriority.labels,
            datasets: [{
                label: 'Tickets',
                data: ticketsByPriority.data,
                backgroundColor: ['#198754', '#fd7e14', '#dc3545', '#000'],
                borderRadius: 4
            }]
        },
        options: {
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
        }
    });

    // 3. Asignados vs Sin Asignar (Donut)
    new Chart(document.getElementById('chart3'), {
        type: 'doughnut',
        data: {
            labels: assignedVsUnassigned.labels,
            datasets: [{
                data: assignedVsUnassigned.data,
                backgroundColor: ['#2563eb', '#e9ecef'],
                borderColor: '#fff',
                borderWidth: 2
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    position: 'bottom'
                }
            }
        }
    });

    // 4. Tickets por Categoría (Bar)
    new Chart(document.getElementById('chart4'), {
        type: 'bar',
        data: {
            labels: ticketsByCategory.labels,
            datasets: [{
                label: 'Tickets',
                data: ticketsByCategory.data,
                backgroundColor: colors.blue,
                borderRadius: 4
            }]
        },
        options: {
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
        }
    });

    // 6. Tiempo Promedio por Prioridad (Bar)
    new Chart(document.getElementById('chart6'), {
        type: 'bar',
        data: {
            labels: avgTimeByPriority.labels,
            datasets: [{
                label: 'Horas',
                data: avgTimeByPriority.data,
                backgroundColor: ['#198754', '#fd7e14', '#dc3545', '#000'],
                borderRadius: 4
            }]
        },
        options: {
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
        }
    });

    // 7. Distribución Estado (Donut)
    new Chart(document.getElementById('chart7'), {
        type: 'doughnut',
        data: {
            labels: statusDistribution.labels,
            datasets: [{
                data: statusDistribution.data,
                backgroundColor: ['#2563eb', '#fd7e14', '#198754', '#dc3545'],
                borderColor: '#fff',
                borderWidth: 2
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    position: 'bottom'
                }
            }
        }
    });

    // 8. Evolución Temporal (Line)
    new Chart(document.getElementById('chart8'), {
        type: 'line',
        data: {
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
        },
        options: {
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
        }
    });
</script>

<jsp:include page="footer.jsp"/>