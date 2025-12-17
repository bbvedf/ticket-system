-- sql/init.sql
CREATE TABLE IF NOT EXISTS tickets (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    description TEXT NOT NULL,
    status VARCHAR(20) DEFAULT 'OPEN' 
        CHECK (status IN ('OPEN', 'IN_PROGRESS', 'RESOLVED', 'CLOSED')),
    priority VARCHAR(20) DEFAULT 'MEDIUM' 
        CHECK (priority IN ('LOW', 'MEDIUM', 'HIGH', 'CRITICAL')),
    category VARCHAR(50),
    client_name VARCHAR(100),
    client_email VARCHAR(100),
    assigned_to VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    resolved_at TIMESTAMP
);

CREATE TABLE IF NOT EXISTS ticket_comments (
    id SERIAL PRIMARY KEY,
    ticket_id INTEGER NOT NULL REFERENCES tickets(id) ON DELETE CASCADE,
    author_name VARCHAR(100),
    comment_text TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Datos de prueba
INSERT INTO tickets (title, description, status, priority, category, client_name, client_email) 
VALUES 
    ('Error al iniciar sesión', 'No puedo acceder con mis credenciales', 'OPEN', 'HIGH', 'Autenticación', 'Juan Pérez', 'juan@example.com'),
    ('Consulta sobre factura', 'No entiendo el cargo de este mes', 'IN_PROGRESS', 'MEDIUM', 'Facturación', 'María López', 'maria@example.com'),
    ('Solicitud de nueva característica', 'Me gustaría poder exportar reportes', 'OPEN', 'LOW', 'Mejora', 'Carlos Ruiz', 'carlos@example.com');