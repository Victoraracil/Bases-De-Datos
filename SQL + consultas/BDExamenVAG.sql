---- 1. Crea las siguientes tablas

CREATE TABLE ACTOR (
	dni CHAR(9), 
	nombre VARCHAR2(20) NOT NULL,
	edad NUMBER(3),
	CONSTRAINT pk_ACTOR PRIMARY KEY (dni)
);
	
CREATE TABLE MIEMBRO_JURADO (
	dni CHAR(9),
	nombre VARCHAR2(20),
	especialidad VARCHAR2(30),
	CONSTRAINT pk_MIEMBROJURADO PRIMARY KEY (dni)
);
	
CREATE TABLE PAPEL (
	cod_pap NUMBER(3),
	descripcion VARCHAR2(50) NOT NULL,
	CONSTRAINT pk_PAPEL PRIMARY KEY (cod_pap)
);
	
CREATE TABLE ACTUACION (
	cod_pap NUMBER(3),
	dni_act CHAR(9),
	fecha DATE NOT NULL,
	CONSTRAINT pk_ACTUACION PRIMARY KEY (cod_pap, dni_act),
	CONSTRAINT fk_ACTUACION_PAPEL FOREIGN KEY (cod_pap) REFERENCES PAPEL, 
	CONSTRAINT fk_ACTUACION_ACTOR FOREIGN KEY (dni_act) REFERENCES ACTOR
);
	
CREATE TABLE FICHA_PUNTUACION (
	cod_ficha NUMBER(3),
	nota NUMBER(2),
	cod_papel NUMBER(3),
	dni_act CHAR(9),
	dni_jur CHAR(9) NOT NULL,
	CONSTRAINT pk_PUNTUACION PRIMARY KEY (cod_ficha),
	CONSTRAINT fk_PUNTUACION_JURADO FOREIGN KEY (dni_jur) REFERENCES MIEMBRO_JURADO,
	CONSTRAINT fk_PUNTUACION_ACTUACION FOREIGN KEY (cod_papel, dni_act) REFERENCES ACTUACION
);

-- 2. En la creación de las tablas nos hemos olvidado algunas consideraciones
-- Realiza las modificaciones que se puedan:
-- a. El nombre del miembro del jurado no puede ser nulo
ALTER TABLE MIEMBRO_JURADO
  MODIFY nombre NOT NULL;
  
---- b. Añade el campo localidad a la tabla Actor siendo su valor predeterminado el de Alicante
ALTER TABLE ACTOR
  ADD COLUMN LOCALIDAD WITH VALUE 'Alicante'

---- c. La edad del actor debe estar comprendida entre 18 y 70 años
ALTER TABLE ACTOR 
 ADD CONSTRAINT chk_edad CHECK (edad between 18 and 70);
 
-- d. La única especialidad posible, si se conoce, de los miembros del jurado es la de Crítico, Director, Director o dejarlo en blanco
ALTER TABLE MIEMBRO_JURADO
  ADD CONSTRAINT chk_especialidad CHECK (especialidad in ('Crítico', 'Director', 'Aficionado', ''))

-- e. Modifica la base de datos para renombrar la tabla MIEMBRO_JURADO a JURADO, ya que el nuevo nombre es más claro y refleja mejor el propósito de la tabla.
-- Vuelve a dejar el nombre como estaba
ALTER TABLE MIEMBRO_JURADO
  RENAME TO JURADO;

-- f. Modifica la tabla MIEMBRO_JURADO para que la columna especialidad pueda aceptar valores nulos.
ALTER TABLE JURADO
  MODIFY especialidad NULL;

-- g. El campo cod_pap de la tabla PAPEL debe ser autoincrementable
ALTER TABLE PAPEL
  MODIFY cod_pap NUMBER(3) GENERATED ALWAYS AS IDENTITY;

-- h. Todas las claves ajenas de las tablas deben permitir borrados en cascada
ALTER TABLE ACTUACION
  ADD CONSTRAINT fk_ACTUACION_PAPEL FOREIGN KEY (cod_pap) REFERENCES PAPEL ON DELETE CASCADE;

-- i. Si quisiéramos indicar que un actor sólo puede realizar una actuación, ¿que
-- restricción debemos añadir, eliminar o modificar? (pon el comando y explícalo)
ALTER TABLE ACTUACION
  ADD CONSTRAINT fk_ACTUACION_ACTOR FOREIGN KEY (dni_act) REFERENCES ACTOR ON DELETE CASCADE;



-- 3. Realiza las siguientes inserciones y, en el caso de que alguna de ellas no se
-- pueda realizar, comenta el motivo por el cual no se ha podido llevar a cabo la
-- inserción y alguna posible solución
INSERT INTO ACTOR(dni,nombre,edad) VALUES ('45678123A','Manolo',38);
INSERT INTO ACTOR(dni,nombre,edad) VALUES ('67891234B','Beatrice',21);
INSERT INTO ACTOR(dni,nombre,edad) VALUES ('12345678C','Juan',32);
INSERT INTO ACTOR(dni,nombre,edad) VALUES ('98765432D','Olga',69);
INSERT INTO ACTOR(dni,nombre,edad) VALUES ('32165498E','Pepito',27);
	
INSERT INTO MIEMBRO_JURADO VALUES ('22233344A','Elisa','critico');
INSERT INTO MIEMBRO_JURADO VALUES ('33344455B','Pablo','director');
INSERT INTO MIEMBRO_JURADO VALUES ('44455566C','Pilar','');
INSERT INTO MIEMBRO_JURADO VALUES ('55566677D','Armando','aficionado');
INSERT INTO MIEMBRO_JURADO VALUES ('66677788E','Maria','critico');
	
INSERT INTO PAPEL (cod_pap,descripcion) VALUES (1,'chica');
INSERT INTO PAPEL VALUES (2,'chico');
INSERT INTO PAPEL VALUES (3,'malo');
INSERT INTO PAPEL VALUES (4,'amiga');
INSERT INTO PAPEL VALUES (5,'policia');
INSERT INTO PAPEL VALUES (6,'');
--La tabla no permite que la descripcion sea nula
--Posible solucion (añadir una descripcion):
INSERT INTO PAPEL VALUES (6,'camarero');
INSERT INTO PAPEL VALUES (7,'cocinero');

INSERT INTO ACTUACION (cod_pap,dni_act,fecha) VALUES (1,'45678123A','03/01/17');
INSERT INTO ACTUACION VALUES (5,'12345678C','');
--La tabla no admite que la fecha sea nula
--Posible solucion(añadir una fecha):
INSERT INTO ACTUACION VALUES (5,'12345678C','05/06/16');
INSERT INTO ACTUACION VALUES (1,'67891234B','04/02/17');
--INSERT INTO ACTUACION VALUES (6,'22233344A','08/01/25');
INSERT INTO ACTUACION VALUES (2,'12345678C','18/02/24');
--INSERT INTO ACTUACION VALUES (1,'45678123A','24/02/24');
INSERT INTO ACTUACION VALUES (4,'45678123A','09/01/24');
	
INSERT INTO FICHA_PUNTUACION VALUES(1,3,1,'67891234B','22233344A');
INSERT INTO FICHA_PUNTUACION VALUES(2,5,4,'45678123A','33344455B');
INSERT INTO FICHA_PUNTUACION VALUES(3,7,null,'45678123A','33344455B');
INSERT INTO FICHA_PUNTUACION VALUES(4,6,2,'12345678C','44455566C');
INSERT INTO FICHA_PUNTUACION VALUES(5,8,1,'67891234B','22233344A');
INSERT INTO FICHA_PUNTUACION VALUES(6,6,null,'67891234B','44455566C');
INSERT INTO FICHA_PUNTUACION VALUES(7,5,null,'','33344455B');
INSERT INTO FICHA_PUNTUACION VALUES(8,9,6,'12345679C','22233344A');

-- Seguidamente realiza el mismo proceso anterior, para las siguientes inserciones:
-- a. Insert into FICHA_PUNTUACION (cod_ficha,nota,dni_act) VALUES (8,5,'12345678C')
-- b. Insert into FICHA_PUNTUACIÓN VALUES (8,3,2,'12345678C','22233344A')
-- c. Insert into FICHA_PUNTUACION VALUES (8,6,1,null,'44455566C')
-- d. Inserta un nuevo actor en la tabla ACTOR con los siguientes datos:
	-- DNI = '23456789B', nombre = 'Pedro Ruiz', edad = 30.
-- e. Inserta un nuevo miembro del jurado con nombre 'María López' y especialidad 'Cine'.
-- f. Inserta un nuevo jurado en la tabla MIEMBRO_JURADO con los siguientes datos: 
	-- DNI = '34567890C', nombre = 'María López', especialidad = 'Actuación'.
-- g. Inserta un nuevo papel Programador.
-- h. Registra una actuación en la que el actor '45678123A' interpreta el papel '8' el 1 de marzo de 2025.
-- i. Inserta una actuación para un actor en un papel en una fecha específica (supón que el código de papel es 1, el DNI del actor es '23456789B', y la fecha es '24-02-2025')
-- j. Inserta una nueva puntuación en la que el jurado '55566677D' puntúa a '45678123A' en el papel '8' con nota 1.
-- k. Inserta una puntuación para una actuación específica dada por un jurado.
-- Supón que el código de ficha es 10, la nota es 8, el código de papel es 1, el DNI del actor es '23456789B' y el DNI del jurado es '34567890C'.
		
-- 4. Modificaciones
-- Realiza, si se puede, las siguientes actualizaciones sobre los datos de las tablas
-- a. El miembro del jurado Armando, de la guerra que ha dado, se ha decido
-- subirle de categoría y pasa a ser crítico.
-- b. Actualiza la edad del actor '23456789B' a 31 años.
-- c. Actualiza la especialidad del jurado '33344455B' a 'Teatro'.
-- d. Actualiza la edad de todos los actores cuyo nombre tenga cuatro letras para incrementar su edad en 2 años.
-- e. Actualiza la nota de un actor en la tabla FICHA_PUNTUACION para el papel con código cod_pap = 101. Establece la nueva nota a 10 para los actores que han obtenido una puntuación menor a 8. Utiliza una subconsulta para obtener el dni_jur del jurado correspondiente a la evaluación.
-- f. La especialidad del miembro del jurado con DNI '34567890C' ahora se especializa en 'Dirección'.



-- 5. Requerimientos (consultas):
-- (alguno de los requerimientos solicitados tienen más de 1 solución, se valorará hallar, al menos, dos de ellas)
-- a. Nombre de los actores que tengan papel de malo
	SELECT nombre
	FROM papel p, actor a
	WHERE UPPER(p.descripcion) = 'MALO'
	
-- b. Nombre del actor y descripción del papel que han llevado a cabo aquellos actores durante el mes de Enero del 2017
	SELECT

-- c. Obtener la edad media de los actores que han realizado actuaciones
-- d. Obtener la descripción de los papeles que han sido puntuados
-- e. Obtener el nombre de los actores que han sacado la nota máxima
-- f. Muestra el dni y nombre de los miembros del jurado, junto con la puntuación promedio que han dado, pero solo para los jurados que han puntuado más de 3 actuaciones. El resultado debe estar ordenado de mayor a menor por la puntuación promedio.
-- g. Escribe una consulta que muestre los actores que han recibido la mejor puntuación para cada papel (cod_pap). El resultado debe incluir el dni, nombre del actor y la descripcion del papel ordenado por dni.
-- h. Escribe una consulta que muestre los actores cuya edad es mayor que la edad promedio de todos los miembros del jurado. El resultado debe incluir el dni y nombre del actor, así como su edad.
-- i. Consulta para obtener los nombres y las edades de todos los actores.
-- j. Muestra los nombres de los jurados y sus especialidades.
-- k. Consulta el nombre de todos los actores y los roles que interpretan en las actuaciones.
-- l. Muestra el código del papel, la descripción del papel y la fecha de la actuación de todas las actuaciones del actor Manolo.
-- ll. Consulta los nombres de los actores junto con los jurados que los puntúan y las notas que recibieron.
-- m. Crea una consulta que combine el nombre y la edad de todos los actores en una sola columna con el formato: Nombre: [nombre], Edad: [edad].
-- n. Consulta todos los jurados que han puntuado a un actor específico, por ejemplo, con dni_act = '23456789B'.
-- o. Muestra el nombre del actor y la fecha de su primera actuación truncada al primer día del mes.
-- p. Escribe una consulta que muestre el jurado que ha dado la mayor cantidad de puntuaciones. El resultado debe incluir el dni y nombre del jurado, y la cantidad de puntuaciones que ha dado.
-- q. Escribe una consulta que muestre los actores que han interpretado más papeles distintos. El resultado debe incluir el dni, nombre del actor y la cantidad de papeles distintos que ha interpretado.
-- r. Consulta la puntuación que un jurado ha dado al actor Manolo en una actuación, mostrando el nombre del jurado, nombre del actor, código del papel, y la puntuación.
-- s. Consulta el actor que ha recibido la puntuación más alta.
-- t. Consulta la media de las puntuaciones recibidas por un actor en todos sus roles, por ejemplo, con dni_act = 'A001'.
-- u. Consulta los jurados que han puntuado más de 5 actuaciones.
-- v. Consulta los actores que han actuado en más de 3 roles diferentes y calcula el número total de actuaciones realizadas por cada uno.
-- w. Encuentra los actores que no han sido puntuados por ningún jurado.
-- x. Encuentra todos los jurados que han puntuado todos los actores de una obra (por ejemplo, todos los actores en el rol 'R004').
-- y. Obtener el jurado con la mayor puntuación media: Escribe una consulta que muestre el nombre del jurado que ha dado la mayor puntuación media a los actores en sus actuaciones.
-- z. Escribe una consulta que muestre los actores que han recibido la menor puntuación para cada uno de los papeles que han interpretado. El resultado debe incluir el dni y nombre del actor, así como la descripcion del papel (la salida irá ordenada de forma creciente por este) y la puntuación.
-- aa. Escribe una consulta que muestre los actores que han tenido más de una actuación. Muestra su nombre y el número de actuaciones que han tenido.
-- ab. Encuentra el actor que ha recibido la puntuación promedio más alta en todas sus actuaciones. Para hacerlo, utiliza subconsultas para calcular la media por actor.
-- ac. Encuentra el jurado que ha puntuado el mayor número de actores, junto con la cantidad de actores puntuados.
-- ad. Escribe una consulta que muestre todos los actores que no tienen puntuaciones registradas en la tabla FICHA_PUNTUACION, es decir, actores que no han sido puntuados por ningún miembro del jurado. El resultado debe incluir el dni y nombre del actor.
-- ae. Muestra todos los actores que han sido puntuados por todos los jurados (es decir, aquellos actores que tienen al menos una puntuación de cada jurado).
-- af. Muestra el promedio de las puntuaciones de cada papel, incluyendo el cod_pap y descripcion del papel, y la puntuación promedio, ordenado de mayor a menor.
-- ag. Escribe una consulta que muestre los actores que han tenido más de una actuación. El resultado debe incluir el dni y el nombre del actor.
-- ah. Crea una vista que muestre el dni y nombre de los actores, junto con el descripcion del papel, y la mejor puntuación que ha recibido ese actor en ese papel. La vista debe incluir solo el actor con la mejor puntuación por cada papel.
-- ai. Crea una vista que muestre el dni, nombre del actor, y la puntuación promedio que ha recibido en todas sus actuaciones. Esta vista debe calcular la puntuación promedio para cada actor.
-- aj. Crea una nueva tabla actoresParaJubilar con los atributos y datos de aquellos actores con edad superior a 65 años


-- 6. Borrados
-- Realiza, si se puede, los siguientes borrados sobre los datos de las tablas
-- a. Debido a la gran cantidad de dinero que el actor “Manolo” ha cobrado por su
-- actuación ha decidido dedicarse a la vida contemplativa por lo que ya no quiere
-- que contemos con sus servicios. ¡Elimínalo!. En caso de que no nos deje, indicar
-- cuál es el motivo y como podría solucionarse.


-- b. Elimina la puntuación que se ha dado al actor 12345678C al realizar la actuación del
-- papel de chico.

-- c. Elimina la actuación con código de papel 1 y actor con DNI '23456789B'.
-- d. Elimina una puntuación de la ficha con código '1'.
-- e. Elimina un actor con dni 23456789B. Ten en cuenta las restricciones de eliminación.
-- Comenta lo que sucede
-- f. Intenta eliminar un actor 23456789B que tiene actuaciones en la base de datos.
-- ¿Qué sucede?

-- g. Intenta eliminar al miembro del jurado 34567890C que tiene puntuaciones registradas en la base de datos. 
-- ¿Qué sucede?

-- h. Elimina todas las actuaciones de la tabla ACTUACION que tengan una fecha posterior al día actual. Asegúrate de que se respete la relación de claves foráneas.

-- i. Elimina la tabla actoresParaJubilar
