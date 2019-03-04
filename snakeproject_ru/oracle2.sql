������ ������� �� Oracle PL/SQL ����� � ���������� ������������


SET serveroutput ON

������ 1:

--������ ����������� IF - ELSE
DECLARE 
  a NUMBER := 5;
BEGIN
  IF a > 5 THEN 
    DBMS_OUTPUT.PUT_LINE('a > 5');
  ELSIF a < 5 THEN 
    DBMS_OUTPUT.PUT_LINE('a < 5');
  ELSE 
    DBMS_OUTPUT.PUT_LINE('a = 5');
  END IF;
END;

������ 2:

--LOOP - ���� ����������� ����������
/*��������� ����� "LOOP"
LOOP
  NULL;
END LOOP
*/
DECLARE
    a NUMBER := 0;
BEGIN
    --1 ������� � ������� �� �����
    LOOP
    a := a + 1;
    IF(a >= 5) THEN a := 0;  EXIT; END IF;
    END LOOP;
  DBMS_OUTPUT.PUT_LINE('LOOP 1 END, a = ' || a);
  --2 ������� � ������� �� �����
    LOOP
    a := a + 1;
    EXIT WHEN (a >= 5);
    END LOOP;
  DBMS_OUTPUT.PUT_LINE('LOOP 2 END, a = ' || a);

END;

������ 3:

--������ � WHILE LOOP
DECLARE
    a NUMBER := 0;
BEGIN

    WHILE (a >= 5) LOOP
        a := a + 1;
    END LOOP;
  DBMS_OUTPUT.PUT_LINE('WHILE LOOP END, a = ' || a);

END;

������ 4:

--������ � ������ FOR
BEGIN
  FOR a IN 0..3 LOOP
    DBMS_OUTPUT.put_line('IN LOOP a = ' || a);        
    END LOOP;
  
    FOR a IN REVERSE 0..3 LOOP
    DBMS_OUTPUT.put_line('IN REVERSE LOOP a = ' || a);        
    END LOOP;
END;