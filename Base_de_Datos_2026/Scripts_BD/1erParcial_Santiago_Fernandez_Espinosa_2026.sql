-- DROP DATABASE IF EXISTS parcial_cursos_pagos;
-- CREATE DATABASE parcial_cursos_pagos;
-- USE parcial_cursos_pagos;

CREATE TABLE alumnos (
    id_alumno INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    correo VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL
);

CREATE TABLE categorias (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nombre_categoria VARCHAR(80) NOT NULL,
    descripcion VARCHAR(150) NOT NULL
);

CREATE TABLE docentes (
    id_docente INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    especialidad VARCHAR(80) NOT NULL
);

CREATE TABLE sedes (
    id_sede INT PRIMARY KEY AUTO_INCREMENT,
    nombre_sede VARCHAR(80) NOT NULL,
    ciudad VARCHAR(60) NOT NULL,
    direccion VARCHAR(100) NOT NULL
);


CREATE TABLE modalidades (
    id_modalidad INT PRIMARY KEY AUTO_INCREMENT,
    nombre_modalidad VARCHAR(40) NOT NULL,
    descripcion VARCHAR(150) NOT NULL
);

CREATE TABLE cursos (
    id_curso INT PRIMARY KEY AUTO_INCREMENT,
    id_categoria INT NOT NULL,
    id_docente INT NOT NULL,
    id_sede INT NOT NULL,
    id_modalidad INT NOT NULL,
    nombre_curso VARCHAR(100) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    arancel DECIMAL(10,2) NOT NULL,
    cupo INT NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria),
    FOREIGN KEY (id_docente) REFERENCES docentes(id_docente),
    FOREIGN KEY (id_sede) REFERENCES sedes(id_sede),
    FOREIGN KEY (id_modalidad) REFERENCES modalidades(id_modalidad)
);

CREATE TABLE inscripciones (
    id_inscripcion INT PRIMARY KEY AUTO_INCREMENT,
    id_alumno INT NOT NULL,
    id_curso INT NOT NULL,
    fecha_inscripcion DATE NOT NULL,
    estado VARCHAR(30) NOT NULL,
    FOREIGN KEY (id_alumno) REFERENCES alumnos(id_alumno),
    FOREIGN KEY (id_curso) REFERENCES cursos(id_curso)
);


CREATE TABLE pagos (
    id_pago INT PRIMARY KEY AUTO_INCREMENT,
    id_inscripcion INT NOT NULL,
    fecha_pago DATE NOT NULL,
    medio_pago VARCHAR(40) NOT NULL,
    importe DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_inscripcion) REFERENCES inscripciones(id_inscripcion)
);

INSERT INTO alumnos (nombre, apellido, correo, telefono) VALUES
('Ana', 'Gomez', 'ana.gomez@mail.com', '2234561001'),
('Juan', 'Perez', 'juan.perez@mail.com', '2234561002'),
('Carla', 'Lopez', 'carla.lopez@mail.com', '2234561003'),
('Bruno', 'Martinez', 'bruno.martinez@mail.com', '2234561004'),
('Lucia', 'Fernandez', 'lucia.fernandez@mail.com', '2234561005'),
('Miguel', 'Sosa', 'miguel.sosa@mail.com', '2234561006'),
('Paula', 'Ramirez', 'paula.ramirez@mail.com', '2234561007'),
('Diego', 'Torres', 'diego.torres@mail.com', '2234561008'),
('Maria', 'Acosta', 'maria.acosta@mail.com', '2234561009'),
('Julia', 'Molina', 'julia.molina@mail.com', '2234561010'),
('Nicolas', 'Castro', 'nicolas.castro@mail.com', '2234561011');

INSERT INTO categorias (nombre_categoria, descripcion) VALUES
('Programacion', 'Cursos vinculados al desarrollo de software'),
('Bases de Datos', 'Cursos sobre modelado, consultas y administracion de datos'),
('Inteligencia Artificial', 'Cursos sobre herramientas y modelos de IA'),
('Redes', 'Cursos sobre conectividad e infraestructura'),
('Diseno Web', 'Cursos sobre sitios y aplicaciones web');

INSERT INTO docentes (nombre, apellido, especialidad) VALUES
('Mariano', 'Suarez', 'Programacion'),
('Laura', 'Benitez', 'Bases de Datos'),
('Santiago', 'Rivas', 'Inteligencia Artificial'),
('Valeria', 'Castro', 'Redes'),
('Pablo', 'Herrera', 'Diseno Web');

INSERT INTO sedes (nombre_sede, ciudad, direccion) VALUES
('Sede Centro', 'Mar del Plata', 'Av. Luro 2500'),
('Sede Norte', 'Mar del Plata', 'Constitucion 4800'),
('Sede Virtual', 'Online', 'Campus virtual'),
('Sede Sur', 'Miramar', 'Calle 21 1450');

INSERT INTO modalidades (nombre_modalidad, descripcion) VALUES
('Presencial', 'Clases dictadas en sede fisica'),
('Virtual', 'Clases dictadas por campus virtual'),
('Mixta', 'Clases presenciales y virtuales');

INSERT INTO cursos (id_categoria, id_docente, id_sede, id_modalidad, nombre_curso, fecha_inicio, fecha_fin, arancel, cupo) VALUES
(1, 1, 1, 1, 'Programacion Inicial con Python', '2025-03-10', '2025-06-10', 85000.00, 30),
(1, 1, 2, 3, 'Programacion Web con JavaScript', '2025-04-01', '2025-07-01', 98000.00, 25),
(2, 2, 1, 1, 'Base de Datos SQL', '2025-03-20', '2025-06-20', 92000.00, 30),
(2, 2, 3, 2, 'Modelado de Datos', '2025-05-05', '2025-08-05', 88000.00, 35),
(2, 2, 3, 2, 'Consultas Avanzadas de Datos', '2025-08-10', '2025-11-10', 110000.00, 25),
(3, 3, 3, 2, 'Introduccion a la Inteligencia Artificial', '2025-04-15', '2025-07-15', 120000.00, 30),
(3, 3, 3, 2, 'IA Aplicada con Prompts', '2025-09-01', '2025-11-30', 135000.00, 25),
(4, 4, 2, 1, 'Redes Informaticas Inicial', '2025-06-01', '2025-09-01', 76000.00, 20),
(5, 5, 1, 3, 'Diseno Web Responsive', '2025-07-10', '2025-10-10', 95000.00, 25),
(5, 5, 4, 1, 'HTML y CSS desde Cero', '2026-03-01', '2026-06-01', 70000.00, 20);

INSERT INTO inscripciones (id_alumno, id_curso, fecha_inscripcion, estado) VALUES
(1, 3, '2025-03-01', 'Activa'),
(1, 5, '2025-08-01', 'Activa'),
(2, 1, '2025-02-20', 'Activa'),
(2, 3, '2025-03-15', 'Activa'),
(3, 4, '2025-04-25', 'Activa'),
(3, 6, '2025-04-10', 'Activa'),
(4, 2, '2025-03-28', 'Activa'),
(4, 9, '2025-07-01', 'Activa'),
(5, 5, '2025-08-03', 'Activa'),
(5, 7, '2025-08-20', 'Activa'),
(6, 8, '2025-05-20', 'Activa'),
(7, 4, '2025-05-01', 'Baja'),
(8, 6, '2025-04-12', 'Activa'),
(9, 9, '2025-07-05', 'Activa'),
(10, 10, '2026-02-15', 'Activa');

INSERT INTO pagos (id_inscripcion, fecha_pago, medio_pago, importe) VALUES
(1, '2025-03-05', 'Transferencia', 92000.00),
(2, '2025-08-05', 'Tarjeta', 110000.00),
(3, '2025-02-25', 'Efectivo', 85000.00),
(4, '2025-03-20', 'Transferencia', 92000.00),
(5, '2025-05-01', 'Tarjeta', 88000.00),
(6, '2025-04-18', 'Transferencia', 120000.00),
(7, '2025-04-03', 'Efectivo', 98000.00),
(8, '2025-07-05', 'Tarjeta', 95000.00),
(9, '2025-08-08', 'Transferencia', 110000.00),
(10, '2025-09-05', 'Tarjeta', 135000.00),
(11, '2025-06-05', 'Efectivo', 76000.00),
(13, '2025-04-20', 'Transferencia', 120000.00),
(14, '2025-07-10', 'Tarjeta', 95000.00),
(15, '2026-02-20', 'Transferencia', 70000.00);

/*Ejercicio 1
Listar, sin repetir, los alumnos que se hayan inscripto durante el anio 2025 en cursos cuyo nombre contenga la palabra "Datos". 
Mostrar apellido, nombre, correo y telefono del alumno. Ordenar alfabeticamente por apellido y nombre.
*/

SELECT DISTINCT 
	a.apellido,
    a.nombre,
    a.correo,
    a.telefono,
    i.fecha_inscripcion    
FROM
	alumnos AS a INNER JOIN inscripciones AS i ON
    a.id_alumno = i.id_alumno,
    
    inscripciones AS i1 INNER JOIN cursos AS c ON
    i1.id_curso = c.id_curso
WHERE
	i.fecha_inscripcion BETWEEN '2025-01-01' AND '2025-12-01' AND
    c.nombre_curso LIKE '%Datos%'
ORDER BY
	a.apellido,
    a.nombre;
	
/*Ejercicio 2
Mostrar por cada categoria de curso la cantidad de cursos registrados y el arancel promedio. 
Incluir solamente las categorias que tengan 2 o mas cursos cargados. Mostrar nombre de la categoria, cantidad de cursos y
promedio de arancel. Ordenar de mayor a menor segun la cantidad de cursos.  
*/

SELECT
	SUM(c.id_curso) AS cantidad_cursos,
    AVG(c.arancel) AS promedio_arancel,
    cat.nombre_categoria
FROM
	cursos AS c INNER JOIN categorias AS cat ON
    c.id_curso = cat.id_categoria
WHERE
	c.cupo > 2
GROUP BY
	cat.nombre_categoria;
    
/*Ejercicio 3
Mostrar el total recaudado por cada medio de pago entre el 01/04/2025 y el 31/08/2025. 
Mostrar medio de pago, cantidad de pagos, cantidad de alumnos distintos que pagaron y total recaudado. 
Ordenar de mayor a menor segun el total recaudado.
*/

SELECT
	SUM(p.importe) AS total_recaudado,
    COUNT(p.id_pago) AS cant_pagos,
    SUM(p.id_inscripcion) AS cant_alumnos_pagos, 
    p.medio_pago
FROM
	pagos AS p INNER JOIN inscripciones AS i ON
    p.id_inscripcion = i.id_inscripcion
WHERE
	p.fecha_pago BETWEEN '2025-04-01' AND '2025-08-31'
GROUP BY
	p.medio_pago;

/*Ejercicio 4
Mostrar todos los cursos, indicando nombre del curso, categoria, modalidad y cantidad de alumnos inscriptos. 
Incluir tambien los cursos que no tengan inscripciones registradas. Ordenar de mayor a menor segun la cantidad de inscriptos.
*/

SELECT
	c.nombre_curso,
    cat.nombre_categoria,
    m.nombre_modalidad,
    COUNT(i.id_inscripcion) AS cant_alumnos_inscriptos
FROM
    categorias AS cat INNER JOIN cursos AS c ON
    cat.id_categoria = c.id_categoria,
    
    modalidades AS m INNER JOIN cursos AS c1 ON
    m.id_modalidad = c1.id_modalidad,
    
    inscripciones AS i RIGHT JOIN cursos AS c2 ON
    i.id_curso = c2.id_curso
GROUP BY
	c.nombre_curso,
    cat.nombre_categoria,
	m.nombre_modalidad;

/*
Ejercicio 5
Listar los alumnos que esten inscriptos en al menos un curso de modalidad "Virtual".
 Mostrar apellido, nombre, correo y telefono.
Resolver obligatoriamente utilizando subconsultas en el WHERE.
 No utilizar JOIN como estrategia principal de resolucion.
*/

SELECT
	a.apellido,
    a.nombre,
    a.correo,
    a.telefono
FROM
	alumnos AS a
    
WHERE id_alumno IN(
	SELECT
		i.id_alumno
	FROM
		inscripciones AS i
	WHERE
		id_curso IN(
			SELECT
				c.id_curso
			FROM
				cursos AS c
			WHERE 
				id_modalidad = (
					SELECT
						m.id_modalidad
					FROM
						modalidades AS m
					WHERE
						m.nombre_modalidad = 'Virtual'
                )
        )
);

/*Ejercicio 6
Mostrar todos los alumnos junto con la fecha de su ultima inscripcion registrada. 
Si un alumno no tiene inscripciones, debe mostrarse igualmente con valor NULL en la fecha de ultima inscripcion.
Resolver obligatoriamente utilizando una subconsulta correlacionada en el SELECT. 
No utilizar JOIN como estrategia principal de resolucion.
*/