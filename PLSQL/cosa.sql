--Ejercicios generals usant Funcions/Procediments
--1. Crea una funció que retorne el factorial d'un número.
CREATE OR REPLACE FUNCTION factorial(num IN NUMBER) RETURN NUMBER IS
    result NUMBER := 1;
BEGIN
    IF num < 0 THEN
        RETURN NULL; -- No es pot calcular el factorial de nombres negatius
    END IF;

    FOR i IN 1..num LOOP
        result := result * i;
    END LOOP;

    RETURN result;
END;
/

/*2. Donat el següent procediment:
CREATE OR replau PROCEDURE crear_depart (
v_num_dept depart.dept_no%TYPE,
v_dnombre depart.dnombre%TYPE DEFAULT 'PROVISIONAL',
v_loc depart.loc%TYPE DEFAULT ‘PROVISIONAL’)
IS
BEGIN
INSERT INTO depart
VALUES (v_num_dept, v_dnombre, v_loc);
END crear_depart;
Indicar quins de les següents anomenades són correctes i quins incorrectes, en
aquest últim cas escriure la crida correcta usant la notació posicional (en els
casos que es puga):
crear_depart; -- 1r Falta el paràmetre obligatori v_num_dept.*/
crear_depart(1);

--crear_depart(50); -- 2n Correcte

--crear_depart('COMPRES'); -- 3r El primer paràmetre ha de ser un número (v_num_dept).
crear_depart(1, 'COMPRES');

--crear_depart(50,'COMPRES'); -- 4t Correcte

--crear_depart('COMPRES', 50); -- 5é L'ordre dels paràmetres no és correcte.
crear_depart(50, 'COMPRES');

--crear_depart('COMPRES', 'VALÈNCIA'); -- 6é El primer paràmetre ha de ser un número (v_num_dept)
crear_depart(1, 'COMPRES', 'VALÈNCIA');

--crear_depart(50, 'COMPRES', 'VALÈNCIA'); -- 7é Correcte

--crear_depart('COMPRES', 50, 'VALÈNCIA'); -- 8é L'ordre dels paràmetres no és correcte.
crear_depart(50, 'COMPRES', 'VALÈNCIA');

--crear_depart('VALÈNCIA', ‘COMPRES’); -- 9é El primer paràmetre ha de ser un número (v_num_dept) i l'ordre dels paràmetres no és correcte.
crear_depart(1, 'COMPRES', 'VALÈNCIA');

--crear_depart('VALÈNCIA', 50); -- 10é El primer paràmetre ha de ser un número (v_num_dept) i l'ordre dels paràmetres no és correcte.
crear_depart(50, 'VALÈNCIA');

--3. Escriure una funció que reba per paràmetre una data i retorne l'any, en número, corresponent a aqueixa data.
CREATE OR REPLACE FUNCTION any_de_data(data IN DATE) RETURN NUMBER IS
    any NUMBER;
BEGIN
    SELECT EXTRACT(YEAR FROM data) INTO any FROM dual;
    RETURN any;
END;

--4. Codificar un procediment que reba una cadena i la visualitze a l'inrevés.
CREATE OR REPLACE PROCEDURE visualitzar_inrevess(cadena IN VARCHAR2) IS
    cadena_inrevess VARCHAR2(100);
BEGIN
    cadena_inrevess := REVERSE(cadena);
    DBMS_OUTPUT.PUT_LINE("Cadena a l'inrevés: " || cadena_inrevess);
END visualitzar_inrevess;

--5. Realitza una funció que retorne si una cadena, passada per paràmetre és no palindroma.
CREATE OR REPLACE FUNCTION es_palindroma(cadena IN VARCHAR2) RETURN BOOLEAN IS
    cadena_inrevess VARCHAR2(100);
BEGIN
    cadena_inrevess := REVERSE(cadena);
    IF cadena = cadena_inrevess THEN
        RETURN TRUE; -- És palíndroma
    ELSE
        RETURN FALSE; -- No és palíndroma
    END IF;
END es_palindroma;

--6. Realitza el mateix exercici anterior, però per a comprovar si un número passat per paràmetre és o no capicúa.
CREATE OR REPLACE FUNCTION es_capicua(num IN NUMBER) RETURN BOOLEAN IS
    num_str VARCHAR2(100);
    num_inrevess VARCHAR2(100);
BEGIN
    num_str := TO_CHAR(num);
    num_inrevess := REVERSE(num_str);
    IF num_str = num_inrevess THEN
        RETURN TRUE; -- És capicúa
    ELSE
        RETURN FALSE; -- No és capicúa
    END IF;
END es_capicua;

/*7. Implementar un procediment que reba un import i visualitze el desglossament
del canvi en unitats monetàries de 1, 2, 5, 10, 20, 50, 1€, 2€, 5€, 10€, 20€, 50€,
100€, 200€ i 500€ en ordre invers al que apareixen ací enumerades.
Repetir l'exercici per a les pessetes.*/

CREATE OR REPLACE FUNCTION desglossar_canvi_func(importe IN NUMBER) RETURN VARCHAR2 IS
    euros NUMBER(15,2) := importe;
    resultat VARCHAR2(4000) := '';
    denominations SYS.ODCINUMBERLIST := SYS.ODCINUMBERLIST(500, 200, 100, 50, 20, 10, 5, 2, 1, 0.5, 0.2, 0.1, 0.05, 0.02, 0.01);
BEGIN
    FOR i IN 1..denominations.COUNT LOOP
        IF euros >= denominations(i) THEN
            resultat := resultat || denominations(i) || '€: ' || TRUNC(euros / denominations(i)) || ' unitats' || CHR(10);
            euros := MOD(euros, denominations(i));
        END IF;
    END LOOP;
    RETURN resultat;
END desglossar_canvi_func;

/*8. La distància entre dos punts és igual a la longitud del segment que els uneix,
per la qual cosa per a calcular aquesta distància s'han de calcular els quadrats
de les diferències entre les seues coordenades i després trobar l'arrel de la suma
d'aquests quadrats.
Fent ús de funcions matemàtiques, elabora un programa en PL/SQL que calcule
la distància de dos punts d'un pla cartesià (x,i), mostrat per pantalla la distància
dels punts x, i.
Exemple: Donat els valors, x = (-4, -3); i = (2, 5) , Distància = 10*/
CREATE OR REPLACE FUNCTION calcular_distancia(x1 IN NUMBER, y1 IN NUMBER, x2 IN NUMBER, y2 IN NUMBER) RETURN NUMBER IS
    distancia NUMBER;
BEGIN
    distancia := SQRT(POWER(x2 - x1, 2) + POWER(y2 - y1, 2));
    RETURN distancia;
END calcular_distancia;

/*9. Fent ús d'estructures de control i funcions matemàtiques, desarrollar un
programa que genere n (número aleatori comprés entre dos valors donats)
números aleatoris delimitats entre dos valors, imprimisca cadascun d'ells per
pantalla i mostre suma obtinguda entre els n números generats.
Exemple: Nombre de valors a sumar: 5
Números generats entre 2 i 6: 2, 4, 3, 2, 4
La suma de 2+4+3+2+4 = 15*/

/*10. Desenvolupar un programa que retorne la quantitat de números múltiples de
5 que existeixen entre 1 i un número generat aleatòriament menor de 500.*/
CREATE OR REPLACE FUNCTION multiples_de_cinc(num IN NUMBER) RETURN NUMBER IS
    count_multiples NUMBER := 0;
BEGIN
    FOR i IN 1..num LOOP
        IF MOD(i, 5) = 0 THEN
            count_multiples := count_multiples + 1;
        END IF;
    END LOOP;
    RETURN count_multiples;
END multiples_de_cinc;

/*1. Realitza el següent exercici 6 funcions, usant excepcions: Crea una funció anomenada PVP que prenga
com a argument un codi de producte, una descripció i un cost del producte, i realitze una inserció en
una taula PRODUCTES si el codi de producte (PK) no existeix i en cas d'existir actualitze les dades de
descripció i cost i retorne el preu de venda al públic, que resulta d'aplicar-li a aqueix preu de cost un
marge comercial del 20%).*/
CREATE TABLE PRODUCTES (
    CODI_PRODUCTE NUMBER PRIMARY KEY,
    DESCRIPCIO VARCHAR2(100),
    COST NUMBER
);
/
CREATE OR REPLACE FUNCTION PVP(codi_producte IN NUMBER, descripcio IN VARCHAR2, cost IN NUMBER) RETURN NUMBER IS
    V_PRECIO NUMBER;
    v_count NUMBER;
    V_CODIGO NUMBER;
BEGIN
        SELECT CODI_PRODUCTE, COST, COUNT(*) INTO V_CODIGO, V_PRECIO, v_count, FROM PRODUCTES WHERE CODI_PRODUCTE = codi_producte;
        
        IF v_count = 0 THEN
            INSERT INTO PRODUCTES (CODI_PRODUCTE, DESCRIPCIO, COST) VALUES (codi_producte, descripcio, cost);
        ELSE
            UPDATE PRODUCTES SET V_PRECIO = cost * 1.2 WHERE CODI_PRODUCTE = codi_producte;
        END IF;
        
        V_PRECIO := cost * 1.2;
        COMMIT;
        
        RETURN V_PRECIO;
    
    END PVP;
/

--2. Realitza l'exercici anterior donant un missatge d'error en cas que ja existisca. (Sense fer el update)

--3. Realitza l'exercici anterior donant un missatge d'error en cas que no existisca. (Sense fer el insert)

--4. Provoca un error perquè salte una excepció i captura-la abans d'eixir de la funció.

--5. Nia totes les excepcions possibles dels exercicis anteriors en la mateixa funció.

--6. Mostra el nombre de productes, de manera que indique “No hi ha productes” en comptes de “Hi ha 0
--productes”.


--ejemplo
CREATE OR REPLACE TRIGGER nouJoc BEFORE INSERT ON jocs
FOR EACH ROW
BEGIN
:NEW.codiPlataforma := LOWER(:NEW.codiPlataforma);
END;

CREATE TRIGGER jocEsborrat AFTER DELETE ON jocs
FOR EACH ROW
BEGIN
INSERT INTO jocsEsborrats VALUES(:OLD.codi, :OLD.nom);
END;

/*Exercici proposat 06.09a:
Crea un trigger que force al fet que, quan es guarda una nova plataforma, el seu codi s'emmagatzeme
en minúscules.*/
CREATE OR REPLACE TRIGGER nouJoc 
BEFORE INSERT ON codi
FOR EACH ROW
BEGIN
:NEW.codi := LOWER(:NEW.codi);
END;

/*Exercici proposat 06.09b:
Crea un trigger que anote "Sense revisar" en el nom d'un joc, en el cas que no s'haja indicat aquest nom
(siga NULL).*/


/*Exercici proposat 06.09c:
Crea una taula de còpia de seguretat dels jocs, i fes que s'anote també en ella cada joc que s'inserisca en
la taula principal.*/

Para examen entra:
- 1 bloque
- 1 procedimiento 
- 1 funcion 
- 1 triger