<?php
include "../includes/header.php";
?>

<!-- TÍTULO. Cambiarlo, pero dejar especificada la analogía -->
<h1 class="mt-3">Consulta 2</h1>

<p class="mt-3">
Mostar codigo, detalle y numero de visitas que ha sumado cada cotizacion
que cumple las siguientes 2 condiciones todas las visitas tienen el mismo tipo y
tener al menos 3 visitas
</p>

<?php
// Crear conexión con la BD
require('../config/conexion.php');

// Query SQL a la BD -> Crearla acá (No está completada, cambiarla a su contexto y a su analogía)
//Mirar lo del numero de visitas
$query = "SELECT c.codigo, c.detalle, COUNT(v.identificador) as numero_de_visitas
FROM cotizacion c
JOIN visita v ON c.codigo = v.cotizacion
WHERE 
    (SELECT COUNT(DISTINCT tipo) FROM visita WHERE cotizacion = c.codigo) = 1 AND 
    (SELECT COUNT(*) FROM visita WHERE cotizacion = c.codigo) >= 3
GROUP BY c.codigo, c.detalle;";

// Ejecutar la consulta
$resultadoC2 = mysqli_query($conn, $query) or die(mysqli_error($conn));

mysqli_close($conn);
?>

<?php
// Verificar si llegan datos
if($resultadoC2 and $resultadoC2->num_rows > 0):
?>

<!-- MOSTRAR LA TABLA. Cambiar las cabeceras -->
<div class="tabla mt-5 mx-3 rounded-3 overflow-hidden">

    <table class="table table-striped table-bordered">

        <!-- Títulos de la tabla, cambiarlos -->
        <thead class="table-dark">
            <tr>
                <th scope="col" class="text-center">Códgio</th>
                <th scope="col" class="text-center">Detalle</th>
                <th scope="col" class="text-center">Número de visitas</th>
            </tr>
        </thead>

        <tbody>

            <?php
            // Iterar sobre los registros que llegaron
            foreach ($resultadoC2 as $fila):
            ?>

            <!-- Fila que se generará -->
            <tr>
                <!-- Cada una de las columnas, con su valor correspondiente -->
                <td class="text-center"><?= $fila["codigo"]; ?></td>
                <td class="text-center"><?= $fila["detalle"]; ?></td>
                <td class="text-center"><?= $fila["numero_de_visitas"]; ?></td>
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

include "../includes/footer.php";
?>
