<!-- src/main/webapp/WEB-INF/views/header.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="es" data-bs-theme="light">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Ticket System - ${pageTitle}</title>

        <!-- 1. Bootstrap base -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

        <!-- 2. Nuestro tema (sobrescribe Bootstrap) -->
        <link href="/tickets/css/theme.css" rel="stylesheet">

        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">

        <!-- Favicon dinámico -->
        <link rel="icon" type="image/png" href="/tickets/logo_light.png" id="favicon">

        <style>
            body {
                display: flex;
                flex-direction: column;
                min-height: 100vh;
            }

            main {
                flex: 1;
            }
        </style>
    </head>

    <body class="theme-light">

        <!-- HEADER FIJO -->
        <header class="app-header py-3 shadow-sm">
            <div class="container">
                <div class="d-flex align-items-center justify-content-between">
                    <div class="d-flex align-items-center">
                        <img src="/tickets/logo_light.png" alt="Ticket System" height="40" class="me-3"
                            id="header-logo">
                        <h1 class="h3 mb-0 fw-bold">Ticket System</h1>
                    </div>
                </div>
            </div>
        </header>

        <!-- MENU HAMBURGUESA -->
        <div class="menu-container">
            <button class="hamburger-button" aria-label="Menú">
                <span class="hamburger-line"></span>
                <span class="hamburger-line"></span>
                <span class="hamburger-line"></span>
            </button>

            <div class="menu-dropdown">
                <!-- NAVEGACIÓN (Aprobados) -->
                <div data-approved-only="true">
                    <div class="section-header">Navegación</div>
                    <a href="https://ryzenpc.mooo.com/" class="menu-item">
                        <i class="bi bi-house-fill"></i> Dashboard Principal
                    </a>
                    <a href="https://ryzenpc.mooo.com/#/dashboard?tab=configuracion" class="menu-item"
                        data-admin-only="true">
                        <i class="bi bi-people-fill"></i> Gestión de Usuarios
                    </a>

                    <div class="menu-divider"></div>

                    <!-- APLICACIONES -->
                    <div class="section-header">Aplicaciones</div>

                    <!-- Finanzas (Colapsable) -->
                    <div class="submenu">
                        <div class="menu-item-container">
                            <div class="menu-item-header" onclick="toggleSubmenu('finanzas', event)">
                                <i class="bi bi-wallet2"></i> <span>Finanzas Personales</span>
                            </div>
                            <button class="submenu-toggle" onclick="toggleSubmenu('finanzas', event)">
                                <i class="bi bi-chevron-down" id="toggle-icon-finanzas"></i>
                            </button>
                        </div>
                        <div class="submenu-content" id="submenu-finanzas" style="display: none;">
                            <a href="/finanzas/categories" class="menu-sub-item">
                                <i class="bi bi-folder2-open"></i> Categorías
                            </a>
                            <a href="/finanzas/transactions" class="menu-sub-item">
                                <i class="bi bi-cash-stack"></i> Transacciones
                            </a>
                            <a href="/finanzas/stats" class="menu-sub-item">
                                <i class="bi bi-graph-up-arrow"></i> Estadísticas
                            </a>
                        </div>
                    </div>

                    <!-- Geo-Data (Colapsable) -->
                    <div class="submenu">
                        <div class="menu-item-container">
                            <div class="menu-item-header" onclick="toggleSubmenu('geo', event)">
                                <i class="bi bi-geo-alt-fill"></i> <span>Geo-Data Analytics</span>
                            </div>
                            <button class="submenu-toggle" onclick="toggleSubmenu('geo', event)">
                                <i class="bi bi-chevron-down" id="toggle-icon-geo"></i>
                            </button>
                        </div>
                        <div class="submenu-content" id="submenu-geo" style="display: none;">
                            <a href="/geo/" class="menu-sub-item">
                                <i class="bi bi-speedometer2"></i> Inicio
                            </a>
                            <a href="/geo/dataset/covid" class="menu-sub-item">
                                <i class="bi bi-virus"></i> COVID España
                            </a>
                            <a href="/geo/dataset/weather" class="menu-sub-item">
                                <i class="bi bi-cloud-sun-fill"></i> Clima España
                            </a>
                            <a href="/geo/dataset/elections" class="menu-sub-item">
                                <i class="bi bi-bar-chart-fill"></i> Resultados Electorales
                            </a>
                            <a href="/geo/dataset/airquality" class="menu-sub-item">
                                <i class="bi bi-wind"></i> Calidad del Aire
                            </a>
                            <a href="/geo/dataset/housing" class="menu-sub-item">
                                <i class="bi bi-house-door-fill"></i> Precios Vivienda
                            </a>
                        </div>
                    </div>

                    <a href="/tickets/" class="menu-item bg-light border-start border-primary border-4"
                        data-admin-only="true">
                        <i class="bi bi-ticket-perforated-fill"></i> Sistema de Tickets
                    </a>
                    <a href="/contactos/" class="menu-item">
                        <i class="bi bi-person-lines-fill"></i> Agenda de Contactos
                    </a>

                    <div class="menu-divider"></div>

                    <!-- HERRAMIENTAS -->
                    <div class="section-header">Herramientas</div>
                    <a href="https://ryzenpc.mooo.com/#/dashboard?tab=calculadora" class="menu-item">
                        <i class="bi bi-calculator-fill"></i> Interés Compuesto
                    </a>
                    <a href="https://ryzenpc.mooo.com/#/dashboard?tab=mortgage" class="menu-item">
                        <i class="bi bi-house-door-fill"></i> Hipoteca
                    </a>
                    <a href="https://ryzenpc.mooo.com/#/dashboard?tab=basic-calculator" class="menu-item">
                        <i class="bi bi-percent"></i> Calculadora Básica
                    </a>

                    <div class="menu-divider"></div>
                </div>

                <!-- SISTEMA -->
                <div id="system-header" class="section-header" style="display: none;">Sistema</div>
                <button class="menu-item"
                    onclick="setTheme(document.body.classList.contains('theme-dark') ? 'light' : 'dark')">
                    <i class="bi" id="theme-icon"></i>
                    <span id="theme-text">Modo Oscuro</span>
                </button>
                <button class="menu-item logout-item"
                    onclick="window.location.href='https://ryzenpc.mooo.com/api/auth/logout'">
                    <i class="bi bi-box-arrow-right"></i> Cerrar Sesión
                </button>
            </div>
        </div>

        <script>
            // Lógica de Roles y Aprobación
            document.addEventListener('DOMContentLoaded', function () {
                try {
                    const savedUser = localStorage.getItem('user');
                    if (savedUser) {
                        const user = JSON.parse(savedUser);

                        // Control de Aprobación
                        if (user.isApproved === false) {
                            document.querySelectorAll('[data-approved-only="true"]').forEach(el => {
                                el.style.display = 'none';
                            });
                            document.getElementById('system-header').style.display = 'block';
                        } else {
                            // Control de Admin (solo si está aprobado)
                            if (user.role !== 'admin') {
                                document.querySelectorAll('[data-admin-only="true"]').forEach(el => {
                                    el.style.display = 'none';
                                });
                            }
                        }
                    }
                } catch (e) {
                    console.error('Error parsing user for role check:', e);
                }

                // Toggle hamburguesa
                const hamburger = document.querySelector('.hamburger-button');
                const dropdown = document.querySelector('.menu-dropdown');

                if (hamburger && dropdown) {
                    hamburger.addEventListener('click', function (e) {
                        e.stopPropagation();
                        dropdown.classList.toggle('show');
                    });
                }
            });

            function toggleSubmenu(name, event) {
                event.preventDefault();
                event.stopPropagation();
                const content = document.getElementById('submenu-' + name);
                const icon = document.getElementById('toggle-icon-' + name);
                const isOpen = content.style.display === 'block';

                content.style.display = isOpen ? 'none' : 'block';
                icon.className = isOpen ? 'bi bi-chevron-down' : 'bi bi-chevron-up';
            }

            // Cerrar menú al hacer clic fuera
            document.addEventListener('click', function (event) {
                const container = document.querySelector('.menu-container');
                const dropdown = document.querySelector('.menu-dropdown');
                if (container && dropdown && !container.contains(event.target)) {
                    dropdown.classList.remove('show');
                }
            });
        </script>

        <!-- CONTENIDO PRINCIPAL -->
        <main class="container my-4">