-- CREATE DATABASE tp_udf_cte_2026;
-- USE tp_udf_cte_2026;

CREATE TABLE Departamentos (
departamento_id INT PRIMARY KEY AUTO_INCREMENT,
nombre_departamento VARCHAR(100) NOT NULL,
jefe_id INT DEFAULT NULL
);

CREATE TABLE Empleados (
empleado_id INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(100) NOT NULL,
departamento_id INT NOT NULL,
fecha_contratacion DATE NOT NULL,
salario DECIMAL(10, 2) NOT NULL,
FOREIGN KEY (departamento_id) REFERENCES Departamentos(departamento_id)
);

-- Relacion opcional: jefe_id apunta a empleado_id
ALTER TABLE Departamentos
ADD CONSTRAINT fk_jefe_id FOREIGN KEY (jefe_id) REFERENCES Empleados(empleado_id);

CREATE TABLE Clientes (
cliente_id INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(100) NOT NULL,
apellido VARCHAR(100) NOT NULL
);

CREATE TABLE Ventas (
venta_id INT PRIMARY KEY AUTO_INCREMENT,
cliente_id INT NOT NULL,
empleado_id INT NOT NULL,
fecha_venta DATE NOT NULL,
valor DECIMAL(10, 2) NOT NULL,
FOREIGN KEY (cliente_id) REFERENCES Clientes(cliente_id),
FOREIGN KEY (empleado_id) REFERENCES Empleados(empleado_id)
);

-- INSERTAR LOS DATOS A LAS TABLAS 

-- DEPARTAMENTOS
INSERT INTO Departamentos (departamento_id, nombre_departamento, jefe_id) VALUES
(1, 'Sistemas', NULL),
(2, 'Ventas', NULL),
(3, 'Administracion', NULL);

-- EMPLEADOS

INSERT INTO Empleados
(empleado_id, nombre, departamento_id, fecha_contratacion, salario) VALUES
(1, 'Ana Torres',     1, '2018-03-10', 6500.00),
(2, 'Bruno Diaz',     1, DATE_SUB(CURDATE(), INTERVAL 2 YEAR), 3500.00),
(3, 'Carla Gomez',    2, '2019-06-20', 7000.00),
(4, 'Diego Perez',    2, DATE_SUB(CURDATE(), INTERVAL 1 YEAR), 5000.00),
(5, 'Elena Ruiz',     3, '2017-01-15', 3000.00),
(6, 'Fabio Lopez',    3, DATE_SUB(CURDATE(), INTERVAL 6 MONTH), 2800.00);

UPDATE Departamentos SET jefe_id = 1 WHERE departamento_id = 1;
UPDATE Departamentos SET jefe_id = 3 WHERE departamento_id = 2;
UPDATE Departamentos SET jefe_id = 5 WHERE departamento_id = 3;

-- CLIENTES


INSERT INTO Clientes (cliente_id, nombre, apellido) VALUES
(1, 'Laura',  'Perez'),
(2, 'Martin', 'Gomez'),
(3, 'Ana',    'Lopez'),
(4, 'Ana',    'Lopez'),
(5, 'Pedro',  'Diaz'),
(6, 'Sofia',  'Ruiz');

-- VENTAS

INSERT INTO Ventas
(venta_id, cliente_id, empleado_id, fecha_venta, valor) VALUES
(1,  1, 3, DATE_SUB(CURDATE(), INTERVAL 2 DAY),  3200.00),
(2,  1, 3, DATE_SUB(CURDATE(), INTERVAL 7 DAY),  2800.00),
(3,  1, 4, DATE_SUB(CURDATE(), INTERVAL 12 DAY), 4100.00),
(4,  1, 4, DATE_SUB(CURDATE(), INTERVAL 20 DAY), 3500.00),
(5,  2, 3, DATE_SUB(CURDATE(), INTERVAL 3 DAY),   900.00),
(6,  2, 3, DATE_SUB(CURDATE(), INTERVAL 25 DAY), 1200.00),
(7,  3, 4, '2025-06-05', 4000.00),
(8,  4, 4, '2025-06-20', 2500.00),
(9,  6, 3, '2025-07-10',  750.00),
(10, 6, 3, '2025-07-18', 1600.00);

/*1. Obtener Nombre Completo del Cliente
• Crear una función que concatene el nombre y apellido de un cliente en un único texto.*/

DELIMITER //
CREATE FUNCTION nombre_completo(v_nombre VARCHAR(50), v_apellido VARCHAR(100))
RETURNS VARCHAR(150)
NOT DETERMINISTIC

BEGIN
	RETURN CONCAT(v_nombre, ' ', v_apellido);
END //

DELIMITER ;

SELECT nombre_completo('Juan', 'Perez') AS Nombre_Completo;

/*2. Calcular el Valor Promedio de Ventas por Cliente
• Diseñar una función que devuelva el promedio del valor de ventas para un cliente dado.*/

DELIMITER //

CREATE FUNCTION promedio_venta_cliente(v_id_cliente INT)
RETURNS DECIMAL(7,2)
NOT DETERMINISTIC
BEGIN
    DECLARE v_promedio DECIMAL(7,2);
    
    SELECT AVG(precio) INTO v_promedio
    FROM ventas
    WHERE id_cliente = v_id_cliente;
    
    RETURN v_promedio;
END //

DELIMITER ;

SELECT promedio_venta_cliente(20000);

/*3. Obtener la Antigüedad de un Empleado
• Crear una función que calcule la antigüedad de un empleado en años, basada en su fecha de
contratación.*/

DELIMITER //
CREATE FUNCTION antiguedad_empleado(p_empleado_id INT)
RETURNS INT
NOT DETERMINISTIC
BEGIN
	DECLARE v_antiguedad INT;
    
    SELECT TIMESTAMPDIFF(YEAR, fecha_contratacion, CURDATE()) INTO v_antiguedad
    FROM empleados
    WHERE empleado_id = p_empleado_id;
    
    RETURN v_antiguedad;
END //

DELIMITER ;

SELECT antiguedad_empleado(1) AS anios_antiguedad_empleado;

/*4. Calcular comisión de ventas
Crear una función que reciba el identificador de un cliente y 
devuelva una comisión equivalente al 10% del valor total de sus ventas.*/

DELIMITER //
CREATE FUNCTION calculo_comision_venta(v_cliente_id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
	DECLARE v_total_ventas DECIMAL(10,2);
    
    SELECT SUM(valor) INTO v_total_ventas
    FROM ventas
    WHERE cliente_id = v_cliente_id;
    
    RETURN v_total_ventas * 0.10;
    
END //
DELIMITER ;

SELECT calculo_comision_venta(1) AS comision_venta;

/*5. Obtener jefe de un departamento
Diseñar una función que reciba el identificador de un departamento y devuelva el nombre del empleado asignado como jefe. 
Si no existe un jefe asignado, devolver NULL.*/

DELIMITER // 

CREATE FUNCTION jefe_departamento(p_departamento_id INT)
RETURNS VARCHAR(150)
NOT DETERMINISTIC
READS SQL DATA
BEGIN
	DECLARE v_nombre_jefe VARCHAR(100);
    
    SELECT e.nombre INTO v_nombre_jefe
    FROM Departamentos AS d
    INNER JOIN Empleados AS e ON d.jefe_id = e.empleado_id
    WHERE d.departamento_id = p_departamento_id;
    
    RETURN v_nombre_jefe;
	
END //

DELIMITER ;

SELECT jefe_departamento(1) AS Jefe_Tesoreria;

/*6. Calcular total de ventas en un rango de fechas
Crear una función que reciba una fecha inicial y una fecha final y 
devuelva el valor total de las ventas comprendidas en ese rango, incluyendo ambas fechas.*/

DELIMITER //
CREATE FUNCTION total_ventas_x_fecha(p_fecha_inicial DATE, p_fecha_final DATE)
RETURNS DECIMAL (10,2)
NOT DETERMINISTIC
READS SQL DATA

BEGIN
	DECLARE v_total_ventas DECIMAL (10,2);
    
    SELECT SUM(valor) INTO v_total_ventas
    FROM Ventas
    WHERE fecha_venta BETWEEN p_fecha_inicial AND p_fecha_final;
    
    RETURN v_total_ventas;
END //

DELIMITER ;

SELECT total_ventas_x_fecha('2025-06-01', '2025-07-31') AS Total_Rango;

/*7. Calcular porcentaje de salario respecto al total del departamento
Diseñar una función que reciba el identificador de un empleado 
y calcule qué porcentaje representa su salario respecto de la suma de salarios de su departamento.*/

DELIMITER //

CREATE FUNCTION porcentaje_salario_x_dep(p_empleado_id INT)
RETURNS DECIMAL (10,2)
NOT DETERMINISTIC
READS SQL DATA

BEGIN
	DECLARE v_salario_empleado DECIMAL (10,2);
    DECLARE v_sum_salario_dep DECIMAL (10,2);
    DECLARE v_departamento_id INT;
    
    SELECT e.salario, e.departamento_id INTO v_salario_empleado, v_departamento_id
    FROM Empleados AS e
    WHERE e.empleado_id = p_empleado_id;
    
    SELECT SUM(salario) INTO v_sum_salario_dep
    FROM Empleados
    WHERE departamento_id = v_departamento_id;
    
    IF v_sum_salario_dep = 0
	OR v_sum_salario_dep IS NULL THEN
		RETURN 0.00;
	END IF;
    
    RETURN (v_salario_empleado * 100.00) / v_sum_salario_dep;
END //

DELIMITER ;

SELECT porcentaje_salario_x_dep(1) AS porcentaje_salario;

/*8.Determinar si un cliente no tiene ventas
Crear una función que reciba el identificador de un cliente y devuelva 1 si no tiene ventas registradas y 0 en caso contrario.*/

DELIMITER //
CREATE FUNCTION cliente_sin_ventas(p_cliente_id INT)
RETURNS INT
DETERMINISTIC
READS SQL DATA

BEGIN
	DECLARE v_cantidad INT;
    
    SELECT COUNT(*) INTO v_cantidad
    FROM Ventas
    WHERE cliente_id = p_cliente_id;
    
    IF v_cantidad = 0 THEN
		RETURN 1;
	ELSE
		RETURN 0;
	END IF;
END //

DELIMITER ;

SELECT cliente_sin_ventas(5) AS Cliente_Sin_Ventas;

/*9. Calcular número de ventas por cliente
Diseñar una función que reciba el identificador de un cliente 
y devuelva la cantidad total de ventas registradas para él.*/

DELIMITER //
CREATE FUNCTION ventas_x_cliente(p_cliente_id INT)
RETURNS INT
NOT DETERMINISTIC
READS SQL DATA

BEGIN
	DECLARE v_cantidad_ventas INT;
    
    SELECT COUNT(*) INTO v_cantidad_ventas
    FROM Ventas
    WHERE cliente_id = p_cliente_id;
    
    RETURN v_cantidad_ventas;
END //

DELIMITER ;

SELECT ventas_x_cliente(1) AS Total_Ventas_Cliente;

/*10. Obtener nombre del departamento de un empleado
Crear una función que reciba el identificador de un empleado 
y devuelva el nombre del departamento al que pertenece.*/

DELIMITER //
CREATE FUNCTION nombre_dep_empleado(p_empleado_id INT)
RETURNS VARCHAR (100)
NOT DETERMINISTIC
READS SQL DATA

BEGIN
	DECLARE v_nombre_dep VARCHAR(100);
    
    SELECT d.nombre_departamento INTO v_nombre_dep 
    FROM Departamentos AS d
    INNER JOIN Empleados AS e ON d.departamento_id = e.departamento_id
    WHERE e.empleado_id = p_empleado_id;
    
    RETURN v_nombre_dep;
END //

DELIMITER ;

SELECT nombre_dep_empleado(1) AS Departamento_Empleado;

-- EJERCICIOS CTE

/*1. Filtrar datos con CTE
Crear una CTE llamada VentasAltas que seleccione todas las ventas con un valor mayor a 1000. 
En la consulta principal, mostrar la cantidad de ventas 
y el valor promedio de las ventas contenidas en la CTE.*/

WITH VentasAltas AS (
    SELECT venta_id, cliente_id, empleado_id, fecha_venta, valor
    FROM Ventas
    WHERE valor > 1000
)
SELECT 
    COUNT(*) AS cantidad_ventas,
    AVG(valor) AS valor_promedio
FROM VentasAltas;

/*2. CTE con funciones de agregado
Crear una CTE llamada PromedioPorDepartamento que calcule el promedio de salarios por departamento.
 En la consulta principal, mostrar únicamente los departamentos cuyo salario promedio sea superior a 4000.*/
 
 WITH Promedio_por_departamento AS (
    SELECT 
        d.departamento_id,
        d.nombre_departamento,
        AVG(e.salario) AS salario_promedio
    FROM Departamentos d
    JOIN Empleados e ON d.departamento_id = e.departamento_id
    GROUP BY d.departamento_id, d.nombre_departamento
)
SELECT 
    nombre_departamento,
    salario_promedio
FROM Promedio_por_departamento
WHERE salario_promedio > 4000;

/*3.CTE para calcular diferencias entre fechas
Crear una CTE llamada AntiguedadEmpleados que calcule, mediante DATEDIFF(), 
la cantidad de días transcurridos desde la fecha de contratación de cada empleado hasta la fecha actual. 
En la consulta principal, mostrar los empleados con más de 1825 días de antigüedad (aproximadamente 5 años).*/

WITH AntiguedadEmpleados AS (
    SELECT 
        empleado_id,
        nombre,
        departamento_id,
        fecha_contratacion,
        salario,
        DATEDIFF(CURDATE(), fecha_contratacion) AS dias_antiguedad
    FROM Empleados
)
SELECT 
    nombre,
    fecha_contratacion,
    dias_antiguedad
FROM AntiguedadEmpleados
WHERE dias_antiguedad > 1825;

/*4.CTE para combinar varias tablas
Crear una CTE llamada VentasClientes que una las tablas Ventas y Clientes mediante cliente_id. 
En la consulta principal, mostrar los clientes que realizaron más de 3 compras durante los últimos 12 meses.*/

WITH VentasClientes AS (
    SELECT 
        c.cliente_id,
        c.nombre,
        c.apellido,
        v.venta_id,
        v.fecha_venta
    FROM Clientes c
    JOIN Ventas v ON c.cliente_id = v.cliente_id
    WHERE v.fecha_venta >= DATE_SUB(CURDATE(), INTERVAL 12 MONTH)
)
SELECT 
    nombre,
    apellido,
    COUNT(venta_id) AS total_compras
FROM VentasClientes
GROUP BY cliente_id, nombre, apellido
HAVING COUNT(venta_id) > 3;

/*5. CTE con ORDER BY y LIMIT
Crear una CTE llamada EmpleadosMejorPagos que seleccione los 10 empleados con los salarios más altos. 
Mostrar su nombre y salario en la consulta principal.*/

	WITH EmpleadosMejorPagos AS (
    SELECT nombre, salario
    FROM Empleados
    ORDER BY salario DESC
    LIMIT 10
)
SELECT 
    nombre,
    salario
FROM EmpleadosMejorPagos;

/*6. CTE con GROUP BY y HAVING
Crear una CTE llamada VentasPorMes que agrupe las ventas por año y mes utilizando YEAR() y MONTH(). 
En la consulta principal, mostrar únicamente los meses cuyo total de ventas sea superior a 5000.*/

WITH VentasPorMes AS (
    SELECT 
        YEAR(fecha_venta) AS anio,
        MONTH(fecha_venta) AS mes,
        SUM(valor) AS total_ventas
    FROM Ventas
    GROUP BY YEAR(fecha_venta), MONTH(fecha_venta)
)
SELECT 
    anio,
    mes,
    total_ventas
FROM VentasPorMes
WHERE total_ventas > 5000;

/*7. CTE para encontrar duplicados
Crear una CTE llamada ClientesDuplicados que detecte nombres y apellidos repetidos en la tabla Clientes. 
Mostrar en la consulta principal el nombre, el apellido y la cantidad de repeticiones.*/

WITH ClientesDuplicados AS (
    SELECT 
        nombre,
        apellido,
        COUNT(*) AS cantidad
    FROM Clientes
    GROUP BY nombre, apellido
    HAVING COUNT(*) > 1
)
SELECT 
    nombre,
    apellido,
    cantidad
FROM ClientesDuplicados;

/*8. CTE anidada
Crear una CTE llamada TotalVentasPorCliente que calcule el total vendido por cada cliente. 
Luego, definir una segunda CTE que seleccione únicamente los clientes cuyo total de ventas sea superior a 10000.*/

WITH TotalVentasPorCliente AS (
    SELECT 
        c.cliente_id,
        c.nombre,
        c.apellido,
        SUM(v.valor) AS total_vendido
    FROM Clientes c
    JOIN Ventas v ON c.cliente_id = v.cliente_id
    GROUP BY c.cliente_id, c.nombre, c.apellido
),
ClientesSuperiores AS (
    SELECT 
        nombre,
        apellido,
        total_vendido
    FROM TotalVentasPorCliente
    WHERE total_vendido > 10000
)
SELECT 
    nombre,
    apellido,
    total_vendido
FROM ClientesSuperiores;

/*9.CTE con JOIN y funciones de fecha
Crear una CTE llamada VentasUltimoMes que seleccione las ventas realizadas desde DATE_SUB(CURDATE(), INTERVAL 1 MONTH) 
hasta la fecha actual. 
Luego, unir el resultado con la tabla Clientes y mostrar el nombre del cliente, la fecha y el valor de cada venta.*/

WITH VentasUltimoMes AS (
    SELECT 
        cliente_id,
        fecha_venta,
        valor
    FROM Ventas
    WHERE fecha_venta BETWEEN DATE_SUB(CURDATE(), INTERVAL 1 MONTH) AND CURDATE()
)
SELECT 
    c.nombre,
    c.apellido,
    v.fecha_venta,
    v.valor
FROM VentasUltimoMes v
JOIN Clientes c ON v.cliente_id = c.cliente_id;