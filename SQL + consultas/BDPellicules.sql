-- A partir de estas tablas y datos:
-- PELÍCULAS, CATEGORIAS (M:M) y REHECHA (1:M)

CREATE TABLE PELICULAS (
  codigo VARCHAR2(6),
  nombre VARCHAR2(30),
  anyoEstreno NUMBER(4),
  valoracion NUMBER(2),
  remakeDe VARCHAR2(6)
);

CREATE TABLE CATEGORIAS (
  codigo VARCHAR2(3),
  nombre VARCHAR2(30)
);

CREATE TABLE PERTENECER (
  codPelicula VARCHAR2(6),
  codCategoria VARCHAR2(3),
  PRIMARY KEY (codPelicula, codCategoria)
);

INSERT INTO PELICULAS VALUES ('eco','El caballero oscuro', 2008, 9, NULL);
INSERT INTO PELICULAS VALUES ('uti','Ultimatum a la Tierra', 1951, 8, NULL);
INSERT INTO PELICULAS VALUES ('uti2','Ultimatum a la Tierra', 2008, 4, 'uti');
INSERT INTO PELICULAS VALUES ('tij','The italian job', 1969, 7, NULL);
INSERT INTO PELICULAS VALUES ('tij2','The italian job', 2003, 7, 'tij');
INSERT INTO PELICULAS VALUES ('skf','Skyfall', 2012, 8, NULL);
INSERT INTO PELICULAS VALUES ('lvi','La ventana indiscreta', 1954, 9, NULL);
INSERT INTO PELICULAS VALUES ('ter','Terror', 1963, 5, NULL);

INSERT INTO CATEGORIAS VALUES ('acc','Acción');
INSERT INTO CATEGORIAS VALUES ('com','Comedia');
INSERT INTO CATEGORIAS VALUES ('cf','Ciencia Ficción');
INSERT INTO CATEGORIAS VALUES ('dr','Drama');
INSERT INTO CATEGORIAS VALUES ('cri','Crimen');
INSERT INTO CATEGORIAS VALUES ('sus','Suspense');
INSERT INTO CATEGORIAS VALUES ('ter','Terror');

INSERT INTO PERTENECER VALUES ('eco','acc');
INSERT INTO PERTENECER VALUES ('eco','cri');
INSERT INTO PERTENECER VALUES ('tij','acc');
INSERT INTO PERTENECER VALUES ('tij','com');
INSERT INTO PERTENECER VALUES ('uti','cf');
INSERT INTO PERTENECER VALUES ('uti','dra');
INSERT INTO PERTENECER VALUES ('skf','acc');
INSERT INTO PERTENECER VALUES ('skf','sus');
INSERT INTO PERTENECER VALUES ('lvi','sus');


-- Añade 5 registros nuevos en cada una de las tablas con información veraz
INSERT INTO PELICULAS('tij','Torrente', 2008, 9, NULL);
INSERT INTO PELICULAS('eco','Venom', 2008, 9, NULL);
INSERT INTO PELICULAS('tat','IT', 2008, 9, NULL);
INSERT INTO PELICULAS('tat','Nosferatu', 2024, 9, NULL);
INSERT INTO PELICULAS('tij','La Mascara', 2008, 9, NULL);

INSERT INTO PERTENECER('tat','tr');
INSERT INTO PERTENECER('','');
INSERT INTO PERTENECER('','');
INSERT INTO PERTENECER('','');
INSERT INTO PERTENECER('','');


-- Modifica las tablas para que las restricciones tengan su nombre de constraints**
ALTER TABLE PELICULAS
MODIFY CONSTRAINT unq_pelicula UNIQUE (nombre);
ALTER TABLE CATEGORIAS
MODIFY CONSTRAINT unq_categorias UNIQUE (nombre);
ALTER TABLE PERTENECER
MODIFY CONSTRAINT unq_pertenecer UNIQUE (nombre);

-- Realiza las modificaciones necesarias sobre las tablas para incluir las siguientes restricciones
-- PELICULAS - Clave principal: codigo
ALTER TABLE PELICULAS
ADD CONSTRAINT pk_CODIGO PRIMARY KEY (codigo);

-- PELICULAS - Clave ajena: remakeDe -> PELICULAS
ALTER TABLE PELICULAS
ADD CONSTRAINT fk_REMAKEDE FOREIGN KEY (remakeDe) REFERENCES PELICULAS (remakeDe);

-- CATEGORIAS - Clave principal: codigo
ALTER TABLE CATEGORIAS
ADD CONSTRAINT pk_CATEGORIAS PRIMARY KEY (codigo);

-- PERTENECER - Clave ajena: codiPellicula -> PELICULAS / codiCategoria -> CATEGORIAS
ALTER TABLE PERTENECER
ADD CONSTRAINT fk_CODPELICULA FOREIGN KEY (codPelicula) REFERENCES PELICULAS (codigo);
--ALTER TABLE PERTENECER
--ADD CONSTRAINT fk_CODCATEGORIA FOREIGN KEY (codCategoria) REFERENCES CATEGORIAS (codigo);

-- El año de estreno siempre sera menor que el año actual
ALTER TABLE PELICULAS
ADD CONSTRAINT chk_anyo CHECK (anyoEstreno < 2025);

-- La valoración de la pelicula tendrá valores entre 0 y 10
ALTER TABLE PELICULAS
ADD CONSTRAINT chk_valoracion CHECK (valoracion between 1 and 10);


-- CONSULTAS
-- 01. Nombre y año de las películas donde, la valoración de las cuales sea de 8 o más.
SELECT nombre, anyoestreno
FROM peliculas
WHERE valoracion >= 8  

-- 02. Nombre y año de las películas donde, la valoración de las cuales no sea 9, ordenadas por nombre.
SELECT nombre, anyoestreno
FROM peliculas
WHERE valoracion != 9  
ORDER BY nombre

-- 03, 04. Nombre de cada película y cantidad de categorias que tenemos sobre ella
-- (solo para las películas de las cuales conocemos alguna categoría), enlazando las tablas de 2 formas diferentes.
-- 05. Nombre de cada película y cantidad de categorias que tenemos sobre ella (quizás ninguna).
-- 06, 07. Películas que contienen un espacio en su nombre, de 2 formas diferentes.
SELECT nombre
FROM peliculas
WHERE nombre LIKE '%_%'

-- 08. Valoración media de las películas el nombre de las cuales empieza por "T" (en mayúsculas), redondeada a 1 decimal.
SELECT ROUND(AVG(valoracion),1)
FROM peliculas
WHERE nombre LIKE 'T%'

-- 09. Valoración más alta de una película el nombre de la cual empiezo por "T" (quizás en minúsculas).
SELECT MAX(valoracion)
FROM peliculas
WHERE UPPER(nombre) LIKE 'T%'

-- 10. Nombre de cada película, año, valoración y categoría (solo para las que conozcamos al menos una categoría), ordenada por título (nombre).
SELECT nombre, anyoestreno, valoracion, codigo
FROM peliculas
ORDER BY nombre

-- 11. Nombre de cada película, año, valoración y categoría (incluso para las que no conozcamos la categoría), ordenada por valoración, de la más alta a la más baja.
SELECT nombre, anyoestreno, valoracion, codigo
FROM peliculas
ORDER BY valoracion DESC

-- 12. Nombre, año y valoración de la/las película/películas con la valoración más alta, empleando ORDER BY.
SELECT nombre, anyoestreno, valoracion
FROM peliculas
ORDER BY valoracion DESC

-- 13. Nombre, año y valoración de la/las película/películas con la valoración más alta, empleando MAX.
SELECT nombre, anyoestreno, valoracion
FROM peliculas
WHERE valoracion = (SElECT MAX(valoracion) 
                    FROM peliculas) 

-- 14. Nombre, año y valoración de la/las película/películas con la valoración más alta, empleando AÑO o AJO.
-- 15. Nombre, año y valoración de la/las película/películas con la valoración más alta, empleando EXISTS o NOT EXISTS.
-- 16. Muestra las películas que sean "remakes" de alguna anterior: nombre, año y valoración de la película moderna, junto con nombre, año y valoración de la película original.
SELECT nombre, anyoestreno, valoracion
FROM peliculas
WHERE remakede LIKE '%'

-- 17. Crea una vista "*v_remakes" que muestro esa información, ordenada de la película (moderna) más reciente a la más antigua, y ordenante por nombre en caso de que coincida el año.
CREATE VIEW v_remakes AS
( select.....);
-- 18. A partir de esa vista "v_remakes", muestra el nombre de la película moderna y los años de diferencia con la película original.
-- 19. Muestra los nombres de las categorias de las cuales tenemos 2 o más películas.
-- 20. Categorias de las cuales no conocemos ninguna película, usando IN / NOT IN.
-- 21. Categorias de las cuales no conocemos ninguna película, usando AJO / AÑO.
-- 22. Categorias de las cuales no conocemos ninguna película, usando EXISTS / NOT EXISTS.
-- 23. Categorias de las cuales no conocemos ninguna película, usando COUNT.
-- 24. Añade un índice a la tabla de películas, porque las búsquedas por título (nombre) sean más rápidas.
-- 25. Crea una tabla de "personas". Para cada persona querremos un código (6 letras, clave primaria), un nombre (hasta 40 letras, no nulo) y su fecha de nacimiento (fecha). Usa sintaxis de Oráculo.
-- 26. Añade a la tabla "personas" la restricción que el código tiene que estar en mayúsculas.
-- 27. Añade dos personas: Christopher Nolan (código CNOLAN), nacido el 30 de julio de 1970, y Alfred Hitchcock (código AHITCH), la fecha de nacimiento del cual no conocemos.
-- 28. Añade a la tabla de películas un campo llamado "director", de 6 letras, que será clave ajena a la tabla de personas.
-- 29. Indica que Nolan dirigió "El caballero oscuro" y que Hitchock dirigió "La ventana indiscreta" (puedes usar tanto los códigos de los directores como los de las películas).
-- 30. Borra el registro del director denominado "Uwe Boll", si existe.
-- 31. Modifica el registro de Alfred Hitchcock, para indicar que nació el 13 de agosto de 1899.
-- 32. Crea una tabla "PELICULASDirectores", volcando a ella el título (nombre) y año de cada película, junto con el nombre de su director, que quizás no conocemos (y en ese caso tendría que guardarse como valor nulo).
-- 33, 34. A partir de esa tabla, muestra título y año para las películas que estén entre el año 1980 y el 2010, los dos inclusivamente, de dos formas diferentes.
-- 35, 36. Muestra las películas que sean de los años 2008 o 2012 y que tengan una valoración de 8 o superior, de 2 formas diferentes.
SELECT *
FROM peliculas
WHERE (anyoestreno BETWEEN 2008 AND 2012) AND (valoracion >= 8) 

-- 37. Muestra la cantidad de películas que tenemos de cada categoría (quizás ninguna).
-- 38. Muestra la cantidad de películas que tenemos de cada categoría, pero solo para aquellas categorias en las cuales tenemos 2 películas o más.
-- 39. Añade a la tabla "PELICULASDirectores" un campo adicional, la "*categoriaPrincipal", que será un texto de hasta 30 letras.
-- 40. Elimina la columna "categoriaPrincipal" de la tabla "PELICULASDirectores".
-- 41. Vacía la tabla de "PELICULASDirectores", conservando su estructura.
-- 42. Elimina por completo la tabla de "PELICULASDirectores".
DROP TABLE PELICULASDirectores cascade constraints;

-- 43, 44, 45. Muestra las películas el título de las cuales (nombre) empieza por T (quizás en minúsculas), de 3 formas diferentes.
SELECT nombre, anyoestreno, valoracion
FROM peliculas
WHERE UPPER(nombre) LIKE 'T%'

-- 46, 47, 48. Muestra las películas el título de las cuales (nombre) acaba en "a", de 3 formas diferentes.
SELECT nombre, anyoestreno, valoracion
FROM peliculas
WHERE UPPER(nombre) LIKE '%A'

-- 49. Muestra la valoración media de las películas de la categoría "Acción".
SELECT AVG(valoracion)
FROM peliculas
WHERE codigo IN (SELECT codpelicula
                FROM pertenecer
                WHERE pertenecer.codcategoria = 'acc')

-- 50. Muestra las películas (nombre, año y valoración) la valoración de la cual está por encima de la media.
SELECT nombre, anyoestreno, valoracion
FROM peliculas
WHERE valoracion > (SElECT AVG(valoracion)
                    FROM peliculas)

-- 51. Muestra las películas (nombre, año y valoración) que tengan la segunda mejor valoración (tendrían que aparecerte las dos películas que están valoradas con un 8).
SELECT nombre, anyoestreno, valoracion
FROM peliculas
WHERE valoracion < (SElECT MAX(valoracion) 
                  FROM peliculas) AND valoracion > 7

-- 52. Muestra, en una única columna, los títulos (nombres) de películas, los nombres de directores y los de categorias, todo esto ordenado alfabéticamente.
-- 53. Muestra los nombres de películas que no se llaman igual que ninguna categoría (no tendría que aparecerte "Terror"), usando operaciones de conjuntos. 
-- 54. Muestra los nombres de películas que no se llaman igual que ninguna categoría, usando IN / NOT IN. 
-- 55. Muestra los nombres de películas que no se llaman igual que ninguna categoría, usando AJO / AÑO. 
-- 56. Muestra los nombres de películas que no se llaman igual que ninguna categoría, usando EXISTS / NOT EXISTS. 
-- 57. Muestra el nombre de cada película, año y código de película de la cual es remake, o bien el texto "(Original)", si no es remake de ningún anterior.
-- 58. Muestra el nombre de cada película (precedido por "Película: ") y el nombre de su director (quizás vacío, precedido por "Director: ").
-- 59. Añade al director "Ridley Scott", con código "RSCOTT". Muestra el título (nombre) de todas las películas que tenemos, junto con el nombre de su director. Tienen que aparecer todas las películas (incluso si de alguna no conocemos el director) y todos los directores (incluso si no conocemos ninguna película suya).
-- 60. Nombre y valoración de las películas que no tengan ni la valoración más alta de nuestra base de datos ni la valoración más baja.
SELECT nombre, valoracion
FROM peliculas
WHERE valoracion < (SElECT MAX(valoracion)
                    FROM peliculas) AND valoracion > (SElECT MIN(valoracion) 
                    FROM peliculas)

-- 61. Nombre y valoración de la película más valorada de cada categoría.
-- 62. Muestra las películas (código, nombre y año) que coinciden en alguna categoría con "El caballero oscuro".
SELECT codigo, nombre, anyoestreno
FROM peliculas
WHERE codigo IN (SELECT codpelicula
                FROM pertenecer
                WHERE pertenecer.codpelicula IN (SELECT nombre
                FROM peliculas
                WHERE UPPER(nombre) = 'EL CABALLERO OSCURO'))
                
-- 63. Muestra las películas (código, nombre y año) que coinciden en alguna categoría con "El caballero oscuro" o con "La ventana indiscreta".
