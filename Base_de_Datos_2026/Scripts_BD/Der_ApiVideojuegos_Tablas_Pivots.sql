-- USE ApiVideojuegos;

-- Tablas Pivots

CREATE TABLE personajexjuego
(
	id_personajexjuego INT PRIMARY KEY AUTO_INCREMENT,
	id_personaje INT,
    id_juego INT,
    FOREIGN KEY (id_personaje) REFERENCES Personaje (id_personaje),
    FOREIGN KEY (id_juego) REFERENCES Juego (id_juego)
);

CREATE TABLE generoxjuego
(
	id_generoxjuego INT PRIMARY KEY AUTO_INCREMENT,
	id_genero INT,
    id_juego INT,
    FOREIGN KEY (id_genero) REFERENCES Genero (id_genero),
    FOREIGN KEY (id_juego) REFERENCES Juego (id_juego)
);

CREATE TABLE plataformaxjuego
(
	id_plataformaxjuego INT PRIMARY KEY AUTO_INCREMENT,
    id_plataforma INT,
    id_juego INT,
    FOREIGN KEY (id_plataforma) REFERENCES Plataforma (id_plataforma),
    FOREIGN KEY (id_juego) REFERENCES Juego (id_juego)
);

CREATE TABLE tiendaxjuego
(
	id_tiendaxjuego INT PRIMARY KEY AUTO_INCREMENT,
    id_tienda INT,
    id_juego INT,
    FOREIGN KEY (id_tienda) REFERENCES Tienda (id_tienda),
    FOREIGN KEY (id_juego) REFERENCES Juego (id_juego)
);

CREATE TABLE estudioxjuego
(
	id_estudioxjuego INT PRIMARY KEY AUTO_INCREMENT,
    id_estudio INT,
    id_juego INT,
    FOREIGN KEY (id_estudio) REFERENCES Tienda (id_estudio),
    FOREIGN KEY (id_juego) REFERENCES Juego (id_juego)
);