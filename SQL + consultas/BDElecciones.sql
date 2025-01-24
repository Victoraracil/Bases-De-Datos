CREATE TABLE MESA (
    letra CHAR(1),
    cole NUMBER(2),
    blanM NUMBER(5) DEFAULT 0,
    blanA NUMBER(5) DEFAULT 0,
    nulM NUMBER(5) DEFAULT 0,
    nulA NUMBER(5) DEFAULT 0,
	CONSTRAINT pk_MESA PRIMARY KEY (letra, cole),
	CONSTRAINT fk_MESA_COLEGIO FOREIGN KEY (cole) REFERENCES COLEGIO (numCole)
);

CREATE TABLE VOTANTE (
    nif CHAR(9),
	nombre VARCHAR2(25),
    fechaNac DATE,
    direccion VARCHAR2(30),
    letraMesa CHAR(1) NOT NULL,
    numCole NUMBER(2) NOT NULL,
    CONSTRAINT pk_vot PRIMARY KEY (nif),
	CONSTRAINT fk_VOTANTE_MESA FOREIGN KEY (letraMesa,numCole) REFERENCES MESA (letra,cole)
);

CREATE TABLE NACIONAL (
	nifNac CHAR(9),
	CONSTRAINT pk_NACIONAL PRIMARY KEY (nifNac),
	CONSTRAINT fk_NACIONAL_VOTANTE FOREIGN KEY (nifNac) REFERENCES VOTANTE (nif)
);

CREATE TABLE DEMESA (
	nifTitular CHAR(9),
	nifSuplente CHAR(9) NOT NULL,
	CONSTRAINT pk_DEMESA PRIMARY KEY (nifTitular),
	CONSTRAINT uk_DEMESA UNIQUE (nifSuplente),
	CONSTRAINT fk_DEMESA_NACIONAL1 FOREIGN KEY (nifTitular) REFERENCES NACIONAL (nifNac),
	CONSTRAINT fk_DEMESA_NACIONAL2 FOREIGN KEY (nifSuplente) REFERENCES NACIONAL (nifNac)
);

CREATE TABLE PARTIDO (
	siglas VARCHAR2(10),
	nombre VARCHAR2(30),
	nombreLider VARCHAR2(40),
	CONSTRAINT pk_partido PRIMARY KEY (siglas)
);

CREATE TABLE POLITICO (
	nifPolitico CHAR(9),
	porPartido VARCHAR2(10) NOT NULL,
	orden NUMBER(3),
	CONSTRAINT pk_POLITICO PRIMARY KEY (nifPolitico),
	CONSTRAINT fk_POLITICO_NACIONAL FOREIGN KEY (nifPolitico) REFERENCES NACIONAL (nifNac),
	CONSTRAINT fk_POLITICO_PARTIDO FOREIGN KEY (porPartido) REFERENCES PARTIDO (siglas)
);

CREATE TABLE EXTRANJERO (
	nifExtran CHAR(9),
	porPartido VARCHAR2(10) NOT NULL,
	orden NUMBER(3),
	CONSTRAINT pk_EXTRANJERO PRIMARY KEY (nifExtran),
	CONSTRAINT fk_EXTRANJERO_VOTANTE FOREIGN KEY (nifExtran) REFERENCES VOTANTE (nif),
	CONSTRAINT fk_EXTRANJERO_PARTIDO FOREIGN KEY (porPartido) REFERENCES PARTIDO (siglas)
);

CREATE TABLE APODERADO (
	nifApod CHAR(9),
	nombre VARCHAR2(25),
	porPartido VARCHAR2(10),
	CONSTRAINT pk_APODERADO PRIMARY KEY (nifApod),
	CONSTRAINT fk_APODERADO_PARTIDO FOREIGN KEY (porPartido) REFERENCES PARTIDO (siglas)
);

CREATE TABLE AUTONOMICA (
	partido VARCHAR2(10),
	mesa CHAR(1),
	colegio NUMBER(2),
	votos NUMBER(5) DEFAULT 0, 
	CONSTRAINT chk_votosaut CHECK (votos>0),
	CONSTRAINT pk_AUTONOMICA PRIMARY KEY (partido,mesa,colegio),
	CONSTRAINT fk_AUTONOMICA_PARTIDO FOREIGN KEY (partido) REFERENCES PARTIDO (siglas),
	CONSTRAINT fk_AUTONOMICA_MESA FOREIGN KEY (mesa,colegio) REFERENCES MESA (letra,cole)
);	
		
CREATE TABLE MUNICIPAL (
	partido VARCHAR2(10),
	mesa CHAR(1),
	colegio NUMBER(2),
	votos NUMBER(5) DEFAULT 0, 
	CONSTRAINT chk_votosmun CHECK (votos>0),
	CONSTRAINT pk_MUNICIPAL PRIMARY KEY (partido,mesa,colegio),
	CONSTRAINT fk_MUNICIPAL_PARTIDO FOREIGN KEY (partido) REFERENCES PARTIDO (siglas),
	CONSTRAINT fk_MUNICIPAL_MESA FOREIGN KEY (mesa,colegio) REFERENCES MESA (letra,cole)
);

CREATE TABLE VOCAL (
	nifVocal CHAR(9),
	numero NUMBER(3),
	CONSTRAINT pk_VOCAL PRIMARY KEY (nifVocal),
	CONSTRAINT fk_VOCAL_DEMESA FOREIGN KEY (nifVocal) REFERENCES DEMESA (nifTitular)
);

CREATE TABLE PRESIDENTE (
	nifPresi CHAR(9),
	CONSTRAINT pk_PRESIDENTE PRIMARY KEY (nifPresi),
	CONSTRAINT fk_PRESIDENTE_DEMESA FOREIGN KEY (nifPresi) REFERENCES DEMESA (nifTitular)
);

-- Ejercicio 2
-- El atributo orden de POLITICO y EXTRANJERO admitirá 
-- valores entre 1 y 4
ALTER TABLE POLITICO
ADD CONSTRAINT chk_orden_politico CHECK (orden between 1 and 4);
ALTER TABLE EXTRANJERO
ADD CONSTRAINT chk_orden_extranjero CHECK (orden between 1 and 4);
--ALTER TABLE POLITICO
--ADD CONSTRAINT chk_orden CHECK (orden>=1 and orden<=4);


-- Añade un nuevo atributo a la tabla VOTANTE llamado 
-- sexo que solamente permita los valores ‘V’ y ‘M’
ALTER TABLE VOTANTE
ADD sexo char(1) CHECK (sexo='V' or sexo='M');
--ALTER TABLE VOTANTE
--ADD sexo char(1);
--ALTER TABLE VOTANTE
--ADD CONSTRAINT chk_sexo CHECK (sexo='V' or sexo='M');

-- Ejercicio 3
--Hacer que el atributo orden de la tabla EXTRANJERO 
--no admita nulos
ALTER TABLE EXTRANJERO
MODIFY orden NUMBER(3) NOT NULL;

-- Ejercicio 4
-- Añadir el atributo fechaFund con valor por defecto a 
-- fecha 01/01/1974 y hacer que el nombre del PARTIDO 
-- sea único
ALTER TABLE PARTIDO
ADD fechaFund DATE DEFAULT '01/01/1974';
ALTER TABLE PARTIDO
ADD CONSTRAINT unq_partido UNIQUE (nombre);

-- Ejercicio 5
-- Realizar las siguientes inserciones en cada una de las 
-- tablas con el ejecutando las siguientes líneas:
INSERT INTO COLEGIO VALUES(1,3400);
INSERT INTO COLEGIO VALUES(4,4100);
INSERT INTO COLEGIO VALUES(8,3700);

INSERT INTO MESA (letra,cole) VALUES('A',1);
INSERT INTO MESA (letra,cole) VALUES('B',1);
INSERT INTO MESA (letra,cole) VALUES('C',1);
INSERT INTO MESA (letra,cole) VALUES('A',4);
INSERT INTO MESA (letra,cole) VALUES('B',4);
INSERT INTO MESA (letra,cole) VALUES('C',4);
INSERT INTO MESA (letra,cole) VALUES('D',4);
INSERT INTO MESA (letra,cole) VALUES('A',8);
INSERT INTO MESA (letra,cole) VALUES('B',8);
INSERT INTO MESA (letra,cole) VALUES('C',8);
INSERT INTO MESA (letra,cole) VALUES('D',8);

INSERT INTO VOTANTE VALUES('11111111A','ANDRES GONZALEZ AMOROS','23/03/1962','TRIANGULO 17, 3C','B',1,'V');
INSERT INTO VOTANTE VALUES('22222222B','ELENA VALLEJO RODRIGUEZ','28/02/1970','MANZANO 32, 5B','D',4,'M');
INSERT INTO VOTANTE VALUES('33333333C','VIRGINIA GONZALEZ MENDEZ','20/04/1964','PERAL 4, 7A','B',4,'M');
INSERT INTO VOTANTE VALUES('44444444D','ARMANDO GUERRA GUERRA','01/12/1980','ARMONTE 0','D',1,'V');
--No permite la inserción de esta tupla debido a que no existe la mesa de letra D y colegio 1

INSERT INTO VOTANTE VALUES('55555555E','ANTONIO VIDAL PEREZ','12/02/1961','TRIANGULO 14, 1B','C',1,'V');
INSERT INTO VOTANTE VALUES('66666666F','ANDRES GONZALEZ PEREZ','29/08/1937','TRIANGULO 17, 3C','B',1,'V');

--Ejercicio 6
INSERT INTO nacional VALUES('11111111A');
INSERT INTO nacional VALUES('22222222B');
INSERT INTO nacional VALUES('33333333C');
INSERT INTO nacional VALUES('55555555E');
INSERT INTO nacional VALUES('66666666F');

--Ejercicio 7
INSERT INTO nacional VALUES('77777777F');
--Error que indica que estás intentando insertar un valor en una tabla hija (ALUMNO) que 
--depende de una clave primaria en una tabla padre (NACIONAL), pero esa clave primaria no existe.

--Ejercicio 8
INSERT INTO VOTANTE (nif, direccion, fechaNac)
VALUES ('99999999G', 'ALCORNOQUE 8', 14/05/1967);
--Valores insuficientes

-- Ejercicio 9
-- Eliminar la mesa C del colegio 1
DELETE FROM MESA WHERE letra = 'C' AND cole = 1;
--No deja eliminarla, forgeing dependency

-- Cambiar la letra de la mesa del votante Antonio Vidal a B
UPDATE votante SET letramesa = 'B' WHERE nombre = 'ANTONIO VIDAL PEREZ';

-- Intentar eliminar de nuevo la mesa C del colegio 1
DELETE FROM MESA WHERE letra = 'C' AND cole = 1;
--Ahora si deja

-- Ejercicio 10
-- Modificar la dirección del votante con NIF 33333333M
UPDATE VOTANTE SET direccion = 'Cuadrado 14, 5ºA' WHERE nif = '33333333M';
--No existe votante cuya letra del DNI sea 'M' por lo que no cambia nada

-- Ejercicio 11
-- Modificar los valores de votos blancos y nulos en la mesa A del colegio 1
UPDATE MESA 
SET blanM = 1500, blanA = 1480, nulM = 200, nulA = 130
WHERE letra = 'A' AND cole = 1;

-- Ejercicio 12
-- Aumentar el total de votantes en colegios específicos
UPDATE COLEGIO SET totalVotantes = totalVotantes + 10 WHERE numCole = 1;
UPDATE COLEGIO SET totalVotantes = totalVotantes + 20 WHERE numCole = 4;
UPDATE COLEGIO SET totalVotantes = totalVotantes + 50 WHERE numCole = 8;

-- Ejercicio 13
-- Asignar la mesa A del colegio 1 a votantes de la calle Triangulo
UPDATE votante SET letramesa = 'A', numcole = 1 WHERE direccion LIKE upper('%TRIANGULO%') ;

-- Ejercicio 14
-- Eliminar la dirección de la votante con NIF 33333333M
UPDATE VOTANTE SET direccion = NULL WHERE nif = '33333333M';
--No existe votante cuya letra del DNI sea 'M' por lo que no cambia nada

-- Ejercicio 15
-- Eliminar la mesa D del colegio 8
DELETE FROM MESA WHERE letra = 'D' AND cole = 8;

-- Ejercicio 16
-- Eliminar el colegio número 4
DELETE FROM COLEGIO WHERE numCole = 4;
--No deja eliminarla, forgeing dependency

-- Ejercicio 17
-- Realizar inserciones en las tablas (ejemplo para varias tablas)
INSERT INTO partido (siglas, nombre, nombrelider) VALUES ('SSS', 'SOCIEDAD SOCIOS SESUDOS', 'SESUDO MAYOR');
INSERT INTO votante VALUES ('77777777A', 'JUAN COLOMA VARO', '03/08/1962', 'ROMBO 25', 'A', 4, 'V');
INSERT INTO apoderado VALUES ('77777777A', 'JUAN COLOMA', 'SSS');
INSERT INTO partido VALUES ('CCC', 'CAMINANTES CON CAMINO', 'ARMANDO CAMINOS FUERTES', '01/02/1978');
INSERT INTO partido (siglas) VALUES ('MMM');
INSERT INTO politico (nifpolitico, porpartido, orden) VALUES ('11111111A', 'CCC', 1); 
INSERT INTO extranjero (nifextran, porpartido, orden) VALUES ('22222222B', 'CCC', 2); 
INSERT INTO politico (nifpolitico, porpartido, orden) VALUES ('55555555D', 'SSS', 1); 
INSERT INTO colegio (numcole) VALUES (2);
INSERT INTO mesa (cole, letra) VALUES (2, 'B');

-- Ejercicio 18
-- Inserciones variadas para poblar las tablas
INSERT INTO votante VALUES ('12345678A', 'LUIS GARCIA PASTOR', '22-03-80', 'CalleLuna, 15', 'B', 1, 'V');
INSERT INTO partido VALUES ('PP', 'Partido Popular', 'Carlos López', '20-1-89');
INSERT INTO apoderado VALUES ('87654321B', 'Ana Torres', 'PP');
INSERT INTO nacional VALUES ('12345678A');
INSERT INTO votante VALUES ('23456789C', 'MARÍA PÉREZ SOLER', '12-08-95', 'CalleSol, 10', 'A', 1, 'M');
INSERT INTO municipal VALUES ('PP', 'A', 1, 150);
INSERT INTO autonomica VALUES ('PP', 'A', 1, 180);
INSERT INTO politico VALUES ('12345678A', 'PP', 1);

--Ejercicio 19 (Consultas)
--1
SELECT nombre
FROM votante
WHERE direccion LIKE '%PERAL%'

--2
SELECT nif, nombre
FROM votante
WHERE fechanac BETWEEN '1-1-65' AND '30-12-70'

--3
SELECT letra
FROM mesa
GROUP BY letra

--4
SELECT count (letra) as totalmesas
FROM mesa
WHERE cole = 1

--5
SELECT (nulm), (nula)
FROM mesa
WHERE cole = 1

--6
SELECT (nulm), (nula), cole
FROM mesa
WHERE letra LIKE 'A'

--7
SELECT (nulm), (nula), cole
FROM mesa
WHERE nula > 100 AND nulm > 100

--9
INSERT INTO demesa VALUES ('11111111A', '33333333C');
INSERT INTO demesa VALUES ('22222222B', '55555555E');
SELECT *
FROM demesa

--10
SELECT nif
FROM votante
WHERE numcole LIKE 1

--11
SELECT *
FROM votante
WHERE UPPER(direccion) LIKE '%PERAL%' OR UPPER(direccion) LIKE '%TRIANGULO%'

--13
SELECT nif
FROM votante
WHERE to_char (fechanac, 'YYYY') < (1960)

--14
SELECT *
FROM votante
WHERE to_char (fechanac, 'YYYY') IN (1952, 1960, 1970)

--15
SELECT COUNT(*) totalmesa
FROM mesa
GROUP BY cole

--16
SELECT cole, SUM (nulm) AS totalnulos
FROM mesa
GROUP BY cole

--17
SELECT *
FROM votante
WHERE to_char (fechanac, 'MM/YYYY') IN ('03/1962')

--18
SELECT cole, SUM(blanm)
FROM mesa
GROUP BY cole
HAVING COUNT(*) > 3

--19
SELECT nif, nombre, numcole
FROM votante v, mesa m
WHERE cole = (SELECT cole
                FROM mesa
                GROUP BY cole
                HAVING SUM (nula) > 100)