-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 03-07-2024 a las 00:21:36
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `gestorinventario`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `IdCategoria` int(11) NOT NULL,
  `Nombre` varchar(100) NOT NULL,
  `Estado` bit(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Tabla para almacenar categorías de productos.';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `IdCliente` int(11) NOT NULL,
  `Nombre` varchar(150) NOT NULL,
  `Direccion` varchar(100) NOT NULL,
  `Correo` varchar(150) NOT NULL,
  `numeroTelefonico` varchar(15) NOT NULL,
  `TipoIdentificacion` varchar(10) NOT NULL,
  `numeroIdentificacion` varchar(20) NOT NULL,
  `Estado` bit(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Tabla para almacenar información de clientes.';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalleentrada`
--

CREATE TABLE `detalleentrada` (
  `IdDetalleEntrada` int(11) NOT NULL,
  `Cantidad` int(11) NOT NULL,
  `PrecioEntrada` decimal(10,2) NOT NULL,
  `Producto_IdProducto` int(11) NOT NULL,
  `Entrada_IdEntrada` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Tabla para almacenar detalles de entradas de productos.';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detallesalida`
--

CREATE TABLE `detallesalida` (
  `IdDetalleSalida` int(11) NOT NULL,
  `Cantidad` int(11) NOT NULL,
  `PrecioSalida` decimal(10,2) NOT NULL,
  `Producto_IdProducto` int(11) NOT NULL,
  `Salida_IdSalida` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Tabla para almacenar detalles de salidas de productos.';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `entrada`
--

CREATE TABLE `entrada` (
  `IdEntrada` int(11) NOT NULL,
  `FechaEntrada` date NOT NULL,
  `Proveedor_IdProveedor` int(11) NOT NULL,
  `Usuario_IdUsuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Tabla para almacenar información de entradas de productos.';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `nivelacceso`
--

CREATE TABLE `nivelacceso` (
  `IdnivelAcceso` int(11) NOT NULL,
  `Nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Tabla para almacenar niveles de acceso.';

--
-- Volcado de datos para la tabla `nivelacceso`
--

INSERT INTO `nivelacceso` (`IdnivelAcceso`, `Nombre`) VALUES
(1, 'Escritura'),
(2, 'Lectura');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `IdProducto` int(11) NOT NULL,
  `Nombre` varchar(150) NOT NULL,
  `Descripcion` varchar(500) DEFAULT NULL,
  `Imagen` longblob DEFAULT NULL,
  `Precio` decimal(10,2) NOT NULL,
  `CantidadDisponible` int(11) NOT NULL,
  `Estado` bit(1) NOT NULL,
  `Subcategoria_IdSubcategoria` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Tabla para almacenar productos.';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedor`
--

CREATE TABLE `proveedor` (
  `IdProveedor` int(11) NOT NULL,
  `Nombre` varchar(150) NOT NULL,
  `Direccion` varchar(100) NOT NULL,
  `Correo` varchar(150) NOT NULL,
  `numeroTelefonico` varchar(15) NOT NULL,
  `TipoIdentificacion` varchar(10) NOT NULL,
  `numeroIdentificacion` varchar(20) NOT NULL,
  `Estado` bit(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Tabla para almacenar información de proveedores.';

--
-- Volcado de datos para la tabla `proveedor`
--

INSERT INTO `proveedor` (`IdProveedor`, `Nombre`, `Direccion`, `Correo`, `numeroTelefonico`, `TipoIdentificacion`, `numeroIdentificacion`, `Estado`) VALUES
(1, 'Santiago ', 'Calle 38 # 7 A 51', 'sbarbosarivas@gmail.com', '3217696864', 'CC', '1003865', b'1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `salida`
--

CREATE TABLE `salida` (
  `IdSalida` int(11) NOT NULL,
  `FechaSalida` date NOT NULL,
  `Cliente_IdCliente` int(11) NOT NULL,
  `Usuario_IdUsuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Tabla para almacenar información de salidas de productos.';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `subcategoria`
--

CREATE TABLE `subcategoria` (
  `IdSubcategoria` int(11) NOT NULL,
  `Nombre` varchar(150) NOT NULL,
  `Estado` bit(1) NOT NULL,
  `Categoria_IdCategoria` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Tabla para almacenar subcategorías de productos.';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `IdUsuario` int(11) NOT NULL,
  `Nombre` varchar(100) NOT NULL,
  `Direccion` varchar(100) NOT NULL,
  `Correo` varchar(150) NOT NULL,
  `numeroTelefonico` varchar(15) NOT NULL,
  `TipoIdentificacion` varchar(10) NOT NULL,
  `numeroIdentificacion` varchar(20) NOT NULL,
  `Usuario` varchar(100) NOT NULL,
  `Contrasena` varchar(100) NOT NULL,
  `Estado` bit(1) NOT NULL,
  `nivelAcceso_IdnivelAcceso` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Tabla para almacenar información de usuarios.';

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`IdUsuario`, `Nombre`, `Direccion`, `Correo`, `numeroTelefonico`, `TipoIdentificacion`, `numeroIdentificacion`, `Usuario`, `Contrasena`, `Estado`, `nivelAcceso_IdnivelAcceso`) VALUES
(1, 'user', 'Calle 38 # 7 A 51', 'user12@gmail.com', '3217696864', 'CC', '1003865', 'user', '123', b'1', 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`IdCategoria`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`IdCliente`);

--
-- Indices de la tabla `detalleentrada`
--
ALTER TABLE `detalleentrada`
  ADD PRIMARY KEY (`IdDetalleEntrada`,`Producto_IdProducto`,`Entrada_IdEntrada`),
  ADD KEY `fk_DetalleEntrada_Producto1_idx` (`Producto_IdProducto`),
  ADD KEY `fk_DetalleEntrada_Entrada1_idx` (`Entrada_IdEntrada`);

--
-- Indices de la tabla `detallesalida`
--
ALTER TABLE `detallesalida`
  ADD PRIMARY KEY (`IdDetalleSalida`,`Producto_IdProducto`,`Salida_IdSalida`),
  ADD KEY `fk_DetalleSalida_Producto1_idx` (`Producto_IdProducto`),
  ADD KEY `fk_DetalleSalida_Salida1_idx` (`Salida_IdSalida`);

--
-- Indices de la tabla `entrada`
--
ALTER TABLE `entrada`
  ADD PRIMARY KEY (`IdEntrada`),
  ADD KEY `fk_Entrada_Proveedor1_idx` (`Proveedor_IdProveedor`),
  ADD KEY `fk_Entrada_Usuario1_idx` (`Usuario_IdUsuario`);

--
-- Indices de la tabla `nivelacceso`
--
ALTER TABLE `nivelacceso`
  ADD PRIMARY KEY (`IdnivelAcceso`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`IdProducto`),
  ADD KEY `fk_Producto_Subcategoria_idx` (`Subcategoria_IdSubcategoria`);

--
-- Indices de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  ADD PRIMARY KEY (`IdProveedor`);

--
-- Indices de la tabla `salida`
--
ALTER TABLE `salida`
  ADD PRIMARY KEY (`IdSalida`),
  ADD KEY `fk_Salida_Cliente1_idx` (`Cliente_IdCliente`),
  ADD KEY `fk_Salida_Usuario1_idx` (`Usuario_IdUsuario`);

--
-- Indices de la tabla `subcategoria`
--
ALTER TABLE `subcategoria`
  ADD PRIMARY KEY (`IdSubcategoria`),
  ADD KEY `fk_Subcategoria_Categoria1_idx` (`Categoria_IdCategoria`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`IdUsuario`),
  ADD KEY `fk_Usuario_nivelAcceso1_idx` (`nivelAcceso_IdnivelAcceso`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `IdCategoria` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `IdCliente` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detalleentrada`
--
ALTER TABLE `detalleentrada`
  MODIFY `IdDetalleEntrada` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detallesalida`
--
ALTER TABLE `detallesalida`
  MODIFY `IdDetalleSalida` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `entrada`
--
ALTER TABLE `entrada`
  MODIFY `IdEntrada` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `nivelacceso`
--
ALTER TABLE `nivelacceso`
  MODIFY `IdnivelAcceso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `IdProducto` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  MODIFY `IdProveedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `salida`
--
ALTER TABLE `salida`
  MODIFY `IdSalida` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `subcategoria`
--
ALTER TABLE `subcategoria`
  MODIFY `IdSubcategoria` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `IdUsuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `detalleentrada`
--
ALTER TABLE `detalleentrada`
  ADD CONSTRAINT `fk_DetalleEntrada_Entrada1` FOREIGN KEY (`Entrada_IdEntrada`) REFERENCES `entrada` (`IdEntrada`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_DetalleEntrada_Producto1` FOREIGN KEY (`Producto_IdProducto`) REFERENCES `producto` (`IdProducto`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `detallesalida`
--
ALTER TABLE `detallesalida`
  ADD CONSTRAINT `fk_DetalleSalida_Producto1` FOREIGN KEY (`Producto_IdProducto`) REFERENCES `producto` (`IdProducto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_DetalleSalida_Salida1` FOREIGN KEY (`Salida_IdSalida`) REFERENCES `salida` (`IdSalida`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `entrada`
--
ALTER TABLE `entrada`
  ADD CONSTRAINT `fk_Entrada_Proveedor1` FOREIGN KEY (`Proveedor_IdProveedor`) REFERENCES `proveedor` (`IdProveedor`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Entrada_Usuario1` FOREIGN KEY (`Usuario_IdUsuario`) REFERENCES `usuario` (`IdUsuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `fk_Producto_Subcategoria` FOREIGN KEY (`Subcategoria_IdSubcategoria`) REFERENCES `subcategoria` (`IdSubcategoria`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `salida`
--
ALTER TABLE `salida`
  ADD CONSTRAINT `fk_Salida_Cliente1` FOREIGN KEY (`Cliente_IdCliente`) REFERENCES `cliente` (`IdCliente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Salida_Usuario1` FOREIGN KEY (`Usuario_IdUsuario`) REFERENCES `usuario` (`IdUsuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `subcategoria`
--
ALTER TABLE `subcategoria`
  ADD CONSTRAINT `fk_Subcategoria_Categoria1` FOREIGN KEY (`Categoria_IdCategoria`) REFERENCES `categoria` (`IdCategoria`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `fk_Usuario_nivelAcceso1` FOREIGN KEY (`nivelAcceso_IdnivelAcceso`) REFERENCES `nivelacceso` (`IdnivelAcceso`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
