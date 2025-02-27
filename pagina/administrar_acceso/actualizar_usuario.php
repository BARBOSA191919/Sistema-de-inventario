<?php
$page = 'administrar_acceso'; // Define la página actual
session_start();

if (!isset($_SESSION['loggedin']) || $_SESSION['loggedin'] !== true) {
    // Redirigir a la página de inicio de sesión si no se ha iniciado sesión
    header("Location: ../../index.php");
    exit();
}

// Definir los roles según el nivel de acceso
$roles = [
    1 => "Escritura",
    2 => "Lectura"
];

// Obtener el id del usuario desde la sesión
$IdSesion = $_SESSION['IdUsuario'];

// Obtener el nivel de acceso del usuario desde la sesión
$nivelAcceso = isset($_SESSION['nivelAcceso_IdnivelAcceso']) ? $_SESSION['nivelAcceso_IdnivelAcceso'] : null;

// Determinar el rol del usuario
$rolUsuario = isset($roles[$nivelAcceso]) ? $roles[$nivelAcceso] : "Desconocido";

// Redirigir si el usuario no tiene permiso de escritura
if ($rolUsuario !== "Escritura") {
    header("Location: ../../pagina/administrar_acceso/usuario.php");
    exit();
}
?>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Inventario</title>
    <link rel="stylesheet" href="../../css/administrar_acceso/actualizar_usuario_styles.css">
</head>

<body>
    <?php include '../../sidebar.php'; ?>
    <div class="content">
        <div class="header">
            <div class="user-info">
                <div class="user-icon">
                    <img src="../../img/svg/icon.svg" alt="Usuario">
                </div>
                <div class="user-details">
                    <span style="font-size: 16px; font-weight: bold; margin-bottom: 2px;"><?php echo $_SESSION['usuario']; ?></span>
                    <span style="font-size: 12px;"><?php echo $rolUsuario; ?></span>
                </div>
                <div class="dropdown-menu-container">
                    <div class="dropdown-toggle">
                        <img src="../../img/svg/option.svg" alt="Opciones">
                        <span>Opciones</span>
                    </div>
                    <div class="menu-content">
                        <a href="../../logout.php">Cerrar sesión</a>
                        <a href="../../pagina/inicio/ver_usuario.php">Ver usuario</a>
                    </div>
                </div>
            </div>
        </div>
        <div class="title-section">
            <img src="../../img/svg/lock.svg" alt="Administrar acceso" class="title-svg">
            <span>Administrar Acceso</span>
        </div>
        <div class="body-content">
            <div class="container">
                <div class="add-user">
                    <img src="../../img/svg/edit.svg" alt="Agregar Usuario">
                    <span class="title">Editar Usuario</span>
                </div>
                <?php
                // Verificar si se recibió un ID de usuario válido
                if (isset($_GET['id']) && !empty($_GET['id'])) {
                    $servername = "localhost";
                    $username = "root";
                    $password = "";
                    $dbname = "gestorinventario";

                    // Crea la conexion
                    $conn = mysqli_connect($servername, $username, $password, $dbname);

                    // Comprueba la conexion
                    if ($conn->connect_error) {
                        die("Connection failed: " . $conn->connect_error);
                    }

                    // Obtener el ID del usuario
                    $idUsuario = $_GET['id'];

                    // Consulta SQL para obtener los datos del usuario por su ID
                    $query = "SELECT * FROM Usuario WHERE IdUsuario = $idUsuario";
                    $result = mysqli_query($conn, $query);

                    // Verificar si se encontraron resultados
                    if (mysqli_num_rows($result) > 0) {
                        $row = mysqli_fetch_assoc($result);
                ?>
                        <form action="../../php/administrar_acceso/update_usuario.php" method="POST" id="edit-user-form" class="form-columns">
                            <input type="hidden" name="idUsuario" value="<?php echo $row['IdUsuario']; ?>">
                            <div class="input-group">
                                <label for="nombre">Nombre</label>
                                <input type="text" id="nombre" name="nombre" value="<?php echo $row['Nombre']; ?>" required>
                            </div>
                            <div class="input-group">
                                <label for="usuario">Usuario</label>
                                <input type="text" id="usuario" name="usuario" value="<?php echo $row['Usuario']; ?>" required>
                            </div>
                            <div class="input-group">
                                <label for="contrasena">Contraseña</label>
                                <input type="password" id="contrasena" name="contrasena" value="<?php echo $row['Contrasena']; ?>" required>
                            </div>
                            <div class="input-group">
                                <label for="direccion">Dirección</label>
                                <input type="text" id="direccion" name="direccion" value="<?php echo $row['Direccion']; ?>" required>
                            </div>
                            <div class="input-group">
                                <label for="correo">Correo</label>
                                <input type="email" id="correo" name="correo" value="<?php echo $row['Correo']; ?>" required>
                            </div>
                            <div class="input-group">
                                <label for="telefono">Número Telefónico</label>
                                <input type="tel" id="telefono" name="telefono" value="<?php echo $row['numeroTelefonico']; ?>" required>
                            </div>
                            <div class="input-group">
                                <label for="tipo_identificacion">Tipo de Identificación</label>
                                <select id="tipo_identificacion" name="tipo_identificacion" required>
                                    <option value="CC" <?php if ($row['TipoIdentificacion'] == 'CC') echo 'selected'; ?>>Cédula de Ciudadanía</option>
                                    <option value="TI" <?php if ($row['TipoIdentificacion'] == 'TI') echo 'selected'; ?>>Tarjeta de Identidad</option>
                                    <option value="RCN" <?php if ($row['TipoIdentificacion'] == 'RCN') echo 'selected'; ?>>Registro Civil de Nacimiento</option>
                                    <option value="CE" <?php if ($row['TipoIdentificacion'] == 'CE') echo 'selected'; ?>>Cédula de Extranjería</option>
                                    <option value="RUT" <?php if ($row['TipoIdentificacion'] == 'RUT') echo 'selected'; ?>>Registro Único Tributario</option>
                                    <option value="TIN" <?php if ($row['TipoIdentificacion'] == 'TIN') echo 'selected'; ?>>Tarjeta de Identificación Tributaria</option>
                                    <option value="NIT" <?php if ($row['TipoIdentificacion'] == 'NIT') echo 'selected'; ?>>Número de Identificación Tributaria</option>
                                    <option value="NUIP" <?php if ($row['TipoIdentificacion'] == 'NUIP') echo 'selected'; ?>>Número Único de Identificación Personal</option>
                                    <option value="EPS" <?php if ($row['TipoIdentificacion'] == 'EPS') echo 'selected'; ?>>Entidad Promotora de Salud</option>
                                    <option value="ARP" <?php if ($row['TipoIdentificacion'] == 'ARP') echo 'selected'; ?>>Administradora de Riesgos Laborales</option>
                                    <option value="PPE" <?php if ($row['TipoIdentificacion'] == 'PPE') echo 'selected'; ?>>Permiso Provisional Especial</option>
                                    <option value="PEP" <?php if ($row['TipoIdentificacion'] == 'PEP') echo 'selected'; ?>>Permiso Especial de Permanencia</option>
                                    <option value="TSE" <?php if ($row['TipoIdentificacion'] == 'TSE') echo 'selected'; ?>>Tarjeta de Servicios Electrónicos</option>
                                    <option value="TP" <?php if ($row['TipoIdentificacion'] == 'TP') echo 'selected'; ?>>Tarjeta Profesional</option>
                                    <option value="CREMIL" <?php if ($row['TipoIdentificacion'] == 'CREMIL') echo 'selected'; ?>>Carné Militar</option>
                                    <option value="RUNT" <?php if ($row['TipoIdentificacion'] == 'RUNT') echo 'selected'; ?>>Registro Único Nacional de Tránsito</option>
                                </select>
                            </div>
                            <div class="input-group">
                                <label for="numero_identificacion">Número de Identificación</label>
                                <input type="text" id="numero_identificacion" name="numero_identificacion" value="<?php echo $row['numeroIdentificacion']; ?>" required>
                            </div>
                            <div class="input-group">
                                <label for="nivel_acceso">Nivel de Acceso</label>
                                <select id="nivel_acceso" name="nivel_acceso" required>
                                    <option value="1" <?php if ($row['nivelAcceso_IdnivelAcceso'] == 1) echo 'selected'; ?>>Escritura</option>
                                    <option value="2" <?php if ($row['nivelAcceso_IdnivelAcceso'] == 2) echo 'selected'; ?>>Lectura</option>
                                </select>
                            </div>
                            <div class="input-group">
                                <label for="estado">Estado:</label>
                                <?php if ($IdSesion == $idUsuario) { ?>
                                    <select id="estado" name="estado" disabled>
                                        <option value="1" <?php if ($row['Estado'] == 1) echo 'selected'; ?>>Activo</option>
                                        <option value="0" <?php if ($row['Estado'] == 0) echo 'selected'; ?>>Inactivo</option>
                                    </select>
                                    <input type="hidden" name="estado" value="<?php echo $row['Estado']; ?>">
                                <?php } else { ?>
                                    <select id="estado" name="estado" required>
                                        <option value="1" <?php if ($row['Estado'] == 1) echo 'selected'; ?>>Activo</option>
                                        <option value="0" <?php if ($row['Estado'] == 0) echo 'selected'; ?>>Inactivo</option>
                                    </select>
                                <?php } ?>
                            </div>
                            <button type="submit">Actualizar</button>
                        </form>
                <?php
                    } else {
                        echo "<p>No se encontraron datos de usuario para editar.</p>";
                    }

                    // Cerrar conexión a la base de datos
                    mysqli_close($conn);
                } else {
                    echo "<p>No se proporcionó un ID de usuario válido.</p>";
                }
                ?>
            </div>
        </div>
    </div>
</body>

</html>