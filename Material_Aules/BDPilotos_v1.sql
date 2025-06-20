-- BDPilotos

ALTER SESSION SET NLS_DATE_FORMAT='DD/MM/YYYY';

-- Tabla PILOTO

-- DROP TABLE PILOTO cascade constraints; 

CREATE TABLE PILOTO (
	codigo NUMBER(2),
	nombre VARCHAR2(14), 
	ciudad VARCHAR2(14),
	equipo VARCHAR2(14),
	fec_nac DATE 
);

INSERT INTO PILOTO VALUES (1,'Alberto','Madrid','Ford','10/10/1975');
INSERT INTO PILOTO VALUES (2,'Antonio','Alicante','Citroen','01/04/1980');
INSERT INTO PILOTO VALUES (3,'Efice','Barcelona','Toyota','02/05/1985');
INSERT INTO PILOTO VALUES (4,'Santi','Valencia','Peugeot','04/12/1992');
INSERT INTO PILOTO VALUES (5,'Agapito','Alicante','Audi','14/10/2000');
INSERT INTO PILOTO VALUES (6,'Manolo','Alicante','Mercedes','01/01/2001');
INSERT INTO PILOTO VALUES (7,'Fermin','Valencia','Honda','07/03/1999');

COMMIT;

-- Tabla PRUEBA

-- DROP TABLE PRUEBA cascade constraints; 

CREATE TABLE PRUEBA (
	prueba NUMBER(2),
	pais VARCHAR2(20),
	coefic NUMBER(3,2)
);

INSERT INTO PRUEBA VALUES (1,'Monaco',0.20);
INSERT INTO PRUEBA VALUES (2,'Finlandia',0.25);
INSERT INTO PRUEBA VALUES (3,'Espa a',0.75);
INSERT INTO PRUEBA VALUES (4,'Alemania',0.80);
INSERT INTO PRUEBA VALUES (5,'Gran Breta a',0.60);
INSERT INTO PRUEBA VALUES (6,'Francia',0.20);

COMMIT;


-- Tabla RESULT

-- DROP TABLE RESULT cascade constraints;

CREATE TABLE RESULTADO (
	codigo number(2),
	puesto number(2),
	prueba number(2)
);
 
INSERT INTO RESULTADO VALUES (1,2,1);
INSERT INTO RESULTADO VALUES (1,5,2);
INSERT INTO RESULTADO VALUES (1,3,3);
INSERT INTO RESULTADO VALUES (1,1,4);

INSERT INTO RESULTADO VALUES (2,4,1);
INSERT INTO RESULTADO VALUES (2,3,2);
INSERT INTO RESULTADO VALUES (2,2,3);
INSERT INTO RESULTADO VALUES (2,2,4);

INSERT INTO RESULTADO VALUES (3,3,1);
INSERT INTO RESULTADO VALUES (3,4,2);
INSERT INTO RESULTADO VALUES (3,5,3);
INSERT INTO RESULTADO VALUES (3,3,4);

INSERT INTO RESULTADO VALUES (4,5,1);
INSERT INTO RESULTADO VALUES (4,1,2);
INSERT INTO RESULTADO VALUES (4,4,3);
INSERT INTO RESULTADO VALUES (4,4,4);

INSERT INTO RESULTADO VALUES (6,1,1);
INSERT INTO RESULTADO VALUES (6,2,2);
INSERT INTO RESULTADO VALUES (6,1,3);
INSERT INTO RESULTADO VALUES (6,1,4);
INSERT INTO RESULTADO VALUES (6,1,5);
INSERT INTO RESULTADO VALUES (6,5,6);

COMMIT;

-- Modificaciones
-- Las claves primarias, alternativas y ajenas se deber n realizar mediantes la
-- modificaci n de las tablas anteriormente creadas.
    ALTER TABLE PILOTO
    ADD CONSTRAINT pkPiloto PRIMARY KEY (codigo);

    ALTER TABLE PRUEBA
    ADD CONSTRAINT pkPrueba PRIMARY KEY (prueba);

    ALTER TABLE RESULTADO
    ADD CONSTRAINT pkResultado PRIMARY KEY (codigo,prueba);

    ALTER TABLE RESULTADO
    ADD CONSTRAINT fkResultadoPiloto FOREIGN KEY (codigo) REFERENCES PILOTO;

    ALTER TABLE RESULTADO
    ADD CONSTRAINT fkResultadoPrueba FOREIGN KEY (prueba) REFERENCES PRUEBA;

-- El coeficiente de la prueba debe tener un valor comprendido entre 0 y 1

    ALTER TABLE PRUEBA
    ADD CONSTRAINT pkValor coefic CHECK between 0 and 1;

-- La ciudad del piloto solo puede tomar los valores de Alicante, Barcelona,
-- Madrid o Valencia.

    ALTER TABLE PILOTO
    ADD CONSTRAINT pkCiudad ciudad CHECK IN ('Alicante','Barcelona','Madrid','Valencia');

-- Todos los pilotos deben tener m s de 18 a os.

    ALTER TABLE PILOTO
    ADD CONSTRAINT ckEdad TO_CHAR (fec_nac,'yyyy')<2006;

