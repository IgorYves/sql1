��� ������ ���� �� Oracle PL/SQL, ������� �� ���������� ��������� �������� � ���������


SET serveroutput ON

������ 1:

--���� ������� �� ��� ������ � ������ ����� (������� � FOR)
--����� ������ ����� REFCURSOR (��� ������, �� ���� ������ �� ������, ���������� ������ �� ����� ������)
VARIABLE csr REFCURSOR;
BEGIN
  OPEN :csr FOR 'SELECT first_name FROM HR.EMPLOYEES';
END;
/
PRINT :csr

������ 2:

--����� ���������� �������� �� ������� (������� � LOOP)
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

������ 3:

--����� ���������� �������� �� ������� (������� � FOR IN LOOP)
DECLARE
  CURSOR csr_cur IS SELECT * FROM HR.EMPLOYEES;
BEGIN
  FOR csr_rec IN csr_cur LOOP
    DBMS_OUTPUT.PUT_LINE(csr_rec.first_name || ' ' || csr_rec.last_name);
  END LOOP;
END;

������ 4:

--������ 3 � �������� ���������� �������, ������� ������� %rowcount
DECLARE
  CURSOR csr_cur IS SELECT * FROM HR.EMPLOYEES;
BEGIN
  FOR csr_rec IN csr_cur LOOP
    EXIT WHEN csr_cur%rowcount = 3;
    DBMS_OUTPUT.PUT_LINE(csr_rec.first_name || ' ' || csr_rec.last_name);
  END LOOP;
END;

������ 5:

--���������� ������ 3, EXIT WHEN ������� 4 �������� �� �����
BEGIN
  FOR csr_rec IN (SELECT * FROM HR.EMPLOYEES) LOOP
    DBMS_OUTPUT.PUT_LINE(csr_rec.first_name || ' ' || csr_rec.last_name);
  END LOOP;
END;