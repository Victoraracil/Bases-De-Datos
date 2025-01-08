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

insert into VENDEDOR(numvend, nomvend, nombrecomer, telefono, calle, ciudad, provincioa)
values (1, 'Martín Salas, Fernando', 'SALAS S.A.', 965220000, 'C/ Cerámica, nº 14', 'Alicante', 'Alicante');