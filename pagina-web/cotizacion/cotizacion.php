<?php
include "../includes/header.php";
?>

<!-- TÍTULO. Cambiarlo, pero dejar especificada la analogía -->
<!-- TÍTULO. Mirar si tambien cambiarlo en el index -->
<h1 class="mt-3">COTIZACIÓN 12</h1>

<!-- FORMULARIO. Cambiar los campos de acuerdo a su trabajo -->
<div class="formulario p-4 m-3 border rounded-3">

    <form action="cotizacion_insert.php" method="post" class="form-group">

        <!-- CP -->
        <div class="mb-3">
            <label for="codigo" class="form-label">Código</label>
            <input type="number" class="form-control" id="codigo" name="codigo" required>
        </div>

        <div class="mb-3">
            <label for="monto" class="form-label">Monto</label>
            <input type="number" class="form-control" id="monto" name="monto"  required>
        </div>

        <div class="mb-3">
            <label for="detalle" class="form-label">Detalle</label>
            <input type="text" class="form-control" id="detalle" name="detalle" required>
        </div>
        </div>

        <button type="submit" class="btn btn-primary">Agregar</button>
    </form>

</div>


    
</div>

<?php
// Importar el código del otro archivo
require("cotizacion_select.php");

// Verificar si llegan datos
if($resultadoCotizacion and $resultadoCotizacion->num_rows > 0):
?>

<!-- MOSTRAR LA TABLA. Cambiar las cabeceras -->
<div class="tabla mt-5 mx-3 rounded-3 overflow-hidden">

    <table class="table table-striped table-bordered">

        <!-- Títulos de la tabla, cambiarlos -->
        <thead class="table-dark">
            <tr>
                <th scope="col" class="text-center">Código</th>
                <th scope="col" class="text-center">Monto</th>
                <th scope="col" class="text-center">Detalle</th>
            </tr>
        </thead>

        <tbody>

            <?php
            // Iterar sobre los registros que llegaron
            foreach ($resultadoCotizacion as $fila):
            ?>

            <!-- Fila que se generará -->
            <tr>
                <!-- Cada una de las columnas, con su valor correspondiente -->
                <td class="text-center"><?= $fila["codigo"]; ?></td>
                <td class="text-center"><?= $fila["monto"]; ?></td>
                <td class="text-center"><?= $fila["detalle"]; ?></td>
                
                <!-- Botón de eliminar. Debe de incluir la CP de la entidad para identificarla -->
                <td class="text-center">
                    <form action="cotizacion_delete.php" method="post">
                        <input hidden type="text" name="codigoEliminar" value="<?= $fila["codigo"]; ?>">
                        <button type="submit" class="btn btn-danger">Eliminar</button>
                    </form>
                </td>

            </tr>

            <?php
            // Cerrar los estructuras de control
            endforeach;
            ?>

        </tbody>

    </table>
</div>

<?php
endif;

include "../includes/footer.php";
?>
