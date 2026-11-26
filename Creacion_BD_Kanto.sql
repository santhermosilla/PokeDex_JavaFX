CREATE DATABASE IF NOT EXISTS registrokanto;
USE registrokanto;


CREATE TABLE ball (
    id_ball INT(2) NOT NULL,
    tipo_ball VARCHAR(20) NOT NULL,
    precio_ball DECIMAL(8,2) NOT NULL
);

ALTER TABLE ball ADD CONSTRAINT ball_pk PRIMARY KEY ( id_ball );

CREATE TABLE detalle_balls (
	id_entrenador INT(2) NOT NULL,
    id_ball INT(2) NOT NULL,
    cantidad_balls INT(3) NOT NULL
);

ALTER TABLE detalle_balls ADD CONSTRAINT detalle_balls_pk PRIMARY KEY ( id_entrenador,
                                                                        id_ball );

CREATE TABLE equipo (
    codigo_captura VARCHAR(10) NOT NULL, 
    n_pokedex VARCHAR(4) NOT NULL,
    id_entrenador  INT(2) NOT NULL,
    mote_pokemon   VARCHAR(30),
    estado_pokemon ENUM('Avistado','Atrapado','Registrado') NOT NULL DEFAULT 'Avistado'
);

ALTER TABLE equipo
    ADD CONSTRAINT equipo_pk PRIMARY KEY (codigo_captura);

CREATE TABLE entrenador (
    id_entrenador INT(2) NOT NULL,    
    nombre_entrenador VARCHAR(50) NOT NULL, 
    pueblo_entrenador VARCHAR(40) NOT NULL,
    tipo_entrenador ENUM('Errante','Gimnasio','Liga') NOT NULL,
    maximo_equipo INT(2) NOT NULL
);

ALTER TABLE entrenador ADD CONSTRAINT entrenador_pk PRIMARY KEY ( id_entrenador );

CREATE TABLE pokemon (
    n_pokedex VARCHAR(4) NOT NULL, 
    nombre_pokemon VARCHAR(50) NOT NULL, 
    tipo_pokemon   VARCHAR(20) NOT NULL,
    rareza_pokemon ENUM('Comun','Raro','Legendario') NOT NULL
);

ALTER TABLE pokemon ADD CONSTRAINT pokemon_pk PRIMARY KEY ( n_pokedex );

CREATE TABLE comun(
	n_pokedex VARCHAR(4) NOT NULL,
    tipo_actividad ENUM('Dia','Tarde','Noche') NOT NULL,
    ruta_aparicion INT(2) NOT NULL
);
ALTER TABLE comun ADD CONSTRAINT comun_pk PRIMARY KEY (n_pokedex);

CREATE TABLE raro(
	n_pokedex VARCHAR(4) NOT NULL,
    zona_especial ENUM('Cueva','Volcan','Oceano','Safari') NOT NULL,
    es_amistoso TINYINT(1) NOT NULL
);

ALTER TABLE raro ADD CONSTRAINT raro_pk PRIMARY KEY (n_pokedex);

CREATE TABLE legendario(
	n_pokedex VARCHAR(4) NOT NULL,
    nivel_legendario ENUM('Sublegendario','Legendario','Singular') NOT NULL,
    origen_legendario ENUM('Natural','Artificial') NOT NULL
);

ALTER TABLE legendario ADD CONSTRAINT legendario_pk PRIMARY KEY (n_pokedex);

ALTER TABLE detalle_balls
    ADD CONSTRAINT detalle_balls_ball_fk FOREIGN KEY ( id_ball )
        REFERENCES ball ( id_ball ) ON DELETE CASCADE;

ALTER TABLE detalle_balls
    ADD CONSTRAINT detalle_balls_entrenador_fk FOREIGN KEY ( id_entrenador )
        REFERENCES entrenador ( id_entrenador ) ON DELETE CASCADE;

ALTER TABLE equipo
    ADD CONSTRAINT equipo_entrenador_fk FOREIGN KEY ( id_entrenador )
        REFERENCES entrenador ( id_entrenador );

ALTER TABLE equipo
    ADD CONSTRAINT equipo_pokemon_fk FOREIGN KEY ( n_pokedex )
        REFERENCES pokemon ( n_pokedex );
        
ALTER TABLE comun
	ADD CONSTRAINT comun_pokemon_fk FOREIGN KEY (n_pokedex)
		REFERENCES pokemon(n_pokedex) ON DELETE CASCADE;
        
ALTER TABLE raro
	ADD CONSTRAINT raro_pokemon_fk FOREIGN KEY (n_pokedex)
		REFERENCES pokemon(n_pokedex) ON DELETE CASCADE;

ALTER TABLE legendario
	ADD CONSTRAINT legendario_pokemon_fk FOREIGN KEY (n_pokedex)
		REFERENCES pokemon(n_pokedex) ON DELETE CASCADE;

