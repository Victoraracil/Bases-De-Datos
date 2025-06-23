-- BDEmpleadosFormacion

ALTER SESSION SET NLS_DATE_FORMAT='DD/MM/YYYY';

CREATE TABLE EMPLEADOS (
    dni NUMBER(8),
    nombre VARCHAR2(10) NOT NULL,
    apellido1 VARCHAR2(15) NOT NULL,
    apellido2 VARCHAR2(15),
    direcc1 VARCHAR2(25),
    direcc2 VARCHAR2(25),
    ciudad VARCHAR2(25),
    provincia VARCHAR2(20),
    cod_postal VARCHAR2(5),
    sexo VARCHAR2(1) CHECK (sexo IN ('H','M')),
    fecha_nac DATE,
    CONSTRAINT pk_EMPLEADOS PRIMARY KEY (dni)
);

CREATE TABLE DEPARTAMENTOS (
    dpto_cod NUMBER(5),
    nombre_dpto VARCHAR2(30) NOT NULL,
    dpto_padre NUMBER(5),
    presupuesto NUMBER NOT NULL,
    pres_actual NUMBER,
    CONSTRAINT pk_DEPARTAMENTOS PRIMARY KEY (dpto_cod),
    CONSTRAINT uk_DEPARTAMENTOS UNIQUE (nombre_dpto)
);

CREATE TABLE UNIVERSIDADES (
    univ_cod NUMBER(5),
    nombre_univ VARCHAR2(40) NOT NULL,
    ciudad VARCHAR2(20),
    municipio VARCHAR2(2),
    cod_postal VARCHAR2(5),
    CONSTRAINT pk_univ_cod PRIMARY KEY (univ_cod)
);

CREATE TABLE ESTUDIOS (
    empleado_dni NUMBER(8),
    universidad NUMBER(5),
    anyo NUMBER,
    grado VARCHAR2(3),
    especialidad VARCHAR2(20),
    CONSTRAINT pk_ESTUDIOS PRIMARY KEY (empleado_dni, universidad),
    CONSTRAINT fk_ESTUDIOS_EMPLEADOS FOREIGN KEY (empleado_dni) REFERENCES EMPLEADOS (dni),
    CONSTRAINT fk_ESTUDIOS_UNIVERSIDADES FOREIGN KEY (universidad) REFERENCES UNIVERSIDADES (univ_cod)
);

CREATE TABLE TRABAJOS (
    trabajo_cod NUMBER(5),
    nombre_trab VARCHAR2(20) NOT NULL,
    salario_min NUMBER(2) NOT NULL,
    salario_MAX NUMBER(2) NOT NULL,
    CONSTRAINT pk_TRABAJOS PRIMARY KEY (trabajo_cod),
    CONSTRAINT uk_TRABAJOS UNIQUE (nombre_trab)
);

CREATE TABLE HISTORIAL_LABORAL (
    empleado_dni NUMBER(8),
    trabajo_cod NUMBER(5),
    fecha_inicio DATE,
    fecha_fin DATE,
    dpto_cod NUMBER(5),
    supervisor_dni NUMBER(8),
    CONSTRAINT pk_hist_lab PRIMARY KEY (empleado_dni,fecha_inicio),
    CONSTRAINT fk_HISTORIAL_LABORAL_EMPLEADOS FOREIGN KEY (empleado_dni) REFERENCES EMPLEADOS (dni),
    CONSTRAINT fk_HISTORIAL_LABORAL_DEPARTAMENTOS FOREIGN KEY (dpto_cod) REFERENCES DEPARTAMENTOS (dpto_cod),
    CONSTRAINT fk_HISTORIAL_LABORAL_TRABAJOS FOREIGN KEY (trabajo_cod) REFERENCES TRABAJOS (trabajo_cod),
    CONSTRAINT chk_fechaLaboral_validas CHECK (fecha_inicio <= fecha_fin)
);

CREATE TABLE HISTORIAL_SALARIAL (
    empleado_dni NUMBER(8),
    salario NUMBER NOT NULL,
    fecha_comienzo DATE,
    fecha_fin DATE,
    CONSTRAINT pk_HISTORIAL_SALARIAL PRIMARY KEY (empleado_dni, fecha_comienzo),
    CONSTRAINT fk_HISTORIAL_SALARIAL_EMPLEADOS FOREIGN KEY (empleado_dni) REFERENCES EMPLEADOS (dni),
    CONSTRAINT chk_fechaSalario_validas CHECK (fecha_comienzo <= fecha_fin)
);

-- DELETE FROM EMPLEADOS;
-- DELETE FROM DEPARTAMENTOS;
-- DELETE FROM UNIVERSIDADES;
-- DELETE FROM ESTUDIOS;

-- SELECT * FROM EMPLEADOS;
-- SELECT * FROM DEPARTAMENTOS;
-- SELECT * FROM UNIVERSIDADES;
-- SELECT * FROM ESTUDIOS;

INSERT INTO EMPLEADOS (dni, nombre, apellido1, apellido2, direcc1, direcc2, ciudad, provincia, cod_postal, sexo, fecha_nac)
VALUES ('48521025','Saul','Martin','Voisin','Calle la Libertad','bloque 21','San Vicente del Raspeig','Alicante','03690','H','02-10-1997');
INSERT INTO EMPLEADOS
VALUES ('48231456','Laura','Gomez','Fernandez','Calle del Sol','Apto. 3B','Madrid','Madrid','28001','M','15-03-1992');
INSERT INTO EMPLEADOS
VALUES ('48321567','Carlos','Lopez','Perez','Avenida de la Paz','Bloque 2, 5ºA','Barcelona','Barcelona','08002','H','22-07-1988');
INSERT INTO EMPLEADOS
VALUES ('49011234','Ana','Sanchez','Rodriguez','Calle del Mar','Piso 1','Valencia','Valencia','46001','M','10-01-1995');
INSERT INTO EMPLEADOS
VALUES ('49122345','Luis','Torres','Garcia','Calle Mayor','Piso 2','Sevilla','Sevilla','41001','H','18-11-1985');
INSERT INTO EMPLEADOS
VALUES ('49233456','Maria','Martinez','Alvarez','Calle Nueva','2ª planta','Zaragoza','Zaragoza','50001','M','05-06-1990');
INSERT INTO EMPLEADOS
VALUES ('49344567','Jose','Perez','Jimenez','Calle del Rio','Piso 3B','Bilbao','Vizcaya','48001','H','28-09-1982');
INSERT INTO EMPLEADOS
VALUES ('49455678','Elena','Garcia','Lopez','Avenida de la Libertad','Piso 2','Murcia','Murcia','30001','M','20-12-1989');
INSERT INTO EMPLEADOS
VALUES ('49566789','Francisco','Diaz','Hernandez','Calle Gran Via','Apartamento 1A','Alicante','Alicante','03001','H','07-04-1993');
INSERT INTO EMPLEADOS
VALUES ('49677890','Raquel','Serrano','Moreno','Calle San Juan','Piso 1','Vigo','Pontevedra','36201','M','14-08-1991');
INSERT INTO EMPLEADOS (DNI, NOMBRE, APELLIDO1, APELLIDO2, DIRECC1, CIUDAD, PROVINCIA, COD_POSTAL, SEXO, FECHA_NAC)
VALUES ('11111111','Juan', 'Pérez', 'Gómez', 'Calle 1', 'Madrid', 'Madrid', '28001', 'H', '01-01-1980');

INSERT INTO DEPARTAMENTOS (dpto_cod, nombre_dpto, dpto_padre, presupuesto, pres_actual)
VALUES ('10001', 'Recursos Humanos', NULL, '500000', '350000');
INSERT INTO DEPARTAMENTOS
VALUES ('10002', 'Tecnología', NULL, '800000', '650000');
INSERT INTO DEPARTAMENTOS
VALUES ('10003', 'Marketing', NULL, '600000', '550000');
INSERT INTO DEPARTAMENTOS
VALUES ('10004', 'Ventas', NULL, '700000', '600000');
INSERT INTO DEPARTAMENTOS
VALUES ('10005', 'Finanzas', NULL, '900000', '750000');
INSERT INTO DEPARTAMENTOS
VALUES ('10006', 'Atención al Cliente', NULL, '400000', '300000');
INSERT INTO DEPARTAMENTOS
VALUES ('10007', 'Investigación y Desarrollo', NULL, '1000000', '800000');
INSERT INTO DEPARTAMENTOS
VALUES ('10008', 'Logística', NULL, '500000', '450000');
INSERT INTO DEPARTAMENTOS
VALUES ('10009', 'Jurídico', NULL, '300000', '250000');
INSERT INTO DEPARTAMENTOS
VALUES ('10010', 'Compras', NULL, '350000', '300000');

INSERT INTO UNIVERSIDADES (univ_cod, nombre_univ, ciudad, municipio, cod_postal)
VALUES ('1001', 'Universidad de Alicante', 'Alicante', 'A', '03080');
INSERT INTO UNIVERSIDADES
VALUES ('1002', 'Universidad Politécnica de Madrid', 'Madrid', 'M', '28040');
INSERT INTO UNIVERSIDADES
VALUES ('1003', 'Universidad de Barcelona', 'Barcelona', 'B', '08028');
INSERT INTO UNIVERSIDADES
VALUES ('1004', 'Universidad de Valencia', 'Valencia', 'V', '46010');
INSERT INTO UNIVERSIDADES
VALUES ('1005', 'Universidad de Sevilla', 'Sevilla', 'S', '41010');
INSERT INTO UNIVERSIDADES
VALUES ('1006', 'Universidad de Zaragoza', 'Zaragoza', 'Z', '50010');
INSERT INTO UNIVERSIDADES
VALUES ('1007', 'Universidad de Bilbao', 'Bilbao', 'B', '48010');
INSERT INTO UNIVERSIDADES
VALUES ('1008', 'Universidad de Murcia', 'Murcia', 'M', '30010');
INSERT INTO UNIVERSIDADES
VALUES ('1009', 'Universidad de Vigo', 'Vigo', 'V', '36210');
INSERT INTO UNIVERSIDADES
VALUES ('1010', 'Universidad Autónoma de Madrid', 'Madrid', 'M', '28049');

INSERT INTO ESTUDIOS (empleado_dni, universidad, anyo, grado, especialidad) 
VALUES ('48521025', '1001', '2015', 'BA', 'Informática');
INSERT INTO ESTUDIOS
VALUES ('48231456', '1002', '2010', 'MA', 'Ingeniería Civil');
INSERT INTO ESTUDIOS
VALUES ('48321567', '1003', '2008', 'PhD', 'Matemáticas');
INSERT INTO ESTUDIOS
VALUES ('49011234', '1004', '2017', 'BA', 'Arquitectura');
INSERT INTO ESTUDIOS
VALUES ('49122345', '1005', '2005', 'MA', 'Economía');
INSERT INTO ESTUDIOS
VALUES ('49233456', '1006', '2011', 'PhD', 'Física Aplicada');
INSERT INTO ESTUDIOS
VALUES ('49344567', '1007', '2009', 'BA', 'Derecho');
INSERT INTO ESTUDIOS
VALUES ('49455678', '1008', '2014', 'MA', 'Medicina');
INSERT INTO ESTUDIOS
VALUES ('49566789', '1009', '2012', 'PhD', 'Biología Molecular');
INSERT INTO ESTUDIOS
VALUES ('49677890', '1010', '2018', 'BA', 'Psicología');

INSERT INTO TRABAJOS (trabajo_cod, nombre_trab, salario_min, salario_max) 
VALUES ('20001', 'Analista', '20', '35');
INSERT INTO TRABAJOS (trabajo_cod, nombre_trab, salario_min, salario_max) 
VALUES ('20002', 'Desarrollador', '25', '40');
INSERT INTO TRABAJOS (trabajo_cod, nombre_trab, salario_min, salario_max) 
VALUES ('20003', 'Arquitecto TI', '30', '50');
INSERT INTO TRABAJOS (trabajo_cod, nombre_trab, salario_min, salario_max) 
VALUES ('20004', 'Consultor', '18', '33');
INSERT INTO TRABAJOS (trabajo_cod, nombre_trab, salario_min, salario_max) 
VALUES ('20005', 'Gerente', '35', '60');
INSERT INTO TRABAJOS (trabajo_cod, nombre_trab, salario_min, salario_max) 
VALUES ('20006', 'Soporte Técnico', '15', '25');
INSERT INTO TRABAJOS (trabajo_cod, nombre_trab, salario_min, salario_max) 
VALUES ('20007', 'Administrativo', '18', '28');
INSERT INTO TRABAJOS (trabajo_cod, nombre_trab, salario_min, salario_max) 
VALUES ('20008', 'Investigador', '22', '37');
INSERT INTO TRABAJOS (trabajo_cod, nombre_trab, salario_min, salario_max) 
VALUES ('20009', 'Analista Financiero', '28', '45');
INSERT INTO TRABAJOS (trabajo_cod, nombre_trab, salario_min, salario_max) 
VALUES ('20010', 'Marketing Manager', '32', '55');

INSERT INTO HISTORIAL_LABORAL (empleado_dni, trabajo_cod, fecha_inicio, fecha_fin, dpto_cod, supervisor_dni) 
VALUES ('48521025', '20001', TO_DATE('2020-01-15', 'YYYY-MM-DD'), TO_DATE('2023-05-20', 'YYYY-MM-DD'), '10001', '49122345');
INSERT INTO HISTORIAL_LABORAL (empleado_dni, trabajo_cod, fecha_inicio, fecha_fin, dpto_cod, supervisor_dni) 
VALUES ('48231456', '20002', TO_DATE('2019-03-01', 'YYYY-MM-DD'), TO_DATE('2022-12-31', 'YYYY-MM-DD'), '10002', '49344567');
INSERT INTO HISTORIAL_LABORAL (empleado_dni, trabajo_cod, fecha_inicio, fecha_fin, dpto_cod, supervisor_dni) 
VALUES ('48321567', '20003', TO_DATE('2017-06-01', 'YYYY-MM-DD'), TO_DATE('2021-10-15', 'YYYY-MM-DD'), '10003', '49011234');
INSERT INTO HISTORIAL_LABORAL (empleado_dni, trabajo_cod, fecha_inicio, fecha_fin, dpto_cod, supervisor_dni) 
VALUES ('49011234', '20004', TO_DATE('2021-01-01', 'YYYY-MM-DD'), TO_DATE('2024-01-01', 'YYYY-MM-DD'), '10004', '49233456');
INSERT INTO HISTORIAL_LABORAL (empleado_dni, trabajo_cod, fecha_inicio, fecha_fin, dpto_cod, supervisor_dni) 
VALUES ('49122345', '20005', TO_DATE('2018-09-15', 'YYYY-MM-DD'), TO_DATE('2023-07-01', 'YYYY-MM-DD'), '10005', '49455678');
INSERT INTO HISTORIAL_LABORAL (empleado_dni, trabajo_cod, fecha_inicio, fecha_fin, dpto_cod, supervisor_dni) 
VALUES ('49233456', '20006', TO_DATE('2015-04-20', 'YYYY-MM-DD'), TO_DATE('2020-12-31', 'YYYY-MM-DD'), '10006', '49566789');
INSERT INTO HISTORIAL_LABORAL (empleado_dni, trabajo_cod, fecha_inicio, fecha_fin, dpto_cod, supervisor_dni) 
VALUES ('49344567', '20007', TO_DATE('2019-11-01', 'YYYY-MM-DD'), TO_DATE('2022-11-30', 'YYYY-MM-DD'), '10007', '49677890');
INSERT INTO HISTORIAL_LABORAL (empleado_dni, trabajo_cod, fecha_inicio, fecha_fin, dpto_cod, supervisor_dni) 
VALUES ('49455678', '20008', TO_DATE('2020-02-15', 'YYYY-MM-DD'), TO_DATE('2023-02-15', 'YYYY-MM-DD'), '10008', '48521025');
INSERT INTO HISTORIAL_LABORAL (empleado_dni, trabajo_cod, fecha_inicio, fecha_fin, dpto_cod, supervisor_dni) 
VALUES ('49566789', '20009', TO_DATE('2016-07-01', 'YYYY-MM-DD'), TO_DATE('2019-07-01', 'YYYY-MM-DD'), '10009', '48231456');
INSERT INTO HISTORIAL_LABORAL (empleado_dni, trabajo_cod, fecha_inicio, fecha_fin, dpto_cod, supervisor_dni) 
VALUES ('49677890', '20010', TO_DATE('2018-03-20', 'YYYY-MM-DD'), TO_DATE('2021-03-20', 'YYYY-MM-DD'), '10010', '48321567');

-- 5. Añada una restricción que obligue a que las personas que hayan introducido la 
-- CIUDAD tengan que tener el campo COD_POSTAL a NOT NULL. ¿Qué ocurre con las 
-- filas ya introducidas?

-- 6. Añada un nuevo atributo VALORACIÓN en la tabla de EMPLEADOS que indique de 1 a 10
-- la valoración que obtuvo el empleado en su entrevista de trabajo al iniciar su 
-- andadura en la empresa. Ponga el valor por defecto 5 para ese campo.

-- 7. Elimine la restricción de que el atributo NOMBRE de la tabla EMPLEADOS
-- no puede ser nulo.

-- 8. Modificar el tipo de datos de DIREC1 de la tabla EMPLEADOS a cadena 
-- de caracteres de 40 como máximo.

-- 9. ¿Podría modificar el tipo de datos del atributo FECHA_NAC de la tabla
-- EMPLEADOS Y convertirla a tipo cadena?

-- 10. Cambiar la clave primaria de EMPLEADOS al NOMBRE y los dos
-- APELLIDOS.

-- 11. Crear una nueva tabla llamada INFORMACIÓN UNIVERSITARIA que tenga el 
-- NOMBRE y los dos APELLIDOS (en un solo atributo) de todos los EMPLEADOS 
-- junto con la UNIVERSIDAD donde estudiaron. Cárguela con los datos correspondientes.
