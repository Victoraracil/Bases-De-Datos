
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

INSERT INTO IMPARTIR VALUES ('11111111A', 'BD');
INSERT INTO IMPARTIR VALUES ('22222222B', 'ED');
INSERT INTO IMPARTIR VALUES ('33333333C', 'LM');
INSERT INTO IMPARTIR VALUES ('44444444D', 'SI');
INSERT INTO IMPARTIR VALUES ('12345678A', 'MAT01');
INSERT INTO IMPARTIR VALUES ('23456789B', 'FIS01');
INSERT INTO IMPARTIR VALUES ('34567890C', 'QUI01');



-- MODIFICACIONES
-- 1.
ALTER TABLE asignatura
ADD CHECK(horasp >= 0);

ALTER TABLE asignatura
ADD CHECK(horast >= 0);

-- 2. 
ALTER TABLE PROFESOR
ADD email VARCHAR2(50);  --falta el no null

-- 3. 
ALTER TABLE ASIGNATURA
MODIFY descripcion varchar2 (100);

-- 4. 
ALTER TABLE PROFESOR
ADD CONSTRAINT chk_antiguedad CHECK (fechainc >= DATE '1995-06-17')

-- 5. 
ALTER TABLE PROFESOR
DROP COLUMN categoria

-- 6.
ALTER TABLE PROFESOR
RENAME COLUMN dpto TO departamento;

-- 7. 
ALTER TABLE IMPARTIR 
DROP CONSTRAINT FK_IMPARTIR_ASIGNATURA;

-- 8.
ALTER TABLE PROFESOR
ADD UNIQUE (email); 


-- CONSULTAS / REQUERIMIENTOS
-- No se puede utilizar JOIN salvo que se indique expresamente en la propia CONSULTAS

-- 1. 
SELECT nombre, fechainc, departamento
FROM PROFESOR;

-- 2. 
SELECT codigo, descripcion, SUM(horast + horasp) AS totalhoras
FROM ASIGNATURA 
GROUP BY codigo, descripcion;

-- 3. 
SELECT profesor.nombre, COUNT(DISTINCT impartir.codigo) AS num_asignaturas
FROM profesor INNER JOIN impartir ON profesor.dni = impartir.dni
GROUP BY profesor.nombre;

-- 4. 
SELECT nombre
FROM profesor
WHERE dni NOT IN (
    SELECT dni 
	FROM impartir 
	WHERE dni IS NOT NULL
);

-- 5. 
SELECT * 
FROM asignatura
WHERE horasp > horast;

-- 6. 
SELECT nombre
FROM profesor
WHERE UPPER(departamento) LIKE 'INF';

-- 7.
SELECT p.nombre, SUM(horasp + horast) AS totalhoras
FROM profesor p, impartir i, asignatura a 
WHERE p.dni = i.dni
AND i.codigo = a. codigo
GROUP BY p.nombre;

-- 8. 
SELECT p.nombre
FROM profesor p, impartir i
WHERE p.dni = i.dni
GROUP BY p.nombre
HAVING COUNT(DISTINCT i.codigo) = 2;

-- 9. 
SELECT a.descripcion
FROM asignatura a LEFT JOIN impartir i ON a.codigo = i.codigo
WHERE i.codigo IS NULL;

-- 10.
SELECT nombre, fechainc
FROM profesor
WHERE fechainc = (SELECT MIN(fechainc) 
                    FROM profesor);

-- 11. 
SELECT UPPER(nombre), fechainc
FROM profesor;

-- 12. 
SELECT nombre
FROM profesor
WHERE email = dni || '@correo.com';

-- 13. 
SELECT dni, nombre, fechainc, TRUNC(SYSDATE - fechainc) AS dias_desde_incorporacion
FROM PROFESOR;

-- 14.
SELECT nombre,(
        SELECT COUNT(*)
        FROM IMPARTIR i
        WHERE i.dni = p.dni
    ) AS num_asignaturas
FROM PROFESOR p
WHERE (
        SELECT COUNT(*)
        FROM IMPARTIR i2
        WHERE i2.dni = p.dni
    ) > (
        SELECT AVG(asigs)
        FROM (
            SELECT COUNT(*) AS asigs
            FROM IMPARTIR
            GROUP BY dni
        )
    );


-- 15. 
SELECT 
    NOMBRE,
    NVL(
        (SELECT NOMBRE FROM DEPARTAMENTO D WHERE D.ID = P.DEPARTAMENTO),
        'Sin departamento'
    ) AS NOMBRE_DEPARTAMENTO
FROM PROFESOR P;

-- 16. 
SELECT
    d.nombre AS departamento,
    (
        SELECT AVG(a.horasP)
        FROM ASIGNATURA a
        WHERE a.codigo IN (
            SELECT i.codigo
            FROM IMPARTIR i
            WHERE i.dni IN (
                SELECT p.dni
                FROM PROFESOR p
                WHERE p.departamento = d.id
            )
        )
    ) AS media_horas_practicas,
    (
        SELECT AVG(a.horasT)
        FROM ASIGNATURA a
        WHERE a.codigo IN (
            SELECT i.codigo
            FROM IMPARTIR i
            WHERE i.dni IN (
                SELECT p.dni
                FROM PROFESOR p
                WHERE p.departamento = d.id
            )
        )
    ) AS media_horas_teoricas
FROM DEPARTAMENTO d;

-- 17. 
SELECT 
    TO_CHAR(fechainc, 'YYYY') AS anio_incorporacion,
    COUNT(*) AS total_profesores
FROM PROFESOR
GROUP BY TO_CHAR(fechainc, 'YYYY')
ORDER BY anio_incorporacion;

-- 18. 
SELECT nombre
FROM PROFESOR p
WHERE
    -- El profesor pertenece a cualquier departamento (o podrías filtrar si quieres)
    -- Y no existe ninguna asignatura impartida en 'INF' que NO imparta este profesor
    NOT EXISTS (
        SELECT codigo
        FROM IMPARTIR i_inf
        WHERE i_inf.dni IN (
            SELECT dni FROM PROFESOR WHERE departamento = 'INF'
        )
        AND codigo NOT IN (
            SELECT codigo
            FROM IMPARTIR i_p
            WHERE i_p.dni = p.dni
        )
    );

-- 19. 
SELECT COUNT(*) AS num_asignaturas_repe
FROM (
    SELECT codigo
    FROM IMPARTIR
    GROUP BY codigo
    HAVING COUNT(dni) > 1
);

-- 20. 
SELECT
    p.nombre,
    EXTRACT(YEAR FROM p.fechainc) AS anio_incorporacion,
    (
        SELECT LISTAGG(a.descripcion, ', ') WITHIN GROUP (ORDER BY a.descripcion)
        FROM ASIGNATURA a
        WHERE a.codigo IN (
            SELECT i.codigo
            FROM IMPARTIR i
            WHERE i.dni = p.dni
        )
    ) AS asignaturas
FROM PROFESOR p;

-- BORRADOS Y ACTUALIZACIONES
-- 1. 
DELETE FROM PROFESOR
WHERE dni NOT IN (
    SELECT DISTINCT dni FROM IMPARTIR
);

-- 2. 
DELETE FROM ASIGNATURA
WHERE NVL(horasP, 0) + NVL(horasT, 0) < 1;

-- 3. 
-- Paso 1: Eliminar relaciones en IMPARTIR
DELETE FROM IMPARTIR
WHERE dni IN (
    SELECT dni FROM PROFESOR WHERE departamento = 'D01'
);

-- Paso 2: Eliminar profesores del departamento D01
DELETE FROM PROFESOR
WHERE departamento = 'D01';

-- 4. 
DELETE FROM IMPARTIR
WHERE dni IN (
    SELECT dni FROM PROFESOR
    WHERE fechainc < TO_DATE('01-01-2010', 'DD-MM-YYYY')
);

DELETE FROM PROFESOR
WHERE fechainc < TO_DATE('01-01-2010', 'DD-MM-YYYY');

-- 5. 
UPDATE PROFESOR
SET departamento = 'INF'
WHERE MONTHS_BETWEEN(SYSDATE, fechainc) >= 120;

-- 6. 
UPDATE ASIGNATURA
SET horasT = NVL(horasT, 0) + 1
WHERE codigo IN (
    SELECT codigo FROM IMPARTIR
    WHERE dni IN (
        SELECT dni FROM PROFESOR WHERE departamento = 'D02'
    )
);

-- 7. 
UPDATE ASIGNATURA
SET horasP = NVL(horasP, 0) + 1.5
WHERE descripcion LIKE '%Programación%';	

-- 8. 
UPDATE PROFESOR
SET departamento = 'D01'
WHERE nombre LIKE 'Gómez%';

