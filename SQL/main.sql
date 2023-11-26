--Crear schema de base de datos y usarlo por defecto
CREATE SCHEMA exterminator;
USE exterminator;

CREATE TABLE cliente(
   correo VARCHAR(25) PRIMARY KEY,
   telefono NUMERIC(10),
   direccion VARCHAR(40),
   nombre VARCHAR(20)
);

CREATE TABLE departamento(
   codigo INT PRIMARY KEY,
   numero_empleados INT
);

CREATE TABLE grupo_fumigacion(
   codigo_departamento INT PRIMARY KEY REFERENCES departamento
);

CREATE TABLE oficina(
   codigo_departamento INT PRIMARY KEY REFERENCES departamento
);

CREATE TABLE empleado(
   cedula INT PRIMARY KEY,
   nombre_completo VARCHAR(50),
   salario NUMERIC(15),
   telefono NUMERIC(10)
);

CREATE TABLE oficinista(
   cedula_empleado INT PRIMARY KEY REFERENCES empleado,
   oficina INT REFERENCES oficina
);

CREATE table empleado_de_grupo(
   cedula_empleado INT PRIMARY KEY REFERENCES empleado
);

CREATE TABLE cotizacion(
   codigo INT PRIMARY KEY,
   monto VARCHAR(15),
   detalle VARCHAR(255)
);

CREATE TABLE visita(
   codigo INT PRIMARY KEY,
   fecha DATE,
   hora VARCHAR(5), -- es una clave primaria candidata
   costo VARCHAR(50),
   tipo VARCHAR(20),
   reporte VARCHAR(250),
   observaciones VARCHAR(50),
   codigo_departamento INT REFERENCES grupo_fumigacion,
   codigo_cotizacion INT REFERENCES cotizacion,
);

ALTER TABLE cotizacion ADD codigo_proxima_visita INT REFERENCES cotizacion;

CREATE TABLE llamada(
   codigo INT PRIMARY KEY,
   fecha DATE,
   hora VARCHAR(5),
   correo_cliente VARCHAR(25) REFERENCES cliente,
   cedula_empleado INT REFERENCES oficinista,
   codigo_cotizacion INT REFERENCES cotizacion,
   codigo_visita INT REFERENCES visita,
   CHECK (
      (codigo_cotizacion IS NULL AND codigo_visita IS NOT NULL)
      OR
      (codigo_cotizacion IS NOT NULL AND codigo_visita IS NULL)
   ) 
);

CREATE TABLE permiso(
   clave_acceso INT PRIMARY KEY,
   nivel INT,
   descripcion VARCHAR(225)
);

CREATE TABLE tarea (
   clave INT PRIMARY KEY,
   descripcion VARCHAR(220),
   codigo_departamento INT REFERENCES grupo_fumigacion,
   codigo_tarea INT UNIQUE REFERENCES tarea,
   clave_permiso INT UNIQUE REFERENCES permiso,
);

CREATE TABLE producto(
   codigo INT PRIMARY KEY,
   tipo VARCHAR(25),
   nombre VARCHAR(25),
   descripcion VARCHAR(225),
   especificaciones_uso VARCHAR(250),
   fabricante VARCHAR(25),
   nivel_acceso INT,
   clave_permiso INT REFERENCES permiso,
   codigo_visita INT REFERENCES visita,
);

CREATE TABLE empleado_en_grupo(
   cedula_empleado INT REFERENCES empleado_de_grupo, 
   codigo_departamento INT REFERENCES grupo_fumigacion,
   PRIMARY KEY clave_permiso, codigo-visita
);
