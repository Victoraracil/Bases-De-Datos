--CONSULTAS mias con sus respuestas
--1 Selecciona a los empleados que sean hombres

SELECT *
FROM empleados
WHERE sexo = 'M'

--2 Selecciona las universidades cuya ciudad sea Alicante.
--Selecciona todas aquellas instituciones académicas de nivel universitario que estén registradas en la base de datos y cuya localización geográfica coincida con la ciudad específicamente identificada bajo el nombre de "Alicante"

SELECT *
FROM universidades
WHERE UPPER(ciudad) = 'ALICANTE'

--3 Selecciona el nombre y codigo de departamento de aquellos departamentos cuyo presupuesto supere 1300

SELECT nombre_dpto AS nombre, dpto_cod AS codigo
FROM departamentos
WHERE presupuesto > 700000

--4 Selecciona el nombre y el DNI de aquellos empleados que tengan una especialidad en mantenimiento de sistemas informaticos

SELECT nombre, DNI
FROM empleados INNER JOIN estudios ON estudios.empleado_DNI = empleados.DNI
WHERE UPPER(estudios.especialidad) = 'DERECHO' 

--5 Selecciona los trabajos que tengan un salario maximo menor a 30
--Selecciona todas aquellas ocupaciones o puestos laborales que estén registrados en la base de datos y cuyos salarios maximos percibidos, especificados en la columna correspondiente, se encuentren por debajo de 30

SELECT *
FROM trabajos
WHERE salario_max < 30

--6 Selecciona el nombre y el DNI de aquellos empleados cuyo grado de formacion sea phd

SELECT nombre, DNI
FROM empleados INNER JOIN estudios ON estudios.empleado_DNI = empleados.DNI
WHERE UPPER(estudios.grado) = 'PHD'

--7 Selecciona ambos apellidos de cualquier empleado que viva en un primer piso

SELECT apellido1, apellido2
FROM empleados
WHERE direcc2 = 'Piso 1'



--Consultas de mi compañero (Hugo)
--1º Muestra los empleados que viven en la provincia de Alicante:

SELECT *
FROM empleados
WHERE UPPER(provincia) = 'ALICANTE'

--2º Cantidad total de empleados nacidos antes del año 1990.

SELECT *
FROM empleados
WHERE to_char (fecha_nac, 'YYYY') < (1990)

--3º  Obten el nombre del trabajo, de los trabajos con un salario minimo de 25.

SELECT nombre_trab
FROM trabajos
WHERE salario_min LIKE 25

--4º Muestra los empleados nacidos en los años 1982, 1985 o 1991.

SELECT *
FROM empleados
WHERE to_char (fecha_nac, 'YYYY') IN (1982, 1985, 1991)

--5º Obten la especialidad de estudios que contengan (ía) o (ada).

SELECT especialidad
FROM estudios
WHERE especialidad LIKE '%ía%' OR especialidad LIKE '%ada%'

--6º Obten los codigos de universidad, cuyo nombre contenga la letra (l) y que la ciudad contenga la letra (o).

SELECT univ_cod
FROM universidades
WHERE nombre_univ LIKE '%l%' AND ciudad LIKE '%o%'

--7º Cuenta el total de presupuestos mayor a 600000 de la tabla departamentos
--8º Muestra los apellido1 de los empleados con mas de 5 caracteres
--9º Obtener el dni, nombre y ciudad de los empleados que estén asignados en el grado de PhD entre todos sus estudios.

SELECT nombre, DNI, ciudad
FROM empleados INNER JOIN estudios ON estudios.empleado_DNI = empleados.DNI
WHERE UPPER(estudios.grado) = 'PHD'
