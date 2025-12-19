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
    <link href="/css/theme.css" rel="stylesheet">
    
    <!-- MODAL LIMPIO -->
    <link href="/css/modal.css" rel="stylesheet">

    <!-- 3. CSS específicos (sobrescriben tema si necesario) -->
    <link href="/css/styles.css" rel="stylesheet">
    <link href="/css/tickets.css" rel="stylesheet">
    
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">

    <!-- Favicon dinámico -->
    <link rel="icon" type="image/png" href="/logo_light.png" id="favicon">

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
                <img src="/logo_light.png" alt="Ticket System" height="40" class="me-3" id="header-logo">
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
    
    <div class="menu-dropdown" style="display: none;">
        <a href="/" class="menu-item">
            <i class="bi bi-house-fill"></i>
            Inicio
        </a>
        <a href="/tickets" class="menu-item">
            <i class="bi bi-list"></i>
            Tickets
        </a>
        <a href="/tickets/new" class="menu-item">
            <i class="bi bi-plus-circle"></i>
            Nuevo Ticket
        </a>
        
        <div class="menu-divider"></div>
        
        <button class="menu-item" onclick="setTheme(document.body.classList.contains('theme-dark') ? 'light' : 'dark')">
            <i class="bi" id="theme-icon"></i>
            <span id="theme-text">Modo Oscuro</span>
        </button>
    </div>
</div>

<!-- CONTENIDO PRINCIPAL -->
<main class="container my-4">