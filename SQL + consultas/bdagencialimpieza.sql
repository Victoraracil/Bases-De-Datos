-- CREACIÓN DE TABLAS

CREATE TABLE EMPLEADO (
    NIF CHAR(9),
    NOMBRE VARCHAR2(25),
    DIRECCION VARCHAR2(50),
    POBLACION VARCHAR2(15),
    TELEFONO CHAR(11),
    NACIMIENTO DATE,
    CONSTRAINT pkEMPLEADO PRIMARY KEY (NIF)
);

CREATE TABLE PROPIETARIO (
    CIF CHAR(9),
    NOMBRE VARCHAR2(25),
    DIRECCION VARCHAR2(50),
    POBLACION VARCHAR2(15),
    PROVINCIA VARCHAR2(15),
    TELEFONO CHAR(11),
    ACTIVIDAD VARCHAR2(15),
    CONSTRAINT pkPROPIETARIO PRIMARY KEY (CIF)
);

CREATE TABLE SERVICIO (
    CODIGO CHAR(10),
    TURNO VARCHAR2(10),
    ACTIVIDAD VARCHAR2(15),
    TARIFA NUMBER(6),
    CONSTRAINT pkSERVICIO PRIMARY KEY (CODIGO)
);

CREATE TABLE VIVIENDA (
    DIRECCION CHAR(25),
    POBLACION VARCHAR2(15),
    TELEFONO CHAR(12),
    UTIL NUMBER,
    CRISTAL NUMBER,
    WC NUMBER,
    SUELO VARCHAR2(15),
    CIF CHAR(9) NOT NULL,
    CONSTRAINT pkVIVIENDA PRIMARY KEY (TELEFONO),
    CONSTRAINT fkVIVIENDA_PROPIETARIO FOREIGN KEY (CIF) REFERENCES PROPIETARIO(CIF)
);

CREATE TABLE ARTICULO (
    NOMBRE VARCHAR2(25),
    CAPACIDAD NUMBER(4,2),
    DESCRIPCION VARCHAR2(50),
    PRECIO NUMBER(6),
    CONSTRAINT pkARTICULO PRIMARY KEY (NOMBRE, CAPACIDAD)
);

CREATE TABLE CONTRATAR (
    CODIGO CHAR(10),
    TELEFONO CHAR(12),
    CONSTRAINT pkCONTRATAR PRIMARY KEY (CODIGO, TELEFONO),
    CONSTRAINT fkCONTRATAR_SERVICIO FOREIGN KEY (CODIGO) REFERENCES SERVICIO(CODIGO),
    CONSTRAINT fkCONTRATAR_VIVIENDA FOREIGN KEY (TELEFONO) REFERENCES VIVIENDA(TELEFONO)
);

CREATE TABLE ASIGNAR (
    NIF VArCHAR2(25),
    NOMBRE VARCHAR2(15),
    CAPACIDAD NUMBER(4,2),
    TELEFONO CHAR(12),
    CANTIDAD NUMBER(6),
    CONSTRAINT pkASIGNAR PRIMARY KEY (NIF, NOMBRE, CAPACIDAD, TELEFONO),
    CONSTRAINT fkASIGNAR_EMPLEADO FOREIGN KEY (NIF) REFERENCES EMPLEADO(NIF),
    CONSTRAINT fkASIGNAR_ARTICULO FOREIGN KEY (NOMBRE, CAPACIDAD) REFERENCES ARTICULO(NOMBRE, CAPACIDAD),
    CONSTRAINT fkASIGNAR_VIVIENDA FOREIGN KEY (TELEFONO) REFERENCES VIVIENDA(TELEFONO)
);

-- MODIFICACIONES/ALTERACIONES SOBRE LAS TABLAS
-- 1. Agrega una columna EMAIL a la tabla EMPLEADO.
ALTER TABLE EMPLEADO
ADD COLUMN EMAIL VARCHAR2(30)

-- 2. Cambia el tamaño del campo DIRECCION en la tabla VIVIENDA a 50 caracteres.
ALTER TABLE VIVIENDA
MODIFY COLUMN DIRECCION VARCHAR2(50);

-- 3. Elimina la columna DESCRIPCION de la tabla ARTICULO.
ALTER TABLE ARTICULO
DROP COLUMN DESCRIPCION

-- 4. Cambia el nombre de la columna NOMBRE en PROPIETARIO a RAZON_SOCIAL.
ALTER TABLE PROPIETARIO
RENAME COLUMN NOMBRE TO RAZON_SOCIAL

-- 5. Agrega una relación entre EMPLEADO.TELEFONO y VIVIENDA.TELEFONO (suponiendo que tenga sentido en tu modelo):
ALTER TABLE EMPLEADO
ADD contraint fk_telefono_vivienda FOREIGN KEY REFERENCES ()

-- 6. Elimina la clave foránea fkASIGNAR_VIVIENDA.
ALTER TABLE EMPLEADO
DROP contraint fk_telefono_vivienda

-- 7. Cambia el nombre de la tabla SERVICIO a SERVICIOS.
ALTER TABLE SERVICIO
RENAME SERVICIOS

-- 8. Agrega una restricción para que WC en VIVIENDA no sea negativo.


-- 9. Todas las claves ajenas deben realizar borrados en cascada
ALTER TABLE VIVIENDA


-- 10. La fecha de nacimiento siempre deberá ser menor que la fecha actual del sistema
ALTER TABLE EMPLEADO 
ADD CHECK

-- INSERCION DE DATOS EN LAS TABLAS

INSERT INTO EMPLEADO (NIF, NOMBRE, DIRECCION, POBLACION, TELEFONO, NACIMIENTO)
VALUES ('12345678A', 'Laura Pérez', 'Calle Mayor 10', 'Alicante', '600123456', TO_DATE('12/06/1985','DD/MM/YYYY'));
INSERT INTO EMPLEADO
VALUES ('87654321B', 'Juan Martínez', 'Av. Elche 22', 'San Vicente', '600654321', TO_DATE('25/03/1990','DD/MM/YYYY'));
INSERT INTO EMPLEADO
VALUES ('23456789C', 'María Gómez', 'Calle Luna 12', 'Benidorm', '600111222', TO_DATE('10/05/1982','DD/MM/YYYY'), 'maria.gomez@email.com');
INSERT INTO EMPLEADO
VALUES ('34567890D', 'Carlos Ruiz', 'Calle Olivo 8', 'Elche', '600222333', TO_DATE('02/11/1978','DD/MM/YYYY'), 'carlos.ruiz@email.com');
INSERT INTO EMPLEADO
VALUES ('45678901E', 'Ana Torres', 'Av. Ifach 14', 'Calpe', '600333444', TO_DATE('17/07/1993','DD/MM/YYYY'), 'ana.torres@email.com');
INSERT INTO EMPLEADO
VALUES ('56789012F', 'Luis Ibáñez', 'Calle Laurel 7', 'Denia', '600444555', TO_DATE('29/08/1988','DD/MM/YYYY'), 'luis.ibanez@email.com');
INSERT INTO EMPLEADO
VALUES ('67890123G', 'Elena Vidal', 'Plaza Mayor 2', 'Elda', '600555666', TO_DATE('13/01/1991','DD/MM/YYYY'), 'elena.vidal@email.com');

INSERT INTO PROPIETARIO (CIF, NOMBRE, DIRECCION, POBLACION, PROVINCIA, TELEFONO, ACTIVIDAD)
VALUES ('P1234567X', 'Grupo Costablanca', 'Av. Mediterráneo 15', 'Alicante', 'Alicante', '966111222', 'Alquiler');
INSERT INTO PROPIETARIO
VALUES ('P7654321Y', 'Viviendas Sur', 'Calle Colón 8', 'San Juan', 'Alicante', '966333444', 'Compra-Venta');
INSERT INTO PROPIETARIO
VALUES ('P2345678Z', 'Inmobiliaria Norte', 'Calle Norte 3', 'Benidorm', 'Alicante', '966555111', 'Alquiler');
INSERT INTO PROPIETARIO
VALUES ('P3456789W', 'Costa Levante S.L.', 'Av. Sol 9', 'Calpe', 'Alicante', '966666222', 'Compra-Venta');
INSERT INTO PROPIETARIO
VALUES ('P4567890V', 'Grupo Altamar', 'Calle Mar 20', 'Torrevieja', 'Alicante', '966777333', 'Alquiler');
INSERT INTO PROPIETARIO
VALUES ('P5678901U', 'Residencias Este', 'Paseo Playa 5', 'Elche', 'Alicante', '966888444', 'Residencias');
INSERT INTO PROPIETARIO
VALUES ('P6789012T', 'Viviendas Norte', 'Av. Montaña 11', 'Alcoy', 'Alicante', '966999555', 'Alquiler');


INSERT INTO VIVIENDA (DIRECCION, POBLACION, TELEFONO, UTIL, CRISTAL, WC, SUELO, CIF)
VALUES ('Calle Sol 5', 'Altea', '965111111', 80, 20, 2, 'Mármol', 'P1234567X');
INSERT INTO VIVIENDA
VALUES ('Av. del Mar 23', 'Orihuela', '965222222', 95, 25, 2, 'Parqué', 'P7654321Y');
INSERT INTO VIVIENDA
VALUES ('Calle Luna 3', 'Benidorm', '965333333', 70, 18, 1, 'Gres', 'P2345678Z');
INSERT INTO VIVIENDA
VALUES ('Av. Sol 12', 'Calpe', '965444444', 85, 22, 2, 'Tarima', 'P3456789W');
INSERT INTO VIVIENDA
VALUES ('Calle Mar 25', 'Torrevieja', '965555555', 100, 28, 3, 'Parqué', 'P4567890V');
INSERT INTO VIVIENDA
VALUES ('Paseo Playa 10', 'Elche', '965666666', 75, 20, 2, 'Mármol', 'P5678901U');
INSERT INTO VIVIENDA
VALUES ('Av. Montaña 7', 'Alcoy', '965777777', 90, 24, 2, 'Gres', 'P6789012T');

INSERT INTO SERVICIO (CODIGO, TURNO, ACTIVIDAD, TARIFA)
VALUES ('S001', 'Mañana', 'Limpieza', 120.50);
INSERT INTO SERVICIO
VALUES ('S002', 'Tarde', 'Mantenimiento', 150.00);
INSERT INTO SERVICIOS
VALUES ('S003', 'Noche', 'Jardinería', 200.00);
INSERT INTO SERVICIOS
VALUES ('S004', 'Mañana', 'Piscinas', 180.50);
INSERT INTO SERVICIOS
VALUES ('S005', 'Tarde', 'Electricidad', 250.00);
INSERT INTO SERVICIOS
VALUES ('S006', 'Noche', 'Fontanería', 210.75);
INSERT INTO SERVICIOS
VALUES ('S007', 'Mañana', 'Pintura', 190.00);

INSERT INTO CONTRATAR (CODIGO, TELEFONO)
VALUES ('S001', '965111111');
INSERT INTO CONTRATAR
VALUES ('S002', '965222222');
INSERT INTO CONTRATAR
VALUES ('S003', '965333333');
INSERT INTO CONTRATAR
VALUES ('S004', '965444444');
INSERT INTO CONTRATAR
VALUES ('S005', '965555555');
INSERT INTO CONTRATAR
VALUES ('S006', '965666666');
INSERT INTO CONTRATAR
VALUES ('S007', '965777777');

INSERT INTO ARTICULO (NOMBRE, CAPACIDAD, DESCRIPCION, PRECIO)
VALUES ('Limpiador', 1.00, 'Desinfectante base', 4.5);
INSERT INTO ARTICULO
VALUES ('Detergente', 2.00, 'Líquido lavadora', 6.0);
INSERT INTO ARTICULO
VALUES ('Desinfectante', 1.50, 5.0);
INSERT INTO ARTICULO
VALUES ('Limpiacristales', 0.75, 3.8);
INSERT INTO ARTICULO
VALUES ('Fregasuelos', 2.00, 4.0);
INSERT INTO ARTICULO
VALUES ('Aromatizante', 0.50, 2.5);
INSERT INTO ARTICULO
VALUES ('Quitagrasas', 1.25, 5.5);

INSERT INTO ASIGNAR (NIF, NOMBRE, CAPACIDAD, TELEFONO, CANTIDAD)
VALUES ('12345678A', 'Limpiador', 1.00, '965111111', 5);
INSERT INTO ASIGNAR
VALUES ('87654321B', 'Detergente', 2.00, '965222222', 3);
INSERT INTO ASIGNAR
VALUES ('23456789C', 'Desinfectante', 1.50, '965333333', 4);
INSERT INTO ASIGNAR
VALUES ('34567890D', 'Limpiacristales', 0.75, '965444444', 2);
INSERT INTO ASIGNAR
VALUES ('45678901E', 'Fregasuelos', 2.00, '965555555', 3);
INSERT INTO ASIGNAR
VALUES ('56789012F', 'Aromatizante', 0.50, '965666666', 6);
INSERT INTO ASIGNAR
VALUES ('67890123G', 'Quitagrasas', 1.25, '965777777', 5);

-- CONSULTAS / REQUERIMIENTOS

-- 1. Mostrar nombre, dirección y telefono de todos los empleados
SELECT nombre, direccion, telefono
FROM empleados

-- 2. Obtener nombre y teléfono de todos los propietarios
SELECT nombre, telefono
FROM propietarios

-- 3. Obtener un listado con todas las viviendas ubicadas en “Calpe”
SELECT *
FROM vivienda
WHERE UPPER(poblacion) = "CALPE"

-- 4. Mostrar nombre y tarifa de todos los servicios ordenados por tarifa descendente
SELECT nombre, tarifa
FROM servicio
ORDER BY tarifa DESC

-- 5. Nombre y precio de los artículos con un precio menor a 5 euros
SELECT nombre, precio
FROM artículo
WHERE precio < 5

-- 6. Mostrar los empleados que trabajan en viviendas con más de 1 WC
SELECT nombre
FROM empleado e, vivienda a, vivienda v
WHERE e.dni = a.dni
AND v.tel = a.tel
AND wc > 1

-- 7. Mostrar los servicios contratados por cada vivienda (dirección y actividad)
SELECT v.direccion, s.actividad
FROM vivienda v, servicio s, contratar c
WHERE v.telefono = c.telefono
AND s.codigo = c.codigo;

-- 8. Contar cuántas viviendas hay por cada propietario
SELECT p.nombre, COUNT(v.id) AS num_viviendas
FROM propietarios p, vivienda v
WHERE p.nif = v.nif
GROUP BY p.nombre;

-- 9. Mostrar los empleados nacidos antes del año 1990
SELECT *
FROM EMPLEADOS
WHERE TO_CHAR(NACIMIENTO, 'YYYY') < 1990

-- 10. Ver qué artículos han sido asignados a la vivienda con teléfono '965111111'
SELECT a.nombre, a.capacidad, a.descripcion, a.precio
FROM artículo a, asignar b, vivienda v
WHERE a.nombre = b.nombre
AND b.nif = v.nif
AND v.telefono = '965111111';

-- 11. Mostrar el nombre de cada empleado junto con el número total de artículos que se le han asignado
SELECT e.nombre, COUNT(a.cantidad) AS total_articulos
FROM empleados e, asignar a
WHERE e.dni = a.dni
GROUP BY e.nombre;

-- 12. Listar los artículos que han sido asignados a más de una vivienda distinta
SELECT a.nombre, a.capacidad, a.descripcion, a.precio
FROM artículo a, asignar b, vivienda c
WHERE a.nombre = b.nombre
AND b.nif = c.nif
GROUP BY a.nombre AND a.capacidad
HAVING COUNT(DISTINCT c.telefono) > 1;

-- 13. Mostrar el nombre y email de los empleados que no tienen asignado ningún artículo
SELECT e.nombre, e.email
FROM empleados e
WHERE NOT EXISTS (
    SELECT 1
    FROM asignar a
    WHERE a.nif = e.nif
);

-- 14. Obtener la vivienda con mayor superficie útil (UTIL)
SELECT *
FROM vivienda
WHERE util = (SELECT MAX(util) FROM vivienda);


-- 15. Listar las viviendas y el número de servicios que tienen contratados
SELECT v.direccion, COUNT(c.codigo) AS num_servicios
FROM vivienda v
JOIN contratar c ON v.telefono = c.telefono
GROUP BY v.direccion;

-- 16. Mostrar el total recaudado por cada servicio (sumando tarifas por vivienda contratada)
SELECT s.nombre, SUM(s.tarifa) AS total_recaudado
FROM servicio s
JOIN contratar c ON s.codigo = c.codigo
GROUP BY s.nombre;

-- 17. Obtener el nombre del empleado que ha asignado la mayor cantidad total de artículos (sumando CANTIDAD)
SELECT e.nombre, SUM(a.cantidad) AS total_articulos
FROM empleados e
JOIN asignar a ON e.dni = a.dni
GROUP BY e.nombre
ORDER BY total_articulos DESC
LIMIT 1;

-- 18. Mostrar el artículo más caro que ha sido asignado a alguna vivienda
SELECT a.nombre, MAX(a.precio) AS precio
FROM articulo a
JOIN asignar b ON a.nombre = b.nombre
GROUP BY a.nombre
ORDER BY precio DESC
LIMIT 1;

-- 19. Mostrar todas las viviendas que tienen contratados servicios con tarifa superior al promedio
SELECT v.*
FROM vivienda v
JOIN contratar c ON v.telefono = c.telefono
JOIN servicio s ON c.codigo = s.codigo
WHERE s.tarifa > (SELECT AVG(tarifa) FROM servicio);

-- 20. Mostrar por cada propietario la población donde tiene más viviendas registradas
SELECT p.nombre, v.poblacion, COUNT(v.id) AS num_viviendas
FROM propietarios p
JOIN vivienda v ON p.nif = v.nif
GROUP BY p.nombre, v.poblacion
ORDER BY num_viviendas DESC
LIMIT 1;

-- 21. Mostrar los nombres de los empleados que viven en "Alicante".
SELECT e.nombre
FROM empleados e
JOIN vivienda v ON e.dni = v.dni
WHERE UPPER(v.poblacion) = 'ALICANTE';

-- 22. Listar todas las actividades de los servicios sin duplicados.
SELECT DISTINCT s.actividad
FROM servicio s;

-- 23. Mostrar los nombres de los artículos cuyo precio es mayor o igual a 5 euros.
SELECT a.nombre
FROM articulo a
WHERE a.precio >= 5;

-- 24. Motrar cuántos empleados hay en total.
SELECT COUNT(*) AS total_empleados
FROM empleados;

-- 25. Ver todos los propietarios ordenados alfabéticamente por nombre.
SELECT p.nombre
FROM propietarios p
ORDER BY p.nombre;

-- 26. Mostrar las viviendas que tienen suelo de tipo "Parqué".
SELECT v.*
FROM vivienda v
WHERE UPPER(v.suelo) = 'PARQUÉ';

-- 27. Listar los nombres de los empleados y la cantidad total de artículos asignados.
SELECT e.nombre, SUM(a.cantidad) AS total_articulos
FROM empleados e
JOIN asignar a ON e.dni = a.dni
GROUP BY e.nombre;

-- 28. Mostrar nombre y población de los propietarios que tienen al menos una vivienda.
SELECT p.nombre, v.poblacion
FROM propietarios p
JOIN vivienda v ON p.nif = v.nif
GROUP BY p.nombre, v.poblacion;

-- 29. Listar los teléfonos de las viviendas que no tienen servicios contratados.
SELECT v.telefono
FROM vivienda v
LEFT JOIN contratar c ON v.telefono = c.telefono
WHERE c.telefono IS NULL;

-- 30. Mostrar los nombres de los artículos que han sido asignados a más de 3 viviendas.
SELECT a.nombre
FROM articulo a
JOIN asignar b ON a.nombre = b.nombre
GROUP BY a.nombre
HAVING COUNT(DISTINCT b.nif) > 3;

-- 31. Listar los servicios con una tarifa superior al promedio y el número de viviendas que los contrataron.
SELECT s.nombre, s.tarifa, COUNT(c.telefono) AS num_viviendas
FROM servicio s
JOIN contratar c ON s.codigo = c.codigo
GROUP BY s.nombre, s.tarifa
HAVING s.tarifa > (SELECT AVG(tarifa) FROM servicio);

-- 32. Obtener los tres artículos más utilizados (más cantidad total asignada).
SELECT a.nombre, SUM(b.cantidad) AS total_asignado
FROM articulo a
JOIN asignar b ON a.nombre = b.nombre
GROUP BY a.nombre
ORDER BY total_asignado DESC
LIMIT 3;

-- 33. Mostrar las viviendas y el número total de artículos diferentes asignados a cada una.
SELECT v.direccion, COUNT(DISTINCT a.nombre) AS num_articulos
FROM vivienda v
JOIN asignar a ON v.telefono = a.nif
GROUP BY v.direccion;

-- 34. Listar los empleados que comparten el mismo teléfono que una vivienda (relación directa).
SELECT e.nombre
FROM empleados e
JOIN vivienda v ON e.dni = v.dni
WHERE e.telefono = v.telefono;

-- 35. Para cada propietario, mostrar la dirección de su vivienda más grande (por superficie útil).
SELECT p.nombre, v.direccion
FROM propietarios p
JOIN vivienda v ON p.nif = v.nif
WHERE v.util = (SELECT MAX(util) FROM vivienda WHERE nif = p.nif);

-- 36. Actualizar el email de un empleado específico
UPDATE empleados
SET email = 'nuevo_email@example.com'
WHERE dni = '12345678A';

-- 37. Cambiar la actividad del servicio con código ‘S001’ a ‘Pulido de suelos’
UPDATE servicio
SET actividad = 'Pulido de suelos'
WHERE codigo = 'S001';

-- 38. Aumentar en 10% el precio de todos los artículos que cuesten menos de 5 euros
UPDATE articulo
SET precio = precio * 1.1
WHERE precio < 5;

-- 39. Actualizar la provincia de todos los propietarios de San Juan a “Valencia”
UPDATE propietarios
SET provincia = 'Valencia'
WHERE poblacion = 'San Juan';

-- 40. Reducir la tarifa en 20 euros para todos los servicios del turno “Tarde”
UPDATE servicio
SET tarifa = tarifa - 20
WHERE turno = 'Tarde';

-- 41. Eliminar un artículo específico por nombre y capacidad
DELETE FROM articulo
WHERE nombre = 'nombre_articulo' AND capacidad = 'capacidad_articulo';

-- 42. Eliminar todos los empleados nacidos antes de 1980
DELETE FROM empleados
WHERE fecha_nacimiento < '1980-01-01';

-- 43. Borrar todas las asignaciones de artículos de una vivienda específica
DELETE FROM asignar
WHERE nif = 'nif_vivienda_especifica';

-- 44. Eliminar todos los servicios cuya tarifa sea mayor a 250 euros
DELETE FROM servicio
WHERE tarifa > 250;

-- 45. Eliminar todas las viviendas que no tengan artículos asignados
DELETE FROM vivienda
WHERE telefono NOT IN (SELECT DISTINCT nif FROM asignar);

