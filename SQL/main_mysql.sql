-- Crear base de datos y utilizarla por defecto
CREATE DATABASE IF NOT EXISTS exterminator_1;
USE exterminator_1;

CREATE TABLE cliente(
   correo VARCHAR(25) PRIMARY KEY,
   telefono DECIMAL(10,0) NOT NULL,
   direccion VARCHAR(40) NOT NULL,
   nombre VARCHAR(20) NOT NULL
);

CREATE TABLE departamento(
   codigo INT PRIMARY KEY,
   numero_empleados INT NOT NULL
);

CREATE TABLE grupo_fumigacion(
   codigo_departamento INT PRIMARY KEY,
   FOREIGN KEY (codigo_departamento) REFERENCES departamento(codigo)
);

CREATE TABLE oficina(
   codigo_departamento INT PRIMARY KEY,
   FOREIGN KEY (codigo_departamento) REFERENCES departamento(codigo)
);

CREATE TABLE empleado(
   cedula INT PRIMARY KEY,
   nombre_completo VARCHAR(50) NOT NULL,
   salario DECIMAL(15,0) NOT NULL,
   telefono DECIMAL(10,0) NOT NULL
);

CREATE TABLE oficinista(
   cedula_empleado INT PRIMARY KEY,
   oficina INT NOT NULL,
   FOREIGN KEY (cedula_empleado) REFERENCES empleado(cedula),
   FOREIGN KEY (oficina) REFERENCES oficina(codigo_departamento)
);

CREATE TABLE empleado_de_grupo(
   cedula_empleado INT PRIMARY KEY,
   FOREIGN KEY (cedula_empleado) REFERENCES empleado(cedula)
);

CREATE TABLE cotizacion(
   codigo INT PRIMARY KEY,
   monto VARCHAR(15) NOT NULL,
   detalle VARCHAR(255) NOT NULL
);

CREATE TABLE visita(
   codigo INT PRIMARY KEY,
   fecha DATE NOT NULL,
   hora VARCHAR(5) NOT NULL, 
   costo VARCHAR(50) NOT NULL,
   tipo VARCHAR(20) NOT NULL,
   reporte VARCHAR(250) NOT NULL,
   observaciones VARCHAR(50) NOT NULL,
   codigo_departamento INT NOT NULL,
   codigo_cotizacion INT,
   FOREIGN KEY (codigo_departamento) REFERENCES grupo_fumigacion(codigo_departamento),
   FOREIGN KEY (codigo_cotizacion) REFERENCES cotizacion(codigo),
   CHECK(tipo = 'realizada' OR tipo = 'sin realizar')
);

ALTER TABLE cotizacion ADD codigo_proxima_visita INT,
ADD CONSTRAINT fk_proxima_visita FOREIGN KEY (codigo_proxima_visita) REFERENCES cotizacion(codigo);

CREATE TABLE llamada (
   codigo INT PRIMARY KEY,
   fecha DATE NOT NULL,
   hora VARCHAR(5) NOT NULL,
   correo_cliente VARCHAR(25) NOT NULL,
   cedula_empleado INT NOT NULL,
   codigo_cotizacion INT,
   codigo_visita INT,
   FOREIGN KEY (correo_cliente) REFERENCES cliente(correo),
   FOREIGN KEY (cedula_empleado) REFERENCES oficinista(cedula_empleado),
   FOREIGN KEY (codigo_cotizacion) REFERENCES cotizacion(codigo),
   FOREIGN KEY (codigo_visita) REFERENCES visita(codigo),
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
   codigo_departamento INT NOT NULL,
   clave_tarea INT,
   clave_permiso INT NOT NULL,
   FOREIGN KEY (codigo_departamento) REFERENCES grupo_fumigacion(codigo_departamento),
   FOREIGN KEY (clave_tarea) REFERENCES tarea(clave),
   FOREIGN KEY (clave_permiso) REFERENCES permiso(clave_acceso),
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
   clave_permiso INT,
   codigo_visita INT,
   FOREIGN KEY (clave_permiso) REFERENCES permiso(clave_acceso),
   FOREIGN KEY (codigo_visita) REFERENCES visita(codigo),
   CHECK (tipo = 'herramienta' OR tipo = 'insumo')
);

CREATE TABLE empleado_en_grupo(
   cedula_empleado INT,
   codigo_departamento INT,
   PRIMARY KEY (cedula_empleado, codigo_departamento),
   FOREIGN KEY (cedula_empleado) REFERENCES empleado_de_grupo(cedula_empleado), 
   FOREIGN KEY (codigo_departamento) REFERENCES grupo_fumigacion(codigo_departamento)
);
