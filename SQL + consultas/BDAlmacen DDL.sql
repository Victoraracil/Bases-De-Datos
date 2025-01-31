-- BD ALMACEN

-- MODIFICAMOS LA CONFIGURACION PARA INSERTAR LA FECHA
ALTER SESSION SET NLS_DATE_FORMAT='DD/MM/YYYY';

-- BORRADO DE TABLAS
DROP TABLE UNIDADES CASCADE CONSTRAINTS;
DROP TABLE PROVINCIAS CASCADE CONSTRAINTS;
DROP TABLE PROVEEDORES CASCADE CONSTRAINTS;
DROP TABLE FORMAPAGOS CASCADE CONSTRAINTS;
DROP TABLE ALBARANES CASCADE CONSTRAINTS;
DROP TABLE LINEAS CASCADE CONSTRAINTS;
DROP TABLE CLIENTES CASCADE CONSTRAINTS;
DROP TABLE ARTICULOS CASCADE CONSTRAINTS;

-- CREACIÓN DE TABLAS
CREATE TABLE UNIDADES (
    unidad VARCHAR2(2) PRIMARY KEY,
    descripcion VARCHAR2(12)
);

CREATE TABLE PROVINCIAS (
    provincia NUMBER(6) PRIMARY KEY,
    descripcion VARCHAR2(14),
    prefijo NUMBER(6)
);

CREATE TABLE PROVEEDORES (
    proveedor NUMBER(3) PRIMARY KEY,
    empresa VARCHAR2(15),
    apellidos VARCHAR2(25),
    nombre VARCHAR2(15),
    direccion1 VARCHAR2(30),
    direccion2 VARCHAR2(30),
    poblacion VARCHAR2(15),
    provincia NUMBER(6),
    distrito NUMBER(10),
    telefono VARCHAR2(16),
    CONSTRAINT fk_provincia FOREIGN KEY (provincia) REFERENCES PROVINCIAS(provincia) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE FORMAPAGOS (
    forma_pago VARCHAR2(10) PRIMARY KEY,
    descripcion VARCHAR2(30)
);

CREATE TABLE ALBARANES (
    albaran_id NUMBER(6) PRIMARY KEY,
    fecha_albaran DATE NOT NULL,
    fecha_envio DATE NOT NULL,
    forma_pago VARCHAR2(10) NOT NULL,
    CONSTRAINT fk_forma_pago FOREIGN KEY (forma_pago) REFERENCES FORMAPAGOS(forma_pago) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT chk_fecha_envio CHECK (fecha_envio > fecha_albaran)
);

CREATE TABLE LINEAS (
    linea_id NUMBER(6) PRIMARY KEY,
    albaran_id NUMBER(6),
    cantidad NUMBER(10,2) CHECK (cantidad > 0),
    precio NUMBER(10,2) CHECK (precio > 0),
    CONSTRAINT fk_albaran FOREIGN KEY (albaran_id) REFERENCES ALBARANES(albaran_id) ON DELETE RESTRICT ON UPDATE CASCADE
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

-- Realizamos la inserción de datos
-- Inserciones en la tabla UNIDADES
INSERT INTO UNIDADES VALUES ('Un','Unidades');
INSERT INTO UNIDADES VALUES ('m','metros');
INSERT INTO UNIDADES VALUES ('Kg','Kilogramos');
INSERT INTO UNIDADES VALUES ('Cj','Cajas');
INSERT INTO UNIDADES VALUES ('l','litros');
INSERT INTO UNIDADES VALUES ('cc','cm cubicos');

-- Inserciones en la tabla PROVINCIAS
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

-- Inserciones en la tabla PROVEEDORES
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (1,'CASA','REVENGA AROCA','Maria Luisa','San Jaime, 75', ,'Villareal',12,0,'(  )-2014182');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (2,'R. BRANAS','CARDABA ORGUILAR','Reyes,Narvaez, 0', ,'Sevilla',41,0,'(  )-4014148');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (3,'TABLAS,ORGUILAR ESTEVEZ','Ana,Bravo Murillo, 20', ,'Madrid',28,0,'(  )-7030792');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (4,'VENTAUTO,MORCILLO PALOMO','Jose,Bravo Murillo, 78', ,'Granada',18,0,'(  )-2004806');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (5,'ART,BORRAS CALLE','Oscar,Padul, 27', ,'Villareal',12,0,'(  )-4008404');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (6,'DAM,MORENTE RODRIGUEZ','Jose,Princesa, 98', ,'Malaga',29,0,'(  )-7030222');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (7,'BECOR,BORRAS GARCIA','Jose Carlos','Dracena, 20', ,'Barcelona',8,0,'(  )-2026780');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (8,'TYLER,GONZALEZ TEJERO','Maria Jesus','Castro Serna , 0', ,'Madrid',28,0,'(  )-4022352');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (9,'HELIOS,LORANCA VALDIVIESO','Antonio','Ppe. de Vergara  , 14', ,'Madrid',28,0,'(  )-7024510');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (10,'BARNICES DEVA','SASTRE LORANCA','Federico','Bravo Murillo, 33', ,'Azpeitia',20,0,'(  )-2003738');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (11,'ALFOMBRAS MAS','MORCILLO AROCA','Luisa','Isla Malta, 23', ,'Atienza',19,0,'(  )-4031508');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (12,'SIRO','CEBRIAN MONTERO','Javier','Castro de Oro, 2', ,'Barcelona',8,0,'(  )-7031802');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (13,'FESAN','TEJERO LOPEZ','Felipe,Palacios, 27', ,'Barcelona',8,0,'(  )-2014272');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (14,'HELIOS','TEJERO GUIJARRO','Antonio','Ppe. de Vergara  , 57', ,'Villareal',12,0,'(  )-4010578');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (15,'ROSCO','SASTRE SIEIRO','Jose Manuel','Ppe. de Vergara  , 45', ,'Madrid',28,0,'(  )-7025470');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (16,'CIFERSA','ANTON ORGUILAR','Eloy','Serrano, 77', ,'Malaga',29,0,'(  )-2026710');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (17,'ARRIETA','MOLERO BORRAS','Felipe','Avila, 39', ,'Barcelona',8,0,'(  )-4001684');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (18,'GRANDA S.A.','CARDABA VADILLO','Luis','Elda, 1', ,'Barcelona',8,0,'(  )-7013266');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (19,'HELIOS','REVENGA CANTERO','Jaime','Alaro, 52', ,'Barcelona',8,0,'(  )-2026824');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (20,'VENTAUTO','VAZQUEZ BUENDIA','Eloy','Espalter', 0, ,'Barcelona',8,0,'(  )-4026682');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (21,'FIMSA','MARCOS ORGUILAR','Jose Manuel','Palacios, 45', ,'Barcelona',8,0,'(  )-7024854');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (22,'AGRUGASA','RODRIGUEZ CALLE','Angel','Sandoval, 17', ,'Guadalajara',19,0,'(  )-2005354');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (23,'DAM','REVENGA REDONDO','Pedro','Jose Noriega, 99', ,'Madrid',28,0,'(  )-4031532');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (24,'REINA CASTILLA','LARA ORGUILAR','Jose,Serrano, 99', ,'Barcelona',8,0,'(  )-7017106');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (25,'CARLIPS','GARCIA LUNA','Jose Carlos','Juan Anton, 89', ,'Barcelona',8,0,'(  )-2004750');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (26,'ARCO','BOYER PANIAGUA','Julian','Goya, 42', ,'Barcelona',8,0,'(  )-4000354');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (27,'COMERCIAL SILMAR','FAURA ESTEVEZ','Andres','Princesa, 87', ,'Sevilla',41,0,'(  )-7025316');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (28,'DETECSA','VADILLO BOYER','Maria Jesus','Goya, 87', ,'Barcelona',8,0,'(  )-2014058');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (29,'REFO','COLORADO AMATO','Oscar','Bravo Murillo, 32', ,'Barcelona',8,0,'(  )-4009810');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (30,'IEC','GUERRA CANTERO','Ana','Alberto Aguilera, 63', ,'Madrid',28,0,'(  )-7000220');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (31,'REINA CASTILLA','BORRAS PANIAGUA','Javier','Padul, 2', ,'Madrid',28,0,'(  )-2016372');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (32,'PEDRAZA','REDONDO COLORADO','Angel','Bravo Murillo, 24', ,'Madrid',28,0,'(  )-4005560');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (33,'TRITON','GUERRA SASTRE','Luisa','Orfila, 53', ,'Madrid',28,0,'(  )-7021966');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (34,'TYLER','MARADONA RODRIGUEZ','Eloy','Serrano, 85', ,'Granada',18,0,'(  )-2019380');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (35,'COFIMSA','REQUENA GUIJARRO','Federico','Narvaez, 20', ,'Madrid',28,0,'(  )-4002782');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (36,'GREGASA','CANTERO BOLANO','Jaime','Alberto Aguilera, 25', ,'Madrid',28,0,'(  )-7021732');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (37,'LLORENS','VAZQUEZ COLORADO','Luisa','Montera, 85', ,'Soria',42,0,'(  )-2024588');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (38,'SEGURGAS','ANTON GUIJARRO','Ana','Dulcinea, 63', ,'Barcelona',8,0,'(  )-4007194');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (39,'TILEER','PANIAGUA RODRIGUEZ','Luis','Narvaez, 92', ,'Barcelona',8,0,'(  )-7027756');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (40,'DAM','REQUENA CEBRIAN','Jose Manuel','Serrano, 54', ,'Madrid',28,0,'(  )-2024672');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (41,'AGRUGASA','REVENGA HERAS','Jose Manuel','Bravo Murillo, 7', ,'Madrid',28,0,'(  )-4000316');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (42,'AMALLO','BOLANO GARCIA','Jaime','Serrano, 69', ,'Madrid',28,0,'(  )-7031692');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (43,'BIMASA S.L.','GARCIA AROCA','Reyes','Alcala, 62', ,'Madrid',28,0,'(  )-2032182');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (44,'FCP S.A.','AROCA MARCOS','Javier','San Bernardo, 28', ,'Barcelona',8,0,'(  )-4014864');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (45,'CARNAUD','LUNA SALGADO','Angel','Ppe. de Vergara  , 20', ,'Madrid',28,0,'(  )-7012924');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (46,'FACIT','LORANCA VALDIVIESO','Alfonso','Alava, 64', ,'Barcelona',8,0,'(  )-2028230');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (47,'DATAPOINT','CALLE LOPEZ','Javier','Castellana, 19', ,'Madrid',28,0,'(  )-4010438');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (48,'CASA','MOLINA MOLINA','Ana','Goya, 78', ,'Madrid',28,0,'(  )-7003002');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (49,'R. BRANAS','LARA PALOMO','Eloy','Castellana, 7', ,'Madrid',28,0,'(  )-2012584');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (50,'CIFERSA','LARA LUNA','Maria Luisa','Bravo Murillo, 24', ,'Barcelona',8,0,'(  )-4025492');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (51,'HORARIO','REDONDO PRIETO','Felix','Ppe. de Vergara  , 74', ,'Madrid',28,0,'(  )-7027284');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (52,'AMPE','CALLE PALOMO','Felix','General Aranaz, 57', ,'Barcelona',8,0,'(  )-2010030');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (53,'GUYON','REQUENA VADILLO','Luis','Serrano, 68', ,'Guadalajara',19,0,'(  )-4028740');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (54,'SLIPPER','TEJERO MONTERO','Reyes','Fuencarral, 72', ,'Barcelona',8,0,'(  )-7022294');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (55,'CORITEL','RODRIGUEZ REQUENA','Jose Carlos','Bravo Murillo, 88', ,'Barcelona',8,0,'(  )-2004984');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (56,'DATAPOINT','VADILLO MARADONA','Felix','Isla Nelson, 68', ,'Sevilla',41,0,'(  )-4001596');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (57,'GONBARRI','MOLERO CASTEL','Jose Carlos','Alberto Aguilera, 92', ',Madrid',28,0,'(  )-7022756');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (58,'CARO','TEJERO LORANCA','Jesus Manuel','Bravo Murillo, 88', ,'Guadalajara',19,0,'(  )-2001500');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (59,'TECNICONTA S.A.','MOLERO BORRAS','Felipe','Alborea, 36', ,'Madrid',28,0,'(  )-4006842');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (60,'TABLAS','SASTRE GUERRA','Maria Jesus','Narvaez, 27', ,'Atienza',19,0,'(  )-7019134');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (61,'TALLERES PAMO','CANTERO PRIETO','Reyes','Alberto Aguilera, 47', ,'Madrid',28,0,'(  )-2013876');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (62,'ADA','SALGADO FAURA','Juan','Narvaez, 1', ,'Barcelona',8,0,'(  )-4000634');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (63,'RTC S.A.','FAURA FAURA','Maria Luisa','Castellana, 83', ,'Malaga',29,0,'(  )-7019212');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (64,'HELIOS','LOPEZ BOYER','Maria Luisa','Castro Monte , 43', ,'Madrid',28,0,'(  )-2016784');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (65,'DETECSA','GARCIA MOLERO','Maria Jesus','Alberto Aguilera, 20', ,'Barcelona',8,0,'(  )-4023410');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (66,'IEC','MARCOS AMATO','Andres','Serrano, 22', ,'Barcelona',8,0,'(  )-7019964');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (67,'REXPACS','BOYER LARA','Antonio','Bravo Murillo, 8', ,'Madrid',28,0,'(  )-2027690');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (68,'GPU S.A.','LOPEZ OLIVA','Jose Manuel','Bravo Murillo, 68', ,M'adrid',28,0,'(  )-4021292');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (69,'CARLIPS','COLORADO GUERRA','Reyes','Bravo Murillo, 51', ,'Madrid',28,0,'(  )-7009326');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (70,'BALS','REDONDO REQUENA','Pedro','Juan Barrera, 84', ,'Barcelona',8,0,'(  )-2007568');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (71,'GAME','LUNA OLIVA','Luis','Albaida, 7', ,'Villareal',12,0,'(  )-4028142');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (72,'FEMBASA','LOPEZ REDONDO','Maria Luisa','Alberto Aguilera, 77', ,'Barcelona',8,0,'(  )-7008898');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (73,'ARCOSOL','VALDIVIESO LUNA','Antonio','Fuencarral, 97', ,'Madrid',28,0,'(  )-2005368');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (74,'MONCLISA','FERNANDEZ LARA','Juan','Princesa, 2', ,'Barcelona',8,0,'(  )-4004698');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (75,'HORARIO','PELAEZ SASTRE','Federico','Fuencarral, 65', ,'Guadalajara',19,0,'(  )-7026674');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (76,'ROSCO','COLORADO ANTON','Reyes','Bravo Murillo, 26', ,'Madrid',28,0,'(  )-2028428');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (77,'SPOT IBERICA','SASTRE MOLINA','Julian','Goyeneche, 65', ,'Sevilla',41,0,'(  )-4010026');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (78,'KINDAR','TORRECILLAS RODRIGUEZ','Oscar','San Bernardo, 40', ,'Barcelona',8,0,'(  )-7014994');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (79,'TACIME','GUERRA LARA','Eloy','Gran Via, 82', ,'Madrid',28,0,'(  )-2025934');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (80,'DEL OLMO','ANTON MARADONA','Juan','Castro Serna , 23', ,'Barcelona',8,0,'(  )-4024122');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (81,'MUNDIGRAF','PRIETO SIEIRO','Felipe','Esfinge, 79', ,'Barcelona,8',0,'(  )-7017388');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (82,'TRIGUERO','VADILLO SOLCHAGA','Jaime','Escuelas, 51', ,'Madrid',28,0,'(  )-2006248');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (83,'AMALLO','MARADONA AMATO','Reyes','Sancho Pacheco, 4', ,'Madrid',28,0,'(  )-4027986');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (84,'GISA','BOYER GONZALEZ','Oscar','Sandoval, 30', ,'Madrid',28,0,'(  )-7019668');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (85,'ROCHINA','AMATO MOLERO','Andres','Avila, 52', ,'Madrid',28,0,'(  )-2020992');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (86,'ESAN','SOLCHAGA PELAEZ','Ana','Ppe. de Vergara  , 2', ,'Barcelona',8,0,'(  )-4001548');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (87,'JUBANY','COLORADO SINDE','Alfonso','Elfo, 6', ,'Sevilla',41,0,'(  )-7028622');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (88,'CELLINI','MORCILLO CASTEL','Luis','Juan Belmonte, 88', ,'Madrid',28,0,'(  )-2010738');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (89,'VIDA','PANIAGUA MONTERO','Pedro','San Jaime, 76', ,'Barcelona',8,0,'(  )-4009964');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (90,'ALCOLEA','GUIJARROCABELLO','Jose,Alcala, 14', ,'Madrid',28,0,'(  )-7013742');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (91,'LLORENS','SOLCHAGA BOLANO','Luis','Escuelas, 37', ,'Villareal',12,0,'(  )-2023050');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (92,'DETECSA','BOYER LARA','Jose Carlos','Ppe. de Vergara  , 59', ,'Madrid',28,0,'(  )-4006916');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (93,'TALLERES MARFAN','AMATO REVENGA','Antonio','Juan Mazo, 30', ,'Madrid',28,0,'(  )-7003692');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (94,'AMPER','MORCILLO MARCOS','Carlos','Bravo Murillo, 22', ,'Barcelona',8,0,'(  )-2020098');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (95,'DSE','PALOMO PELAEZ','Felipe','Gran Via, 35', ,'Villareal',12,0,'(  )-4003010');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (96,'DALDA','PALOMO GUIJARRO','Juan','Ppe. de Vergara  , 91', ,'Madrid',28,0,'(  )-7010704');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (97,'MATE','TORRECILLAS CASTEL','Maria Jesus','Narvaez, 42', ,'Madrid',28,0,'(  )-2031834');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (98,'CARLIPS','MORCILLO SALGADO','Jose Luis','Juan Mazo, 15', ,'Malaga',29,0,'(  )-4023468');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (99,'BECOR','VALDIVIESO REQUENA','Antonio','Bravo Murillo, 56', ,'Madrid',28,0,'(  )-7029478');
INSERT INTO PROVEEDORES (empresa, apellidos, nombre, direccion1, direccion2, poblacion, provincia, distrito, telefono)
VALUES (100,'SIRO','ESTEVEZ VALDIVIESO','Julian','Sancho Pacheco, 79', ,'Sevilla',41,0,'(  )-2030692');

INSERT INTO FORMAPAGOS (formapago,descripcion) VALUES ('C','Contado');
INSERT INTO FORMAPAGOS (formapago,descripcion) VALUES ('L1','30');
INSERT INTO FORMAPAGOS (formapago,descripcion) VALUES ('L2','30/60');
INSERT INTO FORMAPAGOS (formapago,descripcion) VALUES ('L3','30/60/90');
INSERT INTO FORMAPAGOS (formapago,descripcion) VALUES ('L4','30/60/90/120');
INSERT INTO FORMAPAGOS (formapago,descripcion) VALUES ('CR','Crédito');
INSERT INTO FORMAPAGOS (formapago,descripcion) VALUES ('AB','Abono banco');
INSERT INTO FORMAPAGOS (formapago,descripcion) VALUES ('CH','Cheque');
INSERT INTO FORMAPAGOS (formapago,descripcion) VALUES ('BZ','Bizum');

-- Inserciones en la tabla CLIENTES
INSERT INTO CLIENTES (cliente,apellidos,empresa,nombre,direccion1,direccion2,poblacion,provincia,distrito,telefono,forma_pago,total_factura)
VALUES ();

-- Inserciones en la tabla ALBARANES
INSERT INTO ALBARANES (albaran,cliente,fecha_albaran,fecha_envio,fecha_pago,forma_pago,facturado)
VALUES ();

-- Inserciones en la tabla LINEAS
INSERT INTO LINEAS (albaran,linea,articulo,proveedor,cantidad,descuento,precio)
VALUES ();

-- Inserciones en la tabla ARTICULOS
INSERT INTO ARTICULOS (articulo,proveedor,descripcion,pr_vent,pr_cost,existencias,sobre_maximo,bajo_minimo,fec_ult_ent,fec_ult_sal,unidad)
VALUES ();
