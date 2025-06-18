CREATE TABLE DEPARTAMENT (
dept_no NUMBER(2) NOT NULL,
dnom VARCHAR2(14),
loc VARCHAR2(14)
);

INSERT INTO DEPARTAMENT VALUES (10,'Comptabilitat','Sevilla');
INSERT INTO DEPARTAMENT VALUES (20,'Investigación','Alacant');
INSERT INTO DEPARTAMENT VALUES (30,'Vendes','Barcelona');
INSERT INTO DEPARTAMENT VALUES (40,'Producció','Bilbao');

CREATE TABLE EMPRAT (
  emp_no NUMBER(4) NOT NULL,
  cognom VARCHAR2(10) ,
  ofici VARCHAR2(10) ,
  dir NUMBER(4) ,
  data_alt DATE,
  salari NUMBER(10),
  comision NUMBER(10),
  dept_no NUMBER(2) NOT NULL
); 

INSERT INTO EMPRAT VALUES (7369,'Sanchez','Empleat',7902,'17/12/1980',14000,NULL,20);
INSERT INTO EMPRAT VALUES (7499,'Rierol','Venedor',7698,'20/02/1980',28000,3000,30);
INSERT INTO EMPRAT VALUES (7521,'Sala','Venedor',7698,'22/02/1981',16500,6000,30);
INSERT INTO EMPRAT VALUES (7566,'Jimenez','Director',7839,'02/04/1981',38750,NULL,20);
INSERT INTO EMPRAT VALUES (7654,'Martin','Venedor',7698,'29/09/1981',16500,12000,30);
INSERT INTO EMPRAT VALUES (7698,'Negre','Director',7839,'01/05/1981',37500,NULL,30);
INSERT INTO EMPRAT VALUES (7782,'Cerezo','Director',7839,'09/06/1981',31500,NULL,10);
INSERT INTO EMPRAT VALUES (7788,'Gil','Analista',7566,'09/11/1981',30000,NULL,20);
INSERT INTO EMPRAT VALUES (7839,'Rei','President',NULL,'17/11/1981',60000,NULL,10);
INSERT INTO EMPRAT VALUES (7844,'Tovar','Venedor',7698,'08/09/1981',19000,0,30);
INSERT INTO EMPRAT VALUES (7876,'Alonso','Empleat',7788,'23/09/1981',14000,NULL,20);
INSERT INTO EMPRAT VALUES (7900,'Jimeno','Empleat',7698,'03/12/1981',12500,NULL,30);
INSERT INTO EMPRAT VALUES (7902,'Fernandez','Analista',7566,'03/12/1981',39000,NULL,20);
INSERT INTO EMPRAT VALUES (7934,'Muñoz','Empleat',7782,'23/01/1982',19000,NULL,10);

CREATE TABLE NOTES_ALUMNE (
  nomene_alumne VARCHAR2(25) NOT NULL ,
  nota1 number(2),
  nota2 number(2),
  nota3 number(2)
);

INSERT INTO NOTES_ALUMNE VALUES ('Alcalde Garcia, M. Luisa',5,5,5);
INSERT INTO NOTES_ALUMNE VALUES ('Benito Martin, Luis',7,6,8);
INSERT INTO NOTES_ALUMNE VALUES ('Casas Martinez, Manuel',7,5,5);
INSERT INTO NOTES_ALUMNE VALUES ('Corregidor Sanchez, Ana',6,9,8);
INSERT INTO NOTES_ALUMNE VALUES ('Diaz Sanchez, Maria',NULL,NULL,7);

CREATE TABLE LLIBRERIA (
  tema CHAR(15) NOT NULL ,
  prestatge CHAR(1),
  exemplars NUMBER(2)
);

INSERT INTO LLIBRERIA VALUES ('Informatica', 'A',15);
INSERT INTO LLIBRERIA VALUES ('Economia', 'A',10);
INSERT INTO LLIBRERIA VALUES ('Esports', 'B',8);
INSERT INTO LLIBRERIA VALUES ('Filosofia', 'C',7);
INSERT INTO LLIBRERIA VALUES ('Dibuix', 'C',10);
INSERT INTO LLIBRERIA VALUES ('Medicina', 'C',16);
INSERT INTO LLIBRERIA VALUES ('Biologia', 'A',11);
INSERT INTO LLIBRERIA VALUES ('Geologia', 'D',7);
INSERT INTO LLIBRERIA VALUES ('Societat', 'D',9);
INSERT INTO LLIBRERIA VALUES ('Labors', 'B',20);
INSERT INTO LLIBRERIA VALUES ('Jardineria', 'E',6);

CREATE TABLE ALUMNE (
  dni VARCHAR2(10) NOT NULL,
  apenom VARCHAR2(30),
  direc VARCHAR2(30),
  pobla VARCHAR2(15),
  telef VARCHAR2(10)
);

INSERT INTO ALUMNE VALUES ('12344345','Alcalde Garcia, Elena', 'C/Les Matas, 24','Alacant','917766545');
INSERT INTO ALUMNE VALUES ('4448242','Cerrato Vela, Luis', 'C/Mina 28 - 3A', 'Sant Vicent','916566545');
INSERT INTO ALUMNE VALUES ('56882942','Diaz Fernández, Maria', 'C/Luis Vives 25', 'Sant Joan','915577545');

CREATE TABLE ASSIGNATURA (
  cod NUMBER(2) NOT NULL,
  nom VARCHAR2(25)
);

INSERT INTO ASSIGNATURA VALUES (1,'Prog. Leng. Estr.');
INSERT INTO ASSIGNATURA VALUES (2,'Sist. Informaticos');
INSERT INTO ASSIGNATURA VALUES (3,'Analisis');
INSERT INTO ASSIGNATURA VALUES (4,'FOL');
INSERT INTO ASSIGNATURA VALUES (5,'RET');
INSERT INTO ASSIGNATURA VALUES (6,'Entorns Graficos');
INSERT INTO ASSIGNATURA VALUES (7,'Aplic. Entorns 4ªGen');

CREATE TABLE NOTA (
  dni VARCHAR2(10) NOT NULL,
  cod NUMBER(2) NOT NULL,
  nota NUMBER(2)
);

INSERT INTO NOTA VALUES('12344345', 1,6);
INSERT INTO NOTA VALUES('12344345', 2,5);
INSERT INTO NOTA VALUES('12344345', 3,6);
INSERT INTO NOTA VALUES('4448242', 4,6);
INSERT INTO NOTA VALUES('4448242', 5,8);
INSERT INTO NOTA VALUES('4448242', 6,4);
INSERT INTO NOTA VALUES('4448242', 7,5);
INSERT INTO NOTA VALUES('56882942', 4,8);
INSERT INTO NOTA VALUES('56882942', 5,7);
INSERT INTO NOTA VALUES('56882942', 6,8);
INSERT INTO NOTA VALUES('56882942', 7,9);

1-
SELECT EMP_no, OFICI, emprat.DEPT_NO 
FROM emprat INNER JOIN departament ON emprat.dept_no = departament.dept_no
WHERE departament.dnom = 'intel'
ORDER BY emprat.cognom;

2-
SELECT *
FROM emprat
WHERE ofici LIKE '%Analista%'
ORDER BY emp_no;

3-
SELECT *
FROM emprat
WHERE dept_no = 10 AND ofici LIKE '%Analista%'
ORDER BY cognom DESC, emp_no DESC;

4-
SELECT nomene_alumne AS Alumno, (nota1 +nota2 + nota3)/3 AS media
FROM notes_alumne

5-

6-
SELECT cognom
FROM emprat
WHERE dept_no = 10

7-
SELECT cognom
FROM emprat
WHERE cognom LIKE 'P%'

8-
SELECT cognom
FROM emprat
WHERE cognom LIKE '_r%'

9-
SELECT cognom
FROM emprat
WHERE cognom LIKE 'A%o%'

10-
SELECT *
FROM llibreria
WHERE tema LIKE '%Labors%' 

11-
SELECT cognom
FROM emprat
WHERE comision IS NOT NULL 

12- 
SELECT cognom
FROM emprat
WHERE UPPER(ofici) = 'VENEDOR' OR UPPER(ofici) = 'ANALISTA' OR UPPER(ofici) = 'EMPLEAT'

13-
SELECT cognom
FROM emprat
WHERE UPPER(ofici) != 'VENEDOR' AND UPPER(ofici) != 'ANALISTA' AND UPPER(ofici) != 'EMPLEAT'

14- 
SELECT cognom, salari
FROM emprat
WHERE salari NOT BETWEEN 15000 AND 20000

15-
SELECT cognom, salari, dept_no
FROM emprat
WHERE (salari > 20000) AND (dept_no IN (10, 20))

16-
SELECT cognom
FROM emprat
WHERE ofici = (SELECT ofici
                FROM emprat
                WHERE cognom LIKE 'Gil')

17-
SELECT cognom
FROM emprat
WHERE ofici IN (SELECT ofici
                FROM emprat
                WHERE dept_no = 20
                GROUP BY ofici)

18-
SELECT cognom, ofici
FROM emprat
WHERE ofici IN (SELECT ofici
                FROM emprat INNER JOIN departament ON emprat.dept_no = departament.dept_no
                WHERE dnom = 'Vendes'
                GROUP BY ofici) AND dept_no = 20

19-
SELECT cognom, salari
FROM emprat
WHERE ofici = (SELECT ofici
                FROM emprat
                WHERE cognom LIKE 'Gil') 
            AND salari = (SELECT salari
                          FROM emprat
                          WHERE cognom LIKE 'Gil')

20-
SELECT cognom, salari
FROM emprat
WHERE ofici = (SELECT ofici
                FROM emprat
                WHERE cognom LIKE 'Gil') 
            AND salari = (SELECT salari
                          FROM emprat
                          WHERE cognom LIKE 'Gil')

21-
SELECT apenom AS Alumno, assignatura.nom AS Assignatura, nota.nota
FROM (alumne INNER JOIN nota ON nota.dni = alumne.dni) 
INNER JOIN assignatura ON nota.cod = assignatura.cod

22-
SELECT apenom
FROM alumne
WHERE dni IN (SELECT nota.dni
              FROM assignatura INNER JOIN nota ON nota.cod = assignatura.cod
              WHERE nom LIKE 'FOL')

23-
SELECT *
FROM emprat
WHERE cognom LIKE 'A%' AND  UPPER(ofici) LIKE '%E%' 

24-
SELECT cognom, ofici, departament.loc
FROM emprat INNER JOIN departament ON emprat.dept_no = departament.dept_no
WHERE UPPER(ofici) LIKE 'ANALISTA'

25-
SELECT cognom, ofici, salari, data_alt
FROM emprat
WHERE ofici = (SELECT ofici
              FROM emprat
              WHERE cognom LIKE 'Jimenez') AND salari >=
              (SELECT salari
              FROM emprat
              WHERE cognom LIKE 'Fernandez') 

26-
SELECT cognom, ofici, salari
FROM emprat
WHERE dept_no = (SELECT dept_no
              FROM emprat
              WHERE cognom LIKE 'Fernandez') AND salari =
              (SELECT salari
              FROM emprat
              WHERE cognom LIKE 'Fernandez') 

27-
SELECT cognom, ofici
FROM emprat
WHERE ofici = (SELECT ofici
              FROM emprat
              WHERE cognom LIKE 'Jimenez') 

28- 
SELECT *
FROM llibreria
WHERE exemplars BETWEEN 8 AND 15

29-
SELECT *
FROM llibreria
WHERE prestatge NOT BETWEEN 'B' AND 'D'

30-SELECT tema
FROM llibreria
WHERE exemplars <  (SELECT exemplars
                    FROM llibreria
                    WHERE tema LIKE 'Medicina%')

31-
SELECT tema, exemplars
FROM llibreria
WHERE exemplars NOT BETWEEN 15 AND 20

32-

33-
SELECT apenom
FROM alumne INNER JOIN nota ON  alumne.dni = nota.dni
WHERE nota.nota BETWEEN 7 AND 8 AND nota.cod = (SELECT cod
                                                FROM assignatura 
                                                WHERE nom LIKE 'FOL')

34-
SELECT nom
FROM assignatura INNER JOIN nota ON nota.cod = assignatura.cod
WHERE assignatura.cod NOT IN (SELECT cod
                              FROM nota
                              WHERE nota.nota < 5)
                              GROUP BY assignatura.nom

35-
SELECT apenom
FROM alumne INNER JOIN nota ON  alumne.dni = nota.dni
WHERE nota.nota < 5 AND alumne.pobla LIKE 'Alacant'

36-
SELECT apenom
FROM alumne INNER JOIN nota ON nota.dni = alumne.dni
WHERE nota.nota = (SELECT nota
                    FROM alumne INNER JOIN nota ON  alumne.dni = nota.dni
                    WHERE nota.cod = (SELECT cod
                                      FROM assignatura 
                                      WHERE assignatura.nom LIKE 'FOL') 
                                      AND apenom = 'Diaz Fernández, Maria')
GROUP BY alumne.apenom