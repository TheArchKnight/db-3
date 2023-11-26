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
   departamento INT PRIMARY KEY,
   FOREIGN KEY (departamento) REFERENCES departamento(codigo)
);
CREATE TABLE oficina(
   departamento INT PRIMARY KEY,
   FOREIGN KEY (departamento) REFERENCES departamento(codigo)
);

CREATE TABLE empleado(
   cedula INT PRIMARY KEY,
   nombre_completo VARCHAR(50),
   salario NUMERIC(15),
   telefono NUMERIC(10)
);

CREATE TABLE oficinista(
   empleado INT PRIMARY KEY,
   oficina INT,
   FOREIGN KEY (empleado) REFERENCES empleado(cedula),
   FOREIGN KEY (oficina) REFERENCES oficina(departamento)
);
CREATE table empleado_de_grupo(
   empleado INT PRIMARY KEY,
   FOREIGN KEY (empleado) REFERENCES empleado(cedula)
);

CREATE TABLE llamada(
   codigo INT PRIMARY KEY,
   fecha DATE,
   hora VARCHAR(5),
   cliente VARCHAR(25),
   empleado INT,
   FOREIGN KEY (empleado) REFERENCES oficinista(empleado),
   FOREIGN KEY (cliente) REFERENCES cliente(correo)
);
CREATE TABLE cotizacion(
   codigo INT PRIMARY KEY,
   monto VARCHAR(15),
   detalle VARCHAR(255),
   cliente_correo VARCHAR(25),
   llamada INT,
   FOREIGN KEY (cliente_correo) REFERENCES cliente(correo),
   FOREIGN KEY (llamada) REFERENCES llamada(codigo)
);

CREATE TABLE visita(
   codigo INT PRIMARY KEY,
   hora VARCHAR(5), -- es una clave primaria candidata
   tipo VARCHAR(20),
   reporte VARCHAR(250),
   observaciones VARCHAR(50),
   grupo_fumigacion INT,
   cotizacion INT,
   cotizacion_adicionada INT,
   FOREIGN KEY (cotizacion_adicionada) REFERENCES cotizacion(codigo),
   FOREIGN KEY (cotizacion) REFERENCES cotizacion(codigo),
   FOREIGN KEY (grupo_fumigacion) REFERENCES grupo_fumigacion(departamento)
);

CREATE TABLE permiso(
   clave_acceso INT PRIMARY KEY,
   nivel INT,
   descripcion VARCHAR(225)
);

CREATE TABLE tarea (
   clave INT PRIMARY KEY,
   descripcion VARCHAR(220),
   grupo_fumigacion INT,
   tarea_procedida INT,
   tarea_antecedida INT,
   permiso INT,
   FOREIGN KEY (permiso) REFERENCES permiso(clave_acceso),
   FOREIGN KEY (tarea_procedida) REFERENCES tarea(clave),
   FOREIGN KEY (tarea_antecedida) REFERENCES tarea(clave),
   FOREIGN KEY (grupo_fumigacion) REFERENCES grupo_fumigacion(departamento)
);

CREATE TABLE producto(
   codigo INT PRIMARY KEY,
   tipo VARCHAR(25),
   nombre VARCHAR(25),
   descripcion VARCHAR(225),
   especificaciones_uso VARCHAR(250),
   fabricante VARCHAR(25),
   nivel_acceso INT,
   permiso INT,
   visita INT,
   FOREIGN KEY (permiso) REFERENCES permiso(clave_acceso),
   FOREIGN KEY (visita) REFERENCES visita(codigo)
);

CREATE TABLE empleado_en_grupo(
   empleado_de_grupo INT, 
   grupo_fumigacion INT,
   FOREIGN KEY (empleado_de_grupo) REFERENCES empleado_de_grupo(empleado),
   FOREIGN KEY (grupo_fumigacion) REFERENCES grupo_fumigacion(departamento)
);