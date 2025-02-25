DROP TABLE PROYECTO cascade constraints;
DROP TABLE DEPARTAMENTO cascade constraints;
DROP TABLE EMPLEADO cascade constraints;
DROP TABLE ASIGNAR cascade constraints;
DROP VIEW personas cascade constraints;
DROP VIEW empleados cascade constraints;
DROP VIEW proyectos cascade constraints;



-- Crear tabla PROYECTO
CREATE TABLE PROYECTO (
    codigo CHAR(3) PRIMARY KEY,
    descripcion VARCHAR(40),
    finicio DATE,
    ffinal DATE,
    presupuesto INTEGER,
    nivel number(3)
);

-- Crear tabla DEPARTAMENTO
CREATE TABLE DEPARTAMENTO (
    codigo CHAR(3) PRIMARY KEY,
    nombre VARCHAR(25),
    fcreacion DATE
);

-- Crear tabla EMPLEADO
CREATE TABLE EMPLEADO (
    nif CHAR(9) PRIMARY KEY,
    nombre VARCHAR(40),
    fnac DATE,
    direccion VARCHAR(25),
    localidad VARCHAR(15),
    nivel number(3),
    departamento CHAR(3),
    FOREIGN KEY (departamento) REFERENCES DEPARTAMENTO(codigo)
);

-- Crear tabla ASIGNAR
CREATE TABLE ASIGNAR (
    nif CHAR(9),
    proyecto CHAR(3),
    horas number(3),
    PRIMARY KEY (nif, proyecto),
    FOREIGN KEY (nif) REFERENCES EMPLEADO(nif),
    FOREIGN KEY (proyecto) REFERENCES PROYECTO(codigo)
);

--Crea las siguientes vistas
--a. Vista para trabajar con el código, descripción y nivel de aquellos
--proyectos de nivel inferior a 15
CREATE VIEW personas AS
SELECT codigo, descripcion, nivel
FROM proyecto
WHERE nivel < 15

--b. Vista para trabajar con los datos de los empleados de nivel menor que
--17. Hazlo con la opción WITH CHECK OPTION
CREATE VIEW empleados AS
SELECT *
FROM empleado
WHERE nivel < 15 WITH CHECK OPTION

--c. Vista donde se vea, para los proyectos con empleados asignados, el
--código de un proyecto y el número total de empleados que tiene
--asignados.
CREATE VIEW proyectos AS
SELECT COUNT(*) nif
FROM asignar
WHERE proyecto IN proyecto

-- Insertar datos en DEPARTAMENTO
INSERT INTO DEPARTAMENTO (codigo, nombre, fcreacion) VALUES ('AAA', 'ADMINISTRACION', '2016-03-24');
INSERT INTO DEPARTAMENTO (codigo, nombre, fcreacion) VALUES('VVV', 'VARIOS', '2016-03-24');
INSERT INTO DEPARTAMENTO (codigo, nombre, fcreacion) VALUES ('DDD', 'DESARROLLO', '2016-03-24'); 
INSERT INTO DEPARTAMENTO (codigo, nombre, fcreacion) VALUES('GGG', 'GESTIÓN', '2016-03-24');

-- Insertar datos en EMPLEADO
INSERT INTO EMPLEADO (nif, nombre, fnac, direccion, localidad, nivel, departamento) VALUES ('11111111A', 'ARMANDO GUERRA', '1976-04-25', 'ARRIBA 7', 'ALICANTE', 17, NULL);
INSERT INTO EMPLEADO (nif, nombre, fnac, direccion, localidad, nivel, departamento) VALUES ('33333333C', 'EVA FINA', '1974-11-22', 'ABAJO, 8', 'ALICANTE', 16, 'AAA');
INSERT INTO EMPLEADO (nif, nombre, fnac, direccion, localidad, nivel, departamento) VALUES ('22222222B', 'MANI ATICO', '1972-02-25', 'ABAJO, 8', 'ALICANTE', 17, 'AAA');
INSERT INTO EMPLEADO (nif, nombre, fnac, direccion, localidad, nivel, departamento) VALUES ('44444444D', 'POL RARO', '1975-10-12', 'ESTRECHA, 12', 'ALICANTE', 15, NULL);

-- Insertar datos en PROYECTO
INSERT INTO PROYECTO (codigo, descripcion, finicio, ffinal, presupuesto, nivel) VALUES ('A10', 'VARIACIONES DE LA HOLGURA', '1998-03-27', '1998-12-10', 550, 16);
INSERT INTO PROYECTO (codigo, descripcion, finicio, ffinal, presupuesto, nivel) VALUES ('B10', 'XMP CON DATOS SINTÉTICOS', '1998-04-29', '1999-04-29', 6000, 12);

-- Insertar datos en ASIGNAR
INSERT INTO ASIGNAR (nif, proyecto, horas) VALUES ('11111111A', 'A10', 6);
INSERT INTO ASIGNAR (nif, proyecto, horas) VALUES ('44444444D', 'A10', 4);