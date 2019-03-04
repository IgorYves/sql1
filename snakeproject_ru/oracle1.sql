��� ��������� ������ ���������� ��������� � ������:
SET serveroutput ON

������ 1:

--�������������� ���� "declare", � ��� �� ������� ����������, ����������� := ����������� ��������:
DECLARE 
  a number;
  b VARCHAR(12) NOT NULL := '1st String';
  c constant number := 12;
BEGIN
  a := 0;
  b := q'[2'nd String]';
  --c := 15; ������� ������ �.�. ��������� �����������
  --��������� "PUT_LINE" �� ������ "DBMS_OUTPUT" ������ ��� ������ �� �����:
  DBMS_OUTPUT.PUT_LINE('value of a: ' || a || ' value of b: ' || b);
END;

������ 2:

--������� ���������� ��� ������ ������ �� �������
DECLARE    
  V_FIRSTNAME VARCHAR2(50);
  --���������� ������� ���������������� ��� ���
  X_FIRSTNAME  HR.EMPLOYEES.first_name%TYPE;
BEGIN

  V_FIRSTNAME := 'Lex';
  
  SELECT  first_name
  INTO    X_FIRSTNAME
  FROM    HR.EMPLOYEES
  WHERE   HR.EMPLOYEES.first_name = V_FIRSTNAME;
  
  DBMS_OUTPUT.PUT_LINE('value of X_FIRSTNAME: ' || X_FIRSTNAME);

END;

������ 3:

--����� ������ ����� REFCURSOR (��� ������, �� ���� ������ �� ������, ���������� ������ �� ����� ������)
VAR csr REFCURSOR;
DECLARE
  V_FIRSTNAME1 VARCHAR2(30):='Lex';
  V_FIRSTNAME2 VARCHAR2(30):='Shanta';
BEGIN
  OPEN :csr FOR '
  SELECT  first_name
  FROM    HR.EMPLOYEES
  WHERE   HR.EMPLOYEES.first_name = '''||V_FIRSTNAME1||''' OR
  HR.EMPLOYEES.first_name = '''||V_FIRSTNAME2||'''
  ';
END;
/
PRINT :csr

������ 4:

VARIABLE X_FIRSTNAME VARCHAR2(10)

DECLARE    
  V_FIRSTNAME VARCHAR2(50);
BEGIN
  V_FIRSTNAME := 'Lex';

  SELECT  first_name
  --������ ��������� � ��������� �����
  INTO    :X_FIRSTNAME
  FROM    HR.EMPLOYEES
  WHERE   HR.EMPLOYEES.first_name = V_FIRSTNAME;
END;
/
print X_FIRSTNAME

--������ ����� begin - end
exec :X_FIRSTNAME := 'NewValue'

print X_FIRSTNAME

������ 5:

VARIABLE X_FIRSTNAME VARCHAR2(10)
--������ � ���������������� ����������
DEFINE V_FIRSTNAME = 'Lex'

BEGIN
  SELECT  first_name
  INTO    :X_FIRSTNAME
  FROM    HR.EMPLOYEES
  --������ ��������� � ������ ����������
  WHERE   HR.EMPLOYEES.first_name = '&V_FIRSTNAME';
  
  DBMS_OUTPUT.PUT_LINE('value of X_FIRSTNAME: ' || :X_FIRSTNAME);
END;