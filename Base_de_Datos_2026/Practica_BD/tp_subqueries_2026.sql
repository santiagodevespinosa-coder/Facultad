-- CREATE DATABASE tp_subquery_2026;
-- USE tp_subquery_2026;

CREATE TABLE productos (
id_productos INT auto_increment PRIMARY KEY,
nombre VARCHAR(50),
precio double
);

CREATE TABLE clientes (
id_clientes INT auto_increment PRIMARY KEY,
nombre VARCHAR(50),
correo VARCHAR(100)
);

CREATE TABLE ventas (
id INT auto_increment PRIMARY KEY,
producto_id INT,
cliente_id INT,
cantidad INT,
total double,
CONSTRAINT fk_producto FOREIGN KEY (producto_id) REFERENCES productos(id_productos),
CONSTRAINT fk_cliente FOREIGN KEY (cliente_id) REFERENCES clientes(id_clientes)
);

-- Inserts Productos
INSERT INTO productos (nombre, precio) VALUES ('Laptop', 1500.00);
INSERT INTO productos (nombre, precio) VALUES ('Mouse', 20.00);
INSERT INTO productos (nombre, precio) VALUES ('Teclado', 50.00);
INSERT INTO productos (nombre, precio) VALUES ('Monitor', 300.00);
INSERT INTO productos (nombre, precio) VALUES ('Impresora', 200.00);

-- Insert correos
INSERT INTO clientes (nombre, correo) VALUES ('Juan Perez', 'juan.perez@example.com');
INSERT INTO clientes (nombre, correo) VALUES ('Maria Garcia', 'maria.garcia@example.com');
INSERT INTO clientes (nombre, correo) VALUES ('Carlos Sanchez', 'carlos.sanchez@example.com');
INSERT INTO clientes (nombre, correo) VALUES ('Ana Rodriguez', 'ana.rodriguez@example.com');
INSERT INTO clientes (nombre, correo) VALUES ('Sofia Galbato', 'sofi.galbato@example.com');

-- Insert ventas
INSERT INTO ventas (producto_id, cliente_id, cantidad, total) VALUES (1, 1, 2, 50.00);
INSERT INTO ventas (producto_id, cliente_id, cantidad, total) VALUES (2, 2, 1, 30.00);
INSERT INTO ventas (producto_id, cliente_id, cantidad, total) VALUES (3, 3, 5, 150.00);
INSERT INTO ventas (producto_id, cliente_id, cantidad, total) VALUES (1, 4, 3, 75.00);
INSERT INTO ventas (producto_id, cliente_id, cantidad, total) VALUES (2, 5, 4, 120.00);
INSERT INTO ventas (producto_id, cliente_id, cantidad, total) VALUES (3, 1, 1, 30.00);
INSERT INTO ventas (producto_id, cliente_id, cantidad, total) VALUES (1, 2, 2, 50.00);
INSERT INTO ventas (producto_id, cliente_id, cantidad, total) VALUES (2, 3, 3, 90.00);
INSERT INTO ventas (producto_id, cliente_id, cantidad, total) VALUES (3, 4, 2, 60.00);
INSERT INTO ventas (producto_id, cliente_id, cantidad, total) VALUES (1, 5, 1, 25.00);

/*1. Obtener el nombre y precio de los productos cuyo precio es mayor que el precio promedio
de todos los productos*/

-- Precio promedio de los productos
SELECT AVG(precio)
FROM productos;

SELECT nombre, precio
FROM productos
WHERE precio > (
	SELECT AVG(precio) FROM productos
);

/*2. Listar los nombres de los clientes que han realizado al menos una compra*/

SELECT nombre
FROM clientes
WHERE id_clientes IN (
	SELECT cliente_id FROM ventas
);

/*3. Mostrar los productos que no han sido vendidos*/

SELECT nombre
FROM productos
WHERE id_productos NOT IN (
	SELECT producto_id FROM ventas
);

/*4. Obtener el nombre de los clientes y el total gastado por cada uno.*/

SELECT nombre,(
	SELECT COALESCE(SUM(total), 0)
    FROM ventas
    WHERE ventas.cliente_id = clientes.id_clientes
) AS total_ganado
FROM clientes;

/*5. Listar los productos que han sido comprados más de una vez*/

SELECT nombre 
FROM productos 
WHERE id_productos IN (
    SELECT producto_id 
    FROM ventas 
    GROUP BY producto_id 
    HAVING COUNT(*) > 1
);

/*6. Mostrar los nombres de los clientes que han comprado productos cuyo precio es mayor al
precio promedio de todos los productos*/

SELECT nombre 
FROM clientes 
WHERE id_clientes IN (
    SELECT cliente_id 
    FROM ventas 
    WHERE producto_id IN (
        SELECT id_productos 
        FROM productos 
        WHERE precio > (
            SELECT AVG(precio) 
            FROM productos
        )
    )
);

/*7. Obtener el nombre de los productos y la cantidad total vendida de cada uno*/

SELECT 
    nombre,
    (SELECT COALESCE(SUM(cantidad), 0) 
     FROM ventas 
     WHERE ventas.producto_id = productos.id_productos) AS cantidad_total_vendida
FROM productos;

/*8. Listar los clientes que han gastado más que el promedio de todos los clientes*/

SELECT nombre 
FROM clientes 
WHERE id_clientes IN (
    SELECT cliente_id 
    FROM ventas 
    GROUP BY cliente_id 
    HAVING SUM(total) > (
        SELECT AVG(total_gastado) 
        FROM (
            SELECT SUM(total) AS total_gastado 
            FROM ventas 
            GROUP BY cliente_id
        ) AS tabla_promedios
    )
);

/*9. Mostrar los productos cuyo precio es mayor que el precio promedio de los productos
vendidos*/

SELECT nombre, precio 
FROM productos 
WHERE precio > (
    SELECT AVG(precio) 
    FROM productos 
    WHERE id_productos IN (
        SELECT producto_id 
        FROM ventas
    )
);

/*10. Obtener el nombre de los clientes que han comprado más de 5 productos en total.*/

SELECT nombre 
FROM clientes 
WHERE id_clientes IN (
    SELECT cliente_id 
    FROM ventas 
    GROUP BY cliente_id 
    HAVING SUM(cantidad) > 5
);