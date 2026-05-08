-- create database santiago;
-- use santiago;

CREATE TABLE alumnos
(
	id_alumno INT AUTO_INCREMENT PRIMARY KEY,
    nombre_alumno VARCHAR(50) NOT NULL,
    apellido_alumno VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    edad INT NOT NULL CHECK (edad >= 16),
    estado VARCHAR(50) DEFAULT 'activo',
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE cursos
(
	id_curso INT AUTO_INCREMENT PRIMARY KEY,
    nombre_curso VARCHAR(100) NOT NULL,
    descripcion TEXT,
    horas_semanales TINYINT UNSIGNED NOT NULL,
    cupo_maximo SMALLINT UNSIGNED DEFAULT 30
);

CREATE TABLE inscripciones
(
	id_inscripciones INT AUTO_INCREMENT PRIMARY KEY,
    id_alumno INT NOT NULL,
    id_curso INT NOT NULL,
    fecha_inscripcion DATE DEFAULT (CURRENT_DATE),
    nota_final DECIMAL (4,2),
    FOREIGN KEY (id_alumno) REFERENCES alumnos(id_alumno),
    FOREIGN KEY (id_curso) REFERENCES cursos(id_curso)
);

INSERT INTO alumnos (nombre_alumno, apellido_alumno, email, edad, estado) VALUES
('Mariano', 'Tamay', 'mariano01@gmail.com', '27', 'activo'),
('Santiago', 'Fernandez Espinosa', 'santi02@gmail.com', '21', 'activo'),
('Agustina', 'Barbaresi', 'mapache03@gmail.com', '22', 'activo'),
('Nicolas', 'Mendez', 'nicomendez04@gmail.com', '29', 'activo');

INSERT INTO cursos (nombre_curso, descripcion, horas_semanales, cupo_maximo) VALUES
('Algoritmos', 'aca programamos apps', '4', '16'),
('Base de Datos', 'aca aprendemos MySQL', '4', '16');

INSERT INTO inscripciones (id_alumno, id_curso, nota_final) VALUES
('1', '1', '7.00'),
('2', '1', '7.00'),
('3', '2', '9.00'),
('4', '2', '8.00');

SELECT
	*
FROM
	alumnos





