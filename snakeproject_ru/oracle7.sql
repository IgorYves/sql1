Попробуем сравнить на первый взгляд два одинаковых значения типа строка

SET serveroutput ON;

DECLARE
  l_variable VARCHAR2 (10) := 'Logic';
  l_fixed    CHAR (10) := 'Logic';
BEGIN

  IF l_variable = l_fixed
  THEN
   DBMS_OUTPUT.put_line ('Equal');
  ELSE
   DBMS_OUTPUT.put_line ('Not Equal');
  END IF;

  IF 'Logic' = 'Logic     '
  THEN
    DBMS_OUTPUT.put_line ('Equal');
  ELSE
    DBMS_OUTPUT.put_line ('Not Equal');
  END IF;

END;
/