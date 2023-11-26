CREATE SCHEMA exterminator;
USE exterminator;

-- Crear la tabla "visita" sin la restricción de clave foránea inicialmente
CREATE TABLE visita (
    identificador INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    costo NUMERIC(20, 2) NOT NULL CHECK (costo >= 0),
    tipo VARCHAR(20) NOT NULL CHECK (tipo IN ('realizada', 'sin realizar')),
    reporte TEXT NOT NULL,
    observaciones TEXT NOT NULL,
    cotizacion INT
);

-- Crear la tabla "cotizacion" sin la restricción de clave foránea inicialmente
CREATE TABLE cotizacion (
   codigo INT PRIMARY KEY,
   monto INT NOT NULL,
   detalle TEXT NOT NULL,
   visita_proxima INT
);

-- Agregar restricciones de clave foránea después de la creación de ambas tablas
ALTER TABLE visita ADD FOREIGN KEY (cotizacion) REFERENCES cotizacion(codigo);
ALTER TABLE cotizacion ADD FOREIGN KEY (visita_proxima) REFERENCES visita(identificador);

