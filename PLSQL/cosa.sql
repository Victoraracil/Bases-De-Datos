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
)
/
CREATE OR REPLACE FUNCTION PVP(codi_producte IN NUMBER, descripcio IN VARCHAR2, cost IN NUMBER) RETURN NUMBER IS
    V_PRECIO NUMBER;
    v_count NUMBER;
    V_CODIGO NUMBER;
BEGIN
        SELECT CODI_PRODUCTE, COST, COUNT(*) INTO V_CODIGO, V_PRECIO, v_count
        FROM PRODUCTES WHERE CODI_PRODUCTE = codi_producte;
        
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

/*Exercici proposat 06.09b:
Crea un trigger que anote "Sense revisar" en el nom d'un joc, en el cas que no s'haja indicat aquest nom
(siga NULL).*/


/*Exercici proposat 06.09c:
Crea una taula de còpia de seguretat dels jocs, i fes que s'anote també en ella cada joc que s'inserisca en
la taula principal.*/

CREATE OR REPLACE PROCEDURE ver_emple
AS
CURSOR c_emple IS
SELECT APELLIDO, FECHA_ALT
FROM EMPLE
ORDER BY APELLIDO;
v_apellido VARCHAR2(10);
v_fecha DATE;
BEGIN
OPEN c_emple;
FETCH c_emple into v_apellido, v_fecha;
WHILE c_emple%FOUND LOOP
DBMS_OUTPUT.PUT_LINE( v_apellido||' * '||v_fecha);
FETCH c_emple into v_apellido,v_fecha;
END LOOP;
CLOSE c_emple;
END ver_emple;

CREATE OR REPLACE FUNCTION sust_por_blancos( cad VARCHAR2)
  RETURN VARCHAR2 AS nueva_cad VARCHAR2(30);
  car CHARACTER;
  BEGIN
    FOR i IN 1..LENGTH(cad) LOOP
    car:=SUBSTR(cad,i,1);
    IF (ASCII(car) NOT BETWEEN 65 AND 90)
    AND (ASCII(car) NOT BETWEEN 97 AND 122) THEN
    car :=' ';
    END IF;
    nueva_cad := nueva_cad || car;
    END LOOP;
    RETURN nueva_cad;
  END sust_por_blancos;
/

2 Codificar un procedimiento que reciba una cadena y la visualice al revés.
    CREATE OR REPLACE PROCEDURE cadena_reves(
    vcadena VARCHAR2)
    AS
    vcad_reves VARCHAR2(80);
    BEGIN
    FOR i IN REVERSE 1..LENGTH(vcadena) LOOP
    vcad_reves := vcad_reves || SUBSTR(vcadena,i,1);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(vcad_reves);
    END cadena_reves;

🔹 1. BLOQUES
1. Mostrar preu i nom d’un article pel seu codi

DECLARE
  v_codi_article articles.id_article%TYPE;
  v_nom articles.nom%TYPE;
  v_preu articles.preu%TYPE;
BEGIN
  v_codi_article := '&codi_article'; -- demana per pantalla

  SELECT nom, preu INTO v_nom, v_preu
  FROM articles
  WHERE id_article = v_codi_article;

  DBMS_OUTPUT.PUT_LINE('Nom: ' || v_nom || ' - Preu: ' || v_preu);
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No s''ha trobat cap article amb aquest codi.');
END;

2. Mostra el salari mitjà i empleats que el superen

DECLARE
  v_mitja NUMBER;
BEGIN
  SELECT AVG(salari) INTO v_mitja FROM empleats;

  DBMS_OUTPUT.PUT_LINE('Salari mitjà: ' || v_mitja);

  FOR emp IN (SELECT nom FROM empleats WHERE salari > v_mitja) LOOP
    DBMS_OUTPUT.PUT_LINE('Empleat: ' || emp.nom);
  END LOOP;
END;

3. Bloc amb gestió d errors i registre en log_errors

DECLARE
  v_nom productes.nom%TYPE;
BEGIN
  SELECT nom INTO v_nom FROM productes WHERE id_producte = 9999; -- forcem error
  DBMS_OUTPUT.PUT_LINE('Producte: ' || v_nom);
EXCEPTION
  WHEN OTHERS THEN
    INSERT INTO log_errors(missatge, data_error)
    VALUES(SQLERRM, SYSDATE);
    DBMS_OUTPUT.PUT_LINE('Error registrat.');
END;

🔹 2. PROCEDIMIENTOS
4. actualitza_salari

CREATE OR REPLACE PROCEDURE actualitza_salari(
  p_id_empleat IN empleats.id_empleat%TYPE,
  p_percentatge IN NUMBER
) AS
BEGIN
  UPDATE empleats
  SET salari = salari * (1 + p_percentatge / 100)
  WHERE id_empleat = p_id_empleat;
  COMMIT;
END;

5. afegir_client

CREATE OR REPLACE PROCEDURE afegir_client(
  p_nom IN clients.nom%TYPE,
  p_adreca IN clients.adreca%TYPE,
  p_email IN clients.email%TYPE
) AS
BEGIN
  INSERT INTO clients(nom, adreca, email)
  VALUES(p_nom, p_adreca, p_email);
  COMMIT;
END;

6. esborrar_comanda

CREATE OR REPLACE PROCEDURE esborrar_comanda(p_id_comanda IN comandes.id_comanda%TYPE) AS
BEGIN
  DELETE FROM linies_comanda WHERE id_comanda = p_id_comanda;
  DELETE FROM comandes WHERE id_comanda = p_id_comanda;
  COMMIT;
END;

🔹 3. FUNCIONS
7. salari_anual

CREATE OR REPLACE FUNCTION salari_anual(p_id_empleat IN empleats.id_empleat%TYPE)
RETURN NUMBER IS
  v_salari empleats.salari%TYPE;
BEGIN
  SELECT salari INTO v_salari FROM empleats WHERE id_empleat = p_id_empleat;
  RETURN v_salari * 12;
END;

8. descompte_total

CREATE OR REPLACE FUNCTION descompte_total(p_id_comanda IN NUMBER)
RETURN NUMBER IS
  v_total NUMBER := 0;
BEGIN
  SELECT SUM(preu_unitari * quantitat * descompte) INTO v_total
  FROM linies_comanda
  WHERE id_comanda = p_id_comanda;

  RETURN NVL(v_total, 0);
END;

9. es_major_d_edat

CREATE OR REPLACE FUNCTION es_major_d_edat(p_data_naixement IN DATE)
RETURN BOOLEAN IS
BEGIN
  RETURN MONTHS_BETWEEN(SYSDATE, p_data_naixement) / 12 >= 18;
END;