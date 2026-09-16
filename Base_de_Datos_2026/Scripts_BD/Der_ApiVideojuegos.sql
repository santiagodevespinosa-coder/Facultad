-- CREATE DATABASE ApiVideojuegos;
-- USE ApiVideojuegos;

CREATE TABLE Personaje
(
	id_personaje INT PRIMARY KEY AUTO_INCREMENT,
    nombre_personaje VARCHAR(200) NOT NULL,
    caracteristicas TEXT NOT NULL,
    imagen_personaje VARCHAR(250)
);

CREATE TABLE Genero
(
	id_genero INT PRIMARY KEY AUTO_INCREMENT,
    nombre_genero VARCHAR(100) NOT NULL,
    restriccion_edad INT NOT NULL
);

CREATE TABLE Juego
(
	id_juego INT PRIMARY KEY AUTO_INCREMENT,
    nombre_juego VARCHAR(200) NOT NULL,
    fecha_lanzamiento DATE NOT NULL,
    sinopsis TEXT NOT NULL
);

CREATE TABLE Plataforma
(
	id_plataforma INT PRIMARY KEY AUTO_INCREMENT,
    nombre_plataforma VARCHAR(100) NOT NULL,
    imagen_plataforma VARCHAR(250)
);

CREATE TABLE Estudio
(
	id_estudio INT PRIMARY KEY AUTO_INCREMENT,
    nombre_estudio VARCHAR(200),
    imagen_estudio VARCHAR(250)
);

CREATE TABLE Tienda
(
	id_tienda INT PRIMARY KEY AUTO_INCREMENT,
    nombre_tienda VARCHAR(150),
    imagen_tienda VARCHAR(250)
);

/*
CREATE TABLE Editor
(
	id_editor INT PRIMARY KEY AUTO_INCREMENT,
    estado  TINYINT
);
*/




