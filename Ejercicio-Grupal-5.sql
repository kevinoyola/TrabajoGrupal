CREATE DATABASE telovendo5;

CREATE USER 'admintelovendoo1'@'localhost' IDENTIFIED BY '123456';
GRANT ALL PRIVILEGES ON  telovendo5.* to 'admintelovendoo1'@'localhost';
use telovendo5;

-- La primera almacena a los usuarios de la aplicación (id_usuario, nombre, apellido, contraseña, zona horaria (por defecto UTC-3), género y teléfono de contacto).

	CREATE TABLE usuarios_aplicacion
	(id_usuario INT PRIMARY KEY auto_increment,
	nombre VARCHAR (50),
	apellido VARCHAR (50),
	contraseña VARCHAR (9),
	zona_horaria TIME DEFAULT '-03:00',
	genero VARCHAR (15),
	telefono_contacto INT (9));

-- La segunda tabla almacena información relacionada a la fecha-hora de ingreso de los usuarios a la plataforma (id_ingreso, id_usuario y la fecha-hora de ingreso (por defecto la fecha-hora actual)).

CREATE TABLE ingresos_plataforma (
    id_ingreso INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT,
    fecha_hora_ingreso DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios_aplicacion(id_usuario)
);


--  Parte 3: Modificación de la tabla
-- Modifique el UTC por defecto.Desde UTC-3 a UTC-2.
       
ALTER TABLE usuarios_aplicacion MODIFY zona_horaria TIME DEFAULT '-02:00';

-- Para cada tabla crea 8 registros.

INSERT INTO usuarios_aplicacion (nombre, apellido, contraseña, zona_horaria, genero, telefono_contacto)
VALUES ('Juan', 'Pérez', 'abc123', 'UTC-3', 'Masculino', 111222333),
       ('María', 'Gómez', 'qwerty', 'UTC-3', 'Femenino', 444555666),
       ('Pedro', 'Rodríguez', '123456', 'UTC-3', 'Masculino', 777888999),
       ('Laura', 'López', 'asdfgh', 'UTC-3', 'Femenino', 222333444),
       ('Carlos', 'García', '654321', 'UTC-3', 'Masculino', 555666777),
       ('Ana', 'Martínez', 'zxcvbn', 'UTC-3', 'Femenino', 888999000),
       ('Santiago', 'Hernández', 'p@ssw0rd', 'UTC-3', 'Masculino', 333444555),
       ('Lucía', 'Díaz', 'q1w2e3r4t5', 'UTC-3', 'Femenino', 666777888);
       
INSERT INTO ingresos_plataforma (id_ingreso) 
VALUES (1), (2), (3), (4), (5), (6), (7), (8);

SELECT * FROM contactos;

-- Parte 5: Justifique cada tipo de dato utilizado. ¿Es el óptimo en cada caso?

#id_usuario y id_ingreso: INT es el tipo de dato adecuado para identificadores numéricos.
#nombre y apellido: VARCHAR es el tipo de dato adecuado para nombres, ya que tienen una longitud variable.
#contraseña: VARCHAR es el tipo de dato adecuado para contraseñas, ya que tienen una longitud variable.
#zona_horaria: TIME es el tipo de dato adecuado para almacenar zonas horarias, ya que solo se necesita la hora y los minutos.
#género: VARCHAR es el tipo de dato adecuado para géneros, ya que tienen una longitud variable.
#telefono_contacto: INT es el tipo de dato adecuado para números de teléfono, ya que solo se necesitan números enteros.
#fecha_hora_ingreso: DATETIME es el tipo de dato adecuado para almacenar fechas y horas.


-- Parte 6: Creen una nueva tabla llamada Contactos (id_contacto, id_usuario, numero de telefono,
-- correo electronico).

CREATE TABLE Contactos (
    id_contacto INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT,
    numero_telefono VARCHAR(9),
    correo_electronico VARCHAR(50),
     CONSTRAINT fk_usuario_contacto FOREIGN KEY (id_usuario) REFERENCES usuarios_aplicacion(id_usuario)
);

-- Parte 7: Modifique la columna teléfono de contacto, para crear un vínculo entre la tabla Usuarios y la
-- tabla Contactos.

ALTER TABLE usuarios_aplicacion ADD COLUMN id_contacto INT,
ADD CONSTRAINT fk_contacto_usuario FOREIGN KEY (id_contacto) REFERENCES Contactos(id_contacto);

UPDATE usuarios_aplicacion
SET id_contacto = (
  SELECT id_contacto
  FROM Contactos
  WHERE Contactos.numero_telefono = usuarios_aplicacion.telefono_contacto);
  
ALTER TABLE usuarios_aplicacion
DROP COLUMN telefono_contacto;
-- El ejercicio debe ser subido a github y al Nodo Virtual.

-- https://github.com/kevinoyola/TrabajoGrupal.git
  