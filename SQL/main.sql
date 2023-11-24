CREATE TABLE cliente(
   correo VARCHAR(25) PRIMARY KEY,
   telefono NUMERIC(10),
   direccion VARCHAR(40),
   nombre VARCHAR(20)
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

CREATE TABLE llamada(
   codigo INT PRIMARY KEY,
   fecha DATE,
   hora VARCHAR(5),
   cliente VARCHAR(25),
   FOREIGN KEY (cliente) REFERENCES cliente(correo)
)


