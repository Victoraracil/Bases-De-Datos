
-- NOMBRE: Victor Aracil

-- NOTA IMPORTANTE:
-- El script SQL debe cargar por completo. Si da fallo, el examen estará
-- Suspendido directamente. En caso de algún error, comenta y continua


-- CREACIÓN DE LAS TABLAS
-- En caso de algún error, corrije el fallo
CREATE TABLE EQUIPO (
    cod_eq VARCHAR2(5),
    nombre VARCHAR2(50),
    entrenador VARCHAR2(50),
	CONSTRAINT pk_EQUIPO PRIMARY KEY (cod_eq)
);

CREATE TABLE DEPORTISTA (
    dni VARCHAR2(12),
    nombre VARCHAR2(40),
    equipo VARCHAR2(5),
	CONSTRAINT pk_DEPORTISTA PRIMARY KEY (dni),
    CONSTRAINT fk_DEP_EQ FOREIGN KEY (equipo) REFERENCES EQUIPO(cod_eq)
);

CREATE TABLE COMPETICION (
    cod_comp NUMBER(3),
    fecha DATE NOT NULL,
    num_equipos NUMBER(2),
	CONSTRAINT pk_COMPETICION PRIMARY KEY (cod_comp)
);

CREATE TABLE PRUEBA (
    cod_prueba NUMBER(3),
    cod_comp NUMBER(3),
    dni VARCHAR2(12),
    rtdo NUMBER(4,2),
    CONSTRAINT pk_PRUEBA PRIMARY KEY (cod_prueba, cod_comp, dni),
    CONSTRAINT FK_PRUEBA_DEP FOREIGN KEY (dni) REFERENCES DEPORTISTA(dni),
    CONSTRAINT FK_PRUEBA_COMP FOREIGN KEY (cod_comp) REFERENCES COMPETICION(cod_comp)
);

-- INSERCIÓN DE DATOS
-- Realizar las siguientes inserciones y en caso de fallo en alguna, hacer los cambios necesarios para que funcione
INSERT INTO EQUIPO (cod_eq, nombre, entrenador) VALUES ('EQ01', 'Tigres del Norte', 'Carlos Méndez');
INSERT INTO EQUIPO VALUES ('EQ02', 'Leones del Sur', 'Ana González');
INSERT INTO EQUIPO VALUES ('EQ03', 'Halcones', 'Luis Ramírez');
INSERT INTO EQUIPO VALUES ('EQ04', 'Hércules', 'Manuel Botella');
INSERT INTO EQUIPO VALUES ('EQ05', 'Movistar', 'Roberto Liaño');
INSERT INTO EQUIPO VALUES ('EQ06', 'San Vicente', 'Eva Fina');
INSERT INTO EQUIPO VALUES ('EQ07', 'Los del este', 'Armando Guerra');

INSERT INTO DEPORTISTA (dni, nombre, equipo) VALUES ('12345678A', 'Juan Pérez', 'EQ01');
INSERT INTO DEPORTISTA VALUES ('87654321B', 'María López', 'EQ01');
INSERT INTO DEPORTISTA VALUES ('11223344C', 'Carlos Sánchez', 'EQ02');
INSERT INTO DEPORTISTA VALUES ('99887766D', 'Lucía Fernández', 'EQ03');
INSERT INTO DEPORTISTA VALUES ('11111111A', 'Maria Garcia', 'EQ02');
INSERT INTO DEPORTISTA VALUES ('22222222B', 'Roberto Molto', 'EQ04');
INSERT INTO DEPORTISTA VALUES ('33333333C', 'Margarita Llorens', 'EQ05');
INSERT INTO DEPORTISTA VALUES ('44444444D', 'Pilar Martinez', 'EQ04');
INSERT INTO DEPORTISTA VALUES ('55555555E', 'Bernardo Castello', 'EQ02');

INSERT INTO COMPETICION (cod_comp, fecha, num_equipos) VALUES (1, '01/06/2025', 2);
INSERT INTO COMPETICION VALUES (2, '10/09/2024', 3);
INSERT INTO COMPETICION VALUES (3, '21/10/2024', 2);
INSERT INTO COMPETICION VALUES (4, '15/11/2024', 3);
INSERT INTO COMPETICION VALUES (5, '05/02/2025', 3);
INSERT INTO COMPETICION VALUES (6, '24/05/2025', 2);

INSERT INTO PRUEBA (cod_prueba, cod_comp, dni, rtdo) VALUES (1, 1, '12345678A', 9.85);
INSERT INTO PRUEBA VALUES (1, 1, '87654321B', 4.10);
INSERT INTO PRUEBA VALUES (2, 2, '11223344C', 8.95);
INSERT INTO PRUEBA VALUES (2, 2, '99887766D', 9.25);
INSERT INTO PRUEBA VALUES (1, 3, '11111111A', 9.5);
INSERT INTO PRUEBA VALUES (2, 4, '22222222B', 7.2);
INSERT INTO PRUEBA VALUES (3, 4, '33333333C', NULL);
INSERT INTO PRUEBA VALUES (1, 5, '11111111A', NULL);
INSERT INTO PRUEBA VALUES (2, 4, '44444444D', NULL);
INSERT INTO PRUEBA VALUES (3, 2, '44444444D', NULL);

-- MODIFICACIONES
-- 1. 
ALTER TABLE equipo
MODIFY nombre VARCHAR2(50) NOT NULL;

-- 2. 


-- 3.
ALTER TABLE competicion
DROP COLUMN cod_comp;

ALTER TABLE competicion
ADD cod_competicion NUMBER(3) AUTO INCREMENT;

-- CONSULTAS / REQUERIMIENTOS
-- No se puede utilizar JOIN salvo que se indique expresamente en la propia CONSULTAS
-- 1. 
SELECT d.dni, d.nombre, e.nombre as equipo
FROM deportista d, equipo e;

-- 2. 
SELECT competicion.cod_comp, competicion.fecha, COUNT(prueba.cod_prueba) as nuem_pruebas
FROM competicion INNER JOIN prueba ON competicion.cod_comp = prueba.cod_comp
GROUP BY competicion.cod_comp, competicion.fecha;

-- 3. 
SELECT nombre, dni
FROM deportista
WHERE dni IN (SELECT dni
                FROM prueba
                WHERE rtdo IS NULL);
                
-- 4. 
SELECT e.nombre 
FROM equipo e, deportista d
WHERE e.cod_eq = d.equipo
AND d.equipo IN (SELECT cod_eq
                    FROM equipo)
GROUP BY e.nombre;

-- 5. 
SELECT *
FROM prueba
WHERE rtdo > 9.80;

-- 6. 

-- 7. 

-- 8. 
SELECT nombre, dni
FROM deportista
WHERE dni IN (SELECT dni, COUNT(cod_comp)
                FROM prueba
                GROUP BY dni);

-- 9. 


-- 10.
SELECT nombre, dni
FROM deportista
WHERE dni NOT IN (SELECT dni, COUNT(cod_comp)
                FROM prueba
                GROUP BY dni);

-- 11. 

-- 12. 

-- 13. 
SELECT *
FROM deportista
WHERE dni IN (SELECT dni, MAX(rtdo)
                FROM prueba);


-- BORRADOS Y ACTUALIZACIONES
-- 1. 
DELETE FROM deportista
WHERE dni NOT IN (
    SELECT dni FROM pruebas WHERE rtdo IS NULL
);


-- 2. 
ALTER TABLE prueba
DROP LINES ;

-- 3. 
ALTER TABLE prueba
UPDATE COLUMN rtdo TO 0.00 WHERE rtdo IN (
    SELECT dni FROM pruebas WHERE rtdo IS NULL


-- 4. 





