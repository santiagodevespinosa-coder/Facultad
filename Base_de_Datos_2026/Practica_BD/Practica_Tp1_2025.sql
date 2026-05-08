/*Crea la base de datos TP1070524. 
o Dentro de esa base de datos, crea una tabla llamada Usuarios con los 
siguientes campos:  
▪ ID (INT, clave primaria, autoincremental) 
▪ Nombre (VARCHAR(50), no permite nulos) 
▪ Edad (INT, con una restricción para que solo permita edades mayores 
que 0) 
▪ CorreoElectronico (VARCHAR(100), debe ser único) 
▪ FechaRegistro (TIMESTAMP, con valor por defecto la fecha y hora 
actual)*/

-- Ejercicio 1
-- CREATE DATABASE tp1_2025;
-- use tp1_2025;

CREATE TABLE usuario
(
	id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50),
    edad INT CHECK (edad > 0),
    email VARCHAR(100) NOT NULL UNIQUE,
    fecha_registro TIMESTAMP DEFAULT NOW()
);

-- Ejercicio 2
INSERT INTO usuario(nombre, edad, email) VALUES
('Lionel', 22, 'lionelgoat@gmail.com'),
('Santiago', 21, 'santiago04@gmail.com'),
('Carmen', 24, 'carmencita1234@gmail.com'),
('Agustina', 22, 'agustina03@gmail.com'),
('Rodrigo', 27, 'rodrigo@gmail.com'),
('Ana', 25, 'ana05@gmail.com');


-- Ejercicio 3
UPDATE usuario SET edad = 23 WHERE id_usuario = 2;

-- Ejercicio 4
DELETE FROM usuario WHERE email = 'ana05@gmail.com';

SELECT
	*
FROM usuario;

-- Ejercicio 5

SELECT
	nombre, edad, email
FROM
	usuario
WHERE edad > 25;

-- Ejercicio 5 Parte 2

SELECT
	u.nombre, u.edad, u.email
FROM
	usuario as u
WHERE nombre LIKE'A%';

-- Ejercicio 5 Parte 3

SELECT
	u.nombre, u.edad, u.email
FROM
	usuario as u
WHERE email NOT LIKE 'l%';

-- Ejercicio 6

SELECT
	*
FROM
	usuario
ORDER BY nombre ASC;

-- Ejercicio 6 Parte 2

SELECT
	*
FROM
	usuario
WHERE edad BETWEEN 20 AND 30
ORDER BY edad DESC;