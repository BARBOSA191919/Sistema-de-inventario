<?php
// Datos de conexión a la base de datos
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "gestorinventario";

// Crear conexión
$conn = new mysqli($servername, $username, $password, $dbname);

// Verifica la conexión
if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}

// Verifica si se ha proporcionado un término de búsqueda
$searchTerm = isset($_GET['search']) ? trim((string) $_GET['search']) : null;

// Asegurarse de que el término de búsqueda no sea nulo
if ($searchTerm !== null) {
    // Prepara la consulta SQL para buscar por atributos específicos
    $query = "
        SELECT 
            u.*
        FROM 
            Usuario u
        WHERE 
            u.Nombre LIKE ?
            OR u.Direccion LIKE ?
            OR u.Correo LIKE ?
            OR u.numeroTelefonico LIKE ?
            OR u.numeroIdentificacion LIKE ?
            OR u.Usuario LIKE ?
    ";

    // Prepara la consulta
    $stmt = $conn->prepare($query);

    if ($stmt) {
        // Configurar el patrón de búsqueda
        $searchPattern = '%' . $searchTerm . '%';

        // Vincular parámetros
        $stmt->bind_param('ssssss', 
            $searchPattern, 
            $searchPattern, 
            $searchPattern, 
            $searchPattern, 
            $searchPattern, 
            $searchPattern
        );

        // Ejecutar la consulta
        $stmt->execute();

        // Obtener resultados
        $result = $stmt->get_result();

        if ($result) {
            $usuarios = array();
            // Recorre los resultados y almacena en un array
            while ($row = $result->fetch_assoc()) {
                $usuarios[] = $row;
            }

            // Devuelve los resultados en formato JSON
            echo json_encode($usuarios);
        } else {
            // En caso de error en la ejecución
            echo json_encode(array('error' => 'Error al obtener resultados'));
        }

        // Cierra la declaración
        $stmt->close();
    } else {
        // Si la preparación de la consulta falla
        echo json_encode(array('error' => 'Error al preparar la consulta'));
    }
} else {
    // Si no se proporciona un término de búsqueda
    echo json_encode(array('error' => 'No se proporcionó un término de búsqueda'));
}

// Cierra la conexión
$conn->close();
?>