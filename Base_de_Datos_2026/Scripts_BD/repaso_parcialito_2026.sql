-- CREATE DATABASE IF NOT EXISTS fauna_marina;
-- USE fauna_marina;

-- Tablas
CREATE TABLE especies (
    id_especie INT AUTO_INCREMENT PRIMARY KEY,
    nombre_comun VARCHAR(100) NOT NULL,
    nombre_cientifico VARCHAR(150) NOT NULL,
    nivel_riesgo VARCHAR(30) NOT NULL
);

CREATE TABLE centros (
    id_centro INT AUTO_INCREMENT PRIMARY KEY,
    nombre_centro VARCHAR(120) NOT NULL,
    ciudad VARCHAR(100) NOT NULL,
    capacidad_animales INT NOT NULL
);

CREATE TABLE animales_rescatados (
    id_animal INT AUTO_INCREMENT PRIMARY KEY,
    id_especie INT NOT NULL,
    id_centro INT NOT NULL,
    fecha_rescate DATE NOT NULL,
    peso_ingreso_kg DECIMAL(6,2) NOT NULL,
    estado_ingreso VARCHAR(100) NOT NULL,
    CONSTRAINT fk_especie FOREIGN KEY (id_especie) REFERENCES especies(id_especie),
    CONSTRAINT fk_centro FOREIGN KEY (id_centro) REFERENCES centros(id_centro)
);

CREATE TABLE tratamientos (
    id_tratamiento INT AUTO_INCREMENT PRIMARY KEY,
    id_animal INT NOT NULL,
    tipo_tratamiento VARCHAR(100) NOT NULL,
    costo_estimado DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_animal FOREIGN KEY (id_animal) REFERENCES animales_rescatados(id_animal)
);

-- Inserts básicos para probar
INSERT INTO especies (nombre_comun, nombre_cientifico, nivel_riesgo) VALUES 
('Tortuga verde', 'Chelonia mydas', 'Alto'), ('Pingüino', 'Spheniscus', 'Medio');

INSERT INTO centros (nombre_centro, ciudad, capacidad_animales) VALUES 
('Centro Costero', 'Mar del Plata', 40), ('Fundación Azul', 'Puerto Madryn', 35);

INSERT INTO animales_rescatados (id_especie, id_centro, fecha_rescate, peso_ingreso_kg, estado_ingreso) VALUES 
(1, 1, '2026-01-12', 33.6, 'Varamiento'), (2, 1, '2026-02-20', 3.4, 'Deshidratación');

INSERT INTO tratamientos (id_animal, tipo_tratamiento, costo_estimado) VALUES 
(1, 'Cirugía', 85000), (1, 'Hidratación', 12000), (2, 'Revisión', 9000);


-- Módulo 1: Selección y Filtro

-- Ejercicio 1: Selecciona todas las columnas de la tabla especies cuyo nivel_riesgo sea igual a 'Alto'.

SELECT *
FROM especies
WHERE nivel_riesgo = "Alto";

-- Ejercicio 2: Lista los nombres de los centros cuya ciudad sea 'Mar del Plata' y su capacidad sea mayor a 30.

SELECT 
	cen.nombre_centro
FROM 
	centros AS cen
WHERE cen.ciudad LIKE "%Mar del Plata%" AND 
	capacidad_animales > 30;
    
-- Ejercicio 3: Muestra los animales rescatados después del '2026-01-01', 
-- ordenados por peso de ingreso (peso_ingreso_kg) de forma descendente.

SELECT 
	e.nombre_comun, 
    ar.fecha_rescate,  -- aca pido para mostrar y que se vea mas ordenado el nombre, la fecha y el peso del animal
    ar.peso_ingreso_kg
FROM
	especies AS e INNER JOIN animales_rescatados AS ar ON  -- hago un inner join entre las dos tablas para poder mostrar los datos 
    e.id_especie = ar.id_especie
WHERE
	ar.fecha_rescate > '2026-01-01' -- aca estipulo que la fecha del animal rescatado para mostrar sea mayor a 2026-01-01
ORDER BY
	ar.peso_ingreso_kg DESC; -- aca estoy ordenando a los animales segun su peso al ingresar y que se muestre de forma descendiente
    
-- Módulo 2: JOINs (Relaciones)

-- Ejercicio 4: Muestra el nombre_comun de la especie y el estado_ingreso de cada animal rescatado.

SELECT 
	e.nombre_comun,
    ar.estado_ingreso
FROM 
	especies AS e INNER JOIN animales_rescatados AS ar ON
    e.id_especie = ar.id_especie;
    
-- Ejercicio 5: Realiza un LEFT JOIN entre centros y animales_rescatados 
-- para mostrar qué centros tienen animales asignados y cuáles no (mostrar el nombre del centro y el id del animal).

SELECT 
	c.nombre_centro,
    (ar.id_animal) AS animal_asignado
FROM
	centros AS c LEFT JOIN animales_rescatados AS ar ON
    c.id_centro = ar.id_centro
ORDER BY
	ar.id_animal;
    
-- Módulo 3: Agregación (GROUP BY / HAVING)

-- Ejercicio 6: Calcula el costo total (SUM) de los tratamientos agrupados por tipo_tratamiento.

SELECT 
    e.nombre_comun,
    t.tipo_tratamiento,
    SUM(t.costo_estimado) AS costo_total
FROM 
    tratamientos AS t
INNER JOIN animales_rescatados AS ar ON t.id_animal = ar.id_animal
INNER JOIN especies AS e ON ar.id_especie = e.id_especie
GROUP BY 
    e.nombre_comun, 
    t.tipo_tratamiento;
    
-- Ejercicio 7: Muestra cuántos animales rescatados hay por cada centro, 
-- pero solo de aquellos centros que tengan más de 1 animal rescatado (usa HAVING).

SELECT
	c.nombre_centro,
    c.ciudad,
    c.capacidad_animales,
    COUNT(ar.id_animal) AS cant_animales_rescatados
FROM 
	centros AS c INNER JOIN animales_rescatados AS ar ON
    c.id_centro = ar.id_centro
GROUP BY
	c.nombre_centro,
    c.ciudad,
    c.capacidad_animales
HAVING
	COUNT(ar.id_animal) > 1;
    
-- Módulo 4: Subconsultas
-- Ejercicio 8: Muestra el tipo y 
-- costo de los tratamientos que tengan un costo mayor al costo promedio de todos los tratamientos 
-- (pista: WHERE costo_estimado > (SELECT AVG(costo_estimado)...)).

SELECT
	t.tipo_tratamiento,
    t.costo_estimado
FROM tratamientos AS t
WHERE t.costo_estimado > (
	SELECT
	AVG(t.costo_estimado)
FROM 
	tratamientos AS t);
    
-- Ejercicio 9: Lista el nombre de las especies que no aparecen en la tabla animales_rescatados (usa NOT IN).

SELECT
	e.nombre_comun
FROM
	especies AS e    
WHERE 
	e.id_especie NOT IN(
SELECT
	ar.id_especie
FROM
	animales_rescatados AS ar);
