<?php
include "../includes/header.php";
?>

   <!-- TÍTULO. Cambiarlo, pero dejar especificada la analogía -->
   <h1 class="mt-3">Búsqueda 2</h1>

   <p class="mt-3">
   Dos números enteros n1 y n2, n1 ≥ 0, n2 > n1. Se debe mostrar el codigo y detalles
   de las cotizaciones que tienen entre n1 y n2 visitas.
   (intervalo cerrado [n1, n2]).
   </p>

   <!-- FORMULARIO. Cambiar los campos de acuerdo a su trabajo -->
   <div class="formulario p-4 m-3 border rounded-3">

   <!-- En esta caso, el Action va a esta mismo archivo -->
   <form action="busqueda2.php" method="post" class="form-group">

   <div class="mb-3">
   <label for="numero1" class="form-label">Numero 1</label>
   <input type="number" class="form-control" id="numero1" name="numero1" required>
   </div>

   <div class="mb-3">
   <label for="numero2" class="form-label">Numero 2</label>
   <input type="number" class="form-control" id="numero2" name="numero2" required>
   </div>

   <button type="submit" class="btn btn-primary">Buscar</button>

   </form>

   </div>

<?php
// Dado que el action apunta a este mismo archivo, hay que hacer eata verificación antes
if ($_SERVER['REQUEST_METHOD'] === 'POST'):

   // Crear conexión con la BD
   require('../config/conexion.php');

$numero1 = $_POST["numero1"];
$numero2 = $_POST["numero2"];

// Query SQL a la BD -> Crearla acá (No está completada, cambiarla a su contexto y a su analogía)
$query = "SELECT c.codigo, c.detalle, COUNT(v.identificador) AS total_visitas
   FROM cotizacion c
   LEFT JOIN visita v ON c.codigo = v.cotizacion
   GROUP BY c.codigo, c.detalle
   HAVING COUNT(v.identificador) BETWEEN '$numero1' AND '$numero2';
";

// Ejecutar la consulta
$resultadoB2 = mysqli_query($conn, $query) or die(mysqli_error($conn));

mysqli_close($conn);

// Verificar si llegan datos
if($resultadoB2 and $resultadoB2->num_rows > 0):
?>

<!-- MOSTRAR LA TABLA. Cambiar las cabeceras -->
<div class="tabla mt-5 mx-3 rounded-3 overflow-hidden">

<table class="table table-striped table-bordered">

<!-- Títulos de la tabla, cambiarlos -->
<thead class="table-dark">
<tr>
<th scope="col" class="text-center">Codigo</th>
<th scope="col" class="text-center">Detalle</th>
</tr>
</thead>

<tbody>

<?php
   // Iterar sobre los registros que llegaron
   foreach ($resultadoB2 as $fila):
?>

<!-- Fila que se generará -->
<tr>
<!-- Cada una de las columnas, con su valor correspondiente -->
<td class="text-center"><?= $fila["codigo"]; ?></td>
<td class="text-center"><?= $fila["detalle"]; ?></td>
</tr>

<?php
      // Cerrar los estructuras de control
      endforeach;
?>

   </tbody>

   </table>
   </div>

   <!-- Mensaje de error si no hay resultados -->
<?php
else:
?>

   <div class="alert alert-danger text-center mt-5">
   No se encontraron resultados para esta consulta
   </div>

<?php
endif;
endif;

include "../includes/footer.php";
?>
