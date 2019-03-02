Для включения вывода необходимо прописать в начале:
SET serveroutput ON

Пример 1:

--Необязательный блок "declare", в нем мы объявим переменные, конструкция := присваивает значение:
DECLARE 
  a number;
  b VARCHAR(12) NOT NULL := '1st String';
  c constant number := 12;
BEGIN
  a := 0;
  b := q'[2'nd String]';
  --c := 15; Вызовет ошибку т.к. константа неизменяема
  --Процедура "PUT_LINE" из пакета "DBMS_OUTPUT" служит для вывода на экран:
  DBMS_OUTPUT.PUT_LINE('value of a: ' || a || ' value of b: ' || b);
END;

Пример 2:

--Объявим переменную для вывода данных из запроса
DECLARE    
  V_FIRSTNAME VARCHAR2(50);
  --Переменная столбца подстраивающаяся под тип
  X_FIRSTNAME  HR.EMPLOYEES.first_name%TYPE;
BEGIN

  V_FIRSTNAME := 'Lex';
  
  SELECT  first_name
  INTO    X_FIRSTNAME
  FROM    HR.EMPLOYEES
  WHERE   HR.EMPLOYEES.first_name = V_FIRSTNAME;
  
  DBMS_OUTPUT.PUT_LINE('value of X_FIRSTNAME: ' || X_FIRSTNAME);

END;

Пример 3:

--Вывод данных через REFCURSOR (тип данных, по сути ссылка на курсор, возвращает ссылку на набор данных)
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

Пример 4:

VARIABLE X_FIRSTNAME VARCHAR2(10)

DECLARE    
  V_FIRSTNAME VARCHAR2(50);
BEGIN
  V_FIRSTNAME := 'Lex';

  SELECT  first_name
  --Пример обращения в анонимном блоке
  INTO    :X_FIRSTNAME
  FROM    HR.EMPLOYEES
  WHERE   HR.EMPLOYEES.first_name = V_FIRSTNAME;
END;
/
print X_FIRSTNAME

--Аналог блока begin - end
exec :X_FIRSTNAME := 'NewValue'

print X_FIRSTNAME

Пример 5:

VARIABLE X_FIRSTNAME VARCHAR2(10)
--Пример с пользовательской переменной
DEFINE V_FIRSTNAME = 'Lex'

BEGIN
  SELECT  first_name
  INTO    :X_FIRSTNAME
  FROM    HR.EMPLOYEES
  --Пример обращения к данной переменной
  WHERE   HR.EMPLOYEES.first_name = '&V_FIRSTNAME';
  
  DBMS_OUTPUT.PUT_LINE('value of X_FIRSTNAME: ' || :X_FIRSTNAME);
END;