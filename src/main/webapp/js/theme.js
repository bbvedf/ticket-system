// public/js/theme.js
(function() {
  'use strict';

  // Obtener tema guardado o usar sistema del SO
  const getInitialTheme = () => {
    const saved = localStorage.getItem('ticket-theme');
    if (saved) return saved;

    // Detectar preferencia del sistema
    if (window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches) {
      return 'dark';
    }
    return 'light';
  };

  const theme = getInitialTheme();
  setTheme(theme);

  // Escuchar cambios de tema del sistema
  if (window.matchMedia) {
    window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', e => {
      setTheme(e.matches ? 'dark' : 'light');
    });
  }

  // Función para cambiar tema
  function setTheme(themeName) {
    // Actualizar body
    document.body.classList.remove('theme-light', 'theme-dark');
    document.body.classList.add(`theme-${themeName}`);
    document.documentElement.setAttribute('data-bs-theme', themeName);

    // Guardar preferencia
    localStorage.setItem('ticket-theme', themeName);

    // Actualizar favicon
    updateFavicon(themeName);

    // Disparar evento personalizado
    window.dispatchEvent(new CustomEvent('themechange', { detail: themeName }));
  }

  // Actualizar favicon dinámicamente
  function updateFavicon(theme) {
    // Buscar favicon existente o crear uno
    let favicon = document.querySelector('link[rel="icon"]');
    if (!favicon) {
      favicon = document.createElement('link');
      favicon.rel = 'icon';
      favicon.type = 'image/png';
      document.head.appendChild(favicon);
    }

    // Cambiar href según tema
    const faviconPath = theme === 'dark' ? '/logo_dark.png' : '/logo_light.png';
    favicon.href = faviconPath;
  }

  // Hacer setTheme disponible globalmente
  window.setTheme = setTheme;

  // Inicializar menú hamburguesa si existe
  const initMenu = () => {
    const hamburgerBtn = document.querySelector('.hamburger-button');
    const menuDropdown = document.querySelector('.menu-dropdown');

    if (hamburgerBtn && menuDropdown) {
      hamburgerBtn.addEventListener('click', () => {
        menuDropdown.style.display = 
          menuDropdown.style.display === 'none' ? 'block' : 'none';
      });

      // Cerrar menú al clickear fuera
      document.addEventListener('click', (e) => {
        if (!e.target.closest('.menu-container')) {
          menuDropdown.style.display = 'none';
        }
      });

      // Cerrar menú al clickear un item
      document.querySelectorAll('.menu-item').forEach(item => {
        item.addEventListener('click', () => {
          menuDropdown.style.display = 'none';
        });
      });
    }
  };

  // Esperar a que el DOM esté listo
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initMenu);
  } else {
    initMenu();
  }
})();