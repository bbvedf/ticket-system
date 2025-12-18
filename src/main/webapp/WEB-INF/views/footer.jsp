<%-- src/main/webapp/WEB-INF/views/footer.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
</main>

<!-- FOOTER -->
<footer class="mt-5 py-4 border-top">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-8 mb-3 mb-md-0">
                <h5 class="h6 fw-bold">Ticket System</h5>
                <p class="text-muted mb-0 small">
                    Sistema de gestión de tickets y soporte técnico<br>
                    Backend: Spring Boot 3.1.5 + PostgreSQL
                </p>
            </div>
            <div class="col-md-4 text-md-end">
                <small class="text-muted">&copy; 2025 Ticket System</small>
            </div>
        </div>
    </div>
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- Theme JS -->
<script src="/js/theme.js"></script>

<!-- Script para actualizar icono del menú -->
<script>
    function updateThemeIcon() {
        const isDark = document.body.classList.contains('theme-dark');
        const themeIcon = document.getElementById('theme-icon');
        const themeText = document.getElementById('theme-text');
        const headerLogo = document.getElementById('header-logo');
        
        if (isDark) {
            themeIcon.className = 'bi bi-sun-fill';
            themeText.textContent = 'Modo Claro';
            headerLogo.src = '/logo_dark.png';
        } else {
            themeIcon.className = 'bi bi-moon-fill';
            themeText.textContent = 'Modo Oscuro';
            headerLogo.src = '/logo_light.png';
        }
    }
    
    updateThemeIcon();
    window.addEventListener('themechange', updateThemeIcon);
</script>

<!-- Auto-cerrar alerts -->
<script>
    document.addEventListener('DOMContentLoaded', () => {
        document.querySelectorAll('.alert').forEach(alert => {
            setTimeout(() => {
                const bsAlert = new bootstrap.Alert(alert);
                bsAlert.close();
            }, 5000);
        });
    });
</script>

</body>
</html>