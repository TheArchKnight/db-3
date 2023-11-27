--Crear schema de base de datos y usarlo por defecto
CREATE SCHEMA exterminator;
USE exterminator;

CREATE TABLE cliente(
   correo VARCHAR(25) PRIMARY KEY,
   telefono NUMERIC(10) NOT NULL,
   direccion VARCHAR(40) NOT NULL,
   nombre VARCHAR(20) NOT NULL
);

CREATE TABLE departamento(
   codigo INT PRIMARY KEY,
   numero_empleados INT NOT NULL
);

CREATE TABLE grupo_fumigacion(
   codigo_departamento INT PRIMARY KEY REFERENCES departamento
);

CREATE TABLE oficina(
   codigo_departamento INT PRIMARY KEY REFERENCES departamento
);

CREATE TABLE empleado(
   cedula INT PRIMARY KEY,
   nombre_completo VARCHAR(50) NOT NULL,
   salario NUMERIC(15) NOT NULL,
   telefono NUMERIC(10) NOT NULL
);

CREATE TABLE oficinista(
   cedula_empleado INT PRIMARY KEY REFERENCES empleado,
   oficina INT REFERENCES oficina NOT NULL
);

CREATE table empleado_de_grupo(
   cedula_empleado INT PRIMARY KEY REFERENCES empleado
);

CREATE TABLE cotizacion(
   codigo INT PRIMARY KEY,
   monto VARCHAR(15) NOT NULL,
   detalle VARCHAR(255) NOT NULL
);

CREATE TABLE visita(
   codigo INT PRIMARY KEY,
   fecha DATE NOT NULL,
   hora VARCHAR(5) NOT NULL, -- es una clave primaria candidata
   costo VARCHAR(50) NOT NULL,
   tipo VARCHAR(20) NOT NULL,
   reporte VARCHAR(250) NOT NULL,
   observaciones VARCHAR(50) NOT NULL,
   codigo_departamento INT REFERENCES grupo_fumigacion NOT NULL,
   codigo_cotizacion INT REFERENCES cotizacion,
   CHECK(tipo = 'realizada' OR tipo = 'sin realizar')
);

ALTER TABLE cotizacion ADD codigo_proxima_visita INT UNIQUE REFERENCES cotizacion;

CREATE TABLE llamada (
   codigo INT PRIMARY KEY,
   fecha DATE NOT NULL,
   hora VARCHAR(5) NOT NULL,
   correo_cliente VARCHAR(25) REFERENCES cliente NOT NULL,
   cedula_empleado INT REFERENCES oficinista NOT NULL,
   codigo_cotizacion INT UNIQUE REFERENCES cotizacion,
   codigo_visita INT UNIQUE REFERENCES visita,
   CHECK (
      (codigo_cotizacion IS NULL AND codigo_visita IS NOT NULL)
      OR
      (codigo_cotizacion IS NOT NULL AND codigo_visita IS NULL)
   ) 
);

CREATE TABLE permiso(
   clave_acceso INT PRIMARY KEY,
   nivel INT NOT NULL,
   descripcion VARCHAR(225) NOT NULL
);

CREATE TABLE tarea (
   clave INT PRIMARY KEY,
   descripcion VARCHAR(220) NOT NULL,
   codigo_departamento INT REFERENCES grupo_fumigacion NOT NULL,
   clave_tarea INT UNIQUE REFERENCES tarea,
   clave_permiso INT UNIQUE REFERENCES permiso NOT NULL,
   CHECK(clave != clave_tarea)
);

CREATE TABLE producto(
   codigo INT PRIMARY KEY,
   tipo VARCHAR(25) NOT NULL,
   nombre VARCHAR(25) NOT NULL,
   descripcion VARCHAR(225) NOT NULL,
   especificaciones_uso VARCHAR(250) NOT NULL,
   fabricante VARCHAR(25) NOT NULL,
   nivel_acceso INT NOT NULL,
   clave_permiso INT REFERENCES permiso,
   codigo_visita INT REFERENCES visita,
   CHECK (tipo = 'herramienta' OR tipo = 'insumo')
);

CREATE TABLE empleado_en_grupo(
   cedula_empleado INT REFERENCES empleado_de_grupo(cedula_empleado), 
   codigo_departamento INT REFERENCES grupo_fumigacion(codigo_departamento),
   PRIMARY KEY (cedula_empleado, codigo_departamento)
);
