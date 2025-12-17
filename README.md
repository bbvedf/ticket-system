# Ticket System

Sistema de gestión de tickets desarrollado en Java + Spring Boot + JSP + PostgreSQL.

## 🚀 Requisitos

- Docker
- Docker Compose
- Java 17 (solo para desarrollo)

## ⚙️ Configuración

1. **Clonar el repositorio:**
   ```bash
   git clone <repo-url>
   cd ticket-system

2. **Configurar variables de entorno:**

   ```bash
cp .env.example .env
nano .env  # Editar con tus credenciales


3. **Construir y ejecutar:**

   ```bash
docker-compose up --build -d


4. **Acceder a la aplicación:**

Aplicación: http://localhost:8080

Base de datos: localhost:5432

Usuario DB: (definido en .env)


📁 Estructura del Proyecto
ticket-system/
├── src/                    # Código fuente Java
├── sql/                   # Scripts de base de datos
├── uploads/               # Archivos adjuntos (no en git)
├── logs/                  # Logs de aplicación (no en git)
├── .env                   # Variables de entorno (NO SUBIR)
├── .env.example          # Template de variables
├── docker-compose.yml    # Orquestación
└── README.md            # Este archivo

🔒 Seguridad
Nunca subir .env al repositorio

Cambiar credenciales por defecto

Usar HTTPS en producción

Revisar permisos de archivos


🐛 Desarrollo
bash
# Logs en tiempo real
docker-compose logs -f ticket-app

# Detener servicios
docker-compose down

# Reconstruir
docker-compose up --build -d

# Acceder a PostgreSQL
docker-compose exec postgres psql -U ticket_admin tickets


📄 Licencia
MIT