create table VENDEDOR(
  numvend number(4),
  nomvend char(30),
  nombrecomer char(30),
  telefono char(15),
  calle char(30),
  ciudad char(20),
  provincioa char(20),
  constraint pk_vendedor primary key (numvend)
)

create table PIEZA(
  numpieza char(16),
  nompieza char(30),
  preciovent number(6,2),
  constraint pk_pieza primary key (numpieza)
)

create table PRECIOSUM(
  numpieza char(16),
  numvend number(4),
  preciounit number(6,2),
  diassum number(2),
  descuento number(2),
  constraint pk_preciosum primary key (numpieza, numvend),
  constraint fk_preciosum_pieza foreign key (numpieza) references PIEZA (numpieza),
  constraint fk_preciosum_vend foreign key (numvend) references VENDEDOR (numvend)
)

create table PEDIDO(
  numpedido number(6),
  numvend number(4),
  fecha date,
  constraint pk_pedido primary key (numpedido),
  constraint fk_pedido_vend foreign key (numvend) references VENDEDOR (numvend)
)

create table LINPED(
  numpedido number(6),
  numlinea number(2),
  numpieza char(16),
  preciocompra number(6,2),
  cantpedida number (3),
  fecharecep date,
  cantrecibida number(3),
  constraint pk_linped primary key (numpedido, numlinea),
  constraint fk_linped_pedido foreign key (numpedido) references PEDIDO (numpedido),
  constraint fk_linped_pieza foreign key (numpieza) references PIEZA (numpieza)
)

create table INVENTARIO(
  numpieza char(16),
  numbin number(6),
  cantdisponible number(4),
  fecharecuento date,
  constraint pk_inventario primary key (numbin),
  constraint fk_inventario_pieza foreign key (numpieza) references PIEZA (numpieza)
)

insert into VENDEDOR values (1, 'Martín Salas, Fernando', 'SALAS S.A.', 965220000, 'C/ Cerámica, nº 14', 'Alicante', 'Alicante');
insert into VENDEDOR values (4, 'Montes García, M.Pilar', 'MONTES S.A', '914122025', 'C/ Pez, nº 12', 'Madrid', 'Madrid');
insert into VENDEDOR values (6, 'Rivera Silvestre, Ana', 'ANA S.A.', '926234520', 'C/ Londres, s/n', 'Daimiel', 'Ciudad Real');
insert into VENDEDOR values (15, 'Ramos Ruiz, Luis', 'PRORAMOS S.A.', '925800990', 'C/ Ancha, nº 1', 'Toledo', 'Toledo');
insert into VENDEDOR values (18, 'Ramos Ruiz, Luis', 'RARU S.A.', '925220933', 'C/ Gran Vía, nº 3', 'Talavera', 'Toledo');
insert into VENDEDOR values (22, 'Ruiz Lafuente, Manuel', 'MRL S.A.', '967765000', 'C/ Larga, nº 9', 'Hellín', 'Albacete');
insert into VENDEDOR values (45, 'Serrano Laguía, María', 'SERRA S.L.', '966435267', 'Plaza Mayor', 'Valencia', 'Valencia');
insert into VENDEDOR values (58, 'Ruano Cerezo, Manuel', 'TRATIVO S.A.', '965448009', 'C/ Nueva, nº 6', 'Alicante', 'Alicante');
insert into VENDEDOR values (60, 'Molina Serrano, Alicia', 'ALI S.A.', '965100218', 'C/ París, nº 1', 'Benidorm', 'Alicante');
insert into VENDEDOR values (75, 'Muñoz Rey, Felicia', 'ÑÑÑ S.L.', '965266018', 'C/ Rambla, nº 7', 'Alicante', 'Alicante');
insert into VENDEDOR values (82, 'Marín Marín, Pedro', 'MARINES S.A.', '967550267', 'C/ Mayor, nº 2', 'Barrax', 'Albacete');
insert into VENDEDOR values (96, 'Cruz López, Luis', 'ANA S.A.', '926234520', 'C/ Londres, s/n', 'Daimiel', 'Ciudad Real');

insert into PIEZA values('V-4001-12', 'Tornillo rosca 8', 1.75);
insert into PIEZA values('P-0001-33', 'Martillo madera', 9.99);
insert into PIEZA values('Z-9909-K', 'Tuerca acero 12', 2.49);
insert into PIEZA values('A-1001-L', 'Llave fija 9', 12.99);
insert into PIEZA values('T-2055-12', 'Tornillo madera 6', 3.05);
insert into PIEZA values('X-0101-V', 'Alambre fino 5', 6.50);
insert into PIEZA values('VX-0022-42', 'Destornillador estrella', 55.80);
insert into PIEZA values('DD-0001-210', 'Destornillador plano', 32.90);
insert into PIEZA values('SS-4422-92', 'Berbiquí batería', 102.90);
insert into PIEZA values('FD-0001-144', 'Llave inglesa 18', 75.00);
insert into PIEZA values('ZK-0001-123', 'Torno móvil', 149.50);
insert into PIEZA values('AJ-2233-99', 'Tenazas', 45.00);

INSERT INTO PRECIOSUM VALUES('V-4001-12', 1, 1.75, 15, 0);
INSERT INTO PRECIOSUM VALUES('P-0001-33', 2, 9.99, 20, 2);
INSERT INTO PRECIOSUM VALUES('Z-9909-K', 1, 2.49, 15, 0);
INSERT INTO PRECIOSUM VALUES('A-1001-L', 6, 12.99, 30, 12);
INSERT INTO PRECIOSUM VALUES('T-2055-12', 1, 3.05, 15, 0);
INSERT INTO PRECIOSUM VALUES('VX-0022-42', 2, 55.80, 20, 3);
INSERT INTO PRECIOSUM VALUES('DD-0001-210', 2, 32.90, 20, 3);
INSERT INTO PRECIOSUM VALUES('SS-4422-92', 4, 102.90, 12, 5);
INSERT INTO PRECIOSUM VALUES('FD-0001-144', 6, 75.00, 30, 12);
INSERT INTO PRECIOSUM VALUES('ZK-0001-123', 4, 149.50, 12, 5);
INSERT INTO PRECIOSUM VALUES('V-4001-12', 15, 1.95, 10, 15);
INSERT INTO PRECIOSUM VALUES('P-0001-33', 22, 12.99, 30, 20);
INSERT INTO PRECIOSUM VALUES('Z-9909-K', 15, 2.99, 10, 15);
INSERT INTO PRECIOSUM VALUES('A-1001-L', 60, 11.99, 30, 0);
INSERT INTO PRECIOSUM VALUES('T-2055-12', 15, 3.05, 15, 0);
INSERT INTO PRECIOSUM VALUES('VX-0022-42', 22, 59.80, 30, 20);
INSERT INTO PRECIOSUM VALUES('DD-0001-210', 22, 38.90, 30, 20);
INSERT INTO PRECIOSUM VALUES('SS-4422-92', 45, 122.90, 15, 15);
INSERT INTO PRECIOSUM VALUES('FD-0001-144', 60, 70.00, 30, 0);
INSERT INTO PRECIOSUM VALUES('ZK-0001-123', 45, 179.50, 15, 15);
INSERT INTO PRECIOSUM VALUES('V-4001-12', 60, 1.55, 15, 5);
INSERT INTO PRECIOSUM VALUES('P-0001-33', 82, 7.99, 20, 8);
INSERT INTO PRECIOSUM VALUES('Z-9909-K', 60, 2.19, 15, 5);
INSERT INTO PRECIOSUM VALUES('A-1001-L', 75, 15.99, 10, 10);
INSERT INTO PRECIOSUM VALUES('T-2055-12', 60, 2.65, 15, 5);
INSERT INTO PRECIOSUM VALUES('VX-0022-42', 82, 52.80, 20, 8);
INSERT INTO PRECIOSUM VALUES('DD-0001-210', 82, 30.90, 20, 8);
INSERT INTO PRECIOSUM VALUES('SS-4422-92', 75, 152.90, 10, 10);
INSERT INTO PRECIOSUM VALUES('FD-0001-144', 75, 77.00, 15, 12);
INSERT INTO PRECIOSUM VALUES('ZK-0001-123', 75, 159.50, 10, 5);
INSERT INTO PRECIOSUM VALUES('FD-0001-144', 96, 75.00, 20, 10);
INSERT INTO PRECIOSUM VALUES('VX-0022-42', 96, 75.00, 20, 10);

INSERT INTO PEDIDO VALUES(1, 1, '1-10-2005');
INSERT INTO PEDIDO VALUES(2, 75, '15-10-2005');
INSERT INTO PEDIDO VALUES(3, 4, '15-10-2005');
INSERT INTO PEDIDO VALUES(4, 82, '21-10-2005');
INSERT INTO PEDIDO VALUES(5, 6, '2-11-2005');

INSERT INTO LINPED VALUES(1, 1, 'V-4001-12', 1.75, 100, '12-10-2005', 100);
INSERT INTO LINPED VALUES(1, 2, 'Z-9909-K', 2.49, 40, '12-10-2005', 40);
INSERT INTO LINPED VALUES(2, 1, 'A-1001-L', 14.99, 20, '25-10-2005', 20);
INSERT INTO LINPED VALUES(2, 2, 'SS-4422-92', 154.00, 5, '27-10-2005', 5);
INSERT INTO LINPED VALUES(2, 3, 'FD-0001-144', 75.50, 10, '25-10-2005', 10);
INSERT INTO LINPED VALUES(3, 1, 'SS-4422-92', 102.00, 1, '29-10-2005', 1);
INSERT INTO LINPED VALUES(4, 1, 'P-0001-33', 9.00, 10, '30-10-2005', 10);
INSERT INTO LINPED VALUES(4, 2, 'VX-0022-42', 51.50, 4, '14-11-2005', 2);
INSERT INTO LINPED VALUES(4, 3, 'DD-0001-210', 30.90, 8, '14-11-2005', 5);
INSERT INTO LINPED VALUES(5, 1, 'A-1001-L', 12.00, 10, '4-12-2005', 10);

INSERT INTO INVENTARIO VALUES('V-4001-12', 655769, 100, '15-10-2005');
INSERT INTO INVENTARIO VALUES('Z-9909-K', 123432, 40, '15-10-2005');
INSERT INTO INVENTARIO VALUES('A-1001-L', 145532, 30, '15-12-2005');
INSERT INTO INVENTARIO VALUES('SS-4422-92', 873456, 7, '31-10-2005');
INSERT INTO INVENTARIO VALUES('FD-0001-144', 239855, 12, '31-10-2005');
INSERT INTO INVENTARIO VALUES('P-0001-33', 127734, 10, '31-10-2005');
INSERT INTO INVENTARIO VALUES('VX-0022-42', 515122, 3, '15-11-2005');
INSERT INTO INVENTARIO VALUES('DD-0001-210', 985643, 5, '15-11-2005');
INSERT INTO INVENTARIO VALUES('T-2055-12', 336498, 8, '30-9-2005');