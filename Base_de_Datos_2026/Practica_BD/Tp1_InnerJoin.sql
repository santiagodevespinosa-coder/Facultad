-- CREATE DATABASE tp1Innerjoin;
-- USE tp1Innerjoin;

-- Tabla de profesores
CREATE TABLE profesores (
    idprof INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);	

-- Tabla de materias
CREATE TABLE materia (
    idmat INT AUTO_INCREMENT PRIMARY KEY,
    nombre_materia VARCHAR(100) NOT NULL,
    creditos TINYINT UNSIGNED NOT NULL,
    idprof INT NOT NULL,
    FOREIGN KEY (idprof) REFERENCES profesores(idprof) ON DELETE RESTRICT
);

INSERT INTO profesores (nombre, apellido, email) VALUES
('Juan', 'Pérez', 'juan.perez@escuela.edu'),
('María', 'Gómez', 'maria.gomez@escuela.edu'),
('Carlos', 'López', 'carlos.lopez@escuela.edu'),
('Ana', 'Martínez', 'ana.martinez@escuela.edu');

INSERT INTO profesores(nombre, apellido, email) VALUES
('Jose', 'Miccio', 'josemiccio@gmail.com');

INSERT INTO materia (nombre_materia, creditos, idprof) VALUES
('Matemáticas I', 4, 1),
('Física General', 4, 1),
('Programación Básica', 3, 1),
('Literatura Universal', 3, 2),
('Historia del Arte', 2, 2),
('Inglés Técnico', 3, 2),
('Química Orgánica', 4, 3),
('Biología Celular', 3, 3);

-- NUEVA TABLA: estudiantes
CREATE TABLE estudiantes (
    idest INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

-- NUEVA TABLA: inscripciones
CREATE TABLE inscripciones (
    idinsc INT AUTO_INCREMENT PRIMARY KEY,
    idest INT NOT NULL,
    idmat INT NOT NULL,
    fecha_inscripcion DATE NOT NULL,
    calificacion DECIMAL(3,1) CHECK (calificacion BETWEEN 0 AND 10),
    FOREIGN KEY (idest) REFERENCES estudiantes(idest) ON DELETE CASCADE,
    FOREIGN KEY (idmat) REFERENCES materia(idmat) ON DELETE RESTRICT
);

INSERT INTO estudiantes (nombre, apellido, fecha_nacimiento, email) VALUES
('Luis', 'Fernández', '2005-03-12', 'luis.fernandez@estudiante.edu'),
('Camila', 'Rojas', '2006-07-24', 'camila.rojas@estudiante.edu'),
('Sofía', 'Mendoza', '2004-11-05', 'sofia.mendoza@estudiante.edu'),
('Mateo', 'Silva', '2005-09-18', 'mateo.silva@estudiante.edu');

INSERT INTO estudiantes (nombre, apellido, fecha_nacimiento, email) VALUES
('Julieta', 'Rey', '2004-08-30', 'julietarey@gmail.com');

INSERT INTO inscripciones (idest, idmat, fecha_inscripcion, calificacion) VALUES
(1, 1, '2025-02-10', 8.5),
(1, 2, '2025-02-12', 7.0),
(1, 6, '2025-02-15', 9.2),
(2, 4, '2025-02-11', 6.5),
(2, 5, '2025-02-14', 9.0),
(3, 3, '2025-02-09', 9.8),
(3, 7, '2025-02-13', 8.0),
(3, 8, '2025-02-16', 7.5),
(4, 2, '2025-02-10', 5.0),
(4, 3, '2025-02-12', 6.0);

/*Ejercicio 1
Mostrar nombre y apellido de todos los profesores ordenados alfabéticamente por apellido.*/

SELECT
	p.nombre, p.apellido
FROM
	profesores as p 
ORDER BY p.nombre, p.apellido;

/*Ejercicio 2
Listar las materias con más de 3 créditos. Mostrar nombre_materia y creditos.*/

SELECT
	m.nombre_materia, m.creditos
FROM
	materia as m
WHERE
	creditos > 3;
    
/*Ejercicio 3
Obtener los estudiantes nacidos después del 1 de enero de 2005. 
Mostrar nombre, apellido y fecha_nacimiento, ordenados del más joven al más viejo (fecha descendente)*/    

SELECT
	e.nombre, e.apellido, e.fecha_nacimiento
FROM
	estudiantes as e
WHERE
	e.fecha_nacimiento > 2005/01/01
ORDER BY
	 e.fecha_nacimiento DESC;

/*Ejercicio 4 (INNER JOIN)
Mostrar el nombre de cada materia junto con el nombre y apellido de su profesor.*/

SELECT
	m.nombre_materia, p.nombre, p.apellido
FROM
	materia as m INNER JOIN profesores as p 
    ON  m.idprof = p.idprof 
ORDER BY
	p.nombre, p.apellido;

/*Ejercicio 5 (LEFT JOIN)
Listar todos los estudiantes y, si están inscriptos en alguna materia, mostrar el idmat y la fecha_inscripcion. 
Los que no tengan inscripciones deben aparecer igual (con NULL en esas columnas)*/

SELECT
	e.nombre, 
    e.apellido, 
    insc.idmat, 
    insc.fecha_inscripcion
FROM
	estudiantes as e LEFT JOIN inscripciones as insc
    ON e.idest = insc.idest;

/*Ejercicio 6 (RIGHT JOIN puro)
Mostrar todas las materias y, para cada una, el idest del estudiante que se inscribió (si hay alguno). 
Usar RIGHT JOIN entre inscripciones y materia.*/

SELECT
	m.nombre_materia, 
    m.idmat,
    insc.idest,
    insc.fecha_inscripcion
FROM
	inscripciones as insc RIGHT JOIN materia as m ON
    insc.idmat = m.idmat;
    
 /*Ejercicio 7
Encontrar los estudiantes cuyo nombre comience con "M" o termine con "o". Mostrar nombre y apellido.*/ 

SELECT
	e.nombre,
    e.apellido
FROM
	estudiantes as e
WHERE nombre LIKE 'M%' OR '%o';

/*Ejercicio 8
Seleccionar las inscripciones realizadas entre el 10 y el 15 de febrero de 2025 (inclusive). 
Mostrar idest, idmat y fecha_inscripcion. Usar BETWEEN*/

SELECT
	insc.idest,
    insc.idmat,
    insc.fecha_inscripcion
FROM
	inscripciones as insc
WHERE insc.fecha_inscripcion BETWEEN '2025-02-10' AND '2025-02-15';

/*Ejercicio 9
Listar los estudiantes que cumplen años en el mes de marzo (sin importar el año). 
Mostrar nombre, apellido y fecha_nacimiento. Usar MONTH().*/

SELECT
	e.nombre,
    e.apellido,
    e.fecha_nacimiento
FROM
	estudiantes as e
WHERE MONTH(e.fecha_nacimiento) = 3;

-- Hacer ejercicio 10

/*Ejercicio 10
Mostrar nombre_materia, creditos, y el nombre y apellido del profesor, 
solo para materias con creditos > 3. Ordenar por creditos descendente*/

SELECT
	m.nombre_materia,
    m.creditos,
    p.nombre,
    p.apellido
FROM
	materia as m,
    profesores as p
WHERE
	m.creditos > 3
ORDER BY
	m.creditos DESC;

/*Ejercicio 11
Listar los estudiantes cuyo nombre contenga la letra 'a' (usando LIKE)
 y que tengan inscripciones con fecha anterior al 14 de febrero de 2025. 
 Mostrar nombre del estudiante, nombre_materia y fecha_inscripcion. 
(Se necesitan JOIN entre estudiantes, inscripciones y materia).*/

SELECT
	e.nombre,
    e.apellido,
    m.nombre_materia,
    insc.fecha_inscripcion
FROM
	estudiantes as e INNER JOIN inscripciones as insc
    ON e.idest = insc.idest,
    
    materia as m INNER JOIN inscripciones as i
    ON m.idmat = i.idmat
WHERE
	e.nombre LIKE '%a%' AND insc.fecha_inscripcion < '2025-02-14';