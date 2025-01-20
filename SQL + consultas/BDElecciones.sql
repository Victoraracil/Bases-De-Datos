CREATE TABLE COLEGIO (
    numCole NUMBER(2),
    totalVotantes NUMBER(5),
	CONSTRAINT pk_cole PRIMARY KEY (numCole)
);

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

-- El atributo orden de POLITICO y EXTRANJERO admitirá 
-- valores entre 1 y 4    me he quedado por aqui
ALTER TABLE POLITICO
ADD CONSTRAINT chk_orden CHECK (orden between 1 and 4);
ALTER TABLE EXTRANJERO
ADD CONSTRAINT chk_orden CHECK (orden between 1 and 4);
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


--Hacer que el atributo orden de la tabla EXTRANJERO 
--no admita nulos
ALTER TABLE EXTRANJERO
MODIFY orden SMALLINT NOT NULL;

-- Añadir el atributo fechaFund con valor por defecto a 
-- fecha 01/01/1974 y hacer que el nombre del PARTIDO 
-- sea único
ALTER TABLE PARTIDO
ADD fechaFund DATE DEFAULT '1974/01/01';
ALTER TABLE PARTIDO
ADD CONSTRAINT unq_partido UNIQUE (nombre);

-- Realizar las siguientes inserciones en cada una de las 
-- tablas con el ejecutando las siguientes líneas:
INSERT INTO COLEGIO VALUES
(1,3400),
(4,4100),
(8,3700);

INSERT INTO MESA (letra,cole) VALUES
('A',1),
('B',1),
('C',1),
('A',4),
('B',4),
('C',4),
('D',4),
('A',8),
('B',8),
('C',8),
('D',8);

INSERT INTO VOTANTE VALUES
('11111111A','ANDRES GONZALEZ AMOROS','1962/03/23','TRIANGULO 17, 3C','B',1,'V'),
('22222222B','ELENA VALLEJO RODRIGUEZ','1970/02/28','MANZANO 32, 5B','D',4,'M'),
('33333333C','VIRGINIA GONZALEZ MENDEZ','1964/04/20','PERAL 4, 7A','B',4,'M');
INSERT INTO VOTANTE VALUES
('44444444D','ARMANDO GUERRA GUERRA','1980/12/01','ARMONTE 0','D',1,'V');
--No permite la inserción de esta tupla debido a que no existe la mesa de letra D y colegio 1

INSERT INTO VOTANTE VALUES
('55555555E','ANTONIO VIDAL PEREZ','1961/02/12','TRIANGULO 14, 1B','C',1,'V'),
('66666666F','ANDRES GONZALEZ PEREZ','1937/08/29','TRIANGULO 17, 3C','B',1,'V');
