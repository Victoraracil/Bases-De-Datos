-- BD ALMACEN   

-- MODIFICAMOS LA CONFIGURACION PARA INSERTAR LA FECHA
ALTER SESSION SET NLS_DATE_FORMAT='DD/MM/YYYY';

-- BORRADO DE TABLAS
DROP TABLE UNIDADES cascade constraints;
DROP TABLE PROVINCIAS cascade constraints;
DROP TABLE PROVEEDORES cascade constraints;
DROP TABLE FORMAPAGOS cascade constraints;
DROP TABLE ALBARANES cascade constraints;
DROP TABLE LINEAS cascade constraints;
DROP TABLE CLIENTES cascade constraints;
DROP TABLE ARTICULOS cascade constraints;

-- CREACIÓN DE TABLAS
CREATE TABLE UNIDADES (
	unidad VARCHAR2(2),
	descripcion VARCHAR2(12)
);

CREATE TABLE PROVINCIAS (
    provincia NUMBER(6),
    descripcion VARCHAR2(14),
    prefijo NUMBER(6)
);

CREATE TABLE PROVEEDORES (
    proveedor NUMBER(3),
    empresa VARCHAR2(15),
    apellidos VARCHAR2(25),
    nombre VARCHAR2(15),
    direccion1 VARCHAR2(30),
    direccion2 VARCHAR2(30),
    poblacion VARCHAR2(15),
    provincia NUMBER(6),
    distrito NUMBER(10),
    telefono VARCHAR2(16)
);

CREATE TABLE FORMAPAGOS (
	formapago VARCHAR2(2),
	descripcion VARCHAR2(15)
);

CREATE TABLE ALBARANES (
	albaran NUMBER(3),
	cliente NUMBER(10),
	fecha_albaran DATE,
	fecha_envio DATE,
	fecha_pago DATE,
	forma_pago VARCHAR2(2),
	facturado CHAR(1)
);

CREATE TABLE LINEAS (
    albaran NUMBER(3),
    linea NUMBER(6),
    articulo NUMBER(6),
    proveedor NUMBER(10),
    cantidad NUMBER(6),
    descuento NUMBER(6),
    precio NUMBER(8,2)
);

CREATE TABLE CLIENTES (
    cliente NUMBER(10),
    apellidos VARCHAR2(25),
    empresa VARCHAR2(15),
    nombre VARCHAR2(15),
    direccion1 VARCHAR2(30),
    direccion2 VARCHAR2(30),
    poblacion VARCHAR2(15),
    provincia NUMBER(6),
    distrito NUMBER(10),
    telefono VARCHAR2(16),
    forma_pago VARCHAR2(2),
    total_factura NUMBER (4,2)

);

CREATE TABLE ARTICULOS (
	articulo NUMBER(6),
	proveedor NUMBER(10),
	descripcion VARCHAR2(16),
	pr_vent NUMBER(8,2),
	pr_cost NUMBER(8,2),
	existencias NUMBER(6),
	sobre_maximo NUMBER(6),
	bajo_minimo NUMBER(6),
	fec_ult_ent DATE,
	fec_ult_sal DATE,
	unidad VARCHAR2(2)
);

-- Ejercicios
-- 1. Realizar las modificaciones necesarias sobre las tablas:
-- a. Comprobar los tipos de datos para ver si son correctos, en caso contrario, realizar la modificación necesaria para que se puedan introducir todos los datos.
-- El tipo de datos de la CP de albaranes es NUMBER(3) por lo que hay que cambiar de 10 a 3
ALTER TABLE LINEAS
MODIFY albaran NUMBER(3);
-- No hay suficiente espacio con NUMBER (4,2) por lo que le damos más tamaño
ALTER TABLE CLIENTES
MODIFY total_factura NUMBER (10,2);

-- b. Poner clave primaria y claves ajenas en las tablas.
ALTER TABLE UNIDADES ADD CONSTRAINT PK_UNIDADES PRIMARY KEY (unidad);
ALTER TABLE PROVINCIAS ADD CONSTRAINT PK_PROVINCIAS PRIMARY KEY (provincia);
ALTER TABLE PROVEEDORES ADD CONSTRAINT PK_PROVEEDORES PRIMARY KEY (proveedor);
ALTER TABLE FORMAPAGOS ADD CONSTRAINT PK_FORMAPAGOS PRIMARY KEY (formapago);
ALTER TABLE ALBARANES ADD CONSTRAINT PK_ALBARANES PRIMARY KEY (albaran);
ALTER TABLE LINEAS ADD CONSTRAINT PK_LINEAS PRIMARY KEY (albaran, linea);
ALTER TABLE CLIENTES ADD CONSTRAINT PK_CLIENTES PRIMARY KEY (cliente);
ALTER TABLE ARTICULOS ADD CONSTRAINT PK_ARTICULOS PRIMARY KEY (articulo);
-- Foreign Key Constraints
ALTER TABLE LINEAS ADD CONSTRAINT FK_LINEAS_ALBARANES FOREIGN KEY (albaran) REFERENCES ALBARANES (albaran);
ALTER TABLE LINEAS ADD CONSTRAINT FK_LINEAS_ARTICULOS FOREIGN KEY (articulo) REFERENCES ARTICULOS (articulo);
ALTER TABLE LINEAS ADD CONSTRAINT FK_LINEAS_PROVEEDORES FOREIGN KEY (proveedor) REFERENCES PROVEEDORES (proveedor);
ALTER TABLE CLIENTES ADD CONSTRAINT FK_CLIENTES_FORMAPAGOS FOREIGN KEY (forma_pago) REFERENCES FORMAPAGOS (formapago);
ALTER TABLE CLIENTES ADD CONSTRAINT FK_CLIENTES_PROVINCIAS FOREIGN KEY (provincia) REFERENCES PROVINCIAS (provincia);
ALTER TABLE ALBARANES ADD CONSTRAINT FK_ALBARANES_CLIENTES FOREIGN KEY (cliente) REFERENCES CLIENTES (cliente);
ALTER TABLE ALBARANES ADD CONSTRAINT FK_ALBARANES_FORMAPAGOS FOREIGN KEY (forma_pago) REFERENCES FORMAPAGOS (formapago);
ALTER TABLE ARTICULOS ADD CONSTRAINT FK_ARTICULOS_UNIDADES FOREIGN KEY (unidad) REFERENCES UNIDADES (unidad);
ALTER TABLE ARTICULOS ADD CONSTRAINT FK_ARTICULOS_PROVEEDORES FOREIGN KEY (proveedor) REFERENCES PROVEEDORES (proveedor);
ALTER TABLE PROVEEDORES ADD CONSTRAINT FK_PROVEEDORES_PROVINCIAS FOREIGN KEY (provincia) REFERENCES PROVINCIAS (provincia);

-- c. En la tabla ALBARANES, la fecha de envío siempre deberá de ser posterior a la fecha del albarán
-- d. La cantidad y el precio de la tabla LINEAS siempre deberá tener un valor positivo
-- e. Siempre se deberá conocer la forma de pago en los ALBARANES
-- f. Investigar cómo podemos permitir actualizaciones y borrados en cascada para las tablas LINEAS y ARTICULOS
-- ON DELETE RESTRICT
-- ON UPDATE CASCADE
-- g. Para facilitar la introducción de datos en la BD, hay varios campos en las tablas que pueden facilitarnos la labor. Haz las modificaciones necesarias.

