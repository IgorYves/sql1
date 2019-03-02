--¬ыражение CASE может содержать несколько блоков WHEN-THEN и один или ниодного ELSE


--—интаксис:
--CASE
--  WHEN условное-выражение THEN выражение-результат
--  ELSE выражение-результат
--END

SELECT 
  CASE 
    WHEN 5 > 10 THEN 5
    ELSE 10
  END AS i
FROM dual;

 

--ѕреобразование типов данных с помощью CAST
SELECT CAST('01234567890' AS NUMBER(10)) FROM dual;
SELECT CAST(SYSDATE AS VARCHAR2(9)) FROM dual;


--„асто используемые функции преобразовани€ TO_CHAR ,TO_CLOB, TO_NUMBER, TO_DATE, TO_TIMESTAMP
--ѕримеры:
SELECT TO_TIMESTAMP ( '16-SEP-14' ) FROM dual;
SELECT TO_CHAR ( DATE '2014-9-16', 'day' ) "—егодн€ день" FROM dual;


--—троковые функции дл€ работы с текстом типа VARCHAR2 и CHAR.
--LENGTH Ч вычисление длины строки
--LOWER, UPPER Ч нижний и верхний регистр
--INITCAP Ч повышение регистра первых букв в словах и понижение остальных
--RTRIM, LTRIM Ч обрезание одинаковых символов в конце или в начале (по умолчанию пробелов)
--RPAD, LPAD Ч "добивание" строки текста одинаковыми символами справа или слева (по умолчанию пробелами)
--INSTR, SUBSTR Ч поиск вхождени€ подстроки и замена


SELECT 
  LENGTH('abcd') AS l, 
  UPPER('abcd') AS u, 
  INITCAP('abCD bDEed') AS i, 
  RTRIM('  1') AS rt, 
  RPAD('1',3,'!') AS rp,
  SUBSTR('111222333',3,5) AS s 
FROM dual;