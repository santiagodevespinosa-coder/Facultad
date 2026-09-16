-- CREATE DATABASE tp_store_procedures;
-- USE tp_store_procedures;

-- Tabla de clientes
CREATE TABLE clientes (
	id_cliente INT AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(100) NOT NULL,
	saldo DECIMAL(10,2) NOT NULL
);

-- Tabla de compras
CREATE TABLE compras (
	id_compra INT AUTO_INCREMENT PRIMARY KEY,
	id_cliente INT,
	fecha DATE,
	monto DECIMAL(10,2),
	FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

-- Datos de prueba
INSERT INTO clientes (nombre, saldo) VALUES
	('Juan Pérez', 1000),
	('María López', 500),
	('Pedro Gómez', 2000);

INSERT INTO compras (id_cliente, fecha, monto) VALUES
	(1, '2023-11-01', 100),
	(2, '2023-11-05', 250);
    
/*1 Insertar un cliente

Crear un procedimiento llamado insertar_cliente que permita agregar un cliente a la tabla clientes.

Parámetros de entrada:

    p_nombre — nombre del cliente (VARCHAR)
    p_saldo_inicial — saldo inicial (DECIMAL)

*/

DELIMITER //

CREATE PROCEDURE insertar_cliente(
	IN p_nombre VARCHAR(150),
    IN p_saldo_inicial DECIMAL(10,2)
)
BEGIN
    -- Inserto el nuevo cliente a la tabla, con su respectivo nombre y su saldo inicial
	INSERT clientes(nombre, saldo) VALUES (p_nombre, p_saldo_inicial);
END //

DELIMITER ;

DROP PROCEDURE insertar_cliente;
-- Aca llamo al Procedimiento

CALL insertar_cliente('Nicolas', 105000);

SELECT * FROM clientes;

/*2 Actualizar el nombre de un cliente

Crear un procedimiento llamado actualizar_nombre_cliente que permita cambiar el nombre de un cliente.

Parámetros de entrada:

    p_id_cliente — identificador del cliente (INT)
    p_nuevo_nombre — nuevo nombre (VARCHAR)

*/

DELIMITER //

CREATE PROCEDURE actualizar_nombre_cliente
(
	IN p_id_cliente INT,
    IN p_nuevo_nombre VARCHAR(150)
)
BEGIN
	UPDATE clientes
	SET nombre = p_nuevo_nombre
    WHERE id_cliente = p_id_cliente;
END //

DELIMITER ;

DROP PROCEDURE actualizar_nombre_cliente;

CALL actualizar_nombre_cliente(1, 'Alicia');

SELECT * FROM clientes;

/*3 Eliminar un cliente

Crear un procedimiento llamado eliminar_cliente que permita eliminar un cliente dado su id_cliente.

Parámetro de entrada:

    p_id_cliente — identificador del cliente (INT)

*/

DELIMITER //

CREATE PROCEDURE eliminar_cliente
(
	IN p_id_cliente INT
)
BEGIN
	DELETE FROM compras
    WHERE id_cliente = p_id_cliente;
    
	DELETE FROM clientes
    WHERE id_cliente = p_id_cliente;
END //

DELIMITER ;

DROP PROCEDURE eliminar_cliente;

CALL eliminar_cliente(1);

/*4 Obtener el saldo de un cliente

Crear un procedimiento llamado consultar_saldo que reciba el id_cliente y devuelva el saldo del cliente.

Parámetros:

    IN p_id_cliente — identificador del cliente (INT)
    OUT p_saldo — saldo del cliente (DECIMAL)

Observación: utilizar SELECT saldo INTO p_saldo FROM clientes WHERE ...
*/

DELIMITER //

CREATE PROCEDURE consultar_saldo
(
	IN p_id_cliente INT,
    OUT p_saldo DECIMAL (10,2)
)
BEGIN
	SELECT saldo INTO p_saldo
    FROM clientes
    WHERE id_cliente = p_id_cliente;
END //

DELIMITER ;

SET @saldo_cliente = 0;

CALL consultar_saldo(2, @saldo_cliente);

SELECT @saldo_cliente AS 'Saldo_Actual';

/*5 Incrementar el saldo de un cliente

Crear un procedimiento llamado incrementar_saldo_cliente que permita sumar una cantidad al saldo actual de un cliente.

Parámetros de entrada:

    p_id_cliente — identificador del cliente (INT)
    p_cantidad — cantidad a incrementar (DECIMAL)

*/

DELIMTIER //

CREATE PROCEDURE incrementar_saldo_cliente
(
	IN p_id_cliente INT,
    IN p_cantidad DECIMAL (10,2)
)
BEGIN
	DECLARE 
END //

DELIMITER ;