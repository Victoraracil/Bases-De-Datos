

-- CREACION DE TABLAS

CREATE TABLE PROVINCIA (
    codp VARCHAR2(2) PRIMARY KEY,
    nombre VARCHAR2(25)
);

CREATE TABLE LOCALIDAD (
    codm VARCHAR2(4),
    pueblo VARCHAR2(50) NOT NULL,
    provincia VARCHAR2(2),
    PRIMARY KEY (codm, provincia),
    FOREIGN KEY (provincia) REFERENCES PROVINCIA(codp)
);

CREATE TABLE USUARIO (
    email VARCHAR2(50) PRIMARY KEY,
    nombre VARCHAR2(35) NOT NULL,
    apellidos VARCHAR2(55) NOT NULL,
    dni VARCHAR2(12) UNIQUE NOT NULL,
    telefono VARCHAR2(15),
    calle VARCHAR2(45),
    calle2 VARCHAR2(45),
    codpos VARCHAR2(5),
    pueblo VARCHAR2(4),
    provincia VARCHAR2(2),
    nacido DATE,
    FOREIGN KEY (pueblo, provincia) REFERENCES LOCALIDAD(codm, provincia)
);

CREATE TABLE DIRENVIO (
    email VARCHAR2(50),
    calle VARCHAR2(45),
    calle2 VARCHAR2(45),
    codpos VARCHAR2(5),
    pueblo VARCHAR2(4),
    provincia VARCHAR2(2),
    PRIMARY KEY (email),
    FOREIGN KEY (email) REFERENCES USUARIO(email),
    FOREIGN KEY (pueblo, provincia) REFERENCES LOCALIDAD(codm, provincia)
);

CREATE TABLE MARCA (
    marca VARCHAR2(15) PRIMARY KEY,
    empresa VARCHAR2(60),
    logo BLOB
);

CREATE TABLE ARTICULO (
    cod VARCHAR2(7) PRIMARY KEY,
    nombre VARCHAR2(45),
    pvp NUMBER(7,2),
    marca VARCHAR2(15),
    imagen BLOB,
    urlimagen VARCHAR2(100),
    especificaciones CLOB,
    FOREIGN KEY (marca) REFERENCES MARCA(marca)
);

CREATE TABLE CAMARA (
    cod VARCHAR2(7) PRIMARY KEY,
    resolucion VARCHAR2(15),
    sensor VARCHAR2(45),
    tipo VARCHAR2(45),
    factor VARCHAR2(10),
    objetivo VARCHAR2(15),
    pantalla VARCHAR2(20),
    zoom VARCHAR2(40),
    FOREIGN KEY (cod) REFERENCES ARTICULO(cod)
);

CREATE TABLE TV (
    cod VARCHAR2(7) PRIMARY KEY,
    panel VARCHAR2(45),
    pantalla NUMBER(6),
    resolucion VARCHAR2(15),
    hdreadyfullhd VARCHAR2(6),
    tdt NUMBER(1),
    FOREIGN KEY (cod) REFERENCES ARTICULO(cod)
);

CREATE TABLE MEMORIA (
    cod VARCHAR2(7) PRIMARY KEY,
    tipo VARCHAR2(30),
    FOREIGN KEY (cod) REFERENCES ARTICULO(cod)
);

CREATE TABLE PACK (
    cod VARCHAR2(7) PRIMARY KEY,
    FOREIGN KEY (cod) REFERENCES ARTICULO(cod)
);

CREATE TABLE PTIENEA (
    pack VARCHAR2(7),
    articulo VARCHAR2(7),
    PRIMARY KEY (pack, articulo),
    FOREIGN KEY (pack) REFERENCES PACK(cod),
    FOREIGN KEY (articulo) REFERENCES ARTICULO(cod)
);

CREATE TABLE STOCK (
    articulo VARCHAR2(7) PRIMARY KEY,
    disponible NUMBER(11),
    entrega VARCHAR2(20),
    FOREIGN KEY (articulo) REFERENCES ARTICULO(cod)
);

CREATE TABLE CESTA (
    articulo VARCHAR2(7),
    usuario VARCHAR2(50),
    fecha DATE,
    PRIMARY KEY (articulo, usuario),
    FOREIGN KEY (articulo) REFERENCES ARTICULO(cod),
    FOREIGN KEY (usuario) REFERENCES USUARIO(email)
);

CREATE TABLE PEDIDO (
    numPedido NUMBER(11) PRIMARY KEY,
    usuario VARCHAR2(50),
    fecha DATE NOT NULL,
    FOREIGN KEY (usuario) REFERENCES USUARIO(email)
);

CREATE TABLE LINPED (
    numPedido NUMBER(11),
    linea NUMBER(11),
    articulo VARCHAR2(7),
    precio NUMBER(9,2) NOT NULL,
    cantidad NUMBER(11),
    PRIMARY KEY (linea, numPedido),
    FOREIGN KEY (numPedido) REFERENCES PEDIDO(numPedido),
    FOREIGN KEY (articulo) REFERENCES ARTICULO(cod)
);

CREATE TABLE OBJETIVO (
    cod VARCHAR2(7) PRIMARY KEY,
    tipo VARCHAR2(15),
    montura VARCHAR2(15),
    focal VARCHAR2(10),
    apertura VARCHAR2(10),
    especiales VARCHAR2(35),
    FOREIGN KEY (cod) REFERENCES ARTICULO(cod)
);


INSERT INTO PROVINCIA (codp, nombre) VALUES ('01', 'Álava');
INSERT INTO PROVINCIA (codp, nombre) VALUES ('28', 'Madrid');
INSERT INTO PROVINCIA (codp, nombre) VALUES ('08', 'Barcelona');
INSERT INTO PROVINCIA VALUES ('01', 'Álava');
INSERT INTO PROVINCIA VALUES ('08', 'Barcelona');
INSERT INTO PROVINCIA VALUES ('28', 'Madrid');
INSERT INTO PROVINCIA VALUES ('41', 'Sevilla');
INSERT INTO PROVINCIA VALUES ('31', 'Navarra');

INSERT INTO LOCALIDAD VALUES ('0101', 'Vitoria-Gasteiz', '01');
INSERT INTO LOCALIDAD VALUES ('0801', 'Barcelona', '08');
INSERT INTO LOCALIDAD VALUES ('2801', 'Madrid', '28');
INSERT INTO LOCALIDAD VALUES ('4101', 'Sevilla', '41');
INSERT INTO LOCALIDAD VALUES ('3101', 'Pamplona', '31');

INSERT INTO USUARIO VALUES ('ana@gmail.com', 'Ana', 'Gómez Ruiz', '12345678A', '600123456', 'Calle A', NULL, '01005', '0101', '01', TO_DATE('1990-05-10', 'YYYY-MM-DD'));
INSERT INTO USUARIO VALUES ('luis@yahoo.com', 'Luis', 'Pérez López', '23456789B', '611234567', 'Av. del Sol', '2ºB', '08020', '0801', '08', TO_DATE('1985-11-20', 'YYYY-MM-DD'));
INSERT INTO USUARIO VALUES ('marta@outlook.com', 'Marta', 'Fernández Soto', '34567890C', NULL, 'Calle Luna', NULL, '28015', '2801', '28', TO_DATE('1992-02-14', 'YYYY-MM-DD'));
INSERT INTO USUARIO VALUES ('carlos@gmail.com', 'Carlos', 'Núñez Vidal', '45678901D', '622345678', 'Paseo Verde', NULL, '41002', '4101', '41', TO_DATE('1978-09-30', 'YYYY-MM-DD'));
INSERT INTO USUARIO VALUES ('laura@hotmail.com', 'Laura', 'Díaz Romero', '56789012E', '633456789', 'Ronda Sur', '3A', '31003', '3101', '31', TO_DATE('1988-07-08', 'YYYY-MM-DD'));

INSERT INTO DIRENVIO VALUES ('ana@gmail.com', 'Calle A', NULL, '01005', '0101', '01');
INSERT INTO DIRENVIO VALUES ('luis@yahoo.com', 'Av. del Sol', '2ºB', '08020', '0801', '08');
INSERT INTO DIRENVIO VALUES ('marta@outlook.com', 'Calle Luna', NULL, '28015', '2801', '28');
INSERT INTO DIRENVIO VALUES ('carlos@gmail.com', 'Paseo Verde', NULL, '41002', '4101', '41');
INSERT INTO DIRENVIO VALUES ('laura@hotmail.com', 'Ronda Sur', '3A', '31003', '3101', '31');

INSERT INTO MARCA VALUES ('Canon', 'Canon Inc.', NULL);
INSERT INTO MARCA VALUES ('Sony', 'Sony Corporation', NULL);
INSERT INTO MARCA VALUES ('Samsung', 'Samsung Electronics', NULL);
INSERT INTO MARCA VALUES ('LG', 'LG Electronics', NULL);
INSERT INTO MARCA VALUES ('Kingston', 'Kingston Technology', NULL);

INSERT INTO ARTICULO VALUES ('A00001', 'Canon EOS 90D', 1199.99, 'Canon', NULL, NULL, 'Cámara réflex con sensor APS-C',);
INSERT INTO ARTICULO VALUES ('A00002', 'Sony Alpha 7 III', 1999.00, 'Sony', NULL, NULL, 'Cámara full frame sin espejo');
INSERT INTO ARTICULO VALUES ('A00003', 'Samsung Smart TV 55"', 649.50, 'Samsung', NULL, NULL, 'Televisor 4K UHD con Tizen');
INSERT INTO ARTICULO VALUES ('A00004', 'Kingston SSD 1TB', 95.75, 'Kingston', NULL, NULL, 'Disco duro sólido SATA III');
INSERT INTO ARTICULO VALUES ('A00005', 'Pack Fotografía Pro', 2150.00, NULL, NULL, NULL, 'Incluye cámara, objetivo y memoria');

INSERT INTO CAMARA VALUES ('A00001', '32 MP', 'APS-C CMOS', 'Réflex', '1.6x', 'EF-S 18-55mm', '3"', 'Digital 10x');
INSERT INTO CAMARA VALUES ('A00002', '24 MP', 'Full Frame', 'Sin Espejo', '1x', 'FE 28-70mm', '3"', 'Óptico 5x');

INSERT INTO TV VALUES ('A00003', 'LED', 55, '3840x2160', '4K', 1);

INSERT INTO MEMORIA VALUES ('A00004', 'SSD SATA III');

INSERT INTO PACK VALUES ('A00005');

INSERT INTO PTIENEA VALUES ('A00005', 'A00001');
INSERT INTO PTIENEA VALUES ('A00005', 'A00004');

INSERT INTO STOCK VALUES ('A00001', 10, '48 horas');
INSERT INTO STOCK VALUES ('A00002', 5, 'inmediata');
INSERT INTO STOCK VALUES ('A00003', 2, '3 días');
INSERT INTO STOCK VALUES ('A00004', 20, 'inmediata');
INSERT INTO STOCK VALUES ('A00005', 3, '5 días');

INSERT INTO CESTA VALUES ('A00001', 'ana@gmail.com', SYSDATE);
INSERT INTO CESTA VALUES ('A00003', 'marta@outlook.com', SYSDATE);
INSERT INTO CESTA VALUES ('A00004', 'luis@yahoo.com', SYSDATE);
INSERT INTO CESTA VALUES ('A00002', 'laura@hotmail.com', SYSDATE);
INSERT INTO CESTA VALUES ('A00005', 'carlos@gmail.com', SYSDATE);

INSERT INTO PEDIDO VALUES (1001, 'ana@gmail.com', SYSDATE);
INSERT INTO PEDIDO VALUES (1002, 'marta@outlook.com', SYSDATE);
INSERT INTO PEDIDO VALUES (1003, 'luis@yahoo.com', SYSDATE);
INSERT INTO PEDIDO VALUES (1004, 'laura@hotmail.com', SYSDATE);
INSERT INTO PEDIDO VALUES (1005, 'carlos@gmail.com', SYSDATE);

INSERT INTO LINPED VALUES (1001, 1, 'A00001', 1199.99, 1);
INSERT INTO LINPED VALUES (1002, 1, 'A00003', 649.50, 1);
INSERT INTO LINPED VALUES (1003, 1, 'A00004', 95.75, 2);
INSERT INTO LINPED VALUES (1004, 1, 'A00002', 1999.00, 1);
INSERT INTO LINPED VALUES (1005, 1, 'A00005', 2150.00, 1);

INSERT INTO OBJETIVO VALUES ('A00006', 'Zoom', 'EF', '18-55mm', 'f/3.5-5.6', 'Estabilizador');
INSERT INTO OBJETIVO VALUES ('A00007', 'Fijo', 'FE', '50mm', 'f/1.8', 'Gran apertura');
INSERT INTO OBJETIVO VALUES ('A00008', 'Telefoto', 'EF', '70-300mm', 'f/4-5.6', 'Enfoque ultrasónico');
INSERT INTO OBJETIVO VALUES ('A00009', 'Macro', 'FE', '100mm', 'f/2.8', 'Alta precisión');
INSERT INTO OBJETIVO VALUES ('A00010', 'Gran angular', 'EF', '10-18mm', 'f/4.5-5.6', 'Ideal paisajes');

-- Pueden haber consultas que no devuelvan valor, añadir en ese caso algún registro en las tablas correspondientes

-- CONSULTAS
-- Muestra un listado de todas las provincias

-- Nombre completo (unido) de todos los usuarios registrados

-- Artículos con su precio de venta (PVP)

-- Listar todas las marcas registradas

-- Mostrar las localidades pertenecientes a la provincia de número 28

-- Obtener los usuarios que viven en una localidad específica (por código de pueblo y provincia)

-- Listar los artículos junto con su marca

-- Mostrar el contenido de la cesta de un usuario específico

-- Mostrar los artículos que están en stock y disponibles para entrega inmediata

-- Obtener el número total de artículos distintos en la cesta de cada usuario

-- Listar los pedidos con sus líneas, mostrando el nombre del artículo y el precio total por línea ç
-- Nota: precio * cantidad

-- Obtener los usuarios que han realizado al menos un pedido

-- Listar los packs y los artículos que contienen (mostrar nombre del artículo)

-- Calcular el total gastado por cada usuario en todos sus pedidos

-- Listar todos los tipos de artículos disponibles (CÁMARA, TV, MEMORIA, OBJETIVO, PACK)

-- Mostrar los nombres de los artículos cuyo precio es mayor o igual a 5€

-- Contar cuántos empleados hay en total

-- Ver todos los propietarios ordenados alfabéticamente por nombre

-- Mostrar las viviendas que tienen suelo de tipo "Parqué"

-- Listar los nombres de los empleados y la cantidad total de artículos asignados

-- Mostrar nombre y población de los propietarios que tienen al menos una vivienda

-- Listar los teléfonos de las viviendas que no tienen servicios contratados

-- Mostrar los nombres de los artículos que han sido asignados a más de 3 viviendas

-- Listar los servicios con una tarifa superior al promedio y el número de viviendas que los contrataron

-- Obtener los tres artículos más utilizados (más cantidad total asignada)

-- Mostrar las viviendas y el número total de artículos diferentes asignados a cada una

-- Listar los empleados que comparten el mismo teléfono que una vivienda (relación directa)

-- Para cada propietario, mostrar la dirección de su vivienda más grande (por ejemplo: por superficie útil)

-- Mostrar los códigos y nombres de artículos que cuestan más de 500€

-- Listar los nombres y DNI de los usuarios ordenados alfabéticamente por apellidos

-- Mostrar los emails y teléfonos de los usuarios que tienen teléfono registrado

-- Listar todos los artículos que no tienen marca asignada

-- Mostrar las marcas que no tienen artículos registrados

-- Obtener los nombres de los usuarios y los pueblos donde viven

-- Listar artículos en stock con menos de 5 unidades disponibles

-- Mostrar los pedidos realizados por cada usuario, incluyendo la fecha

-- Obtener el número de artículos por tipo (camara, tv, memoria, etc.)

-- Listar artículos con su tipo correspondiente
-- Nota: usa LEFT JOIN para distinguir tipos

-- Mostrar el artículo más caro registrado en la base de datos

-- Listar los usuarios que han comprado algún artículo de tipo MEMORIA

-- Obtener el promedio del PVP por marca (solo para artículos con marca)

-- Mostrar para cada pedido cuántos artículos se pidieron en total (suma de cantidades)

-- Encontrar los artículos que están en packs y también han sido comprados directamente (aparecen en LINPED)









































