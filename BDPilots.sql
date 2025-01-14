--/1-
CREATE TABLE PILOTO(
  codigo number(4),
  nombre varchar2(14),
  ciudad varchar2(14),
  equipo varchar2(14),
  fec_nac date,
  constraint pk_piloto PRIMARY KEY (codigo)
);

CREATE TABLE PRUEBA(
  prueba number(4),
  coefic number(4,2),
  constraint pk_prueba PRIMARY KEY (prueba)
);

CREATE TABLE RESULTADO(
  codigo number(4),
  puesto number(2),
  prueba number(4),
  constraint fk_resultado_piloto foreign key (codigo) references PILOTO (codigo),
  constraint fk_resultado_prueba foreign key (prueba) references PRUEBA (prueba)
);

--2-
INSERT INTO PILOTO VALUES (1,'Alberto', 'Madrid','Ford', '10/10/1975');
INSERT INTO PILOTO VALUES (2,'Antonio', 'Alicante','Citroen', '1/4/1980');
INSERT INTO PILOTO VALUES (3,'Efice', 'Barcelona','Toyota', '2/5/1985');
INSERT INTO PILOTO VALUES (4,'Santi', 'Valencia','Peugeot', '14/10/1972');

--3-
INSERT INTO PRUEBA VALUES (1, 0.20);
INSERT INTO PRUEBA VALUES (2, 0.25);
INSERT INTO PRUEBA VALUES (3, 0.75);
INSERT INTO PRUEBA VALUES (4, 0.80);

--4-
INSERT INTO RESULTADO VALUES (1, 2, 1);
INSERT INTO RESULTADO VALUES (1, 4, 2);
INSERT INTO RESULTADO VALUES (1, 3, 3);
INSERT INTO RESULTADO VALUES (1, 1, 4);
INSERT INTO RESULTADO VALUES (2, 4, 1);
INSERT INTO RESULTADO VALUES (2, 3, 2);
INSERT INTO RESULTADO VALUES (2, 2, 3);
INSERT INTO RESULTADO VALUES (2, 2, 4);
INSERT INTO RESULTADO VALUES (3, 3, 1);
INSERT INTO RESULTADO VALUES (3, 2, 2);
INSERT INTO RESULTADO VALUES (3, 1, 3);
INSERT INTO RESULTADO VALUES (3, 3, 4);
INSERT INTO RESULTADO VALUES (4, 1, 1);
INSERT INTO RESULTADO VALUES (4, 1, 2);
INSERT INTO RESULTADO VALUES (4, 4, 3);
INSERT INTO RESULTADO VALUES (4, 4, 4);

--5-
SELECT nombre, codigo
FROM piloto
WHERE equipo NOT LIKE 'ONDA'

--6-
SELECT *
FROM prueba
WHERE coefic BETWEEN 0.25 AND 0.75

--7-
SELECT codigo, nombre, ciudad
FROM piloto
WHERE UPPER(ciudad) NOT IN ('MADRID', 'BARCELONA')

--8-
SELECT codigo, nombre, ciudad, equipo
FROM piloto
WHERE UPPER(equipo) IN ('CITROEN', 'PEUGEOT', 'TOYOTA')

--9-
SELECT codigo, nombre
FROM piloto
WHERE UPPER(nombre) LIKE 'ANT%'

--10-
SELECT codigo, nombre
FROM piloto
WHERE UPPER(nombre) LIKE 'A%O' 

--11-
SELECT piloto.codigo, piloto.nombre, piloto.fec_nac
FROM piloto INNER JOIN resultado ON resultado.codigo = piloto.codigo
WHERE resultado.puesto LIKE 1 

--12-
SELECT DISTINCT piloto.codigo, piloto.nombre, piloto.fec_nac
FROM piloto INNER JOIN resultado ON resultado.codigo = piloto.codigo
WHERE resultado.puesto LIKE 1

--13-
--En los propios INSERT ya se establecen los datos que pide el enunciado

--14-
SELECT piloto.codigo, piloto.nombre, piloto.fec_nac
FROM piloto INNER JOIN resultado ON resultado.codigo = piloto.codigo
WHERE resultado.puesto LIKE 1

--15-
SELECT piloto.codigo, piloto.nombre
FROM piloto INNER JOIN resultado ON resultado.codigo = piloto.codigo
WHERE resultado.puesto LIKE 1 
GROUP BY piloto.codigo, piloto.nombre
HAVING COUNT(resultado.puesto) = 2
--(Modificar datos para que exista un piloto que haya ganado 2 veces)

--16-
SELECT codigo, COUNT(puesto) AS pruebas_ganadas
FROM resultado
WHERE puesto LIKE 1
GROUP BY codigo
HAVING COUNT(resultado.puesto) >= 1

--17-


--18-