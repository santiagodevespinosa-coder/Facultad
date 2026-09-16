-- CREATE DATABASE tpvistaindice;
-- USE tpvistaindice;

-- Tabla Clientes
CREATE TABLE Clientes (
    cliente_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    ciudad VARCHAR(50),
    email VARCHAR(50)
);

-- Tabla Productos
CREATE TABLE Productos (
    producto_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_producto VARCHAR(50),
    categoria VARCHAR(50),
    precio DECIMAL(10, 2)
);

-- Tabla Pedidos
CREATE TABLE Pedidos (
    pedido_id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    fecha_pedido DATE,
    FOREIGN KEY (cliente_id) REFERENCES Clientes(cliente_id)
);

-- Tabla Detalle_Pedido
CREATE TABLE Detalle_Pedido (
    detalle_id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT,
    producto_id INT,
    cantidad INT,
    FOREIGN KEY (pedido_id) REFERENCES Pedidos(pedido_id),
    FOREIGN KEY (producto_id) REFERENCES Productos(producto_id)
);

-- Insertar registros en Clientes
INSERT INTO Clientes (cliente_id, nombre, apellido, ciudad, email) VALUES
(1, 'Ana', 'García', 'Madrid', 'ana.garcia@email.com'),
(2, 'Juan', 'Pérez', 'Barcelona', 'juan.perez@email.com'),
(3, 'María', 'López', 'Madrid', 'maria.lopez@email.com'),
(4, 'Carlos', 'Ruiz', 'Valencia', 'carlos.ruiz@email.com');

-- Insertar registros en Productos
INSERT INTO Productos (producto_id, nombre_producto, categoria, precio) VALUES
(1, 'Laptop', 'Electrónicos', 1200.00),
(2, 'Tablet', 'Electrónicos', 300.00),
(3, 'Libro', 'Libros', 25.00),
(4, 'Smartphone', 'Electrónicos', 800.00);

-- Insertar registros en Pedidos
INSERT INTO Pedidos (pedido_id, cliente_id, fecha_pedido) VALUES
(1, 1, '2023-10-26'),
(2, 1, '2023-11-10'),
(3, 2, '2023-11-05'),
(4, 3, '2023-10-28'),
(5, 4, '2023-11-15');

-- Insertar registros en Detalle_Pedido
INSERT INTO Detalle_Pedido (detalle_id, pedido_id, producto_id, cantidad) VALUES
(1, 1, 1, 1),
(2, 1, 2, 2),
(3, 2, 4, 1),
(4, 3, 3, 3),
(5, 4, 1, 1),
(6, 5, 2, 2),
(7, 5, 4, 1);

-- VISTAS

/*Ejercicio 1:
Crear una vista llamada clientes_por_ciudad que muestre el nombre completo de los clientes
y su email, filtrando por una ciudad específica (por ejemplo, 'Madrid').
Utilizar WITH CHECK OPTION para asegurarnos de que no se puedan insertar o actualizar
clientes a través de esta vista que no pertenezcan a la ciudad filtrada.*/

CREATE VIEW clientes_por_ciudad AS
SELECT 
    CONCAT(nombre, ' ', apellido) AS nombre_completo, 
    email, 
    ciudad
FROM Clientes
WHERE ciudad = 'Madrid'
WITH CHECK OPTION;

/*Ejercicio 2:
Crear una vista llamada resumen_ventas_categoria que muestre la categoría de productos y
el total de ventas (suma de cantidades) para cada categoría (JOIN entre las tablas Productos
y Detalle_Pedido).*/

CREATE VIEW resumen_ventas_categoria AS
SELECT 
    p.categoria, 
    SUM(dp.cantidad) AS total_ventas
FROM Productos p
JOIN Detalle_Pedido dp ON p.producto_id = dp.producto_id
GROUP BY p.categoria;

/*Ejercicio 3:
Crear una vista llamada clientes_total_pedidos que muestre el nombre completo de los
clientes y el número total de pedidos realizados por cada cliente (JOIN entre las tablas
Clientes y Pedidos y función COUNT()).*/

CREATE VIEW clientes_total_pedidos AS
SELECT 
    CONCAT(c.nombre, ' ', c.apellido) AS nombre_completo, 
    COUNT(p.pedido_id) AS total_pedidos
FROM Clientes c
LEFT JOIN Pedidos p ON c.cliente_id = p.cliente_id
GROUP BY c.cliente_id, c.nombre, c.apellido;

/*Ejercicio 4:
Crear una vista llamada productos_mas_vendidos_ciudad que muestre la ciudad, el nombre
del producto y la cantidad total vendida de cada producto en cada ciudad (JOIN entre las
tablas Clientes, Pedidos y Detalle_Pedido, y funciones SUM() y GROUP BY).*/

CREATE VIEW productos_mas_vendidos_ciudad AS
SELECT 
    c.ciudad, 
    pr.nombre_producto, 
    SUM(dp.cantidad) AS cantidad_total_vendida
FROM Clientes c
JOIN Pedidos p ON c.cliente_id = p.cliente_id
JOIN Detalle_Pedido dp ON p.pedido_id = dp.pedido_id
JOIN Productos pr ON dp.producto_id = pr.producto_id
GROUP BY c.ciudad, pr.producto_id, pr.nombre_producto;

/*Ejercicio 5:
Crear una vista llamada ingresos_por_mes que muestre el mes y año (en formato "YYYY-
MM") y el total de ingresos generados en ese mes (JOIN entre las tablas Pedidos,
Detalle_Pedido y Productos, y funciones SUM() y DATE_FORMAT()).*/

CREATE VIEW ingresos_por_mes AS
SELECT 
    DATE_FORMAT(p.fecha_pedido, '%Y-%m') AS mes_anio, 
    SUM(dp.cantidad * pr.precio) AS total_ingresos
FROM Pedidos p
JOIN Detalle_Pedido dp ON p.pedido_id = dp.pedido_id
JOIN Productos pr ON dp.producto_id = pr.producto_id
GROUP BY DATE_FORMAT(p.fecha_pedido, '%Y-%m');

-- INDICES

/*Ejercicio 10:
Crear un índice en la tabla Clientes para el campo ciudad y ejecutar una consulta que
muestre el nombre completo de los clientes y su email, filtrando por una ciudad específica
(por ejemplo, 'Madrid'). Comparar el rendimiento de esta consulta con y sin el índice creado*/

CREATE INDEX idx_clientes_ciudad ON Clientes(ciudad);

-- Consulta

SELECT 
    CONCAT(nombre, ' ', apellido) AS nombre_completo, 
    email
FROM Clientes
WHERE ciudad = 'Madrid';

/*Ejercicio 11:
Crear un índice compuesto en la tabla Pedidos para los campos cliente_id y fecha_pedido.
Luego, ejecutar una consulta que muestre el nombre completo de los clientes y el número
total de pedidos realizados por cada cliente en un rango de fechas específico (por ejemplo,
del 1 de enero de 2025 al 31 de diciembre de 2025)*/

CREATE INDEX idx_pedidos_cliente_fecha ON Pedidos(cliente_id, fecha_pedido);

-- CONSULTA

SELECT 
    CONCAT(c.nombre, ' ', c.apellido) AS nombre_completo,
    COUNT(p.pedido_id) AS total_pedidos
FROM Clientes c
JOIN Pedidos p ON c.cliente_id = p.cliente_id
WHERE p.fecha_pedido BETWEEN '2025-01-01' AND '2025-12-31'
GROUP BY c.cliente_id, c.nombre, c.apellido;

/*Ejercicio 12:
Crear un índice único en la tabla Productos para el campo codigo_producto. Luego, intentar
insertar un nuevo producto con un código de producto duplicado y observar el
comportamiento del índice único.*/

ALTER TABLE Productos ADD COLUMN codigo_producto VARCHAR(20);

CREATE UNIQUE INDEX idx_unique_codigo_producto ON Productos(codigo_producto);

-- CONSULTA

-- Inserción correcta (primer registro con código)
UPDATE Productos SET codigo_producto = 'LAP-001' WHERE producto_id = 1;

-- Intento de inserción duplicada (dará error)
INSERT INTO Productos (nombre_producto, categoria, precio, codigo_producto) 
VALUES ('Laptop Pro', 'Electrónicos', 1500.00, 'LAP-001');

/*Ejercicio 13:
Crear un índice de texto completo en la tabla Productos para los campos nombre_producto y
descripcion. Luego, ejecutar una consulta que busque productos cuyo nombre o descripción
contenga una palabra clave específica (por ejemplo, 'portátil').*/

ALTER TABLE Productos ADD COLUMN descripcion TEXT;
UPDATE Productos SET descripcion = 'Ordenador portátil de alta gama con procesador rápido' WHERE producto_id = 1;

CREATE FULLTEXT INDEX idx_ft_productos ON Productos(nombre_producto, descripcion);

-- CONSULTA

SELECT producto_id, nombre_producto, descripcion, precio
FROM Productos
WHERE MATCH(nombre_producto, descripcion) AGAINST('portátil' IN BOOLEAN MODE);

/*Ejercicio 14:
Crear un índice compuesto en la tabla Ventas para los campos producto_id y fecha_venta.
Luego, ejecutar una consulta que muestre el nombre del producto y la cantidad total vendida
para cada producto en un rango de fechas específico (por ejemplo, del 1 de enero de 2025 al
31 de diciembre de 2025).*/


CREATE INDEX idx_ventas_prod_fecha ON Ventas(producto_id, fecha_venta);

-- CONSULTA

SELECT 
    p.nombre_producto,
    SUM(v.cantidad) AS cantidad_total_vendida
FROM Ventas v
JOIN Productos p ON v.producto_id = p.producto_id
WHERE v.fecha_venta BETWEEN '2025-01-01' AND '2025-12-31'
GROUP BY p.producto_id, p.nombre_producto;