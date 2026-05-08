-- CREATE DATABASE ejemplojoins;
-- use ejemplojoins;

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

CREATE TABLE materiaxprofesor
(
	id_materiasxprofesor INT AUTO_INCREMENT PRIMARY KEY,
    descripcion LONGTEXT,
    idmat INT NOT NULL,
    idprof INT NOT NULL,
    FOREIGN KEY (idmat) REFERENCES materia(idmat) ON DELETE RESTRICT,
    FOREIGN KEY (idprof) REFERENCES profesores(idprof) ON DELETE RESTRICT
);

-- Insert Profesores
INSERT INTO profesores (nombre, apellido, email) VALUES
('Juan', 'Pérez', 'juan.perez@escuela.edu'),
('María', 'Gómez', 'maria.gomez@escuela.edu'),
('Carlos', 'López', 'carlos.lopez@escuela.edu'),
('Ana', 'Martínez', 'ana.martinez@escuela.edu'); 

-- Insert Materias
INSERT INTO materia (nombre_materia, creditos, idprof) VALUES
-- Profesor Juan Pérez (idprof = 1)
('Matemáticas I', 4, 1),
('Física General', 4, 1),
('Programación Básica', 3, 1),
('Literatura Universal', 3, 2),
('Historia del Arte', 2, 2),
('Inglés Técnico', 3, 2),
('Química Orgánica', 4, 3),
('Biología Celular', 3, 3);


-- Select Profesores
SELECT 
	*
FROM
	profesores;

-- Select Materias
SELECT
	*
FROM
	materia;

-- Where
SELECT
	p.apellido, p.nombre,
    m.nombre_materia, m.creditos
FROM
	profesores as p,
    materia as m
WHERE
	m.idprof = p.idprof
ORDER BY
	p.apellido, p.nombre DESC;
    
-- INNER JOIN
SELECT
	p.apellido, p.nombre,
    m.nombre_materia, m.creditos
FROM
	profesores as p INNER JOIN  materia as m 
    ON p.idprof = m.idprof
ORDER BY
	p.apellido, p.nombre;
    
-- Left Join
SELECT
	p.apellido, p.nombre,
    m.nombre_materia, m.creditos
FROM
	profesores as p LEFT JOIN materia as m
    ON p.idprof = m.idprof
ORDER BY
	p.apellido, p.nombre;

    