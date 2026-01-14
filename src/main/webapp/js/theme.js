// public/js/theme.js
(function () {
  'use strict';

  // Obtener tema guardado o usar sistema del SO
  const getInitialTheme = () => {
    const saved = localStorage.getItem('theme');
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

  // Escuchar cambios desde otras pestañas
  window.addEventListener('storage', (e) => {
    if (e.key === 'theme' && e.newValue) {
      setTheme(e.newValue);
    }
  });

  // Función para cambiar tema
  function setTheme(themeName) {
    // Actualizar body
    document.body.classList.remove('theme-light', 'theme-dark');
    document.body.classList.add(`theme-${themeName}`);
    document.documentElement.setAttribute('data-bs-theme', themeName);

    // Guardar preferencia
    localStorage.setItem('theme', themeName);

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
    const faviconPath = theme === 'dark' ? '/tickets/logo_dark.png' : '/tickets/logo_light.png';
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


// tickets.js - Funcionalidad específica para tickets

class TicketsViewManager {
  constructor() {
    this.gridViewBtn = document.getElementById('gridViewBtn');
    this.tableViewBtn = document.getElementById('tableViewBtn');
    this.gridView = document.getElementById('gridView');
    this.tableView = document.getElementById('tableView');

    this.init();
  }

  init() {
    // Recuperar preferencia guardada
    this.savedView = localStorage.getItem('ticketViewPreference') || 'grid';

    // Aplicar vista guardada
    this.setActiveView(this.savedView);

    // Event listeners
    this.gridViewBtn?.addEventListener('click', () => this.setActiveView('grid'));
    this.tableViewBtn?.addEventListener('click', () => this.setActiveView('table'));

    // Verificar parámetro de vista en URL
    this.checkUrlViewParam();
  }

  setActiveView(view) {
    if (view === 'grid') {
      this.activateGridView();
    } else {
      this.activateTableView();
    }

    // Guardar preferencia
    localStorage.setItem('ticketViewPreference', view);

    // Actualizar URL sin recargar
    this.updateUrlViewParam(view);
  }

  activateGridView() {
    this.gridViewBtn?.classList.add('active');
    this.tableViewBtn?.classList.remove('active');
    this.gridView?.classList.remove('d-none');
    this.tableView?.classList.add('d-none');
  }

  activateTableView() {
    this.tableViewBtn?.classList.add('active');
    this.gridViewBtn?.classList.remove('active');
    this.tableView?.classList.remove('d-none');
    this.gridView?.classList.add('d-none');
  }

  updateUrlViewParam(view) {
    const url = new URL(window.location);
    url.searchParams.set('view', view);
    window.history.replaceState({}, '', url);
  }

  checkUrlViewParam() {
    const urlParams = new URLSearchParams(window.location.search);
    const urlView = urlParams.get('view');

    if (urlView && (urlView === 'grid' || urlView === 'table')) {
      this.setActiveView(urlView);
    }
  }

  // Método para ordenar tabla (extensible)
  sortTable(column, order) {
    // Implementar lógica de ordenamiento si es necesario
    console.log(`Ordenar por ${column} en orden ${order}`);
  }
}

// Inicializar cuando el DOM esté listo
document.addEventListener('DOMContentLoaded', () => {
  // Inicializar manager de vistas
  if (document.getElementById('gridViewBtn')) {
    window.ticketsViewManager = new TicketsViewManager();
  }

  // Limpiar filtros
  const clearSearchBtn = document.getElementById('clearSearch');
  if (clearSearchBtn) {
    clearSearchBtn.addEventListener('click', () => {
      const searchInput = document.querySelector('input[name="search"]');
      if (searchInput) {
        searchInput.value = '';
        searchInput.closest('form').submit();
      }
    });
  }
});

document.addEventListener('DOMContentLoaded', function () {
  const deleteButtonTrigger = document.getElementById('deleteButtonTrigger');
  const deleteModal = document.getElementById('deleteModal');
  const confirmDeleteBtn = document.getElementById('confirmDeleteBtn');

  if (deleteButtonTrigger && deleteModal) {
    const modalInstance = new bootstrap.Modal(deleteModal);
    deleteButtonTrigger.addEventListener('click', function () {
      modalInstance.show();
    });
  }

  if (confirmDeleteBtn) {
    confirmDeleteBtn.addEventListener('click', function () {
      if (this.disabled) return;
      const ticketId = this.getAttribute('data-ticket-id');
      this.disabled = true;
      this.innerHTML = '<i class="bi bi-hourglass-split me-1"></i> Eliminando...';

      setTimeout(() => {
        window.location.href = '/tickets/' + ticketId + '/delete';
      }, 100);
    });
  }
});
