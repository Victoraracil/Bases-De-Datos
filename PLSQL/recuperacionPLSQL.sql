-- NOMBRE: 
CREATE TABLE DEPARTAMENTO (
    dpto NUMBER(2) NOT NULL,
    dname VARCHAR2(14),
    loc VARCHAR2(13),
    CONSTRAINT DEPT_PK PRIMARY KEY (dpto)
);

CREATE TABLE EMPLEADO (
    empno NUMBER(4) NOT NULL,
    ename VARCHAR2(10),
    job VARCHAR2(9),
    mgr NUMBER(4),
    hiredate DATE,
    sal NUMBER(7,2),
    comm NUMBER(7,2),
    dpto NUMBER(2) NOT NULL,
    CONSTRAINT EMP_MGR_FK FOREIGN KEY (mgr) REFERENCES EMPLEADO (empno),
    CONSTRAINT EMP_DPTNO_FK FOREIGN KEY (dpto) REFERENCES DEPARTAMENTO (dpto),
    CONSTRAINT EMP_PK PRIMARY KEY (empno)
);

-- Ejercicio 1 (bloque en PL/SQL )
DECLARE
    v_salario_medio EMPLEADO.sal%TYPE;
BEGIN
    -- Calcular salario medio
    SELECT AVG(sal) INTO v_salario_medio FROM EMPLEADO;

    -- Mostrar salario antes de la subida
    DBMS_OUTPUT.PUT_LINE('Salario medio antes: ' || v_salario_medio);

    -- Incrementar salario
    UPDATE EMPLEADO
    SET sal = sal + (v_salario_medio * 0.10);

    -- Mostrar salario medio actualizado
    SELECT AVG(sal) INTO v_salario_medio FROM EMPLEADO;
    DBMS_OUTPUT.PUT_LINE('Salario medio después: ' || v_salario_medio);
END;
/


-- Ejercicio 2 (función en PL/SQL)
CREATE OR REPLACE FUNCTION diferencia_salario_medio (
    depto1_nombre VARCHAR2,
    depto2_nombre VARCHAR2
) RETURN NUMBER IS
    sal1 NUMBER;
    sal2 NUMBER;
BEGIN
    SELECT AVG(e.sal)
    INTO sal1
    FROM EMPLEADO e
    JOIN DEPARTAMENTO d ON e.dpto = d.dpto
    WHERE d.dname = depto1_nombre;

    SELECT AVG(e.sal)
    INTO sal2
    FROM EMPLEADO e
    JOIN DEPARTAMENTO d ON e.dpto = d.dpto
    WHERE d.dname = depto2_nombre;

    RETURN ABS(sal1 - sal2);
END;
/


-- Ejercicio 3 (procedimiento PL/SQL)
CREATE OR REPLACE PROCEDURE actualizar_salarios_departamento IS
    CURSOR c_departamentos IS
        SELECT dpto FROM DEPARTAMENTO;

    CURSOR c_empleados(p_dpto NUMBER) IS
        SELECT empno, sal
        FROM EMPLEADO
        WHERE dpto = p_dpto;

    v_sal_medio EMPLEADO.sal%TYPE;
BEGIN
    FOR depto_rec IN c_departamentos LOOP
        -- Obtener salario medio del departamento
        SELECT AVG(sal)
        INTO v_sal_medio
        FROM EMPLEADO
        WHERE dpto = depto_rec.dpto;

        -- Recorrer empleados del departamento
        FOR emp_rec IN c_empleados(depto_rec.dpto) LOOP
            IF emp_rec.sal < v_sal_medio THEN
                UPDATE EMPLEADO
                SET sal = v_sal_medio
                WHERE empno = emp_rec.empno;
            END IF;
        END LOOP;
    END LOOP;
END;
/


