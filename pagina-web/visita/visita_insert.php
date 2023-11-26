<?php
 
// Crear conexión con la BD
require('../config/conexion.php');

// Sacar los datos del formulario. Cada input se identifica con su "name"
$identificador = $_POST["identificador"];
$fecha = $_POST["fecha"];
$hora = $_POST["hora"];
$costo = $_POST["costo"];
$tipo = $_POST["tipo"];
$reporte = $_POST["reporte"];
$observaciones = $_POST["observaciones"];
$cotizacion = $_POST["cotizacion"];

// Query SQL a la BD. Si tienen que hacer comprobaciones, hacerlas acá (Generar una query diferente para casos especiales)
$query = "INSERT INTO visita(identificador,fecha, hora, tipo, reporte, observaciones, cotizacion, costo) VALUES ('$identificador', '$fecha', '$hora', '$tipo', '$reporte', '$observaciones', '$cotizacion', '$costo')";

// Ejecutar consulta
$result = mysqli_query($conn, $query) or die(mysqli_error($conn));

// Redirigir al usuario a la misma pagina
if($result):
    // Si fue exitosa, redirigirse de nuevo a la página de la entidad
	header("Location: visita.php");
else:
	echo "Ha ocurrido un error al crear la visita";
endif;

mysqli_close($conn);
