-- Posible orden de borrado de tablas en caso de volver a comenzar la BD
DROP TABLE MULTA;
DROP TABLE VEHICULO;
DROP TABLE AGENTE;
DROP TABLE CUARTEL;
DROP TABLE PERSONA;
DROP TABLE INFRACCION;

-- Creación de tablas

CREATE TABLE CUARTEL(
    codigo NUMBER(5),
    direccion VARCHAR(24),
    localidad VARCHAR(14),
    dniDirector VARCHAR(9),
    telefono VARCHAR(9),
    cuartelSuperior NUMBER(5)
);

CREATE TABLE AGENTE(
    dni VARCHAR(9),
    nombre VARCHAR(24),
    fNacimiento DATE,
    categoria VARCHAR(10),
    totalMultas NUMBER(3),
    cuartelActual NUMBER(5)
);

CREATE TABLE INFRACCION(
    tipo NUMBER(2),
    descripcion VARCHAR(30),
    importe NUMBER(5,2)
);

-- ¡¡¡ OJO con los tipos de datos que se le dan a los atributos que vienen de 
-- INFRACCION y PERSONA !!!

CREATE TABLE MULTA(
    numero NUMBER(4),
    agente VARCHAR(9),
    infraccion NUMBER(2),
    vehiculo VARCHAR(7),
    conductor VARCHAR(9),
    conductorReconocido VARCHAR(1),
    fecha DATE,
    hora TIMESTAMP,
    lugar VARCHAR(14),
    importe NUMBER(5,2),
    fechaPago DATE
);

CREATE TABLE VEHICULO(
    matricula VARCHAR(7),
    fFabricacion DATE,
    fMatriculacion DATE,
    potencia NUMBER(3),
    propietario VARCHAR(9)
);

CREATE TABLE PERSONA(
    dni VARCHAR(9),
    nombre VARCHAR(24),
    domicilio VARCHAR(24),
    localidad VARCHAR(14),
    telefono VARCHAR(9),
    sexo CHAR(1),
    fNacimiento DATE,
    fCarnet DATE
);

-- Modificaciones en las tablas

ALTER TABLE CUARTEL
ADD CONSTRAINT pkCuartel PRIMARY KEY(codigo);
ALTER TABLE AGENTE
ADD CONSTRAINT pkAgente PRIMARY KEY(dni);
ALTER TABLE INFRACCION
ADD CONSTRAINT pkInfraccion PRIMARY KEY(tipo);
ALTER TABLE MULTA
ADD CONSTRAINT pkMulta PRIMARY KEY(numero);
ALTER TABLE VEHICULO
ADD CONSTRAINT pkVehiculo PRIMARY KEY(matricula);
ALTER TABLE PERSONA
ADD CONSTRAINT pkPersona PRIMARY KEY(dni);

ALTER TABLE AGENTE
ADD CONSTRAINT fkCuartel FOREIGN KEY(cuartelActual) REFERENCES CUARTEL;
ALTER TABLE MULTA
ADD CONSTRAINT fkMultaAgente FOREIGN KEY(agente) REFERENCES AGENTE;
ALTER TABLE MULTA
ADD CONSTRAINT fkMultaInfraccion FOREIGN KEY(infraccion) REFERENCES INFRACCION;
ALTER TABLE MULTA
ADD CONSTRAINT fkMultaMatricula FOREIGN KEY(vehiculo) REFERENCES VEHICULO;
ALTER TABLE MULTA
ADD CONSTRAINT fkMultaConductor FOREIGN KEY(conductor) REFERENCES PERSONA;
ALTER TABLE VEHICULO
ADD CONSTRAINT fkVehiculoPropietario FOREIGN KEY(propietario) REFERENCES PERSONA;

-- Si algún tipo de dato es distinto entre la tabla origen y la que relaciona, debemos
-- realizar una modificación en una de las dos para que sean los mismos:
ALTER TABLE MULTA
MODIFY infraccion NUMBER(2);
--ALTER TABLE MULTA
--MODIFY conductor NUMBER(8);

ALTER TABLE MULTA
ADD CONSTRAINT ckReconocido CHECK (conductorReconocido IN ('S','N'));
ALTER TABLE PERSONA
ADD CONSTRAINT ckSexo CHECK (sexo IN ('H','M'));

-- 4.	Escribe las sentencias SQL para introducir los datos en las tablas correspondientes
INSERT INTO CUARTEL (codigo,direccion,localidad,dniDirector,telefono,cuartelSuperior)
VALUES (03000,'Oscar Espla, 39','Alicante','05221435','965210066',28000);
INSERT INTO CUARTEL
VALUES (03800,'Juan Gil-Albert, 1','Alcoy','73456777','965331212',03000);
INSERT INTO CUARTEL
VALUES (03820,'Pais Valencia, 166','Cocentaina','54321888','965592211',03800);
INSERT INTO CUARTEL
VALUES (03440,'Germanies, 5','Ibi','21555999','965550022',03000);
INSERT INTO CUARTEL
VALUES (100,'Bailen, 2','Alicante','11111111','965240000',03800);
INSERT INTO CUARTEL
VALUES (200,'Maissonave, 200','Alicante','22222222','965249999',5000);
INSERT INTO CUARTEL
VALUES (300,'Ancha Castelar, 100','San Vicente','33333333','965200033',2000);

INSERT INTO AGENTE (dni,nombre,fNacimiento,categoria,totalMultas,cuartelActual)
VALUES ('21601123','Antoni Peris','11/11/1960','Sargento',null,03820);
INSERT INTO AGENTE
VALUES ('21555999','Arnau Coves','22/02/1950','Teniente',null,03440);
INSERT INTO AGENTE
VALUES ('73456777','Ricard Jover','14/09/1949','Capitán',null,03800);
INSERT INTO AGENTE
VALUES ('54321888','Pere Carbonell','15/05/1955','Teniente',null,03820);
INSERT INTO AGENTE
VALUES ('21606123','Jaume Llopis','22/12/1969','Sargento',null,03800);
INSERT INTO AGENTE
VALUES ('21624222','Eva Segarra','11/03/1972','Agente',null,03800);
INSERT INTO AGENTE
VALUES ('11111111','Armando Guerra','01/01/2000','Sargento',NULL,100);
INSERT INTO AGENTE
VALUES ('22222222','Eva Fina Segura','14/02/2003','Cabo',NULL,200);
INSERT INTO AGENTE
VALUES ('33333333','Aitor Menta','25/12/2002','Teniente',NULL,100);
INSERT INTO AGENTE
VALUES ('44444444','Francisco Cano','09/11/1999','Cabo',NULL,200);

INSERT INTO INFRACCION (tipo,descripcion,importe)
VALUES (1,'Exceso de velocidad',200.00);
INSERT INTO INFRACCION
VALUES (2,'Exceso de alcohol',500.00);
INSERT INTO INFRACCION
VALUES (3,'Adelantamiento incorrecto',360.00);
INSERT INTO INFRACCION
VALUES (4,'Saltarse un semaforo',600.00);
INSERT INTO INFRACCION
VALUES (5,'Vacilada',1.00);
-- El atributo importe lo hemos declarado como NUMBER(3,2)
-- Debemos cambiarlo a NUMBER(5,2)
ALTER TABLE INFRACCION
MODIFY importe NUMBER(5,2);

INSERT INTO PERSONA
VALUES ('11111111A','Ramon Casals','Peru, 4','Alcoy','965331212','H','12/12/1945','21/05/1968');
INSERT INTO PERSONA
VALUES ('22222222B','Jordi Sanus','Sabadell, 22','Alcoy',null,'H','28/02/1955','11/01/1980');
INSERT INTO PERSONA
VALUES ('33333333C','Empar Cascant','Bata, 4','Muro','965531122','M','11/11/1962','11/05/1983');
INSERT INTO PERSONA
VALUES ('44444444D','Joaquin Climent','Mayor, 4','Benilloba',965510066,'H','22/01/1967','22/01/1987');
INSERT INTO PERSONA
VALUES ('55555555E','Andres Trozado','Calle de la Pasa, 1','Alicante','965212211','H','11/05/1989','30/07/2009');
INSERT INTO PERSONA
VALUES ('66666666F','Elba Surero','Calle Rómpete alma, 5','San Vicente','965241122','M','20/09/1993','30/05/2016');
INSERT INTO PERSONA
VALUES ('77777777G','Alex Cremento','Calle Catahuevos, 9','Alicante','965243311','H','07/10/1999','30/05/2018');
INSERT INTO PERSONA
VALUES ('88888888H','Alba Sura','Calle Abrazamozas, 13','San Juan','965240044','H','01/01/1992','10/09/2015');
INSERT INTO PERSONA
VALUES ('99999999I','Aitor Tilla','Calle Salsipuedes, 2','Alicante','965244466','H','14/02/1997','22/06/2016');

INSERT INTO VEHICULO (matricula,fFabricacion,fMatriculacion,potencia,propietario)
VALUES ('A1122CK','21/06/1993','12/10/1993',70,'11111111A');
INSERT INTO VEHICULO
VALUES ('A1123CK','11/05/1993','12/10/1993',90,'11111111A');
INSERT INTO VEHICULO
VALUES ('A4432DD','22/01/1997','15/07/1998',80,'22222222B');
INSERT INTO VEHICULO
VALUES ('V6788GJ','11/11/1996','28/12/1999',80,'33333333C');
INSERT INTO VEHICULO
VALUES ('1111BBB','01/01/1980','01/06/2015',105,'33333333C');
INSERT INTO VEHICULO
VALUES ('2222CCC','01/01/1985','01/06/2015',90,'55555555E');
INSERT INTO VEHICULO
VALUES ('3333DDD','01/01/1990','01/06/2015',70,'77777777G');
INSERT INTO VEHICULO
VALUES ('4444FFF','01/01/1995','01/06/2015',90,'55555555E');
INSERT INTO VEHICULO
VALUES ('5555GGG','01/01/2000','01/06/2015',136,'99999999I');
INSERT INTO VEHICULO
VALUES ('6666HHH','01/01/2005','01/06/2015',150,'99999999I');
INSERT INTO VEHICULO
VALUES ('7777JJJ','01/01/2010','01/06/2015',90,'55555555E');
INSERT INTO VEHICULO
VALUES ('8888KKK','01/01/2015','01/06/2015',70,'55555555E');
INSERT INTO VEHICULO
VALUES ('9999LLL','01/01/2020','01/06/2015',200,'99999999I');

INSERT INTO MULTA (numero,agente,infraccion,vehiculo,conductor,conductorReconocido,fecha,hora,lugar,importe,fechaPago)
VALUES (1001,'21555999',3,'A1122CK','33333333C','S',TO_DATE('08/12/2006','DD/MM/YYYY'),TO_TIMESTAMP ('23:30:00.00','HH24:MI:SS.FF'),'Onil',360.00,'19/12/2006');
INSERT INTO MULTA
VALUES (1002,'21601123',1,'A4432DD',NULL,'N','13/02/2022',TO_TIMESTAMP ('00:15:00.00','HH24:MI:SS.FF'),'Muro',200.00,null);
INSERT INTO MULTA
VALUES (1003,'21624222',4,'V6788GJ','44444444D','S','13/02/2022',TO_TIMESTAMP ('22:00:00.00','HH24:MI:SS.FF'),'Alcoy',600.00,null);
INSERT INTO MULTA
VALUES (1004,'11111111',5,'1111BBB','33333333C','S','13/02/2022',TO_TIMESTAMP ('02:45:00.00','HH24:MI:SS.FF'),'Alicante',500,null);
INSERT INTO MULTA
VALUES (1005,'22222222',2,'2222CCC','11111111A','S','07/04/2021',TO_TIMESTAMP ('09:22:00.00','HH24:MI:SS.FF'),'San Vicente',150,null);
INSERT INTO MULTA
VALUES (1006,'33333333',2,'3333DDD','11111111A','N','21/01/2022',TO_TIMESTAMP ('14:55:00.00','HH24:MI:SS.FF'),'Alicante',220,null);
INSERT INTO MULTA
VALUES (1007,'44444444',5,'4444FFF','66666666F','N','04/10/2021',TO_TIMESTAMP ('19:35:00.00','HH24:MI:SS.FF'),'San Juan',300,null);
INSERT INTO MULTA
VALUES (1008,'11111111',1,'5555GGG','33333333C','S','19/12/2020',TO_TIMESTAMP ('22:47:00.00','HH24:MI:SS.FF'),'Campello',100,null);
INSERT INTO MULTA
VALUES (1009,'22222222',3,'6666HHH','66666666F','S','12/06/2021',TO_TIMESTAMP ('07:15:00.00','HH24:MI:SS.FF'),'Alicante',320,null);
INSERT INTO MULTA
VALUES (1010,'11111111',2,'1111BBB','33333333C','S','13/09/2020',TO_TIMESTAMP ('10:25:00.00','HH24:MI:SS.FF'),'Alicante',170,null);
INSERT INTO MULTA
VALUES (1011,'33333333',2,'3333DDD','11111111A','S','13/09/2020',TO_TIMESTAMP ('23:40:00.00','HH24:MI:SS.FF'),'San Juan',170,null);
INSERT INTO MULTA
VALUES (1012,'11111111',1,'1111BBB','66666666F','S','20/04/2021',TO_TIMESTAMP ('12:35:00.00','HH24:MI:SS.FF'),'San Vicente',150,null);
INSERT INTO MULTA
VALUES (1013,'11111111',2,'8888KKK','11111111A','N','07/03/2021',TO_TIMESTAMP ('13:30:00.00','HH24:MI:SS.FF'),'Alicante',170,null);
INSERT INTO MULTA
VALUES (1014,'22222222',5,'3333DDD','66666666F','N','13/09/2020',TO_TIMESTAMP ('03:50:00.00','HH24:MI:SS.FF'),'Torrevieja',170,null);
INSERT INTO MULTA
VALUES (1015,'11111111',1,'8888KKK','66666666F','S','13/09/2020',TO_TIMESTAMP ('21:10:00.00','HH24:MI:SS.FF'),'San Juan',170,null);
INSERT INTO MULTA
VALUES (1016,'22222222',1,'8888KKK',NULL,'N','07/02/2022',TO_TIMESTAMP ('15:00:00.00','HH24:MI:SS.FF'),'San Vicente',600,null);

--CONSULTAS

--1 Obtén las matrículas de los vehículos que tengan en total más de 3000,00 
--€ de multas pendientes de pagar, de manera que es muestren primero las
--cantidades más elevadas
SELECT vehiculo.matricula, SUM(multa.importe)
FROM vehiculo INNER JOIN multa ON vehiculo.matricula = multa.vehiculo
WHERE multa.fechapago IS NULL
GROUP BY multa.vehiculo
HAVING SUM (importe) > 300

--2 Lista alfabéticamente los nombres de los propietarios de vehículos que
--tengan algún vehículo sin multas.
SELECT nombre
FROM persona INNER JOIN vehiculo ON persona.dni = vehiculo.propietario
WHERE vehiculo.matricula NOT IN (SELECT vehiculo
                                  FROM multa)
ORDER BY persona.nombre

--3 Muestra la media de multas puestas en el año 2006 para cada categoría
--de agente (capitán, teniente,....). Antes es necesario calcular el campo
--total_multas puestas por cada agente. (por acabar)
SELECT agente.categoria, AVG(multa.importe)
FROM agente INNER JOIN multa ON agente.dni = multa.agente
AND to_char(multa.fecha, 'YYYY') = 2006
GROUP BY agente.categoria

--4
SELECT agente.categoria, agente.nombre
FROM agente INNER JOIN multa ON agente.dni = multa.agente
WHERE multa.infraccion = 4
