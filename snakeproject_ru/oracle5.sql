--��������� CASE ����� ��������� ��������� ������ WHEN-THEN � ���� ��� �������� ELSE


--���������:
--CASE
--  WHEN ��������-��������� THEN ���������-���������
--  ELSE ���������-���������
--END

SELECT 
  CASE 
    WHEN 5 > 10 THEN 5
    ELSE 10
  END AS i
FROM dual;

 

--�������������� ����� ������ � ������� CAST
SELECT CAST('01234567890' AS NUMBER(10)) FROM dual;
SELECT CAST(SYSDATE AS VARCHAR2(9)) FROM dual;


--����� ������������ ������� �������������� TO_CHAR ,TO_CLOB, TO_NUMBER, TO_DATE, TO_TIMESTAMP
--�������:
SELECT TO_TIMESTAMP ( '16-SEP-14' ) FROM dual;
SELECT TO_CHAR ( DATE '2014-9-16', 'day' ) "������� ����" FROM dual;


--��������� ������� ��� ������ � ������� ���� VARCHAR2 � CHAR.
--LENGTH � ���������� ����� ������
--LOWER, UPPER � ������ � ������� �������
--INITCAP � ��������� �������� ������ ���� � ������ � ��������� ���������
--RTRIM, LTRIM � ��������� ���������� �������� � ����� ��� � ������ (�� ��������� ��������)
--RPAD, LPAD � "���������" ������ ������ ����������� ��������� ������ ��� ����� (�� ��������� ���������)
--INSTR, SUBSTR � ����� ��������� ��������� � ������


SELECT 
  LENGTH('abcd') AS l, 
  UPPER('abcd') AS u, 
  INITCAP('abCD bDEed') AS i, 
  RTRIM('  1') AS rt, 
  RPAD('1',3,'!') AS rp,
  SUBSTR('111222333',3,5) AS s 
FROM dual;