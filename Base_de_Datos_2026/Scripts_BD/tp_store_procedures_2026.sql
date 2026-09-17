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

CALL actualizar_nombre_cliente(5, 'Ezequiel');

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

CALL consultar_saldo(4, @mi_saldo);

SELECT @mi_saldo AS saldo_consultado;

/*5 Incrementar el saldo de un cliente

Crear un procedimiento llamado incrementar_saldo_cliente que permita sumar una cantidad al saldo actual de un cliente.

Parámetros de entrada:

    p_id_cliente — identificador del cliente (INT)
    p_cantidad — cantidad a incrementar (DECIMAL)

*/

DELIMITER //

CREATE PROCEDURE incrementar_saldo_cliente
(
	IN p_id_cliente INT,
    IN p_cantidad DECIMAL (10,2)
)
BEGIN
	UPDATE clientes
    SET saldo = saldo + p_cantidad
    WHERE id_cliente = p_id_cliente;
END //

DELIMITER ;

DROP PROCEDURE incrementar_saldo_cliente;

CALL incrementar_saldo_cliente(4, 10000);

SELECT * FROM clientes;

/*6 Transferir saldo entre clientes

Crear un procedimiento llamado transferir_saldo que permita transferir un saldo de un cliente a otro.

Parámetros de entrada:

    p_origen_id — ID del cliente que transfiere (INT)
    p_destino_id — ID del cliente que recibe (INT)
    p_monto — monto a transferir (DECIMAL)

Requisito: controlar que el saldo del cliente origen sea suficiente para realizar la transferencia.
*/

DELIMITER //
CREATE PROCEDURE transferir_saldo
(
	IN p_origen_id INT,
    IN p_destino_id INT,
    IN p_monto DECIMAL (10,2)
)
BEGIN
	DECLARE v_saldo_origen DECIMAL (10,2);

    SELECT saldo INTO v_saldo_origen
    FROM clientes
    WHERE id_cliente = p_origen_id;
    
    IF v_saldo_origen >= p_monto THEN
		
        UPDATE clientes
        SET saldo = saldo - p_monto
        WHERE id_cliente = p_origen_id;
        
        UPDATE clientes
        SET saldo = saldo + p_monto
        WHERE id_cliente = p_origen_id;
        
    END IF;
END //
DELIMITER ;

DROP PROCEDURE transferir_saldo;

CALL transferir_saldo(4,3, 5000);

SELECT * FROM clientes
WHERE id_cliente IN (4,3);

/*7 Consultar clientes por rango de saldo

Crear un procedimiento llamado consultar_clientes_por_saldo que devuelva todos los clientes cuyo saldo se encuentre entre dos valores.

Parámetros de entrada:

    p_saldo_min — saldo mínimo (DECIMAL)
    p_saldo_max — saldo máximo (DECIMAL)

Observación: utilizar la cláusula BETWEEN en la condición WHERE.
*/

DELIMITER //

CREATE PROCEDURE consultar_clientes_por_saldo
(
	IN p_saldo_min DECIMAL (10,2),
    IN p_saldo_max DECIMAL (10,2)
)
BEGIN
	SELECT *
    FROM clientes
    WHERE saldo BETWEEN p_saldo_min AND p_saldo_max;
END //

DELIMITER ;

CALL consultar_clientes_por_saldo(1000, 10000);

/*8 Registrar una compra

Crear un procedimiento llamado registrar_compra que permita registrar una compra hecha por un cliente.

Parámetros de entrada:

    p_id_cliente — identificador del cliente (INT)
    p_monto — monto de la compra (DECIMAL)

Acciones a realizar:

    Insertar el registro en la tabla compras (utilizar CURDATE() para la fecha)
    Actualizar el saldo del cliente restando el monto de la compra

Observación: utilizar LAST_INSERT_ID() para obtener el ID de la compra recién creada y mostrarlo como resultado.
*/

DELIMITER //
CREATE PROCEDURE registrar_compra
(
	IN p_id_cliente INT,
    IN p_monto DECIMAL (10,2)
)
BEGIN
	
    DECLARE v_nuevo_id INT;
	-- Insercion nuevo registro en la tabla de compras
	INSERT INTO compras (id_compra, fecha, monto)
    VALUES(p_id_cliente, CURDATE(), p_monto);
    
    -- Selecciono el ultimo ID de la ultima compra registrada
    SELECT LAST_INSERT_ID() AS ultima_compra_registrada;
    
    -- Actualizacion de saldo del cliente
    
    UPDATE clientes
    SET saldo = saldo - p_monto
    WHERE id_cliente = p_id_cliente;
    
END //
DELIMITER ;

CALL registrar_compra(3, 300);

SELECT * FROM clientes;

/*9 Listar clientes con filtros avanzados

Crear un procedimiento llamado listar_clientes_avanzado que permita listar clientes según varios filtros opcionales.

Parámetros de entrada (todos opcionales):

    p_nombre — filtro por nombre (utilizar LIKE) — si es NULL, no filtrar
    p_saldo_min — saldo mínimo — si es NULL, no filtrar
    p_saldo_max — saldo máximo — si es NULL, no filtrar
    p_fecha_desde — fecha mínima de última compra — si es NULL, no filtrar

Consideraciones:

    Para el filtro por nombre, utilizar LIKE CONCAT('%', p_nombre, '%')
    Para el filtro por saldo, utilizar BETWEEN o condiciones con >= y <=
    Para el filtro por fecha, considerar la fecha de la última compra de cada cliente

Nota: este ejercicio combina varios conceptos. 
Construir la consulta de manera que los filtros se apliquen solo cuando el parámetro no sea NULL.
*/

DELIMITER //
CREATE PROCEDURE listar_clientes_avanzado
(
	IN p_nombre VARCHAR(150),
    IN p_saldo_min DECIMAL (10,2),
    IN p_saldo_max DECIMAL (10,2),
    IN p_fecha_desde DECIMAL (10,2)
)
BEGIN
	SELECT nombre
    
END //
DELIMITER ;