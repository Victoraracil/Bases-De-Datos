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
    NIF CHAR(9),
    NOMBRE VARCHAR2(25),
    CAPACIDAD NUMBER(4,2),
    TELEFONO CHAR(12),
    CANTIDAD NUMBER(6),
    CONSTRAINT pkASIGNAR PRIMARY KEY (NIF, NOMBRE, CAPACIDAD, TELEFONO),
    CONSTRAINT fkASIGNAR_EMPLEADO FOREIGN KEY (NIF) REFERENCES EMPLEADO(NIF),
    CONSTRAINT fkASIGNAR_ARTICULO FOREIGN KEY (NOMBRE, CAPACIDAD) REFERENCES ARTICULO(NOMBRE, CAPACIDAD),
    CONSTRAINT fkASIGNAR_VIVIENDA FOREIGN KEY (TELEFONO) REFERENCES VIVIENDA(TELEFONO)
);

-- INSERCION DE DATOS EN LAS TABLAS
INSERT INTO EMPLEADO (NIF, NOMBRE, DIRECCION, POBLACION, TELEFONO, NACIMIENTO)
VALUES ('12345678A', 'Laura Pérez', 'Calle Mayor 10', 'Alicante', '600123456', TO_DATE('12/06/1985','DD/MM/YYYY'));
INSERT INTO EMPLEADO
VALUES ('87654321B', 'Juan Martínez', 'Av. Elche 22', 'San Vicente', '600654321', TO_DATE('25/03/1990','DD/MM/YYYY'));
INSERT INTO EMPLEADO
VALUES ('23456789C', 'María Gómez', 'Calle Luna 12', 'Benidorm', '600111222', TO_DATE('10/05/1982','DD/MM/YYYY'));
INSERT INTO EMPLEADO
VALUES ('34567890D', 'Carlos Ruiz', 'Calle Olivo 8', 'Elche', '600222333', TO_DATE('02/11/1978','DD/MM/YYYY'));
INSERT INTO EMPLEADO
VALUES ('45678901E', 'Ana Torres', 'Av. Ifach 14', 'Calpe', '600333444', TO_DATE('17/07/1993','DD/MM/YYYY'));
INSERT INTO EMPLEADO
VALUES ('56789012F', 'Luis Ibáñez', 'Calle Laurel 7', 'Denia', '600444555', TO_DATE('29/08/1988','DD/MM/YYYY'));
INSERT INTO EMPLEADO
VALUES ('67890123G', 'Elena Vidal', 'Plaza Mayor 2', 'Elda', '600555666', TO_DATE('13/01/1991','DD/MM/YYYY'));

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
INSERT INTO SERVICIO
VALUES ('S003', 'Noche', 'Jardinería', 200.00);
INSERT INTO SERVICIO
VALUES ('S004', 'Mañana', 'Piscinas', 180.50);
INSERT INTO SERVICIO
VALUES ('S005', 'Tarde', 'Electricidad', 250.00);
INSERT INTO SERVICIO
VALUES ('S006', 'Noche', 'Fontanería', 210.75);
INSERT INTO SERVICIO
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
VALUES ('Desinfectante', 1.50, 'Vinagre manzana', 5.0);
INSERT INTO ARTICULO
VALUES ('Limpiacristales', 0.75, 'Ambientador', 3.8);
INSERT INTO ARTICULO
VALUES ('Fregasuelos', 2.00, 'Lejia', 4.0);
INSERT INTO ARTICULO
VALUES ('Aromatizante', 0.50, 'Amoniaco', 2.5);
INSERT INTO ARTICULO
VALUES ('Quitagrasas', 1.25, 'Desengrasante', 5.5);

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

-- MODIFICACIONES/ALTERACIONES SOBRE LAS TABLAS
-- 1. Agrega una columna EMAIL a la tabla EMPLEADO.

-- 2. Cambia el tamaño del campo DIRECCION en la tabla VIVIENDA a 50 caracteres.

-- 3. Elimina la columna DESCRIPCION de la tabla ARTICULO.

-- 4. Cambia el nombre de la columna NOMBRE en PROPIETARIO a RAZON_SOCIAL.

-- 5. Agrega una relación entre EMPLEADO.TELEFONO y VIVIENDA.TELEFONO (suponiendo que tenga sentido en tu modelo):

-- 6. Elimina la clave foránea fkASIGNAR_VIVIENDA.

-- 7. Cambia el nombre de la tabla SERVICIO a SERVICIOS.

-- 8. Agrega una restricción para que WC en VIVIENDA no sea negativo.

-- 9. Todas las claves ajenas deben realizar borrados en cascada

-- 10. La fecha de nacimiento siempre deberá ser menor que la fecha actual del sistema


-- CONSULTAS / REQUERIMIENTOS

-- 1. Mostrar nombre, dirección y telefono de todos los empleados

-- 2. Obtener nombre y teléfono de todos los propietarios

-- 3. Obtener un listado con todas las viviendas ubicadas en “Calpe”

-- 4. Mostrar nombre y tarifa de todos los servicios ordenados por tarifa descendente

-- 5. Nombre y precio de los artículos con un precio menor a 5 euros

-- 6. Mostrar los empleados que trabajan en viviendas con más de 1 WC

-- 7. Mostrar los servicios contratados por cada vivienda (dirección y actividad)

-- 8. Contar cuántas viviendas hay por cada propietario

-- 9. Mostrar los empleados nacidos antes del año 1990

-- 10. Ver qué artículos han sido asignados a la vivienda con teléfono '965111111'

-- 11. Mostrar el nombre de cada empleado junto con el número total de artículos que se le han asignado

-- 12. Listar los artículos que han sido asignados a más de una vivienda distinta

-- 13. Mostrar el nombre y email de los empleados que no tienen asignado ningún artículo

-- 14. Obtener la vivienda con mayor superficie útil (UTIL)

-- 15. Listar las viviendas y el número de servicios que tienen contratados

-- 16. Mostrar el total recaudado por cada servicio (sumando tarifas por vivienda contratada)

-- 17. Obtener el nombre del empleado que ha asignado la mayor cantidad total de artículos (sumando CANTIDAD)

-- 18. Mostrar el artículo más caro que ha sido asignado a alguna vivienda

-- 19. Mostrar todas las viviendas que tienen contratados servicios con tarifa superior al promedio

-- 20. Mostrar por cada propietario la población donde tiene más viviendas registradas

-- 21. Mostrar los nombres de los empleados que viven en "Alicante".

-- 22. Listar todas las actividades de los servicios sin duplicados.

-- 23. Mostrar los nombres de los artículos cuyo precio es mayor o igual a 5 euros.

-- 24. Motrar cuántos empleados hay en total.

-- 25. Ver todos los propietarios ordenados alfabéticamente por nombre.

-- 26. Mostrar las viviendas que tienen suelo de tipo "Parqué".

-- 27. Listar los nombres de los empleados y la cantidad total de artículos asignados.

-- 28. Mostrar nombre y población de los propietarios que tienen al menos una vivienda.

-- 29. Listar los teléfonos de las viviendas que no tienen servicios contratados.

-- 30. Mostrar los nombres de los artículos que han sido asignados a más de 3 viviendas.

-- 31. Listar los servicios con una tarifa superior al promedio y el número de viviendas que los contrataron.

-- 32. Obtener los tres artículos más utilizados (más cantidad total asignada).

-- 33. Mostrar las viviendas y el número total de artículos diferentes asignados a cada una.

-- 34. Listar los empleados que comparten el mismo teléfono que una vivienda (relación directa).

-- 35. Para cada propietario, mostrar la dirección de su vivienda más grande (por superficie útil).

-- 36. Actualizar el email de un empleado específico

-- 37. Cambiar la actividad del servicio con código ‘S001’ a ‘Pulido de suelos’

-- 38. Aumentar en 10% el precio de todos los artículos que cuesten menos de 5 euros

-- 39. Actualizar la provincia de todos los propietarios de San Juan a “Valencia”

-- 40. Reducir la tarifa en 20 euros para todos los servicios del turno “Tarde”

-- 41. Eliminar un artículo específico por nombre y capacidad

-- 42. Eliminar todos los empleados nacidos antes de 1980

-- 43. Borrar todas las asignaciones de artículos de una vivienda específica

-- 44. Eliminar todos los servicios cuya tarifa sea mayor a 250 euros

-- 45. Eliminar todas las viviendas que no tengan artículos asignados

