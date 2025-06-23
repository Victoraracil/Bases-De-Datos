-- Ejercicios de introducción

-- 1. ¿Es correcta la siguiente sintaxis General de la sentencia IF-THEN ELSE?,¿Por qué?, ¿Cómo la escribirías?.
BEGIN
	IF condicion1 THEN
		secuencia_de_instrucciones1;
	ELSE
		secuencia_de_instrucciones2;
	END IF;
END;
/

-- 2. ¿Qué resultado nos daría la siguiente comparación?
DECLARE
	identificador1 VARCHAR2(10):='Hola Pepe';
	identificador2 VARCHAR2(10):='Hola pepe';
BEGIN
	IF identificador1<>identificador2 THEN
		RETURN TRUE;
	ELSE RETURN FALSE;
	END IF;
END;

-- y si es empleando función, ¿cambiaría el resultado?
CREATE OR REPLACE FUNCTION f1 RETURN boolean
IS
	identificador1 VARCHAR2(10):='Hola Pepe';
	identificador2 VARCHAR2(10):='Hola pepe';
BEGIN
	IF identificador1<>identificador2 THEN
		RETURN TRUE;
	ELSE
		RETURN FALSE;
	END IF;
END;
/
-- es distinto da como resultado true

-- 3. Indicar que errores existen en el siguiente código fuente:
DECLARE
	a NUMBER:=1;
	b NUMBER:=6;
	salida_bucle BOOLEAN;
BEGIN
	salida_bucle:='FALSE';
	-- sobran las comillas de false
	WHILE NOT salida_bucle LOOP
		BEGIN
		--sobra un begin
			IF a>=b THEN
				salida_bucle:='TRUE';
				--sobran las comillas de true
			ELSE
				a:=(a+1);
			END IF;
		END;
	END LOOP;
END;
/

-- 4. ¿Qué valor contendrá la variable 'sumador' al salir del bucle?, ¿Por qué?
DECLARE
	sumador NUMBER;
BEGIN
	FOR i IN 1..100 LOOP
		sumador:=sumador+i;
	END LOOP;
END;
/
--entra en el bucle pero sumador no tiene nada

-- 5. ¿Qué resultado dará la ejecución del siguiente código?
DECLARE
	temp NUMBER;
	SUBTYPE numero IS temp%TYPE;
	valor numero:=1;
BEGIN
	WHILE valor<20 LOOP
		valor:=valor+1;
	END LOOP;
	DBMS_OUTPUT.PUT_LINE (valor);
END;
/
-- el valor es 20

-- 6. ¿Funcionaría el siguiente trozo de código?, ¿Por qué?, ¿Cómo arreglarlo?
DECLARE
	mi_valor NUMBER;
	cierto BOOLEAN:=FALSE;
BEGIN
	WHILE NOT cierto LOOP
		IF mi_valor=NULL THEN
			mi_valor:=1;
		ELSE
			mi_valor:=mi_valor+1;
		END IF;
		IF mi_valor>100
			THEN cierto:=TRUE;
		END IF;
	-- EXIT WHEN cierto;
	END LOOP;
END;
/
-- No se puede comparar un NUMBER con NULL, tendriamos que poner
-- =0 o un IF mi_valor IS NULL THEN siendo mi_valor BOOLEAN

-- 7. Escribir la sintaxis General de un código que evalúe si se
-- cumple una condición, en caso de cumplirse que ejecute una serie
-- de sentencias, en caso contrario que evalúe otra, que de cumplirse
-- ejecute otras instrucciones, si ésta no se cumple que evalúe una
-- tercera condición.. y así N veces. En caso de existir varias soluciones,
-- comentarlas y escribir la más óptima o clara.


-- 8. Implementar en PL/SQL un bucle infinito que vaya sumando
-- valores en una variable de tipo NUMBER.
DECLARE
	v_num number:=0;
BEGIN
	WHILE v_num > -1 LOOP
	-- WHILE true LOOP
		v_num:= v_num + 1;
	END LOOP;
END;
/

-- 9. En base al bucle anterior, añadirle la condición de
-- que salga cuando la variable sea mayor que 10.000
DECLARE
	v_num number:=1;
	--Salir boolean:=true;
BEGIN
	WHILE v_num < 10001 LOOP
		v_num:=v_num +1 ;
	END LOOP;
	--WHILE Salir LOOP
	IF v_num=10000 THEN
		Salir:=FALSE;
	ELSE
		  v_num:= v_num + 1;
	END IF;
	--END LOOP;
END;
/

-- 10. Implementar un bucle en PL/SQL mediante la sentencia WHILE,
-- en el cual vayamos sumando valores a una variable mientras ésta
-- sea menor que 10, y asegurándonos de que el bucle se ejecuta por
-- lo menos una vez.
DECLARE
	numeritos number:=1;
BEGIN
	LOOP 
		numeritos:=numeritos +1 ;
		EXIT when numeritos > 10
	END LOOP;
END;
/

-- 11. Implementar en PL/SQL, el código necesario de un programa 
-- que al final de su ejecución haya almacenado en una variable llamada
--  'cadena', el siguiente valor:
-- cadena:='10*9*8*7*6*5*4*3*2*1'
DECLARE
	cadena VARCHAR(30)
BEGIN
	FOR valor IN REVERSE 1..10 LOOP
		IF valor=10 THEN 
			cadena:='\''
		ELSIF valor<=10 AND valor>1 THEN
			cadena:=cadena||TO_CHAR(valor)||'*';
		ELSIF valor<=1 THEN 
			cadena:=cadena||TO_CHAR(valor)||'\'';
	END LOOP;
END;
/
--Primero realizamos un for que empieza en 10 y va hasta el numero 1
-- al entrar verifica si el valor es 10 y añadimos una '
--