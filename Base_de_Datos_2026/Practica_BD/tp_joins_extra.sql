-- CREATE DATABASE tp_joins_extra;
-- USE tp_joins_extra;

CREATE TABLE Alumnos (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(50),
    Apellido VARCHAR(50),
    Edad INT,
    CorreoElectronico VARCHAR(100)
);

CREATE TABLE Materias (
    MateriaID INT PRIMARY KEY AUTO_INCREMENT,
    NombreMateria VARCHAR(50)
);

CREATE TABLE AlumnosXMateria (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    AlumnoID INT,
    MateriaID INT,
    FOREIGN KEY (AlumnoID) REFERENCES Alumnos(ID),
    FOREIGN KEY (MateriaID) REFERENCES Materias(MateriaID)
);

CREATE TABLE CalificacionesXAlumno (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    AlumnoID INT,
    MateriaID INT,
    FechaExamen DATE,
    Calificacion INT,
    FOREIGN KEY (AlumnoID) REFERENCES Alumnos(ID),
    FOREIGN KEY (MateriaID) REFERENCES Materias(MateriaID)
);

/*Ejercicio 1
Consulta: Seleccionar todos los alumnos que tienen más de 20 años.*/

SELECT
	a.Nombre,
    a.Apellido,
    a.Edad
FROM
	Alumnos AS a
WHERE
	a.Edad > 20;

INSERT INTO Alumnos (Nombre, Apellido, Edad, CorreoElectronico) VALUES
('Martin', 'Zapata', '30', 'martinz30@gmail.com'),
('')