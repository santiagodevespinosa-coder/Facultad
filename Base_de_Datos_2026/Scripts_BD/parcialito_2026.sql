-- DROP DATABASE IF EXISTS parcialito_reservas_hotel;
-- CREATE DATABASE parcialito_reservas_hotel;
-- USE parcialito_reservas_hotel;

CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    correo VARCHAR(100) NOT NULL,
    ciudad VARCHAR(60) NOT NULL
);

CREATE TABLE habitaciones (
    id_habitacion INT PRIMARY KEY AUTO_INCREMENT,
    numero VARCHAR(10) NOT NULL,
    tipo VARCHAR(40) NOT NULL,
    piso INT NOT NULL,
    precio_noche DECIMAL(10,2) NOT NULL
);


CREATE TABLE servicios (
    id_servicio INT PRIMARY KEY AUTO_INCREMENT,
    nombre_servicio VARCHAR(80) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    costo DECIMAL(10,2) NOT NULL
);

CREATE TABLE reservas (
    id_reserva INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    id_habitacion INT NOT NULL,
    fecha_reserva DATE NOT NULL,
    fecha_ingreso DATE NOT NULL,
    fecha_salida DATE NOT NULL,
    estado VARCHAR(30) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_habitacion) REFERENCES habitaciones(id_habitacion)
);

CREATE TABLE reservas_servicios (
    id_reserva_servicio INT PRIMARY KEY AUTO_INCREMENT,
    id_reserva INT NOT NULL,
    id_servicio INT NOT NULL,
    cantidad INT NOT NULL,
    FOREIGN KEY (id_reserva) REFERENCES reservas(id_reserva),
    FOREIGN KEY (id_servicio) REFERENCES servicios(id_servicio)
);

INSERT INTO clientes (nombre, apellido, correo, ciudad) VALUES
('Juan', 'Perez', 'juan.perez@mail.com', 'Mar del Plata'),
('Maria', 'Gomez', 'maria.gomez@mail.com', 'Balcarce'),
('Lucia', 'Fernandez', 'lucia.fernandez@mail.com', 'Mar del Plata'),
('Carlos', 'Rivas', 'carlos.rivas@mail.com', 'Tandil'),
('Sofia', 'Martinez', 'sofia.martinez@mail.com', 'Necochea'),
('Diego', 'Lopez', 'diego.lopez@mail.com', 'Miramar'),
('Valentina', 'Suarez', 'valentina.suarez@mail.com', 'Mar del Plata'),
('Andres', 'Molina', 'andres.molina@mail.com', 'Pinamar');

INSERT INTO habitaciones (numero, tipo, piso, precio_noche) VALUES
('101', 'Individual', 1, 45000.00),
('102', 'Doble', 1, 68000.00),
('201', 'Doble Superior', 2, 85000.00),
('202', 'Familiar', 2, 120000.00),
('301', 'Suite', 3, 180000.00);

INSERT INTO servicios (nombre_servicio, categoria, costo) VALUES
('Desayuno buffet', 'Gastronomia', 12000.00),
('Spa relax', 'Bienestar', 30000.00),
('Traslado aeropuerto', 'Transporte', 25000.00),
('Cena especial', 'Gastronomia', 28000.00),
('Excursion costera', 'Turismo', 40000.00),
('Late check out', 'Hospedaje', 18000.00);


INSERT INTO reservas (id_cliente, id_habitacion, fecha_reserva, fecha_ingreso, fecha_salida, estado) VALUES
(1, 2, '2025-01-10', '2025-02-01', '2025-02-05', 'Confirmada'),
(2, 4, '2025-02-15', '2025-03-10', '2025-03-14', 'Confirmada'),
(3, 1, '2025-03-01', '2025-03-20', '2025-03-22', 'Cancelada'),
(4, 5, '2025-04-05', '2025-05-01', '2025-05-06', 'Confirmada'),
(1, 3, '2025-05-12', '2025-06-01', '2025-06-03', 'Pendiente'),
(5, 2, '2025-06-20', '2025-07-10', '2025-07-12', 'Confirmada'),
(6, 4, '2025-07-01', '2025-07-20', '2025-07-25', 'Confirmada'),
(2, 3, '2025-08-03', '2025-08-15', '2025-08-18', 'Cancelada'),
(7, 5, '2025-09-10', '2025-10-01', '2025-10-04', 'Confirmada'),
(4, 2, '2025-10-22', '2025-11-05', '2025-11-07', 'Confirmada'),
(3, 1, '2025-11-11', '2025-12-01', '2025-12-03', 'Confirmada'),
(6, 5, '2026-01-15', '2026-02-10', '2026-02-14', 'Confirmada');


INSERT INTO reservas_servicios (id_reserva, id_servicio, cantidad) VALUES
(1, 1, 4),
(1, 2, 1),
(2, 1, 4),
(2, 4, 2),
(4, 2, 2),
(4, 5, 2),
(5, 6, 1),
(6, 1, 2),
(6, 3, 1),
(7, 1, 5),
(7, 2, 1),
(9, 4, 2),
(9, 5, 1),
(10, 1, 2),
(11, 6, 1),
(12, 2, 1),
(12, 3, 1);

-- Ejercicio 1

-- Listar las reservas confirmadas realizadas durante el año 2025, mostrando apellido y nombre del cliente,
--  numero y tipo de habitacion, fecha de ingreso, fecha de salida y estado. 
-- Ordenar el resultado por fecha de ingreso de manera ascendente.

SELECT 
	cl.nombre,
    cl.apellido,
    h.numero,
    h.tipo,
    r.fecha_ingreso,
    r.fecha_salida,
    r.estado
FROM
	clientes AS cl INNER JOIN reservas AS r ON
    cl.id_cliente = r.id_cliente,
    
    habitaciones AS h INNER JOIN reservas AS r2 ON
    h.id_habitacion = r2.id_habitacion
ORDER BY
	r.fecha_ingreso ASC;
    
-- Ejercicio 2

-- Mostrar los servicios contratados en reservas cuya fecha de ingreso se encuentre entre el 01/07/2025 y el 31/10/2025. 
-- Mostrar apellido y nombre del cliente, nombre del servicio, categoria, cantidad y fecha de ingreso. 
-- Incluir solo los servicios cuyo nombre contenga la palabra 'Spa' o cuya categoria sea 'Gastronomia'.
    
SELECT 
	r.fecha_ingreso,
	cl.nombre,
	cl.apellido,
	s.nombre_servicio,
	s.categoria,
	rs.cantidad
FROM
        clientes AS cl INNER JOIN reservas AS r ON
        cl.id_cliente = r.id_cliente,
        
        servicios AS s INNER JOIN reservas_servicios AS rs ON
        s.id_servicio = rs.id_servicio
WHERE
	r.fecha_ingreso BETWEEN '01-07-2025' AND '31-10-2025' AND
    s.nombre_servicio LIKE 'Spa' OR s.categoria LIKE 'Gastronomia';
    
/*Ejercicio 3

Mostrar todos los clientes registrados, indicando apellido, nombre y cantidad de reservas realizadas. 
Incluir tambien a los clientes que no tengan reservas cargadas. 
Ordenar de mayor a menor segun la cantidad de reservas*/

SELECT
	cl.nombre,
    cl.apellido,
    rs.cantidad
FROM
	clientes AS cl INNER JOIN reservas AS r ON
    cl.id_cliente = r.id_cliente,
    
    reservas AS r2 INNER JOIN reservas_servicios AS rs ON
    r2.id_reserva = rs.id_reserva
ORDER BY
	rs.cantidad DESC;
    
/*Ejercicio 4

Mostrar las habitaciones que tengan mas de una reserva confirmada. Indicar numero de habitacion, tipo, 
cantidad de reservas confirmadas y promedio de noches reservadas. 
Para calcular las noches, utilizar la diferencia entre fecha_salida y fecha_ingreso.*/

SELECT
	r.estado,
	h.numero,
    h.tipo,
    AVG(rs.cantidad) AS promedio_noches_reservadas
FROM
	reservas AS r INNER JOIN habitaciones AS h ON
    r.id_reserva = h.id_habitacion,
    
    reservas AS r2 INNER JOIN reservas_servicios AS rs ON
    r2.id_reserva = rs.id_reserva
WHERE
   TIMEDIFF(r.fecha_salida, r.fecha_ingreso)
GROUP BY
	r.estado,
    h.numero,
    h.tipo;
   
/*Ejercicio 5
Mostrar por cada cliente la cantidad de reservas confirmadas realizadas durante el año 2025 y el total de noches reservadas. 
Incluir solo los clientes que tengan 2 o mas reservas confirmadas en ese año. 
Mostrar apellido, nombre, cantidad de reservas confirmadas y total de noches.
 Ordenar de mayor a menor segun el total de noches.*/
 
 SELECT
	cl.nombre,
    cl.apellido,
    r.estado,
	SUM(rs.cantidad) AS total_noches_reservadas
FROM
	clientes AS cl INNER JOIN reservas AS r ON
    cl.id_cliente = r.id_cliente,
    
    reservas AS r2 INNER JOIN reservas_servicios AS rs ON
    r2.id_reserva = rs.id_reserva
WHERE
	r.estado LIKE 'Confirmada' AND r.estado > 2
ORDER BY 
	rs.cantidad DESC;
    
/*Ejercicio 6

Listar los clientes que hayan realizado al menos una reserva confirmada. Mostrar apellido, nombre, correo y ciudad. 
Resolver obligatoriamente utilizando una subconsulta. 
No utilizar JOIN como estrategia principal de resolucion.*/

SELECT
	cl.apellido,
    cl.nombre,
    cl.correo,
    cl.ciudad
FROM
	clientes AS cl
WHERE cl.id_cliente IN
(
	SELECT 
		r.estado
	FROM
		reservas AS r JOIN clientes AS cl ON
        r.id_cliente = cl.id_cliente
	WHERE
		r.estado LIKE 'Confirmada'
);