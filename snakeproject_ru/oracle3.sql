Это третий каст по Oracle PL/SQL, сегодня мы рассмотрим несколько примеров с курсорами


SET serveroutput ON

Пример 1:

--Этот вариант мы уже видели в первой части (Вариант с FOR)
--Вывод данных через REFCURSOR (тип данных, по сути ссылка на курсор, возвращает ссылку на набор данных)
VARIABLE csr REFCURSOR;
BEGIN
  OPEN :csr FOR 'SELECT first_name FROM HR.EMPLOYEES';
END;
/
PRINT :csr

Пример 2:

--Вывод нескольких столбцов из курсора (Вариант с LOOP)
DECLARE
  CURSOR csr_cur IS SELECT * FROM HR.EMPLOYEES;
  csr_rec csr_cur%rowtype;
BEGIN
  OPEN csr_cur;
  LOOP
    FETCH csr_cur INTO csr_rec;
    EXIT WHEN csr_cur%notfound;
    DBMS_OUTPUT.PUT_LINE(csr_rec.first_name || ' ' || csr_rec.last_name);
  END LOOP;
END;

Пример 3:

--Вывод нескольких столбцов из курсора (Вариант с FOR IN LOOP)
DECLARE
  CURSOR csr_cur IS SELECT * FROM HR.EMPLOYEES;
BEGIN
  FOR csr_rec IN csr_cur LOOP
    DBMS_OUTPUT.PUT_LINE(csr_rec.first_name || ' ' || csr_rec.last_name);
  END LOOP;
END;

Пример 4:

--Пример 3 с условием количества записей, атрибут курсора %rowcount
DECLARE
  CURSOR csr_cur IS SELECT * FROM HR.EMPLOYEES;
BEGIN
  FOR csr_rec IN csr_cur LOOP
    EXIT WHEN csr_cur%rowcount = 3;
    DBMS_OUTPUT.PUT_LINE(csr_rec.first_name || ' ' || csr_rec.last_name);
  END LOOP;
END;

Пример 5:

--Упрощенный пример 3, EXIT WHEN примера 4 работать не будет
BEGIN
  FOR csr_rec IN (SELECT * FROM HR.EMPLOYEES) LOOP
    DBMS_OUTPUT.PUT_LINE(csr_rec.first_name || ' ' || csr_rec.last_name);
  END LOOP;
END;