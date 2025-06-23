DROP DATABASE BDCOLEGIO;
CREATE DATABASE BDCOLEGIO;
USE BDCOLEGIO;

CREATE TABLE PROFESOR (
	dni CHAR (9),
	nombre VARCHAR(25), 
	categoría VARCHAR (10), 
	fechainc date,
	CONSTRAINT pk_prof PRIMARY KEY (dni)
);

CREATE TABLE ASIGNATURA (
	codigo CHAR(5),
	descripcion VARCHAR(40),
	horasP NUMBER (3,1),
	horasT NUMBER (3,1),
	CONSTRAINT pk_asig PRIMARY KEY (codigo)
);

CREATE TABLE IMPARTIR (
	dni CHAR(9),
	codigo CHAR(5),
	CONSTRAINT pk_imp PRIMARY KEY (dni,codigo),
	CONSTRAINT fk_imp_prof FOREIGN KEY (dni) REFERENCES PROFESOR (dni),
	CONSTRAINT fk_imp_asig FOREIGN KEY (codigo) REFERENCES ASIGNATURA (codigo)
);

-- Inserción de datos
INSERT INTO ASIGNATURA (codigo, descripcion, horasP, horasT)
VALUES ('BD', 'Bases de Datos', 1.5, 3.5);
INSERT INTO ASIGNATURA (codigo, descripcion, horasP, horasT)
VALUES ('Prog', 'Programación', 6.5, 1.5);
INSERT INTO ASIGNATURA (codigo, descripcion, horasP, horasT)
VALUES ('ED', 'Entornos de Desarrollo', 2.5, 0.5);
INSERT INTO ASIGNATURA (codigo, descripcion, horasP, horasT)
VALUES ('LM', 'Lenguaje de Marcas', 2.5, 0.5);
INSERT INTO ASIGNATURA (codigo, descripcion, horasP, horasT)
VALUES ('SI', 'Sistemas Informáticos', 3.5, 1.5);
INSERT INTO ASIGNATURA (codigo, descripcion, horasP, horasT)
VALUES ('FOL', 'Formación y Orientación Laboral', 2.0, 1.0);

INSERT INTO PROFESOR 
VALUES ('11111111A', 'Manuel Botella','Prov','2016/09/01');
INSERT INTO PROFESOR 
VALUES ('22222222B', 'Eva Fina Segura','Fijo','2005/09/01');
INSERT INTO PROFESOR 
VALUES ('33333333C', 'Armando Guerra','Prov','2011/07/01');
INSERT INTO PROFESOR 
VALUES ('44444444D', 'Pulpito Caido','Fijo','2009/09/01');

INSERT INTO IMPARTIR VALUES 
('11111111A', 'BD'),
('22222222B', 'ED'),
('33333333C', 'LM'),
('44444444D', 'SI'),
('11111111A', 'ED');

