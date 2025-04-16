--Estructura basica:

DECLARE (opcional)
variables, cursors, excepcions definides per l usuari
BEGIN (obligatori)
sentències SQL
sentències de control PL / SQL
EXCEPTION (opcional)
accions a realitzar quan es produeixen errors
END; (obligatori)

--Ejemplo minimo
-- Exemple 06.02.01a
BEGIN
dbms_output.put_line('Hola');
END;

--Ejemplo sencillo para obtener informacion de la base de datos
-- Exemple 06.02.01b
DECLARE
espaiMax NUMBER(9,3);
BEGIN
SELECT MAX(espaiOcupatMb)
INTO espaiMax
FROM jocs;
dbms_output.put_line(espaiMax);
END;

--Ejemplo mas ampliado
CREATE TABLE plataformes(
codi CHAR(4),
nom VARCHAR2(30),
CONSTRAINT pk_plataformes PRIMARY KEY (codi)
);
CREATE TABLE jocs(
codi CHAR(5),
nom VARCHAR2(50),
descripcio VARCHAR2(1000),
anyLlancament NUMBER(4),
espaiOcupatMb NUMBER(9,3),
codiPlataforma CHAR(4),
CONSTRAINT pk_jocs PRIMARY KEY (codi),
CONSTRAINT fk_jocs_plataformes
FOREIGN KEY (codiPlataforma) REFERENCES plataformes(codi)
);

INSERT INTO plataformes VALUES('cpc', 'Amstrad CPC');
INSERT INTO plataformes VALUES('pcw', 'Amstrad PCW');
INSERT INTO plataformes VALUES('msx', 'MSX');
INSERT INTO plataformes VALUES('spec', 'Sinclair ZX Spectrum');
INSERT INTO plataformes VALUES('psx', 'Playstation');
INSERT INTO plataformes VALUES('ps2', 'Playstation 2');
INSERT INTO plataformes VALUES('ps3', 'Playstation 3');
INSERT INTO plataformes VALUES('ps4', 'Playstation 4');
INSERT INTO plataformes VALUES('ps5', 'Playstation 5');
INSERT INTO plataformes VALUES('wii', 'Nintendo WII');
INSERT INTO plataformes VALUES('stea', 'PC + Steam');
INSERT INTO plataformes VALUES('epic', 'PC + Epic');
INSERT INTO jocs VALUES('efre', 'Electro Freddy', NULL, 1982, 0.2, 'cpc');
INSERT INTO jocs VALUES('mmic', 'Manic Miner', 'Plataformas sin scroll', 1983, 0.2, 'cpc');
INSERT INTO jocs VALUES('mmiz', 'Manic Miner', 'Plataformas sin scroll', 1983, 0.2, 'spec');
INSERT INTO jocs VALUES('aa', 'Ant Attack', NULL, 1983, 0.1, 'spec');
INSERT INTO jocs VALUES('ikaw', 'Ikari Warriors', 'Disparos, vista cenital', 1986, 0.2, 'msx');
INSERT INTO jocs VALUES('wsr', 'Wii Sports Resort', NULL, 2009, 0, 'wii');
INSERT INTO jocs VALUES('gt5', 'Gran Turismo 5', NULL, 2010, 0, 'ps3');
INSERT INTO jocs VALUES('last1', 'The last of US', NULL, 2013, NULL, 'ps3');
INSERT INTO jocs VALUES('fortn', 'Fortnite', 'FPS + Battle Royale', 2017, NULL, 'epic');
INSERT INTO jocs VALUES('aliso', 'Alien: Isolation', NULL, 2017, 35000, 'epic');
INSERT INTO jocs VALUES('cont', 'Control', 'Aventura', 2019, NULL, 'epic');
INSERT INTO jocs VALUES('batao', 'Batman: A.O.', NULL, 2013, 18250, 'stea');

--Declaracion de variables

data DATE;
numDepartament NUMBER(2) NOT NULL := 10;
localitat VARCHAR2(13) := 'ATLANTA';
comisio CONSTANT NUMBER := 1400;

/*En aqueixa especificació de sintaxi:
     Identificador: es el nom de la variable.
     CONSTANT: restringeix la variable amb el propòsit que el seu valor no puga canviar; les
    constants han de ser inicialitzades (s'ha d'indicar forçosament el seu valor).
     Data type: pot ser un escalar, compost, referenciat o LOB.
     NOT NULL: restringeix la variable perquè siga obligatori que tinga un valor.
     := és l'operador d'assignació, que s'empra per a donar valor a una variable.
     Expr: és qualsevol expressió PL/SQL que pot ser una expressió literal, una altra variable o una
    expressió que involucra operadors i funcions .
Identificadors
     Poden contindre fins a 30 caràcters.
     Han de començar amb un caràcter alfabètic.
     Poden contindre números, signes de dòlar i subratllats.
     No poden contindre caràcters com a guions, barres de divisió, i espais.
     No han de tenir el mateix nom d'una columna de la taula de la base de dades.
     No poden ser paraules reservades (per exemple, una variable no es podrà dir "if").
De manera que podríem declarar una variable de text i obtindre el nom d'un dels jocs de la nostra base
de dades a partir del seu codi així:*/

--Exemple 06.02.03a
DECLARE
resultat VARCHAR2(50);
BEGIN
SELECT nom
INTO resultat
FROM jocs
WHERE codi='mmiz';
dbms_output.put_line(resultat);
END;

/*Exercici proposat 06.02.03a:
Basant-te en el segon exemple, crea un fragment de codi que obtinga el nom del joc que més ocupa de
la nostra base de dades, el guarde en una variable "nomMesGran" i després ho mostre en la finestra
d'eixida.*/

DECLARE
    nomMesGran VARCHAR2(50);
BEGIN
    SELECT MAX(nom)
    INTO nomMesGran
    FROM jocs
    WHERE codi='mmiz';
    dbms_output.put_line(nomMesGran);
END;

--Tipos de datos:
/*Alfanumèrics:
    VARCHAR2(n).
    Quan es declara una dada d'aquest tipus, aquest pot contenir caràcters (codificats segons el joc
    de caràcters de la sessió) fins a una longitud total de n posicions. La longitud màxima per a les
    columnes d'aquest tipus de dades és de 4000 posicions. És obligatori especificar la longitud
    d'una columna Varchar2.

Numèrics:
    NUMBER(p, s)
    On p indica el nombre total de dígits (fins a 38), s indica l'escala, o nombre de dígits a la dreta
    del punt decimal (fins a 127).
    Si a l'emmagatzemar un valor en una columna de tipus number s'excedeix la precisió (nombre
    de dígits), Oracle dóna un error, si s'excedeix l'escala (més decimals dels que suporta) Oracle
    arrodoneix el valor a la capacitat de la columna.

Data:
    DATE
    Una columna de tipus date emmagatzema informació sobre data i hora. Per a cada dada de
    tipus date, Oracle emmagatzema informació sobre segle, any, mes, dia, hora, minut i segon.
    
Altres tipus:
    LOB: Els tipus de dades LOB (Large OBject), s'usen per emmagatzemar dades de grans
    dimensions, com fitxers (BFILE), text (CLOB), vídeo o imatges (BLOB).

    ROWID : És una peudocolumna que identifica de manera única a cada fila de cada taula, és una
    columna invisible que tota taula d'Oracle té, la crea automàticament Oracle i només es pot
    consultar, no apareix en els SELECT ni es pot modificar en els UPDATE, ni en els INSERT.

    Boolean
    El tipus booleà, només admet els valors TRUE, FALSE o NULL.*/

-- Exemple 06.02.03b
DECLARE
    identificador ROWID;
    nomJoc VARCHAR2(50);
BEGIN
    SELECT ROWID
    INTO identificador
    FROM jocs
    WHERE codi='mmiz';
    dbms_output.put_line(identificador);
    SELECT nom
    INTO nomJoc
    FROM jocs
    WHERE ROWID = identificador;
    dbms_output.put_line(nomJoc);
END;    

-- Exemple 06.02.03c
DECLARE
acabat BOOLEAN := TRUE;
BEGIN
IF acabat THEN
dbms_output.put_line('Procés acabat');
ELSE
dbms_output.put_line('Procés no acabat');
END IF;
END;

--Atributos %TYPE y %ROWTYPE









































-- Exemple 06.05.01a
-- Contacte amb PROCEDURE
CREATE OR REPLACE PROCEDURE EscriureDestacat(cadena IN VARCHAR2) IS
BEGIN
DBMS_OUTPUT.PUT_LINE('--- ' || cadena || ' ---');
END EscriureDestacat;
--I aqueix procediment es podria invocar d'un script com el següent:
DECLARE
missatge VARCHAR2(30) := 'Hola';
BEGIN
EscriureDestacat(missatge);
END;

/*Crea un procedimiento "EscribirGuiones", que escriba varios guiones en la salida de la base de datos, 
tantos como se indican en un parámetro numérico (de entrada).*/

CREATE OR REPLACE PROCEDURE EscribirGuiones(num_guiones IN NUMBER) IS
BEGIN
    FOR i IN 1..num_guiones LOOP
        DBMS_OUTPUT.PUT('-');
    END LOOP;
    DBMS_OUTPUT.NEW_LINE; 
END EscribirGuiones;
/

/*Crea un procedimiento "InsertarPlataforma", que afianza una nueva plataforma en la base de datos de 
juegos y plataformas. Su código y su nombre se indicarán como parámetros (de entrada).*/

CREATE OR REPLACE PROCEDURE InsertarPlataforma(
    codigo_plataforma IN VARCHAR2,
    nombre_plataforma IN VARCHAR2
) IS
BEGIN
    INSERT INTO plataformas (codigo, nombre)
    VALUES (codigo_plataforma, nombre_plataforma);
    
    DBMS_OUTPUT.PUT_LINE('Plataforma insertada correctamente: ' || nombre_plataforma);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al insertar la plataforma: ' || SQLERRM);
END InsertarPlataforma;
/

/*Crea un procedimiento "InsertarJuego", que afianza un nuevo juego en la base de datos. 
Recibirá como parámetros el código del juego, el nombre del juego y el código de la plataforma. 
Si la plataforma no existe, se limitará a escribir el aviso de "No existe esa plataforma", 
y si existe, guardará el juego y avisará "Juego guardado". correctamente".*/

CREATE OR REPLACE PROCEDURE InsertarJuego(
    codigo_juego IN VARCHAR2,
    nombre_juego IN VARCHAR2,
    codigo_plataforma IN VARCHAR2
) IS
    plataforma_count NUMBER;
BEGIN

    SELECT COUNT(*)
    INTO plataforma_count
    FROM plataformas
    WHERE codigo = codigo_plataforma;

    IF plataforma_count = 0 THEN

        DBMS_OUTPUT.PUT_LINE('No existe esa plataforma');
    ELSE

        INSERT INTO juegos (codigo, nombre, codigo_plataforma)
        VALUES (codigo_juego, nombre_juego, codigo_plataforma);

        DBMS_OUTPUT.PUT_LINE('Juego guardado correctamente: ' || nombre_juego);
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al insertar el juego: ' || SQLERRM);
END InsertarJuego;
/

/*Crea un procedimiento llamado "MostrarJocIncomplet", que muestre el nombre de un juego del 
que no sabem cuánto espacio ocupa, junto con el nombre de la plataforma correspondiente. 
Como todavía no sabemos obtener datos de manera repetitiva, tomará sólo el juego cuyo nombre 
sea el primer alfabéticamente (lo mejoraremos más adelante). No recibirá ningún detalle como parámetro.*/

CREATE OR REPLACE PROCEDURE MostrarJocIncomplet IS
    nombre_juego VARCHAR2(100);
    nombre_plataforma VARCHAR2(100);
BEGIN

    SELECT j.nombre, p.nombre
    INTO nombre_juego, nombre_plataforma
    FROM juegos j
    JOIN plataformas p ON j.codigo_plataforma = p.codigo
    WHERE j.tamano IS NULL
    ORDER BY j.nombre
    FETCH FIRST 1 ROWS ONLY;

    DBMS_OUTPUT.PUT_LINE('Juego: ' || nombre_juego || ', Plataforma: ' || nombre_plataforma);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró ningún juego incompleto.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al mostrar el juego incompleto: ' || SQLERRM);
END MostrarJocIncomplet;
/


DECLARE
CURSOR cursorJocs IS
SELECT codi, nom FROM jocs ORDER BY nom;
v_nom jocs.nom % TYPE;
v_codi jocs.codi % TYPE;
BEGIN
OPEN cursorJocs;
LOOP
FETCH cursorJocs INTO v_codi, v_nom;
EXIT WHEN cursorJocs % ROWCOUNT > 10
OR cursorJocs % NOTFOUND;
dbms_output.put_line(v_codi || ' - ' || v_nom);
END LOOP;
CLOSE cursorJocs;
END;