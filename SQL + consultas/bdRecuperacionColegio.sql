
-- NOMBRE: Victor Aracil Gozalvez

CREATE TABLE DEPARTAMENTO (
    id VARCHAR2(5),
    nombre VARCHAR2(30),
    CONSTRAINT pk_DEPARTAMENTO PRIMARY KEY (id)
);

CREATE TABLE PROFESOR (
	dni varchar2 (10),
	nombre varchar2 (25), 
	categor�a varchar2 (5), 
	fechainc date,
	dpto VARCHAR2(5),
	CONSTRAINT pk_prof PRIMARY KEY (dni),
	CONSTRAINT fk_prof_depto FOREIGN KEY (dpto) REFERENCES DEPARTAMENTO(id)
);

CREATE TABLE ASIGNATURA (
	codigo varchar2(5),
	descripcion varchar2(40),
	horasP number (3,1),
	horasT number (3,1),
	CONSTRAINT pk_asig PRIMARY KEY (codigo)
);

CREATE TABLE IMPARTIR (
	dni varchar2(10),
	codigo varchar2(5),
	CONSTRAINT pk_imp PRIMARY KEY (dni,codigo),
	CONSTRAINT fk_imp_prof FOREIGN KEY (dni) REFERENCES PROFESOR (dni),
	CONSTRAINT fk_imp_asig FOREIGN KEY (codigo) REFERENCES ASIGNATURA (codigo)
);

-- INSERCI�N DE DATOS
-- Realizar las siguientes inserciones y en caso de fallo en alguna, hacer los cambios necesarios para que funcione
INSERT INTO DEPARTAMENTO VALUES ('INF', 'Inform�tica');
INSERT INTO DEPARTAMENTO VALUES ('D01', 'Ciencias Exactas');
INSERT INTO DEPARTAMENTO VALUES ('D02', 'F�sica y Qu�mica');

INSERT INTO PROFESOR VALUES ('11111111A', 'Manuel Botella', 'Prov', '01/09/2016', 'INF');
INSERT INTO PROFESOR VALUES ('22222222B', 'Eva Fina Segura', 'Fijo', '01/09/2005', 'D02');
INSERT INTO PROFESOR VALUES ('33333333C', 'Armando Guerra', 'Prov', '01/05/2011', 'INF');
INSERT INTO PROFESOR VALUES ('44444444D', 'Pulpito Caido', 'Fijo', '01/09/2009', 'D01');
INSERT INTO PROFESOR VALUES ('12345678A', 'Ana Torres', 'Tit', '01/09/2010', 'INF');
INSERT INTO PROFESOR VALUES ('23456789B', 'Luis G�mez', 'Tutor', '01/09/2015', 'D02');
INSERT INTO PROFESOR VALUES ('34567890C', 'Marta R�os', 'Int', '15/02/2015', 'D02');

INSERT INTO IMPARTIR VALUES ('11111111A', 'BD');
INSERT INTO IMPARTIR VALUES ('22222222B', 'ED');
INSERT INTO IMPARTIR VALUES ('33333333C', 'LM');
INSERT INTO IMPARTIR VALUES ('44444444D', 'SI');
INSERT INTO IMPARTIR VALUES ('12345678A', 'MAT01');
INSERT INTO IMPARTIR VALUES ('23456789B', 'FIS01');
INSERT INTO IMPARTIR VALUES ('34567890C', 'QUI01');

INSERT INTO ASIGNATURA (codigo, descripcion, horasP, horasT)
VALUES ('BD', 'Bases de Datos', 1.5, 3.5);
INSERT INTO ASIGNATURA (codigo, descripcion, horasP, horasT)
VALUES ('Prog', 'Programaci�n', 6.5, 1.5);
INSERT INTO ASIGNATURA (codigo, descripcion, horasP, horasT)
VALUES ('ED', 'Entornos de Desarrollo', 2.5, 0.5);
INSERT INTO ASIGNATURA (codigo, descripcion, horasP, horasT)
VALUES ('LM', 'Lenguaje de Marcas', 2.5, 0.5);
INSERT INTO ASIGNATURA (codigo, descripcion, horasP, horasT)
VALUES ('SI', 'Sistemas Inform�ticos', 3.5, 1.5);
INSERT INTO ASIGNATURA (codigo, descripcion, horasP, horasT)
VALUES ('FOL', 'Formaci�n y Orientaci�n Laboral', 2.0, 1.0);
INSERT INTO ASIGNATURA VALUES ('MAT01', 'Matem�ticas I', 2.0, 3.0);
INSERT INTO ASIGNATURA VALUES ('FIS01', 'F�sica I', 1.0, 4.0);
INSERT INTO ASIGNATURA VALUES ('QUI01', 'Qu�mica I', 1.5, 3.5);



-- MODIFICACIONES
-- 1.
ALTER TABLE asignatura
MODIFY COLUMN horasP
ADD RESTRICTION horasP NOT < 0;
ALTER TABLE asignatura
MODIFY COLUMN horasT
ADD RESTRICTION horasT NOT < 0;

-- 2. 
ALTER TABLE PROFESOR
ADD COLUMN email VARCHAR2 (50);

-- 3. 
ALTER TABLE ASIGNATURA
MODIFY COLUMN descripcion varchar2 (50) TO varchar2 (100);

-- 4. 
ALTER TABLE PROFESOR --Seria restarla a la fecha actual y que no diese mas de 30, 30 es el maximo
ADD RESTRICT fechainc NOT 30;

-- 5. 
ALTER TABLE PROFESOR
DROP COLUMN categoria

-- 6.
ALTER TABLE PROFESOR
RENAME COLUMN dpto TO departamento;

-- 7. 

-- 8. 


-- CONSULTAS / REQUERIMIENTOS
-- No se puede utilizar JOIN salvo que se indique expresamente en la propia CONSULTAS

-- 1. 
SELECT nombre, fechainc, departamento
FROM PROFESOR;

-- 2. 
SELECT *
FROM ASIGNATURA
WHERE (horasp + horast) > 4

-- 3. 
SELECT profesor.nombre, impartir.codigo
FROM profesor INNER JOIN impartir ON profesor.dni = impartir.dni

-- 4. 
SELECT nombre
FROM profesor
WHERE dni NOT IN (SELECT dni
                    FROM impartir)

-- 5. 
SELECT * 
FROM asignatura
WHERE horasp > horast

-- 6. 
SELECT nombre
FROM profesor
WHERE UPPER(departamento) LIKE 'INF'

-- 7.
SELECT *
FROM profesor p, impartir i, asignatura a
WHERE p.dni = i.dni
AND i.codigo = a. codigo

-- 8. 
SELECT p.nombre
FROM profesor p, impartir i
WHERE p.dni = i.dni
AND p.dni IN i.dni 

-- 9. 
SELECT asignatura.descripcion
FROM asignatura INNER JOIN impartir ON asignatura.codigo = impartir.codigo
WHERE 

-- 10.
SELECT *
FROM profesor 
WHERE TO_CHAR (fechainc, 'YYYY') < 2000;

-- 11. 
SELECT UPPER(nombre), fechainc
FROM profesor

-- 12. 
SELECT *
FROM profesor
WHERE CONCAT (dni + '@correo.com')

-- 13. 
SELECT *
FROM profesor

-- 14.
SELECt *
FROM profesor

-- 15. 
SELECt *
FROM profesor

-- 16. 
SELECT AVG(horast + horasp)
FROM asignatura a, profesor p, departamento d
WHERE a.dni = p.dni
AND p.departamento = d.id

-- 17. 


-- 18. 

-- 19. 

-- 20. 

-- BORRADOS Y ACTUALIZACIONES
-- 1. 

-- 2. 

-- 3. 

-- 4. 

-- 5. 

-- 6. 

-- 7. 

-- 8. 

