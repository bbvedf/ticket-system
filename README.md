# Ticket System

[![Java](https://img.shields.io/badge/Java-17-orange?logo=java)](https://www.java.com/)
[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.1.5-green?logo=springboot)](https://spring.io/projects/spring-boot)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16-blue?logo=postgresql)](https://www.postgresql.org/)
[![Docker](https://img.shields.io/badge/Docker-Compose-blue?logo=docker)](https://www.docker.com/)
[![License](https://img.shields.io/badge/License-MIT-green)](LICENSE)

Sistema de gestión de tickets desarrollado en **Java + Spring Boot + JSP + PostgreSQL**, con soporte completo para Docker.

## ✨ Características

- ✅ CRUD completo de tickets
- ✅ Sistema de comentarios
- ✅ Filtrado por estado, prioridad y búsqueda
- ✅ Asignación de tickets
- ✅ Interfaz responsive con Bootstrap 5
- ✅ Base de datos PostgreSQL
- ✅ Deployable con Docker Compose

## 🚀 Quick Start

### Prerequisitos

- Docker & Docker Compose
- Git

### Instalación

1. **Clonar repositorio:**
   ```bash
   git clone <repo-url>
   cd ticket-system
   ```

2. **Crear archivo de configuración:**
   ```bash
   cp .env.example .env
   # Editar .env si es necesario
   ```

3. **Iniciar la aplicación:**
   ```bash
   docker-compose up --build -d
   ```

4. **Acceder:**
   - 🌐 Aplicación: http://localhost:8080
   - 🗄️ Base de datos: localhost:5432

## 📁 Estructura del Proyecto

```
ticket-system/
├── src/
│   └── main/
│       ├── java/com/tickets/
│       │   ├── controller/          # Controladores Spring
│       │   ├── model/               # Entidades JPA
│       │   ├── repository/          # Interfaces Repository
│       │   ├── service/             # Lógica de negocio
│       │   └── TicketSystemApplication.java
│       ├── resources/
│       │   └── application.properties
│       └── webapp/WEB-INF/views/    # Templates JSP
├── sql/
│   └── init.sql                     # Script inicial BD
├── .env.example                     # Template variables
├── docker-compose.yml               # Orquestación
├── Dockerfile                       # Build image
├── pom.xml                          # Maven config
└── README.md
```

## ⚙️ Configuración

### Variables de entorno (.env)

```properties
# Base de datos
DB_URL=jdbc:postgresql://postgres:5432/tickets
DB_USER=admin
DB_PASSWORD=tu_contraseña_segura

# App
APP_PORT=8080
APP_UPLOAD_DIR=/app/uploads
APP_MAX_UPLOAD_SIZE=5MB

# PostgreSQL
DB_EXTERNAL_PORT=5432
```

## 🛠️ Desarrollo

### Ver logs en tiempo real:
```bash
docker-compose logs -f ticket-app
```

### Acceder a la BD:
```bash
docker-compose exec postgres psql -U admin -d tickets
```

### Detener servicios:
```bash
docker-compose down
```

### Reconstruir después de cambios:
```bash
docker-compose up --build -d
```

### Limpiar volúmenes (⚠️ elimina datos):
```bash
docker-compose down -v
```

## 🏗️ Arquitectura

### Stack Tecnológico

| Capa | Tecnología |
|------|-----------|
| **Frontend** | JSP + Bootstrap 5 + JavaScript |
| **Backend** | Spring Boot 3.1.5 + Spring MVC |
| **BD** | PostgreSQL 16 |
| **ORM** | Hibernate/JPA |
| **Contenedor** | Docker + Docker Compose |

### Endpoints principales

```
GET    /                     # Dashboard
GET    /tickets              # Lista de tickets
GET    /tickets/new          # Formulario nuevo
POST   /tickets              # Crear ticket
GET    /tickets/{id}         # Detalle ticket
GET    /tickets/{id}/edit    # Editar formulario
POST   /tickets/{id}         # Actualizar ticket
GET    /tickets/{id}/delete  # Eliminar ticket
POST   /tickets/{id}/comments # Añadir comentario
```

## 🔒 Seguridad

> ⚠️ **Importante para Producción:**

- [ ] Nunca subir `.env` a Git (ya está en `.gitignore`)
- [ ] Cambiar credenciales por defecto
- [ ] Usar HTTPS/TLS
- [ ] Implementar autenticación
- [ ] Configurar CORS adecuadamente
- [ ] Usar variables secretas en producción

## 📝 API Endpoints Detallados

### Tickets

```bash
# Listar con filtros
GET /tickets?status=OPEN&priority=HIGH&search=error

# Crear
POST /tickets
Content-Type: application/x-www-form-urlencoded
title=Bug crítico&description=El sistema falla...

# Actualizar estado
GET /tickets/1/status?status=IN_PROGRESS

# Cambiar de página
GET /tickets/1/edit
```

### Comentarios

```bash
# Añadir comentario a ticket
POST /tickets/1/comments
author_name=Juan&comment_text=He visto el problema...
```

## 🐛 Troubleshooting

### Error "database admin does not exist"
Normal en el primer arranque. PostgreSQL reintenta la conexión automáticamente.

### Puerto 8080 en uso
```bash
# Cambiar en docker-compose.yml o .env
APP_PORT=8081
```

### Permisos de volúmenes
```bash
docker-compose down -v
docker-compose up --build -d
```

## 📚 Recursos

- [Spring Boot Documentation](https://spring.io/projects/spring-boot)
- [PostgreSQL Docs](https://www.postgresql.org/docs/)
- [Docker Compose](https://docs.docker.com/compose/)
- [Bootstrap 5](https://getbootstrap.com/docs/5.0/)

## 📄 Licencia

MIT License - Ver archivo [LICENSE](LICENSE)

## 👤 Contribuciones

Las contribuciones son bienvenidas. Para cambios mayores, abre un issue primero.

---

**Última actualización:** Diciembre 2025