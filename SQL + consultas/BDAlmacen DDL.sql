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

--ALTER TABLES
-- Realizar las modificaciones necesarias sobre las tablas para ponerles clave primaria y sus claves ajenas.
-- Investigar como podemos permitir actualizaciones y borrados en cascada para la tabla LINEAS
--ON DELETE RESTRICT
--ON UPDATE CASCADE

-- El tipo de datos de la CP de albaranes es NUMBER(3) por lo que hay que cambiar de 10 a 3
ALTER TABLE LINEAS
MODIFY albaran NUMBER(3);
-- No hay suficiente espacio con NUMBER (4,2) por lo que le damos más tamaño
ALTER TABLE CLIENTES
MODIFY total_factura NUMBER (10,2);

ALTER TABLE UNIDADES 
    ADD CONSTRAINT PK_UNIDADES PRIMARY KEY (unidad); --
ALTER TABLE PROVINCIAS 
    ADD CONSTRAINT PK_PROVINCIAS PRIMARY KEY (provincia); --
ALTER TABLE PROVEEDORES 
    ADD CONSTRAINT PK_PROVEEDORES PRIMARY KEY (proveedor);
ALTER TABLE FORMAPAGOS 
    ADD CONSTRAINT PK_FORMAPAGOS PRIMARY KEY (formapago);
ALTER TABLE ALBARANES 
    ADD CONSTRAINT PK_ALBARANES PRIMARY KEY (albaran); --
ALTER TABLE LINEAS 
    ADD CONSTRAINT PK_LINEAS PRIMARY KEY (albaran, linea); --
ALTER TABLE CLIENTES 
    ADD CONSTRAINT PK_CLIENTES PRIMARY KEY (cliente); --
ALTER TABLE ARTICULOS 
    ADD CONSTRAINT PK_ARTICULOS PRIMARY KEY (articulo); --

-- Foreign Key Constraints
ALTER TABLE LINEAS 
    ADD CONSTRAINT FK_LINEAS_ALBARANES 
    FOREIGN KEY (albaran) REFERENCES ALBARANES (albaran); --
ALTER TABLE LINEAS 
    ADD CONSTRAINT FK_LINEAS_ARTICULOS 
    FOREIGN KEY (articulo) REFERENCES ARTICULOS (articulo); --
ALTER TABLE LINEAS 
    ADD CONSTRAINT FK_LINEAS_PROVEEDORES 
    FOREIGN KEY (proveedor) REFERENCES PROVEEDORES (proveedor); --
ALTER TABLE CLIENTES 
    ADD CONSTRAINT FK_CLIENTES_FORMAPAGOS 
    FOREIGN KEY (forma_pago) REFERENCES FORMAPAGOS (formapago); --
ALTER TABLE CLIENTES 
    ADD CONSTRAINT FK_CLIENTES_PROVINCIAS 
    FOREIGN KEY (provincia) REFERENCES PROVINCIAS (provincia); --
ALTER TABLE ALBARANES 
    ADD CONSTRAINT FK_ALBARANES_CLIENTES 
    FOREIGN KEY (cliente) REFERENCES CLIENTES (cliente); --
ALTER TABLE ALBARANES 
    ADD CONSTRAINT FK_ALBARANES_FORMAPAGOS 
    FOREIGN KEY (forma_pago) REFERENCES FORMAPAGOS (formapago); --
ALTER TABLE ARTICULOS 
    ADD CONSTRAINT FK_ARTICULOS_UNIDADES 
    FOREIGN KEY (unidad) REFERENCES UNIDADES (unidad); --
ALTER TABLE ARTICULOS 
    ADD CONSTRAINT FK_ARTICULOS_PROVEEDORES 
    FOREIGN KEY (proveedor) REFERENCES PROVEEDORES (proveedor); --
ALTER TABLE PROVEEDORES 
    ADD CONSTRAINT FK_PROVEEDORES_PROVINCIAS 
    FOREIGN KEY (provincia) REFERENCES PROVINCIAS (provincia); --

-- Realizamos la inserción de datos**
-- Inserciones en la tabla UNIDADES
INSERT INTO UNIDADES VALUES ('Un','Unidades');
INSERT INTO UNIDADES VALUES ('m','metros');
INSERT INTO UNIDADES VALUES ('Kg','Kilogramos');
INSERT INTO UNIDADES VALUES ('Cj','Cajas');
INSERT INTO UNIDADES VALUES ('l','litros');
INSERT INTO UNIDADES VALUES ('cc','cm cubicos');

-- Inserciones en la tabla PROVINCIAS**
INSERT INTO PROVINCIAS (provincia,descripcion,prefijo) VALUES (1,'ALAVA',945);
INSERT INTO PROVINCIAS (provincia,descripcion,prefijo) VALUES (2,'ALBACETE',967);
INSERT INTO PROVINCIAS (provincia,descripcion,prefijo) VALUES (3,'ALICANTE',965);
INSERT INTO PROVINCIAS (provincia,descripcion,prefijo) VALUES (4,'ALMERIA',951);
INSERT INTO PROVINCIAS (provincia,descripcion,prefijo) VALUES (33,'ASTURIAS',985);
INSERT INTO PROVINCIAS (provincia,descripcion,prefijo) VALUES (5,'AVILA',918);
INSERT INTO PROVINCIAS (provincia,descripcion,prefijo) VALUES (6,'BADAJOZ',924);
INSERT INTO PROVINCIAS (provincia,descripcion,prefijo) VALUES (7,'BALEARES',971);
INSERT INTO PROVINCIAS (provincia,descripcion,prefijo) VALUES (8,'BARCELONA',93);
INSERT INTO PROVINCIAS (provincia,descripcion,prefijo) VALUES (9,'BURGOS',947);
INSERT INTO PROVINCIAS (provincia,descripcion,prefijo) VALUES (10,'CACERES',927);
INSERT INTO PROVINCIAS (provincia,descripcion,prefijo) VALUES (11,'CADIZ',956);
INSERT INTO PROVINCIAS (provincia,descripcion,prefijo) VALUES (39,'CANTABRIA',942);
INSERT INTO PROVINCIAS (provincia,descripcion,prefijo) VALUES (12,'CASTELLON',964);
INSERT INTO PROVINCIAS (provincia,descripcion,prefijo) VALUES (13,'CIUDAD REAL',926);
INSERT INTO PROVINCIAS (provincia,descripcion,prefijo) VALUES (14,'CORDOBA',957);
INSERT INTO PROVINCIAS (provincia,descripcion,prefijo) VALUES (15,'LA CORU¥A',981);
INSERT INTO PROVINCIAS (provincia,descripcion,prefijo) VALUES (16,'CUENCA',966);
INSERT INTO PROVINCIAS (provincia,descripcion,prefijo) VALUES (17,'GERONA',972);
INSERT INTO PROVINCIAS (provincia,descripcion,prefijo) VALUES (18,'GRANADA',958);
INSERT INTO PROVINCIAS (provincia,descripcion,prefijo) VALUES (19,'GUADALAJARA',911);
INSERT INTO PROVINCIAS (provincia,descripcion,prefijo) VALUES (20,'GUIPUZCOA',943);
INSERT INTO PROVINCIAS (provincia,descripcion,prefijo) VALUES (21,'HUELVA',955);
INSERT INTO PROVINCIAS (provincia,descripcion,prefijo) VALUES (22,'HUESCA',974);
INSERT INTO PROVINCIAS (provincia,descripcion,prefijo) VALUES (23,'JAEN',953);
INSERT INTO PROVINCIAS (provincia,descripcion,prefijo) VALUES (24,'LEON',987);
INSERT INTO PROVINCIAS (provincia,descripcion,prefijo) VALUES (25,'LERIDA',973);
INSERT INTO PROVINCIAS (provincia,descripcion,prefijo) VALUES (27,'LUGO',982);
INSERT INTO PROVINCIAS (provincia,descripcion,prefijo) VALUES (28,'MADRID',91);
INSERT INTO PROVINCIAS (provincia,descripcion,prefijo) VALUES (29,'MALAGA',952);
INSERT INTO PROVINCIAS (provincia,descripcion,prefijo) VALUES (30,'MURCIA',968);
INSERT INTO PROVINCIAS (provincia,descripcion,prefijo) VALUES (31,'NAVARRA',948);
INSERT INTO PROVINCIAS (provincia,descripcion,prefijo) VALUES (32,'ORENSE',988);
INSERT INTO PROVINCIAS (provincia,descripcion,prefijo) VALUES (34,'PALENCIA',988);
INSERT INTO PROVINCIAS (provincia,descripcion,prefijo) VALUES (35,'LAS PALMAS',928);
INSERT INTO PROVINCIAS (provincia,descripcion,prefijo) VALUES (36,'PONTEVEDRA',986);
INSERT INTO PROVINCIAS (provincia,descripcion,prefijo) VALUES (26,'LA RIOJA',941);
INSERT INTO PROVINCIAS (provincia,descripcion,prefijo) VALUES (37,'SALAMANCA',923);
INSERT INTO PROVINCIAS (provincia,descripcion,prefijo) VALUES (38,'TENERIFE',922);
INSERT INTO PROVINCIAS (provincia,descripcion,prefijo) VALUES (40,'SEGOVIA',911);
INSERT INTO PROVINCIAS (provincia,descripcion,prefijo) VALUES (41,'SEVILLA',954);
INSERT INTO PROVINCIAS (provincia,descripcion,prefijo) VALUES (42,'SORIA',975);
INSERT INTO PROVINCIAS (provincia,descripcion,prefijo) VALUES (43,'TARRAGONA',977);
INSERT INTO PROVINCIAS (provincia,descripcion,prefijo) VALUES (44,'TERUEL',974);
INSERT INTO PROVINCIAS (provincia,descripcion,prefijo) VALUES (45,'TOLEDO',925);
INSERT INTO PROVINCIAS (provincia,descripcion,prefijo) VALUES (46,'VALENCIA',96);
INSERT INTO PROVINCIAS (provincia,descripcion,prefijo) VALUES (47,'VALLADOLID',983);
INSERT INTO PROVINCIAS (provincia,descripcion,prefijo) VALUES (48,'VIZCAYA',94);
INSERT INTO PROVINCIAS (provincia,descripcion,prefijo) VALUES (49,'ZAMORA',988);
INSERT INTO PROVINCIAS (provincia,descripcion,prefijo) VALUES (50,'ZARAGOZA',976);

-- Inserciones en la tabla PROVEEDORES**
INSERT INTO PROVEEDORES VALUES (1,'CASA','REVENGA AROCA','Maria Luisa','San Jaime', '75', 'Villareal', 12 ,0,'2014182');
INSERT INTO PROVEEDORES VALUES (2,'R. BRANAS','CARDABA ORGUILAR','Reyes', 'Narvaez', '0', 'Sevilla', 41, 0,'4014148');
INSERT INTO PROVEEDORES VALUES (3,'TABLAS', 'ORGUILAR ESTEVEZ','Ana', 'Bravo Murillo', '20', 'Madrid', 28, 0,'7030792');
INSERT INTO PROVEEDORES VALUES (4,'VENTAUTO', 'MORCILLO PALOMO','Jose', 'Bravo Murillo', '78', 'Granada',18,0,'2004806');
INSERT INTO PROVEEDORES VALUES (5,'ART', 'BORRAS CALLE','Oscar', 'Padul', '27', 'Villareal',12,0,'4008404');
INSERT INTO PROVEEDORES VALUES (6,'DAM', 'MORENTE RODRIGUEZ','Jose', 'Princesa', '98', 'Malaga',29,0,'7030222');
INSERT INTO PROVEEDORES VALUES (7,'BECOR', 'BORRAS GARCIA','Jose Carlos','Dracena', '20', 'Barcelona',8,0,'2026780');
INSERT INTO PROVEEDORES VALUES (8,'TYLER','GONZALEZ TEJERO','Maria Jesus', 'Castro Serna' , '0', 'Madrid',28,0,'4022352');
INSERT INTO PROVEEDORES VALUES (9,'HELIOS','LORANCA VALDIVIESO','Antonio','Ppe. de Vergara' , '14', 'Madrid',28,0,'7024510');
INSERT INTO PROVEEDORES VALUES (10,'BARNICES DEVA','SASTRE LORANCA','Federico','Bravo Murillo', '33', 'Azpeitia',20,0,'2003738');
INSERT INTO PROVEEDORES VALUES (11,'ALFOMBRAS MAS','MORCILLO AROCA','Luisa','Isla Malta', '23', 'Atienza',19,0,'4031508');
INSERT INTO PROVEEDORES VALUES (12,'SIRO','CEBRIAN MONTERO','Javier','Castro de Oro', '2', 'Barcelona',8,0,'7031802');
INSERT INTO PROVEEDORES VALUES (13,'FESAN','TEJERO LOPEZ','Felipe,Palacios', '27', 'Barcelona',8,0,'2014272');
INSERT INTO PROVEEDORES VALUES (14,'HELIOS','TEJERO GUIJARRO','Antonio','Ppe. de Vergara' , '57', 'Villareal',12,0,'4010578');
INSERT INTO PROVEEDORES VALUES (15,'ROSCO','SASTRE SIEIRO','Jose Manuel','Ppe. de Vergara' , '45', 'Madrid',28,0,'7025470');
INSERT INTO PROVEEDORES VALUES (16,'CIFERSA','ANTON ORGUILAR','Eloy','Serrano', '77', 'Malaga',29,0,'2026710');
INSERT INTO PROVEEDORES VALUES (17,'ARRIETA','MOLERO BORRAS','Felipe','Avila', '39', 'Barcelona',8,0,'4001684');
INSERT INTO PROVEEDORES VALUES (18,'GRANDA S.A.','CARDABA VADILLO','Luis','Elda', '1', 'Barcelona',8,0,'7013266');
INSERT INTO PROVEEDORES VALUES (19,'HELIOS','REVENGA CANTERO','Jaime','Alaro', '52', 'Barcelona',8,0,'2026824');
INSERT INTO PROVEEDORES VALUES (20,'VENTAUTO','VAZQUEZ BUENDIA','Eloy','Espalter', '0', 'Barcelona',8,0,'4026682');
INSERT INTO PROVEEDORES VALUES (21,'FIMSA','MARCOS ORGUILAR','Jose Manuel','Palacios', '45', 'Barcelona',8,0,'7024854');
INSERT INTO PROVEEDORES VALUES (22,'AGRUGASA','RODRIGUEZ CALLE','Angel','Sandoval', '17', 'Guadalajara',19,0,'2005354');
INSERT INTO PROVEEDORES VALUES (23,'DAM','REVENGA REDONDO','Pedro','Jose Noriega', '99', 'Madrid',28,0,'4031532');
INSERT INTO PROVEEDORES VALUES (24,'REINA CASTILLA','LARA ORGUILAR','Jose,Serrano', '99', 'Barcelona',8,0,'7017106');
INSERT INTO PROVEEDORES VALUES (25,'CARLIPS','GARCIA LUNA','Jose Carlos','Juan Anton', '89', 'Barcelona',8,0,'2004750');
INSERT INTO PROVEEDORES VALUES (26,'ARCO','BOYER PANIAGUA','Julian','Goya', '42', 'Barcelona',8,0,'4000354');
INSERT INTO PROVEEDORES VALUES (27,'COMERCIALSILMAR','FAURA ESTEVEZ','Andres','Princesa', '87', 'Sevilla',41,0,'7025316');
INSERT INTO PROVEEDORES VALUES (28,'DETECSA','VADILLO BOYER','Maria Jesus','Goya', '87', 'Barcelona',8,0,'2014058');
INSERT INTO PROVEEDORES VALUES (29,'REFO','COLORADO AMATO','Oscar','Bravo Murillo', '32', 'Barcelona',8,0,'4009810');
INSERT INTO PROVEEDORES VALUES (30,'IEC','GUERRA CANTERO','Ana','Alberto Aguilera', '63', 'Madrid',28,0,'7000220');
INSERT INTO PROVEEDORES VALUES (31,'REINA CASTILLA','BORRAS PANIAGUA','Javier','Padul', '2', 'Madrid',28,0,'2016372');
INSERT INTO PROVEEDORES VALUES (32,'PEDRAZA','REDONDO COLORADO','Angel','Bravo Murillo', '24', 'Madrid',28,0,'4005560');
INSERT INTO PROVEEDORES VALUES (33,'TRITON','GUERRA SASTRE','Luisa','Orfila', '53', 'Madrid',28,0,'7021966');
INSERT INTO PROVEEDORES VALUES (34,'TYLER','MARADONA RODRIGUEZ','Eloy','Serrano', '85', 'Granada',18,0,'2019380');
INSERT INTO PROVEEDORES VALUES (35,'COFIMSA','REQUENA GUIJARRO','Federico','Narvaez', '20', 'Madrid',28,0,'4002782');
INSERT INTO PROVEEDORES VALUES (36,'GREGASA','CANTERO BOLANO','Jaime','Alberto Aguilera', '25', 'Madrid',28,0,'7021732');
INSERT INTO PROVEEDORES VALUES (37,'LLORENS','VAZQUEZ COLORADO','Luisa','Montera', '85', 'Soria',42,0,'2024588');
INSERT INTO PROVEEDORES VALUES (38,'SEGURGAS','ANTON GUIJARRO','Ana','Dulcinea', '63', 'Barcelona',8,0,'4007194');
INSERT INTO PROVEEDORES VALUES (39,'TILEER','PANIAGUA RODRIGUEZ','Luis','Narvaez', '92', 'Barcelona',8,0,'7027756');
INSERT INTO PROVEEDORES VALUES (40,'DAM','REQUENA CEBRIAN','Jose Manuel','Serrano', '54', 'Madrid',28,0,'2024672');
INSERT INTO PROVEEDORES VALUES (41,'AGRUGASA','REVENGA HERAS','Jose Manuel','Bravo Murillo', '7', 'Madrid',28,0,'4000316');
INSERT INTO PROVEEDORES VALUES (42,'AMALLO','BOLANO GARCIA','Jaime','Serrano', '69', 'Madrid',28,0,'7031692');
INSERT INTO PROVEEDORES VALUES (43,'BIMASA S.L.','GARCIA AROCA','Reyes','Alcala', '62', 'Madrid',28,0,'2032182');
INSERT INTO PROVEEDORES VALUES (44,'FCP S.A.','AROCA MARCOS','Javier','San Bernardo', '28', 'Barcelona',8,0,'4014864');
INSERT INTO PROVEEDORES VALUES (45,'CARNAUD','LUNA SALGADO','Angel','Ppe. de Vergara', '20', 'Madrid',28,0,'7012924');
INSERT INTO PROVEEDORES VALUES (46,'FACIT','LORANCA VALDIVIESO','Alfonso','Alava', '64', 'Barcelona',8,0,'2028230');
INSERT INTO PROVEEDORES VALUES (47,'DATAPOINT','CALLE LOPEZ','Javier','Castellana', '19','Madrid',28,0,'4010438');
INSERT INTO PROVEEDORES VALUES (48,'CASA','MOLINA MOLINA','Ana','Goya', '78','Madrid',28,0,'7003002');
INSERT INTO PROVEEDORES VALUES (49,'R. BRANAS','LARA PALOMO','Eloy','Castellana', '7','Madrid',28,0,'2012584');
INSERT INTO PROVEEDORES VALUES (50,'CIFERSA','LARA LUNA','Maria Luisa','Bravo Murillo', '24','Barcelona',8,0,'4025492');
INSERT INTO PROVEEDORES VALUES (51,'HORARIO','REDONDO PRIETO','Felix','Ppe. de Vergara', '74','Madrid',28,0,'7027284');
INSERT INTO PROVEEDORES VALUES (52,'AMPE','CALLE PALOMO','Felix','General Aranaz', '57','Barcelona',8,0,'2010030');
INSERT INTO PROVEEDORES VALUES (53,'GUYON','REQUENA VADILLO','Luis','Serrano', '68','Guadalajara',19,0,'4028740');
INSERT INTO PROVEEDORES VALUES (54,'SLIPPER','TEJERO MONTERO','Reyes','Fuencarral', '72','Barcelona',8,0,'7022294');
INSERT INTO PROVEEDORES VALUES (55,'CORITEL','RODRIGUEZ REQUENA','Jose Carlos','Bravo Murillo', '88','Barcelona',8,0,'2004984');
INSERT INTO PROVEEDORES VALUES (56,'DATAPOINT','VADILLO MARADONA','Felix','Isla Nelson', '68','Sevilla',41,0,'4001596');
INSERT INTO PROVEEDORES VALUES (57,'GONBARRI','MOLERO CASTEL','Jose Carlos','Alberto Aguilera', '92', ',Madrid',28,0,'7022756');
INSERT INTO PROVEEDORES VALUES (58,'CARO','TEJERO LORANCA','Jesus Manuel','Bravo Murillo', '88','Guadalajara',19,0,'2001500');
INSERT INTO PROVEEDORES VALUES (59,'TECNICONTA S.A.','MOLERO BORRAS','Felipe','Alborea', '36','Madrid',28,0,'4006842');
INSERT INTO PROVEEDORES VALUES (60,'TABLAS','SASTRE GUERRA','Maria Jesus','Narvaez', '27','Atienza',19,0,'7019134');
INSERT INTO PROVEEDORES VALUES (61,'TALLERES PAMO','CANTERO PRIETO','Reyes','Alberto Aguilera', '47','Madrid',28,0,'2013876');
INSERT INTO PROVEEDORES VALUES (62,'ADA','SALGADO FAURA','Juan','Narvaez', '1','Barcelona',8,0,'4000634');
INSERT INTO PROVEEDORES VALUES (63,'RTC S.A.','FAURA FAURA','Maria Luisa','Castellana', '83','Malaga',29,0,'7019212');
INSERT INTO PROVEEDORES VALUES (64,'HELIOS','LOPEZ BOYER','Maria Luisa','Castro Monte' , '43','Madrid',28,0,'2016784');
INSERT INTO PROVEEDORES VALUES (65,'DETECSA','GARCIA MOLERO','Maria Jesus','Alberto Aguilera', '20','Barcelona',8,0,'4023410');
INSERT INTO PROVEEDORES VALUES (66,'IEC','MARCOS AMATO','Andres','Serrano', '22','Barcelona',8,0,'7019964');
INSERT INTO PROVEEDORES VALUES (67,'REXPACS','BOYER LARA','Antonio','Bravo Murillo', '8','Madrid',28,0,'2027690');
INSERT INTO PROVEEDORES VALUES (68,'GPU S.A.','LOPEZ OLIVA','Jose Manuel','Bravo Murillo', '68','Madrid',28,0,'4021292');
INSERT INTO PROVEEDORES VALUES (69,'CARLIPS','COLORADO GUERRA','Reyes','Bravo Murillo', '51','Madrid',28,0,'7009326');
INSERT INTO PROVEEDORES VALUES (70,'BALS','REDONDO REQUENA','Pedro','Juan Barrera', '84','Barcelona',8,0,'2007568');
INSERT INTO PROVEEDORES VALUES (71,'GAME','LUNA OLIVA','Luis','Albaida', '7','Villareal',12,0,'4028142');
INSERT INTO PROVEEDORES VALUES (72,'FEMBASA','LOPEZ REDONDO','Maria Luisa','Alberto Aguilera', '77','Barcelona',8,0,'7008898');
INSERT INTO PROVEEDORES VALUES (73,'ARCOSOL','VALDIVIESO LUNA','Antonio','Fuencarral', '97','Madrid',28,0,'2005368');
INSERT INTO PROVEEDORES VALUES (74,'MONCLISA','FERNANDEZ LARA','Juan','Princesa', '2','Barcelona',8,0,'4004698');
INSERT INTO PROVEEDORES VALUES (75,'HORARIO','PELAEZ SASTRE','Federico','Fuencarral', '65','Guadalajara',19,0,'7026674');
INSERT INTO PROVEEDORES VALUES (76,'ROSCO','COLORADO ANTON','Reyes','Bravo Murillo', '26','Madrid',28,0,'2028428');
INSERT INTO PROVEEDORES VALUES (77,'SPOT IBERICA','SASTRE MOLINA','Julian','Goyeneche', '65','Sevilla',41,0,'4010026');
INSERT INTO PROVEEDORES VALUES (78,'KINDAR','TORRECILLAS RODRIGUEZ','Oscar','San Bernardo', '40','Barcelona',8,0,'7014994');
INSERT INTO PROVEEDORES VALUES (79,'TACIME','GUERRA LARA','Eloy','Gran Via', '82','Madrid',28,0,'2025934');
INSERT INTO PROVEEDORES VALUES (80,'DEL OLMO','ANTON MARADONA','Juan','Castro Serna' , '23','Barcelona',8,0,'4024122');
INSERT INTO PROVEEDORES VALUES (81,'MUNDIGRAF','PRIETO SIEIRO','Felipe','Esfinge', '79','Barcelona',8,0,'7017388');
INSERT INTO PROVEEDORES VALUES (82,'TRIGUERO','VADILLO SOLCHAGA','Jaime','Escuelas', '51','Madrid',28,0,'2006248');
INSERT INTO PROVEEDORES VALUES (83,'AMALLO','MARADONA AMATO','Reyes','Sancho Pacheco', '4','Madrid',28,0,'4027986');
INSERT INTO PROVEEDORES VALUES (84,'GISA','BOYER GONZALEZ','Oscar','Sandoval', '30','Madrid',28,0,'7019668');
INSERT INTO PROVEEDORES VALUES (85,'ROCHINA','AMATO MOLERO','Andres','Avila', '52','Madrid',28,0,'2020992');
INSERT INTO PROVEEDORES VALUES (86,'ESAN','SOLCHAGA PELAEZ','Ana','Ppe. de Vergara'  , '2','Barcelona',8,0,'4001548');
INSERT INTO PROVEEDORES VALUES (87,'JUBANY','COLORADO SINDE','Alfonso','Elfo', '6','Sevilla',41,0,'7028622');
INSERT INTO PROVEEDORES VALUES (88,'CELLINI','MORCILLO CASTEL','Luis','Juan Belmonte', '88','Madrid',28,0,'2010738');
INSERT INTO PROVEEDORES VALUES (89,'VIDA','PANIAGUA MONTERO','Pedro','San Jaime', '76','Barcelona',8,0,'4009964');
INSERT INTO PROVEEDORES VALUES (90,'ALCOLEA','GUIJARROCABELLO','Jose','Alcala', '14','Madrid',28,0,'7013742');
INSERT INTO PROVEEDORES VALUES (91,'LLORENS','SOLCHAGA BOLANO','Luis','Escuelas', '37','Villareal',12,0,'2023050');
INSERT INTO PROVEEDORES VALUES (92,'DETECSA','BOYER LARA','Jose Carlos','Ppe. de Vergara'  , '59','Madrid',28,0,'4006916');
INSERT INTO PROVEEDORES VALUES (93,'TALLERES MARFAN','AMATO REVENGA','Antonio','Juan Mazo', '30','Madrid',28,0,'7003692');
INSERT INTO PROVEEDORES VALUES (94,'AMPER','MORCILLO MARCOS','Carlos','Bravo Murillo', '22','Barcelona',8,0,'2020098');
INSERT INTO PROVEEDORES VALUES (95,'DSE','PALOMO PELAEZ','Felipe','Gran Via', '35','Villareal',12,0,'4003010');
INSERT INTO PROVEEDORES VALUES (96,'DALDA','PALOMO GUIJARRO','Juan','Ppe. de Vergara'  , '91','Madrid',28,0,'7010704');
INSERT INTO PROVEEDORES VALUES (97,'MATE','TORRECILLAS CASTEL','Maria Jesus','Narvaez', '42','Madrid',28,0,'2031834');
INSERT INTO PROVEEDORES VALUES (98,'CARLIPS','MORCILLO SALGADO','Jose Luis','Juan Mazo', '15','Malaga',29,0,'4023468');
INSERT INTO PROVEEDORES VALUES (99,'BECOR','VALDIVIESO REQUENA','Antonio','Bravo Murillo', '56','Madrid',28,0,'7029478');
INSERT INTO PROVEEDORES VALUES (100,'SIRO','ESTEVEZ VALDIVIESO','Julian','Sancho Pacheco', '79','Sevilla',41,0,'2030692');

--Insert de formas de pago**
INSERT INTO FORMAPAGOS VALUES ('C','Contado');
INSERT INTO FORMAPAGOS VALUES ('L1','30');
INSERT INTO FORMAPAGOS VALUES ('L2','30/60');
INSERT INTO FORMAPAGOS VALUES ('L3','30/60/90');
INSERT INTO FORMAPAGOS VALUES ('L4','30/60/90/120');
INSERT INTO FORMAPAGOS VALUES ('CR','Crédito');
INSERT INTO FORMAPAGOS VALUES ('AB','Abono banco');
INSERT INTO FORMAPAGOS VALUES ('CH','Cheque');
INSERT INTO FORMAPAGOS VALUES ('BZ','Bizum');

-- Inserciones en la tabla CLIENTES**
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (1,'MOTOROLA','BUENDIA CANTERO','Antonio','Duque de Medinacelli. 13', null ,'Valencia',8,0, '2028228','C',0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (2,'RTC S.A.','LUNA REQUENA','Maria Jesus','Profesor Waksman. 49' , null,'Valencia',8,0, 4031048,'C',0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (3,'GUYON','ROJAS MORCILLO','Jose','Palencia. 37' , null,'Valencia',8,0, 7011254,'C',0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (4,'P.P.B.',' BORRAS FAURA','Maria Jesus','Narvaez. 31 ',null,'Alicante',28,0,2017402,'C',7834305.12);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (5,' ARCO',' MOLERO HERAS',' Pedro',' Profesor Waksman. 51 ',  null,' Alicante', 28, 0,  4021796,'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (6,' FCP S.A.',' PALOMO VADILLO',' Jesus Manuel',' Orfila. 85 ',  null,' Alicante', 28, 0,  7005208,'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (7, 'MATE', 'SALGADO CANTERO', 'Jesus Manuel', 'Juan Belmonte. 53', NULL, 'Valencia', 8, 0, 2006524, 'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (8, 'DRAPOSA', 'GARCIA SASTRE', 'Angel', 'Gran Via. 57', NULL, 'Alicante', 28, 0, 4014220, 'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (9, 'ALCOLEA', 'CRISTOBAL OLIVA', 'Reyes', 'Narvaez. 48', NULL, 'Valencia', 8, 0, 7009908, 'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (10, 'DEL OLMO', 'GUERRA ESTEVEZ', 'Maria Jesus', 'Profesor Waksman. 14', NULL, 'Alicante', 28, 0, 2013692, 'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (11, 'CIFERSA', 'VAZQUEZ AMATO', 'Reyes', 'Goya. 33', NULL, 'Alicante', 28, 0, 4008714, 'C', 2942949.06);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (12, 'ATC', 'AMATO AMATO', 'Luis', 'Goyeneche. 60', NULL, 'Guadalajara', 19, 0, 7016752, 'C', 2069117.32);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (13, 'BARNICES DEVA', 'PELAEZ ESTEVEZ', 'Federico', 'Doctor Huya. 88', NULL, 'Valencia', 8, 0, 2007004, 'C', 1174628.44);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (14, 'ZENITH', 'MOLERO CANTERO', 'Jesus Manuel', 'Palacios. 86', NULL, 'Alicante', 28, 0, 4016324, 'C', 5518655.64);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (15, 'INTEL', 'CASTEL GONZALEZ', 'Andres', 'Castellana. 93', NULL, 'Valencia', 8, 0, 7000806, 'C', 1339824.64);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (16, 'LEM', 'REQUENA CEBRIAN', 'Federico', 'Fuencarral. 66', NULL, 'Granada', 18, 0, 2001512, 'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (17, 'SPOT IBERICA', 'TORRECILLAS CEBRIAN', 'Javier', 'Princesa. 85', NULL, 'Valencia', 8, 0, 4013724, 'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (18, 'RTC S.A.', 'ROJAS OLIVA', 'Reyes', 'Elche. 39', NULL, 'Valencia', 8, 0, 7004592, 'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (19, 'REXPACS', 'TEJERO GUIJARRO', 'Luis', 'Bravo Murillo. 76', NULL, 'Soria', 42, 0, 2032140, 'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (20, 'TALLERES MARFAN', 'AMATO REQUENA', 'Maria Jesus', 'Narvaez. 65', NULL, 'Valencia', 8, 0, 4031230, 'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (21, 'FESAN', 'MORCILLO CASTEL', 'Jose Manuel', 'Fuencarral. 13', NULL, 'Valencia', 8, 0, 7032082, 'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (22, 'TALLERES MARFAN', 'CANTERO LORANCA', 'Ana', 'Castro de Oro. 78', NULL, 'Valencia', 8, 0, 2011248, 'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (23, 'DETECSA', 'SIEIRO VAZQUEZ', 'Maria Luisa', 'Serrano. 91', NULL, 'Alicante', 28, 0, 4028016, 'C', 2474654.58);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (24, 'FIMSA', 'CANTERO ANTON', 'Angel', 'Princesa. 41', NULL, 'Valencia', 8, 0, 7011906, 'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (25, 'CIFERSA', 'REQUENA AROCA', 'Felipe', 'Roderos. 13', NULL, 'Alicante', 28, 0, 2031296, 'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (26, 'POLIGAS', 'COLORADO SOLCHAGA', 'Julian', 'Castro Serna. 70', NULL, 'Valencia', 8, 0, 4004886, 'C', 2912395.76);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (27, 'DSE', 'MONTERO REQUENA', 'Antonio', 'Ppe. de Vergara. 42', NULL, 'Alicante', 28, 0, 7026178, 'C', 2520847.42);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (28, 'GYM', 'MORCILLO CRISTOBAL', 'Jose Luis', 'Princesa. 47', NULL, 'Soria', 42, 0, 2002332, 'C', 2688528.76);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (29, 'DSE', 'FERNANDEZ ORGUILAR', 'Oscar', 'Avila. 88', NULL, 'Valencia', 8, 0, 4015688, 'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (30, 'PEREIRA', 'HERAS ROJAS', 'Jesus Manuel', 'Goya. 48', NULL, 'Granada', 18, 0, 7011426, 'C', 4951218.84);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (31, 'AOL', 'PULIDO REVENGA', 'Alfonso', 'Pajaritos. 64', NULL, 'Alicante', 28, 0, 2006950, 'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (32, 'DSE', 'REQUENA CRISTOBAL', 'Eloy', 'Don Quijote. 95', NULL, 'Alicante', 28, 0, 4008500, 'C', 313722.02);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (33, 'ELEUSIS', 'GONZALEZ LOPEZ', 'Angel', 'Serrano. 71', NULL, 'Valencia', 8, 0, 7001372, 'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (34, 'ALBISA', 'GUERRA PRIETO', 'Jose Luis', 'Profesor Waksman. 8', NULL, 'Alicante', 28, 0, 2004460, 'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (35, 'ATC', 'HERAS AROCA', 'Eloy', 'Elfo. 22', NULL, 'Alicante', 28, 0, 4013396, 'C', 4355603.1);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (36, 'CARO', 'PALOMO LOPEZ', 'Antonio', 'Serrano 29', NULL, 'Valencia', 8, 0, 7004682, 'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (37, 'GRIFFIN S.A.', 'LOPEZ PANIAGUA', 'Javier', 'Bravo Murillo 94', NULL, 'Alicante', 28, 0, 2018346, 'C', 6076421.46);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (38, 'E.M.M.', 'MONTERO AROCA', 'Reyes', 'Profesor Waksman 74', NULL, 'Valencia', 8, 0, 4015962, 'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (39, 'RTP', 'ROJAS SINDE', 'Jaime', 'Alberto Aguilera 80', NULL, 'Atienza', 19, 0, 7030160, 'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (40, 'DRAPOSA', 'CANTERO ANTON', 'Luis', 'Bravo Murillo 88', NULL, 'Sevilla', 41, 0, 2013106, 'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (41, 'DEPRETOL', 'REVENGA SALGADO', 'Julian', 'Isla Malta 49', NULL, 'Sevilla', 41, 0, 4030136, 'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (42, 'TEMINSA', 'BORRAS AROCA', 'Pedro', 'Princesa 69', NULL, 'Valencia', 8, 0, 7012154, 'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (43, 'DEL OLMO', 'PELAEZ TEJERO', 'Felix', 'Juan Belmonte 29', NULL, 'Valencia', 8, 0, 2024886, 'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (44, 'FCP S.A.', 'FERNANDEZ LOPEZ', 'Jaime', 'Orfila 46', NULL, 'Alicante', 28, 0, 4014620, 'C', 2845183.44);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (45, 'ROSCO', 'LARA CANTERO', 'Antonio', 'Bravo Murillo 95', NULL, 'Valencia', 8, 0, 7002316, 'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (46, 'ADA', 'MORCILLO MOLINA', 'Jose Luis', 'Sancho Pacheco 78', NULL, 'Valencia', 8, 0, 2008808, 'C', 130417.28);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (47, 'PALCOSA', 'GUIJARRO MOLINA', 'Angel', 'Alberto Leon 58', NULL, 'Valencia', 8, 0, 4021274, 'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (48, 'HARSHAW', 'REDONDO RODRIGUEZ', 'Jose', 'Ppe. de Vergara 68', NULL, 'Alicante', 28, 0, 7014264, 'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (49, 'ARCOSOL', 'COLORADO VALDIVIESO', 'Jesus Manuel', 'General Aranda 85', NULL, 'Valencia', 8, 0, 2031936, 'C', 3162395.38);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (50, 'ATR', 'BOYER HERAS', 'Antonio', 'Pedro Villar 84', NULL, 'Valencia', 8, 0, 4027696, 'C', 1571793.1);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (51, 'TALLERES', 'PAMO CALLE MORCILLO', 'Julian', 'San Jaime 87', NULL, 'Valencia', 8, 0, 7023136, 'C', 0.0);    
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (52, 'HIDROPONIA', 'GARCIA REDONDO', 'Jose Carlos', 'Albaida 53', NULL, 'Alicante', 28, 0, 2024322, 'C', 4999547.98);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (53, 'MOTOROLA', 'MARADONA CABELLO', 'Maria Jesus', 'Bravo Murillo 71', NULL, 'Alicante', 28, 0, 4028132, 'C', 1756132.82);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (54, 'LLORENS', 'ROJAS SINDE', 'Jose Luis', 'Bravo Murillo 69', NULL, 'Alicante', 28, 0, 7001766, 'C', 9662639.18);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (55, 'INFERSA', 'MORCILLO RODRIGUEZ', 'Jose Manuel', 'Dragon 31', NULL, 'Valencia', 8, 0, 2026990, 'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (56, 'CARLIPS', 'BORRAS ORGUILAR', 'Andres', 'Gran Via 27', NULL, 'Valencia', 8, 0, 4017778, 'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (57, 'BECOR', 'PELAEZ CALLE', 'Maria Jesus', 'Bravo Murillo 68', NULL, 'Valencia', 8, 0, 7023176, 'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (58, 'FITNESS', 'SASTRE AROCA', 'Ana', 'Pajaritos 38', NULL, 'Alicante', 28, 0, 2007882, 'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (59, 'INFERSA', 'RODRIGUEZ CANTERO', 'Luisa', 'Fuencarral 39', NULL, 'Alicante', 28, 0, 4027326, 'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (60, 'MACARRON S.A.', 'PALOMO REQUENA', 'Oscar', 'Bravo Murillo 51', NULL, 'Alicante', 28, 0, 7004742, 'C', 4847966.86);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (61, 'GYM', 'LORANCA REQUENA', 'Antonio', 'Alberto Aguilera 53', NULL, 'Malaga', 29, 0, 2007492, 'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (62, 'ENFERSA', 'ORGUILAR BOYER', 'Antonio', 'Castellana 2', NULL, 'Valencia', 8, 0, 4014000, 'C', 2116493.3);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (63, 'LEM', 'PRIETO PRIETO', 'Javier', 'Jaen 19', NULL, 'Valencia', 8, 0, 7016556, 'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (64, 'MONCLISA', 'FAURA REQUENA', 'Jose Luis', 'Goya 44', NULL, 'Valencia', 8, 0, 2022928, 'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (65, 'JULIO SOTO', 'SASTRE SIEIRO', 'Juan', 'Alarico 69', NULL, 'Granada', 18, 0, 4022522, 'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (66, 'HIDROPONIA', 'VADILLO RODRIGUEZ', 'Jose', 'Bravo Murillo 95', NULL, 'Valencia', 8, 0, 7019192, 'C', 6088441.04);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (67, 'PALCOSA', 'VADILLO ORGUILAR', 'Antonio', 'Sandoval 47', NULL, 'Alicante', 28, 0, 2014916, 'C', 13735675.4);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (68, 'MAJISA', 'CANTERO GARCIA', 'Jaime', 'Fuencarral 95', NULL, 'Valencia', 8, 0, 4016912, 'C', 9650181.1);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (69, 'CASAZUL', 'PULIDO AMATO', 'Luis', 'Jaen 22', NULL, 'Valencia', 8, 0, 7021504, 'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (70, 'MATE', 'CABELLO VAZQUEZ', 'Angel', 'Bravo Murillo 54', NULL, 'Valencia', 8, 0, 2027018, 'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (71, 'POLIGAS', 'SASTRE AMATO', 'Eloy', 'Pajaritos 90', NULL, 'Valencia', 8, 0, 4013228, 'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (72, 'GREGASA', 'CANTERO RODRIGUEZ', 'Jose Manuel', 'Princesa 16', NULL, 'Villareal', 12, 0, 7022398, 'C', 2525751.18);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (73, 'TACIME', 'BUENDIA REDONDO', 'Eloy', 'Alberto Aguilera 46', NULL, 'Alicante', 28, 0, 2026566, 'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (74, 'ARRIETA', 'CARDABA TEJERO', 'Oscar', 'Padul 7', NULL, 'Valencia', 8, 0, 4006646, 'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (75, 'MACARRON S.A.', 'PULIDO ROJAS', 'Julian', 'Profesor Waksman 17', NULL, 'Atienza', 19, 0, 7007908, 'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (76, 'PEREIRA', 'SALGADO CANTERO', 'Jose Manuel', 'Serrano 55', NULL, 'Alicante', 28, 0, 2016960, 'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (77, 'LEM', 'CALLE HERAS', 'Javier', 'Escuelas 42', NULL, 'Alicante', 28, 0, 4011844, 'C', 1004690.46);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (78, 'FEAGAS', 'CEBRIAN PALOMO', 'Eloy', 'Escuelas 82', NULL, 'Alicante', 28, 0, 7007156, 'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (79, 'ATT', 'LOPEZ CEBRIAN', 'Ana', 'Goya 59', NULL, 'Valencia', 8, 0, 2032732, 'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (80, 'ROBLES', 'MARCOS BORRAS', 'Maria Jesus', 'Narvaez 87', NULL, 'Atienza', 19, 0, 4023866, 'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (81, 'TACIME', 'CEBRIAN PRIETO', 'Carlos', 'Castellana 37', NULL, 'Alicante', 28, 0, 7010322, 'C', 1269389.62);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (82, 'RODIO', 'REDONDO ROJAS', 'Maria Jesus', 'Orfila 70', NULL, 'Alicante', 28, 0, 2028376, 'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (83, 'REXPACS', 'PANIAGUA SIEIRO', 'Jose Luis', 'Drogueros 46', NULL, 'Granada', 18, 0, 4022090, 'C', 4565025.64);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (84, 'ARCONES', 'VAZQUEZ BOLANO', 'Ana', 'San Bernardo 85', NULL, 'Alicante', 28, 0, 7004480, 'C', 1286057.92);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (85, 'ADA', 'LUNA CARDABA', 'Reyes', 'Bravo Murillo 24', NULL, 'Alicante', 28, 0, 2024062, 'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (86, 'GPU S.A.', 'GUIJARRO BOYER', 'Felix', 'Bravo Murillo 59', NULL, 'Valencia', 8, 0, 4019034, 'C', 4750587.22);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (87, 'ADA', 'REVENGA LUNA', 'Antonio', 'Conde Torralba 31', NULL, 'Valencia', 8, 0, 7020174, 'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (88, 'TABLAS', 'MARADONA MORENTE', 'Ana', 'Bravo Murillo 84', NULL, 'Azpeitia', 20, 0, 2007902, 'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (89, 'MASIDER', 'OLIVA MOLERO', 'Felix', 'Sandoval 63', NULL, 'Alicante', 28, 0, 4027954, 'C', 7306205.32);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (90, 'SCOTCHMAN', 'GUERRA PANIAGUA', 'Eloy', 'Elfo 35', NULL, 'Alicante', 28, 0, 7008704, 'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (91, 'VENTAUTO', 'PULIDO OLIVA', 'Luis', 'Princesa 73', NULL, 'Valencia', 8, 0, 2006568, 'C', 3916102.1);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (92, 'ESSA', 'AROCA RODRIGUEZ', 'Luisa', 'Alcala 54', NULL, 'Valencia', 8, 0, 4021338, 'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (93, 'ARCO', 'OLIVA GARCIA', 'Jose Manuel', 'Escribanos 69', NULL, 'Alicante', 28, 0, 7020398, 'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (94, 'SPOT IBERICA', 'SIEIRO MONTERO', 'Felix', 'Goya 44', NULL, 'Alicante', 28, 0, 2029008, 'C', 3627657.78);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (95, 'AUTOCARES SALAS', 'TEJERO LOPEZ', 'Carlos', 'Narvaez 22', NULL, 'Valencia', 8, 0, 4021334, 'C', 500384.16);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (96, 'DATAPOINT', 'MORENTE SALGADO', 'Ana', 'Reina Mercedes 89', NULL, 'Valencia', 8, 0, 7012122, 'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (97, 'ROS', 'AMATO BOLANO', 'Ana', 'Ponzano 95', NULL, 'Sevilla', 41, 0, 2030254, 'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (98, 'CASAZUL', 'SINDE CEBRIAN', 'Ana', 'Palacios 67', NULL, 'Alicante', 28, 0, 4017436, 'C', 1079965.66);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (99, 'ALFOMBRAS MAS', 'PRIETO CEBRIAN', 'Carlos', 'Bravo Murillo 95', NULL, 'Guadalajara', 19, 0, 7023996, 'C', 0.0);
INSERT INTO CLIENTES (cliente, empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono, forma_pago, total_factura) 
VALUES (100, 'INTEL', 'VALDIVIESO AROCA', 'Luisa', 'Bravo Murillo 49', NULL, 'Valencia', 8, 0, 2011086, 'C', 0.0);



-- Inserciones en la tabla ALBARANES**
INSERT INTO ALBARANES VALUES (1, 14, '2024-11-11', '2024-11-18', '2024-11-25', 'C', 'N');
INSERT INTO ALBARANES VALUES (2, 28, '2024-08-16', '2024-08-23', '2024-09-01', 'C', 'N');
INSERT INTO ALBARANES VALUES (3, 13, '2024-04-23', '2024-05-01', '2024-05-08', 'C', 'N');
INSERT INTO ALBARANES VALUES (4, 68, '2024-02-27', '2024-03-01', '2024-03-08', 'C', 'N');
INSERT INTO ALBARANES VALUES (5, 26, '2024-01-13', '2024-01-20', '2024-01-27', 'C', 'N');
INSERT INTO ALBARANES VALUES (6, 84, '2024-10-16', '2024-10-23', '2024-11-01', 'C', 'N');
INSERT INTO ALBARANES VALUES (7, 67, '2024-07-22', '2024-08-01', '2024-08-08', 'C', 'N');
INSERT INTO ALBARANES VALUES (8, 12, '2024-12-23', '1989-01-01', '1989-01-08', 'C', 'N');
INSERT INTO ALBARANES VALUES (9, 32, '2024-07-28', '2024-08-01', '2024-08-08', 'C', 'S');
INSERT INTO ALBARANES VALUES (10, 37, '2024-11-14', '2024-11-21', '2024-11-28', 'C', 'N');
INSERT INTO ALBARANES VALUES (11, 95, '2024-06-05', '2024-06-12', '2024-06-19', 'C', 'N');
INSERT INTO ALBARANES VALUES (12, 68, '2024-12-11', '2024-12-18', '2024-12-25', 'C', 'N');
INSERT INTO ALBARANES VALUES (13, 62, '2024-02-15', '2024-02-22', '2024-03-01', 'C', 'N');
INSERT INTO ALBARANES VALUES (14, 89, '2024-09-21', '2024-09-28', '2024-10-01', 'C', 'N');
INSERT INTO ALBARANES VALUES (15, 68, '2024-04-26', '2024-05-01', '2024-05-08', 'C', 'N');
INSERT INTO ALBARANES VALUES (16, 4, '2024-10-19', '2024-10-26', '2024-11-01', 'C', 'N');
INSERT INTO ALBARANES VALUES (17, 54, '2024-07-27', '2024-08-01', '2024-08-08', 'C', 'N');
INSERT INTO ALBARANES VALUES (18, 4, '2024-05-25', '2024-06-01', '2024-06-08', 'C', 'N');
INSERT INTO ALBARANES VALUES (19, 23, '2024-11-11', '2024-11-18', '2024-11-25', 'C', 'N');
INSERT INTO ALBARANES VALUES (20, 46, '2024-06-24', '2024-07-01', '2024-07-08', 'C', 'N');
INSERT INTO ALBARANES VALUES (21, 52, '2024-08-04', '2024-08-11', '2024-08-18', 'C', 'N');
INSERT INTO ALBARANES VALUES (22, 60, '2024-11-03', '2024-11-10', '2024-11-17', 'C', 'N');
INSERT INTO ALBARANES VALUES (23, 30, '2024-06-09', '2024-06-16', '2024-06-23', 'C', 'N');
INSERT INTO ALBARANES VALUES (24, 91, '2024-11-07', '2024-11-14', '2024-11-21', 'C', 'N');
INSERT INTO ALBARANES VALUES (25, 15, '2024-01-07', '2024-01-14', '2024-01-21', 'C', 'N');
INSERT INTO ALBARANES VALUES (26, 26, '2024-05-27', '2024-06-01', '2024-06-08', 'C', 'N');
INSERT INTO ALBARANES VALUES (27, 44, '2024-07-18', '2024-07-25', '2024-08-01', 'C', 'N');
INSERT INTO ALBARANES VALUES (28, 37, '2024-02-15', '2024-02-22', '2024-03-01', 'C', 'N');
INSERT INTO ALBARANES VALUES (29, 72, '2024-08-17', '2024-08-24', '2024-09-01', 'C', 'N');
INSERT INTO ALBARANES VALUES (30, 62, '2024-01-26', '2024-02-01', '2024-02-08', 'C', 'N');
INSERT INTO ALBARANES VALUES (31, 30, '2024-06-13', '2024-06-20', '2024-06-27', 'C', 'N');
INSERT INTO ALBARANES VALUES (32, 94, '2024-08-01', '2024-08-08', '2024-08-15', 'C', 'N');
INSERT INTO ALBARANES VALUES (33, 89, '2024-04-07', '2024-04-14', '2024-04-21', 'C', 'N');
INSERT INTO ALBARANES VALUES (34, 72, '2024-07-06', '2024-07-13', '2024-07-20', 'C', 'N');
INSERT INTO ALBARANES VALUES (35, 83, '2024-10-11', '2024-10-18', '2024-10-25', 'C', 'N');
INSERT INTO ALBARANES VALUES (36, 54, '2024-03-12', '2024-03-19', '2024-03-26', 'C', 'N');
INSERT INTO ALBARANES VALUES (37, 52, '2024-11-15', '2024-11-22', '2024-12-01', 'C', 'N');
INSERT INTO ALBARANES VALUES (38, 35, '2024-06-13', '2024-06-20', '2024-06-27', 'C', 'N');
INSERT INTO ALBARANES VALUES (39, 49, '2024-11-18', '2024-11-25', '2024-12-01', 'C', 'N');
INSERT INTO ALBARANES VALUES (40, 50, '2024-05-15', '2024-05-22', '2024-06-01', 'C', 'N');
INSERT INTO ALBARANES VALUES (41, 67, '2024-03-21', '2024-03-28', '2024-04-01', 'C', 'N');
INSERT INTO ALBARANES VALUES (42, 11, '2024-06-18', '2024-06-25', '2024-07-01', 'C', 'N');
INSERT INTO ALBARANES VALUES (43, 27, '2024-12-28', '1989-01-01', '1989-01-08', 'C', 'N');
INSERT INTO ALBARANES VALUES (44, 83, '2024-02-10', '2024-02-17', '2024-02-24', 'C', 'N');
INSERT INTO ALBARANES VALUES (45, 53, '2024-09-15', '2024-09-22', '2024-10-01', 'C', 'N');
INSERT INTO ALBARANES VALUES (46, 81, '2024-09-26', '2024-10-01', '2024-10-08', 'C', 'N');
INSERT INTO ALBARANES VALUES (47, 86, '2024-09-16', '2024-09-23', '2024-10-01', 'C', 'N');
INSERT INTO ALBARANES VALUES (48, 66, '2024-06-16', '2024-06-23', '2024-07-01', 'C', 'N');
INSERT INTO ALBARANES VALUES (49, 77, '2024-08-23', '2024-09-01', '2024-09-08', 'C', 'N');
INSERT INTO ALBARANES VALUES (50, 98, '2024-08-22', '2024-09-01', '2024-09-08', 'C', 'N');

-- Inserciones en la tabla LINEAS
INSERT INTO LINEAS (albaran,linea,articulo,proveedor,cantidad,descuento,precio)
VALUES ();

-- Inserciones en la tabla ARTICULOS
INSERT INTO ARTICULOS (articulo,proveedor,descripcion,pr_vent,pr_cost,existencias,sobre_maximo,bajo_minimo,fec_ult_ent,fec_ult_sal,unidad)
VALUES ();



--CONSULTAS
--1
SELECT *
FROM proveedores

--2
SELECT cliente, nombre
FROM clientes
WHERE total_factura > 50

--3
SELECT albaran
FROM albaranes
WHERE UPPER(facturado) LIKE 'N'

--4
SELECT *
FROM albaranes
WHERE albaran = 40

--5
SELECT *
FROM articulos
WHERE existencias < bajo_minimo

--6
SELECT *
FROM articulos
WHERE existencias > sobre_maximo

--7
SELECT nombre
FROM clientes
WHERE UPPER(poblacion) LIKE 'ALICANTE'

SELECT nombre
FROM clientes
WHERE UPPER(provincia) = 28

--8
SELECT provincias.descripcion
FROM proveedores INNER JOIN provincias ON provincias.provincia = proveedores.provincia 
WHERE UPPER(proveedores.empresa) LIKE 'ROSCO'

--9
SELECT articulo
FROM articulos INNER JOIN proveedores ON proveedores.proveedor = articulos.proveedor
WHERE articulos.proveedor = 12

--10
SELECT *
FROM clientes c, albaranes ab, articulos ar, lineas l
WHERE cliente = l cliente
AND ab albaran = l albaran
AND ar articulo = l articulo

--11


--13. Ver los albaranes del cliente número 5 en el rango de fechas 01/01/2024
--y 31/03/2024
SELECT *
FROM albaranes
WHERE cliente = 5

--14. Obtener una lista de todas las provincias de los clientes y cuántos
--clientes hay en cada provincia


--15. Contar cuántos productos hay en cada unidad de medida
SELECT unidad, COUNT(*)
FROM articulos
GROUP BY unidad

--16. Número de albaranes que tiene cada formas de pago
SELECT forma_pago, COUNT(*)
FROM albaranes
GROUP BY forma_pago

--17. Precio total de las líneas que tiene cada albarán
SELECT albaran, SUM(precio)
FROM lineas
GROUP BY albaran

--18. Total de ventas por cliente y forma de pago
SELECT cliente, forma_pago, SUM(total_factura)
FROM clientes
GROUP BY cliente, forma_pago
--19. Obtener el total de ventas de cada producto por cada proveedor
SELECT proveedor, articulo, SUM(precio)
FROM lineas
GROUP BY proveedor, articulo
--20. Obtener el total de ventas por provincia de cliente y su promedio de
--ventas
SELECT provincia, SUM(total_factura), AVG(total_factura)
FROM clientes
GROUP BY provincia
--21. Datos de clientes que hayan realizado pago aplazado (en 30, 60,…días)
SELECT *
FROM clientes
WHERE forma_pago = 'A'

--22. Precio total de las líneas enviadas en agosto del 2024 pagadas en
--efectivo.
SELECT SUM(precio)
FROM lineas l, albaranes a
WHERE l.albaran = a.albaran
AND a.fec_entrega BETWEEN '2024-08-01' AND '2024-08-31'
AND a.forma_pago = 'E'

--23. Diferencia (ganancia) entre el precio de coste y venta de los artículos.
SELECT articulo, pr_vent - pr_cost
FROM articulos

--24. Número de artículos que suministra cada proveedor.
SELECT proveedor, COUNT(*)
FROM articulos
GROUP BY proveedor

--25. Datos de los proveedores que suministran más de 3 artículos distintos.
SELECT proveedor
FROM articulos
GROUP BY proveedor
HAVING COUNT(DISTINCT articulo) > 3

--26. Clientes con más de un albarán y el total facturado por cada uno de ellos
SELECT cliente, COUNT(*), SUM(total_factura)
FROM clientes
GROUP BY cliente
HAVING COUNT(*) > 1

--27. Ver proveedores y sus productos más vendidos
SELECT proveedor, articulo, MAX(cantidad)
FROM lineas
GROUP BY proveedor, articulo

--28. Consultar el total de ventas por proveedor en el primer trimestre del
--2024
SELECT proveedor, SUM(precio + cantidad)
FROM lineas l, albaranes a,
WHERE l.albaran = a.albaran
AND a.fecha_albaran BETWEEN '2024-01-01' AND '2024-03-31'
GROUP BY proveedor

--29. Ver los productos más vendidos por el cliente número 5 en el último
--trimestre del 2024 ordenados por la cantidad vendida
SELECT articulo, SUM(cantidad)
FROM lineas l, albaranes a
WHERE l.albaran = a.albaran
AND a.cliente = 5
AND a.fec_entrega BETWEEN '2024-10-01' AND '2024-12-31'
GROUP BY articulo
ORDER BY SUM(cantidad) DESC

--30. Ver los proveedores con los productos que no han sido vendidos en los
--últimos 6 meses
SELECT proveedor, articulo
FROM lineas l, albaranes
WHERE l.albaran = albaranes.albaran
AND albaranes.fecha_albaran NOT BETWEEN '2024-06-01' AND '2024-12-31'
GROUP BY proveedor, articulo
HAVING COUNT(*) = 0

--a partir de aqui pueden aparecer subconsultas
--31. Ver los productos que no tienen ventas y sus proveedores
SELECT DISTINCT articulo
FROM lineas
WHERE articulo NOT IN (SELECT articulo 
                       FROM lineas
                       GROUP BY articulo)

--32. Obtener los proveedores que tienen productos con existencias por
--debajo del mínimo
SELECT DISTINCT proveedor
FROM articulos
WHERE existencias < bajo_minimo

--33. Clientes que han comprado un producto, articulo 101 (subconsulta con
--JOIN)
SELECT cliente
FROM albaranes a, lineas l
WHERE a.albaran = l.albaran
AND l.articulo = 101

--34. Proveedores con productos que no tienen ventas en el último año
SELECT DISTINCT proveedor
FROM articulos
WHERE articulo NOT IN (SELECT articulo
                       FROM lineas l, albaranes a
                       WHERE l.albaran = a.albaran
                       AND a.fecha_albaran BETWEEN '2023-01-01' AND '2023-12-31')

--35. Ver los albaranes que tienen productos con precios por encima del
--promedio de todos los productos
SELECT albaran
FROM lineas
WHERE precio > (SELECT AVG(precio)
                FROM lineas)

--36. Obtener el cliente con el mayor total de compras
SELECT DISTINCT proveedor
FROM articulos
WHERE existencias < bajo_minimo

--37. Productos que tienen un precio superior al promedio de productos
--vendidos por el proveedor 123
SELECT articulo
FROM articulos
WHERE pr_vent > (SELECT AVG(pr_vent)
                 FROM articulos
                 WHERE proveedor = 123)

--38. Clientes que no han realizado compras en el último año
SELECT cliente
FROM albaranes
WHERE cliente NOT IN (SELECT cliente
                      FROM albaranes
                      WHERE fecha_albaran BETWEEN '2023-01-01' AND '2023-12-31')

--39. Productos cuyo precio de venta está por debajo del precio de costo
--promedio
SELECT articulo
FROM articulos
WHERE pr_vent < (SELECT AVG(pr_cost)
                 FROM articulos)

--40. Clientes que han comprado más de 5 productos diferentes
SELECT cliente
FROM lineas
GROUP BY cliente
HAVING COUNT(DISTINCT articulo) > 5

--41. Ver los proveedores con productos con existencias por encima de un
--cierto umbral (100), pero sin ventas en los últimos 6 meses
SELECT DISTINCT proveedor
FROM articulos
WHERE existencias > 100
AND articulo NOT IN (SELECT articulo
                     FROM lineas l, albaranes a
                     WHERE l.albaran = a.albaran
                     AND a.fecha_albaran BETWEEN '2024-06-01' AND '2024-12-31')

--42. Ver los albaranes cuyo total es mayor que el promedio de todos los
--albaranesº
SELECT albaran
FROM albaranes
WHERE total > (SELECT AVG(total)
               FROM albaranes)
               
