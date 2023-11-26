<?php
include "../includes/header.php";
?>

<!-- TÍTULO. Cambiarlo, pero dejar especificada la analogía -->
<h1 class="mt-3">VISITA</h1>

<!-- FORMULARIO. Cambiar los campos de acuerdo a su trabajo -->
<div class="formulario p-4 m-3 border rounded-3">

    <form action="proyecto_insert.php" method="post" class="form-group">
        <!-- CP -->
        <div class="mb-3">
            <label for="identificador" class="form-label">Identificador</label>
            <input type="number" class="form-control" id="identificador" name="identificador" min="1" required>
        </div>

        <div class="mb-3">
            <label for="fecha" class="form-label">Fecha</label>
            <input type="date" class="form-control" id="fecha" name="fecha" required>
        </div>

        <div class="mb-3">
            <label for="hora" class="form-label">Hora</label>
            <input type="time" class="form-control" id="hora" name="hora" required>
        </div>

        <div class="mb-3">
            <label for="costo" class="form-label">Costo</label>
            <input type="number" class="form-control" id="costo" name="costo"  required>
        </div>

        <div class="mb-3">
            <label for="tipo" class="form-label">Tipo</label>
            <input type="text" class="form-control" id="tipo" name="tipo" required>
        </div>

        <div class="mb-3">
            <label for="reporte" class="form-label">Reporte</label>
            <input type="text" class="form-control" id="reporte" name="reporte" required>
        </div>

        <div class="mb-3">
            <label for="observaciones" class="form-label">Observaciones</label>
            <input type="text" class="form-control" id="observaciones" name="observaciones" required>
        </div>

        <!-- Consultar la lista de cotizaciones y desplegarlass -->
        <div class="mb-3">
            <label for="cotizacion" class="form-label">Cotizacion</label>
            <select name="cotizacion" id="cotizacion" class="form-select">
                
                <!-- Option por defecto -->
                <option value="" selected disabled hidden></option>

                <?php
                // Importar el código del otro archivo
                require("../cotizacion/cotizacion_select.php");
                
                // Verificar si llegan datos
                if($resultadoCotizacion):
                    
                    // Iterar sobre los registros que llegaron
                    foreach ($resultadoCotizacion as $fila):
                ?>

                <!-- Opción que se genera -->
                <option name="cotizacion" value="<?= $fila["codigo"]; ?>">Codigo <?= $fila["codigo"]; ?></option>

                <?php
                        // Cerrar los estructuras de control
                    endforeach;
                endif;
                ?>
            </select>
        </div>

        <button type="submit" class="btn btn-primary">Agregar</button>

    </form>
    
</div>

<?php
// Importar el código del otro archivo
require("proyecto_select.php");
            
// Verificar si llegan datos
if($resultadoProyecto and $resultadoProyecto->num_rows > 0):
?>

<!-- MOSTRAR LA TABLA. Cambiar las cabeceras -->
<div class="tabla mt-5 mx-3 rounded-3 overflow-hidden">

    <table class="table table-striped table-bordered">

        <!-- Títulos de la tabla, cambiarlos -->
        <thead class="table-dark">
            <tr>
                <th scope="col" class="text-center">Indentificador</th>
                <th scope="col" class="text-center">Fecha</th>
                <th scope="col" class="text-center">Hora</th>
                <th scope="col" class="text-center">Costo</th>
                <th scope="col" class="text-center">Tipo</th>
                <th scope="col" class="text-center">Reporte</th>
                <th scope="col" class="text-center">Observaciones</th>

                <!-- Entidad relacionada -->
                <th scope="col" class="text-center">Cotizacion</th>
            </tr>
        </thead>

        <tbody>

            <?php
            // Iterar sobre los registros que llegaron
            foreach ($resultadoProyecto as $fila):
            ?>

            <!-- Fila que se generará -->
            <tr>
                <!-- Cada una de las columnas, con su Hora correspondiente -->
                <td class="text-center"><?= $fila["Identificador"]; ?></td>
                <td class="text-center"><?= $fila["fecha"]; ?></td>
                <td class="text-center"><?= $fila["Hora"]; ?></td>
                <td class="text-center"><?= $fila["Costo"]; ?></td>
                <td class="text-center"><?= $fila["Tipo"]; ?></td>
                <td class="text-center"><?= $fila["Reporte"]; ?></td>
                <td class="text-center"><?= $fila["Observaciones"]; ?></td>


                <!-- Entidad relacionada -->
                <td class="text-center">Codigo <?= $fila["cotizacion"]; ?></td>
                
                <!-- Botón de eliminar. Debe de incluir la CP de la entidad para identificarla -->
                <td class="text-center">
                    <form action="proyecto_delete.php" method="post">
                        <input hidden type="text" name="identificadorEliminar" value="<?= $fila["identificador"]; ?>">
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
