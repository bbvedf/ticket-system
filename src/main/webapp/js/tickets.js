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
        this.gridViewBtn.classList.add('active');
        this.tableViewBtn.classList.remove('active');
        this.gridView.classList.remove('d-none');
        this.tableView.classList.add('d-none');
    }
    
    activateTableView() {
        this.tableViewBtn.classList.add('active');
        this.gridViewBtn.classList.remove('active');
        this.tableView.classList.remove('d-none');
        this.gridView.classList.add('d-none');
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

document.addEventListener('DOMContentLoaded', function() {
    const deleteButtonTrigger = document.getElementById('deleteButtonTrigger');
    const deleteModal = document.getElementById('deleteModal');
    const confirmDeleteBtn = document.getElementById('confirmDeleteBtn');
    
    if (deleteButtonTrigger && deleteModal) {
        const modalInstance = new bootstrap.Modal(deleteModal);
        deleteButtonTrigger.addEventListener('click', function() {
            modalInstance.show();
        });
    }
    
    if (confirmDeleteBtn) {
        confirmDeleteBtn.addEventListener('click', function() {
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