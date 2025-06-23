

CREATE TABLE CLIENTE (
	cod NUMBER,
	nombre varchar2(100),
	direccion varchar2(100),
	pais varchar2(100) DEFAULT 'ESPAÑA',
	CONSTRAINT pk_client PRIMARY KEY(cod)
);

CREATE TABLE PEDIDO (
	cod NUMBER,
	cliente NUMBER,
	fecha2 DATE,
	total NUMBER(6,2),
	CONSTRAINT pk_order PRIMARY KEY(cod),
	CONSTRAINT fk_ord_cli FOREIGN KEY (cliente) REFERENCES CLIENTE
);

CREATE TABLE LINPEDIDO (
	codPedido NUMBER,
	numPed NUMBER,
	cantidad NUMBER,
	descripcion VARCHAR2(20),
	precioUnidad NUMBER(6,2),
	CONSTRAINT PK_li_order PRIMARY KEY(codPedido, numPed),
	CONSTRAINT FK_ord_lineord FOREIGN KEY(numPed) REFERENCES PEDIDO
);

INSERT INTO CLIENTE (cod, nombre, direccion, pais) VALUES (1, 'Manolo', 'C/Saigon 5','ESPAÑA');
INSERT INTO CLIENTE (cod, nombre, direccion, pais) VALUES (2, 'Carlos', 'C/Silvestre Stalone 3','ANDORRA');
INSERT INTO CLIENTE (cod, nombre, direccion, pais) VALUES (3, 'Jose', 'C/Rambo 4','ESPAÑA');
INSERT INTO CLIENTE (cod, nombre, direccion, pais) VALUES (4, 'Armando', 'C/Acorralado 2','ANDORRA');
INSERT INTO PEDIDO (cod, cliente, fecha2, total) VALUES (1,1,TO_DATE('08/02/2016', 'dd/mm/yyyy')+dbms_random.value(1, 50),50);
INSERT INTO PEDIDO (cod, cliente, fecha2, total) VALUES (2,1,TO_DATE('08/02/2016', 'dd/mm/yyyy')+dbms_random.value(1, 50),60);
INSERT INTO PEDIDO (cod, cliente, fecha2, total) VALUES (3,2,TO_DATE('08/02/2016', 'dd/mm/yyyy')+dbms_random.value(1, 50),70);
INSERT INTO LINPEDIDO (codPedido, numPed, cantidad, descripcion, precioUnidad) VALUES (1,1,2,'ZAPATILLAS CORRER',125);
INSERT INTO LINPEDIDO (codPedido,numPed,cantidad,descripcion,precioUnidad) VALUES (2,1,3,'CALCETINES RUNNER',53);
INSERT INTO LINPEDIDO (codPedido,numPed,cantidad,descripcion,precioUnidad) VALUES (3,1,1,'BOTAS DE AGUA',34);
INSERT INTO LINPEDIDO (codPedido,numPed,cantidad,descripcion,precioUnidad) VALUES (1,2,1,'TELEFONO NOQUIA',55);
INSERT INTO LINPEDIDO (codPedido,numPed,cantidad,descripcion,precioUnidad) VALUES (2,2,5,'GALLETAS PRINCIPE',5);
INSERT INTO LINPEDIDO (codPedido,numPed,cantidad,descripcion,precioUnidad) VALUES (1,3,3,'LIBROS DE ESTUDIO',3.5);
INSERT INTO LINPEDIDO (codPedido,numPed,cantidad,descripcion,precioUnidad) VALUES (2,3,5,'RULOS PARA EL PELO',13.5);