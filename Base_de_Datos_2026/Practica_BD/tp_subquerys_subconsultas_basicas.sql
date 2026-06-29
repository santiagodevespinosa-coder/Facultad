-- CREATE DATABASE tp_subquerys_subconsultas_basico;
-- USE tp_subquerys_subconsultas_basico;

CREATE TABLE clientes (
id INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(80) NOT NULL,
correo VARCHAR(100),
ciudad VARCHAR(60)
);

CREATE TABLE productos (
id INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(80) NOT NULL,
categoria VARCHAR(60) NOT NULL,
precio DECIMAL(10,2) NOT NULL
);

CREATE TABLE ventas (
id INT AUTO_INCREMENT PRIMARY KEY,
producto_id INT NOT NULL,
cliente_id INT NOT NULL,
cantidad INT NOT NULL,
fecha DATE NOT NULL,
total DECIMAL(10,2) NOT NULL,
CONSTRAINT fk_ventas_productos
FOREIGN KEY (producto_id) REFERENCES productos(id),
CONSTRAINT fk_ventas_clientes
FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

-- Insert Clientes

INSERT INTO clientes (nombre, correo, ciudad) VALUES
('Juan Perez', 'juan.perez@example.com', 'Mar del Plata'),
('Maria Garcia', 'maria.garcia@example.com', 'Mar del Plata'),
('Carlos Sanchez', 'carlos.sanchez@example.com', 'Balcarce'),
('Ana Rodriguez', 'ana.rodriguez@example.com', 'Miramar'),
('Sofia Galbato', 'sofia.galbato@example.com', 'Mar del Plata'),
('Lucia Fernandez', 'lucia.fernandez@example.com', 'Necochea');	

-- Insert Productos

INSERT INTO productos (nombre, categoria, precio) VALUES
('Notebook', 'Computacion', 1500.00),
('Mouse', 'Perifericos', 20.00),
('Teclado', 'Perifericos', 50.00),
('Monitor', 'Perifericos', 300.00),
('Impresora', 'Impresion', 220.00),
('Silla ergonomica', 'Oficina', 180.00),
('Webcam', 'Perifericos', 90.00),
('Tablet', 'Computacion', 500.00);

-- Insert Ventas

INSERT INTO ventas (producto_id, cliente_id, cantidad, fecha,
total) VALUES
(1, 1, 1, '2025-03-05', 1500.00),
(2, 1, 2, '2025-03-05', 40.00),
(3, 2, 1, '2025-03-10', 50.00),
(4, 2, 1, '2025-03-10', 300.00),
(2, 3, 1, '2025-04-01', 20.00),
(5, 3, 1, '2025-04-02', 220.00),
(6, 4, 2, '2025-04-10', 360.00),
(1, 4, 1, '2025-04-11', 1500.00),
(3, 5, 3, '2025-05-01', 150.00),
(4, 5, 2, '2025-05-03', 600.00),
(2, 2, 1, '2025-05-05', 20.00),
(5, 1, 1, '2025-05-08', 220.00);

/*1. Obtener el nombre, la categoria y el precio de los productos cuyo precio
sea mayor que el precio promedio de todos los productos*/

SELECT nombre, categoria, precio
FROM productos
WHERE precio > (
	SELECT AVG(precio)
    FROM productos
);

/*2. Obtener el nombre y el precio del producto mas caro.*/

SELECT nombre, precio
FROM productos
WHERE precio = (
	SELECT MAX(precio) 
    FROM productos
);

/*3. Listar los nombres de los clientes que realizaron al menos una compra.*/

SELECT c.nombre
FROM clientes AS c
WHERE c.id IN (
	SELECT v.cliente_id
    FROM ventas AS v
);

/*4. Listar los nombres de los clientes que no realizaron ninguna compra.*/

SELECT c.nombre
FROM clientes AS c
WHERE c.id NOT IN (
	SELECT v.cliente_id
    FROM ventas AS v
);

/*5. Mostrar los productos que fueron vendidos al menos una vez*/

SELECT p.nombre
FROM productos AS p
WHERE p.id IN (
	SELECT v.producto_id
    FROM ventas AS v
);

/*6. Mostrar los productos que nunca fueron vendidos*/

SELECT p.nombre
FROM productos AS p
WHERE NOT EXISTS (
	SELECT 1
    FROM ventas AS v
    WHERE v.producto_id = p.id
);