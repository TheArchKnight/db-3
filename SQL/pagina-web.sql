DROP SCHEMA exterminator;

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

-- consulta 1
SELECT c.codigo, c.detalle
FROM cotizacion c
LEFT JOIN (
   SELECT cotizacion, SUM(costo) AS total_costo
   FROM visita
   GROUP BY cotizacion
) v ON c.codigo = v.cotizacion
WHERE c.monto >= IFNULL(v.total_costo, 0);

-- Consulta 2
SELECT c.codigo, c.detalle, COUNT(v.identificador) as numero_de_visitas
FROM COTIZACIÓN c
JOIN VISITA v ON c.codigo = v.sumada_a 
WHERE 
(SELECT COUNT(DISTINCT tipo) FROM VISITA WHERE sumada_a = c.codigo) = 1 AND 
(SELECT COUNT(*) FROM VISITA WHERE sumada_a = c.codigo) >= 3
GROUP BY c.codigo, c.detalle;

-- Busqueda 1

SELECT c.codigo, c.detalle
FROM cotizacion c
JOIN (
   SELECT cotizacion, COUNT(*) as num_visitas
   FROM visita
   WHERE fecha BETWEEN '$fecha1' AND '$fecha2'  -- Reemplaza 'f1' y 'f2' con las fechas específicas
   GROUP BY cotizacion
   HAVING COUNT(*) = '$numero'  -- Reemplaza 'n' con el número de visitas exacto
) v ON c.codigo = v.cotizacion;

-- Busqueda 2

SELECT c.codigo, c.detalle, COUNT(v.identificador) AS total_visitas
FROM cotizacion c
LEFT JOIN visita v ON c.codigo = v.cotizacion
GROUP BY c.codigo, c.detalle
HAVING COUNT(v.identificador) BETWEEN '$numero1' AND '$numero2';



-- Insertar datos en la tabla cotizacion
INSERT INTO cotizacion (codigo, monto, detalle, visita_proxima)
VALUES
(1, 500, 'Detalle cotización 1', NULL),
(2, 700, 'Detalle cotización 2', NULL),
(3, 1000, 'Detalle cotización 3', NULL),
(4, 300, 'Detalle cotización 4', NULL),
(5, 1200, 'Detalle cotización 5', NULL);

-- Insertar datos en la tabla visita
INSERT INTO visita (fecha, hora, costo, tipo, reporte, observaciones, cotizacion)
VALUES
('2023-01-10', '08:30:00', 200.00, 'realizada', 'Reporte visita 1', 'Observaciones visita 1', 1),
('2023-02-15', '09:45:00', 300.00, 'realizada', 'Reporte visita 2', 'Observaciones visita 2', 1),
('2023-03-20', '11:00:00', 400.00, 'realizada', 'Reporte visita 3', 'Observaciones visita 3', 1),
('2023-04-25', '10:00:00', 700.00, 'realizada', 'Reporte visita 4', 'Observaciones visita 4', 2),
('2023-05-30', '13:30:00', 200.00, 'sin realizar', 'Reporte visita 5', 'Observaciones visita 5', 2),
('2023-06-05', '14:45:00', 1000.00, 'realizada', 'Reporte visita 6', 'Observaciones visita 6', 2),
('2023-07-12', '16:00:00', 500.00, 'realizada', 'Reporte visita 7', 'Observaciones visita 7', 2),
('2023-08-18', '09:00:00', 600.00, 'realizada', 'Reporte visita 8', 'Observaciones visita 8', 2),
('2023-09-22', '12:30:00', 800.00, 'realizada', 'Reporte visita 9', 'Observaciones visita 9', 3),
('2023-10-28', '15:15:00', 200.00, 'sin realizar', 'Reporte visita 10', 'Observaciones visita 10', 3),
('2023-11-05', '17:30:00', 600.00, 'realizada', 'Reporte visita 11', 'Observaciones visita 11', 3),
('2023-12-10', '10:45:00', 1200.00, 'realizada', 'Reporte visita 12', 'Observaciones visita 12', 5),
('2023-12-15', '11:30:00', 800.00, 'realizada', 'Reporte visita 13', 'Observaciones visita 13', 5),
('2023-12-20', '13:00:00', 500.00, 'realizada', 'Reporte visita 14', 'Observaciones visita 14', 5);

-- Actualizar el campo visita_proxima en la tabla cotizacion
UPDATE cotizacion
SET visita_proxima =
CASE 
      WHEN codigo = 1 THEN 2
      WHEN codigo = 2 THEN 3
      WHEN codigo = 3 THEN 1
      WHEN codigo = 4 THEN 5
      WHEN codigo = 5 THEN 4
      ELSE NULL -- Si hay otros códigos, puedes definir su visita próxima aquí
END;


