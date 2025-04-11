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