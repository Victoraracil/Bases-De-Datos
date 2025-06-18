DROP DATABASE IF EXISTS tienda;
CREATE DATABASE tienda CHARACTER SET utf8mb4;
USE tienda;

CREATE TABLE fabricante (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL
);

CREATE TABLE producto (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  precio DOUBLE NOT NULL,
  id_fabricante INT UNSIGNED NOT NULL,
  FOREIGN KEY (id_fabricante) REFERENCES fabricante(id)
);

INSERT INTO fabricante VALUES(1, 'Asus');
INSERT INTO fabricante VALUES(2, 'Lenovo');
INSERT INTO fabricante VALUES(3, 'Hewlett-Packard');
INSERT INTO fabricante VALUES(4, 'Samsung');
INSERT INTO fabricante VALUES(5, 'Seagate');
INSERT INTO fabricante VALUES(6, 'Crucial');
INSERT INTO fabricante VALUES(7, 'Gigabyte');
INSERT INTO fabricante VALUES(8, 'Huawei');
INSERT INTO fabricante VALUES(9, 'Xiaomi');

INSERT INTO producto VALUES(1, 'Disco duro SATA3 1TB', 86.99, 5);
INSERT INTO producto VALUES(2, 'Memoria RAM DDR4 8GB', 120, 6);
INSERT INTO producto VALUES(3, 'Disco SSD 1 TB', 150.99, 4);
INSERT INTO producto VALUES(4, 'GeForce GTX 1050Ti', 185, 7);
INSERT INTO producto VALUES(5, 'GeForce GTX 1080 Xtreme', 755, 6);
INSERT INTO producto VALUES(6, 'Monitor 24 LED Full HD', 202, 1);
INSERT INTO producto VALUES(7, 'Monitor 27 LED Full HD', 245.99, 1);
INSERT INTO producto VALUES(8, 'Portátil Yoga 520', 559, 2);
INSERT INTO producto VALUES(9, 'Portátil Ideapd 320', 444, 2);
INSERT INTO producto VALUES(10, 'Impresora HP Deskjet 3720', 59.99, 3);
INSERT INTO producto VALUES(11, 'Impresora HP Laserjet Pro M26nw', 180, 3);

1.1.3 Consultas sobre una tabla

Lista el nombre de todos los productos que hay en la tabla producto.
SELECT nombre 
FROM producto

Lista los nombres y los precios de todos los productos de la tabla producto.
SELECT nombre, precio
FROM producto

Lista todas las columnas de la tabla producto.
SELECT *
FROM producto

Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD).
SELECT nombre, precio
FROM producto

Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD). 
Utiliza los siguientes alias para las columnas: nombre de producto, euros, dólares.
SELECT nombre as nombreproducto, precio as precioeuro
FROM producto

Lista los nombres y los precios de todos los productos de la tabla producto, convirtiendo los nombres a mayúscula.
SELECT UPPER(nombre), UPPER(precio)
FROM producto

Lista los nombres y los precios de todos los productos de la tabla producto, convirtiendo los nombres a minúscula.
SELECT LOWER(nombre), LOWER(precio)
FROM producto

Lista el nombre de todos los fabricantes en una columna, y en otra columna obtenga en mayúsculas los dos primeros 
caracteres del nombre del fabricante.
SELECT LOWER(nombre), LOWER(precio)
FROM producto

Lista los nombres y los precios de todos los productos de la tabla producto, redondeando el valor del precio.

Lista los nombres y los precios de todos los productos de la tabla producto, truncando el valor del precio para 
mostrarlo sin ninguna cifra decimal.

Lista el identificador de los fabricantes que tienen productos en la tabla producto.

Lista el identificador de los fabricantes que tienen productos en la tabla producto, eliminando los identificadores que aparecen repetidos.

Lista los nombres de los fabricantes ordenados de forma ascendente.

Lista los nombres de los fabricantes ordenados de forma descendente.

Lista los nombres de los productos ordenados en primer lugar por el nombre de forma ascendente y en segundo lugar 
por el precio de forma descendente.

Devuelve una lista con las 5 primeras filas de la tabla fabricante.

Devuelve una lista con 2 filas a partir de la cuarta fila de la tabla fabricante. La cuarta fila también se debe incluir en la respuesta.

Lista el nombre y el precio del producto más barato. (Utilice solamente las cláusulas ORDER BY y LIMIT)

Lista el nombre y el precio del producto más caro. (Utilice solamente las cláusulas ORDER BY y LIMIT)

Lista el nombre de todos los productos del fabricante cuyo identificador de fabricante es igual a 2.

Lista el nombre de los productos que tienen un precio menor o igual a 120€.

Lista el nombre de los productos que tienen un precio mayor o igual a 400€.

Lista el nombre de los productos que no tienen un precio mayor o igual a 400€.

Lista todos los productos que tengan un precio entre 80€ y 300€. Sin utilizar el operador BETWEEN.

Lista todos los productos que tengan un precio entre 60€ y 200€. Utilizando el operador BETWEEN.

Lista todos los productos que tengan un precio mayor que 200€ y que el identificador de fabricante sea igual a 6.

Lista todos los productos donde el identificador de fabricante sea 1, 3 o 5. Sin utilizar el operador IN.

Lista todos los productos donde el identificador de fabricante sea 1, 3 o 5. Utilizando el operador IN.

Lista el nombre y el precio de los productos en céntimos (Habrá que multiplicar por 100 el valor del precio). 
Cree un alias para la columna que contiene el precio que se llame céntimos.

Lista los nombres de los fabricantes cuyo nombre empiece por la letra S.

Lista los nombres de los fabricantes cuyo nombre termine por la vocal e.

Lista los nombres de los fabricantes cuyo nombre contenga el carácter w.

Lista los nombres de los fabricantes cuyo nombre sea de 4 caracteres.

Devuelve una lista con el nombre de todos los productos que contienen la cadena Portátil en el nombre.

Devuelve una lista con el nombre de todos los productos que contienen la cadena Monitor en el nombre y tienen un precio inferior a 215 €.

Lista el nombre y el precio de todos los productos que tengan un precio mayor o igual a 180€. 
Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente).

1.1.4 Consultas multitabla (Composición interna)

Resuelva todas las consultas utilizando la sintaxis de SQL1 y SQL2.

Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos.

Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos. 
Ordene el resultado por el nombre del fabricante, por orden alfabético.

Devuelve una lista con el identificador del producto, nombre del producto, identificador del fabricante y nombre del fabricante,
de todos los productos de la base de datos.

Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más barato.

Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más caro.

Devuelve una lista de todos los productos del fabricante Lenovo.

Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que 200€.

Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packardy Seagate. Sin utilizar el operador IN.

Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packardy Seagate. Utilizando el operador IN.

Devuelve un listado con el nombre y el precio de todos los productos de los fabricantes cuyo nombre termine por la vocal e.

Devuelve un listado con el nombre y el precio de todos los productos cuyo nombre de fabricante contenga el carácter w en su nombre.

Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos los productos que tengan un precio mayor 
o igual a 180€. Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente)

Devuelve un listado con el identificador y el nombre de fabricante, solamente de aquellos fabricantes que tienen 
productos asociados en la base de datos.

1.1.5 Consultas multitabla (Composición externa)

Resuelva todas las consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.

Devuelve un listado de todos los fabricantes que existen en la base de datos, junto con los productos que tiene cada uno de ellos. 
El listado deberá mostrar también aquellos fabricantes que no tienen productos asociados.

Devuelve un listado donde sólo aparezcan aquellos fabricantes que no tienen ningún producto asociado.

¿Pueden existir productos que no estén relacionados con un fabricante? Justifique su respuesta.

1.1.6 Consultas resumen

Calcula el número total de productos que hay en la tabla productos.

Calcula el número total de fabricantes que hay en la tabla fabricante.

Calcula el número de valores distintos de identificador de fabricante aparecen en la tabla productos.

Calcula la media del precio de todos los productos.

Calcula el precio más barato de todos los productos.

Calcula el precio más caro de todos los productos.
SELECT precio
FROM productos
WHERE precio = (SELECT MAX(precio)
                FROM productos)

Lista el nombre y el precio del producto más barato.

Lista el nombre y el precio del producto más caro.

Calcula la suma de los precios de todos los productos.

Calcula el número de productos que tiene el fabricante Asus.

Calcula la media del precio de todos los productos del fabricante Asus.

Calcula el precio más barato de todos los productos del fabricante Asus.

Calcula el precio más caro de todos los productos del fabricante Asus.

Calcula la suma de todos los productos del fabricante Asus.

Muestra el precio máximo, precio mínimo, precio medio y el número total de productos que tiene el fabricante Crucial.

Muestra el número total de productos que tiene cada uno de los fabricantes. El listado también debe incluir 
los fabricantes que no tienen ningún producto. El resultado mostrará dos columnas, una con el nombre del fabricante 
y otra con el número de productos que tiene. Ordene el resultado descendentemente por el número de productos.

Muestra el precio máximo, precio mínimo y precio medio de los productos de cada uno de los fabricantes. 
El resultado mostrará el nombre del fabricante junto con los datos que se solicitan.

Muestra el precio máximo, precio mínimo, precio medio y el número total de productos de los fabricantes 
que tienen un precio medio superior a 200€. No es necesario mostrar el nombre del fabricante, con el identificador del fabricante es suficiente.

Muestra el nombre de cada fabricante, junto con el precio máximo, precio mínimo, precio medio y el número total de 
productos de los fabricantes que tienen un precio medio superior a 200€. Es necesario mostrar el nombre del fabricante.

Calcula el número de productos que tienen un precio mayor o igual a 180€.

Calcula el número de productos que tiene cada fabricante con un precio mayor o igual a 180€.

Lista el precio medio los productos de cada fabricante, mostrando solamente el identificador del fabricante.

Lista el precio medio los productos de cada fabricante, mostrando solamente el nombre del fabricante.

Lista los nombres de los fabricantes cuyos productos tienen un precio medio mayor o igual a 150€.

Devuelve un listado con los nombres de los fabricantes que tienen 2 o más productos.

Devuelve un listado con los nombres de los fabricantes y el número de productos que tiene cada uno con 
un precio superior o igual a 220 €. No es necesario mostrar el nombre de los fabricantes que no tienen productos que cumplan la condición.

Devuelve un listado con los nombres de los fabricantes y el número de productos que tiene cada uno con 
un precio superior o igual a 220 €. El listado debe mostrar el nombre de todos los fabricantes, es decir, 
si hay algún fabricante que no tiene productos con un precio superior o igual a 220€ deberá aparecer en el 
listado con un valor igual a 0 en el número de productos.

Devuelve un listado con los nombres de los fabricantes donde la suma del precio de todos sus productos es superior a 1000 €.

Devuelve un listado con el nombre del producto más caro que tiene cada fabricante. El resultado debe tener tres columnas: 
nombre del producto, precio y nombre del fabricante. El resultado tiene que estar ordenado alfabéticamente de 
menor a mayor por el nombre del fabricante.

1.1.7 Subconsultas (En la cláusula WHERE)
1.1.7.1 Con operadores básicos de comparación

Devuelve todos los productos del fabricante Lenovo. (Sin utilizar INNER JOIN).

Devuelve todos los datos de los productos que tienen el mismo precio que el producto más caro del fabricante Lenovo. (Sin utilizar INNER JOIN).

Lista el nombre del producto más caro del fabricante Lenovo.

Lista el nombre del producto más barato del fabricante Hewlett-Packard.
SELECT nombre
FROM producto
WHERE precio = (SELECT MIN(precio)
                FROM fabricante
                WHERE UPPER(nombre) LIKE 'Hewlett-Packard ')
Devuelve todos los productos de la base de datos que tienen un precio mayor o igual al producto más caro del fabricante Lenovo.

Lista todos los productos del fabricante Asus que tienen un precio superior al precio medio de todos sus productos.

1.1.7.2 Subconsultas con ALL y ANY

Devuelve el producto más caro que existe en la tabla producto sin hacer uso de MAX, ORDER BY ni LIMIT.

Devuelve el producto más barato que existe en la tabla producto sin hacer uso de MIN, ORDER BY ni LIMIT.

Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando ALL o ANY).

Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando ALL o ANY).

1.1.7.3 Subconsultas con IN y NOT IN

Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando IN o NOT IN).

Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando IN o NOT IN).

1.1.7.4 Subconsultas con EXISTS y NOT EXISTS

Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando EXISTS o NOT EXISTS).

Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando EXISTS o NOT EXISTS).

1.1.7.5 Subconsultas correlacionadas

Lista el nombre de cada fabricante con el nombre y el precio de su producto más caro.

Devuelve un listado de todos los productos que tienen un precio mayor o igual a la media de todos los productos de su mismo fabricante.
SELECT nombre
FrOM productos
WHERE precio >= (SELECT AVG(precio), nombre
                  FROM productos
                  GROUP BY nombre)
Lista el nombre del producto más caro del fabricante Lenovo.

1.1.8 Subconsultas (En la cláusula HAVING)

Devuelve un listado con todos los nombres de los fabricantes que tienen el mismo número de productos que el fabricante Lenovo.
