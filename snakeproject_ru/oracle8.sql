����� � Oracle �� ���� �������� �������, ����� � ���� ��������� ��������� �������.


��������� ������:
CREATE OR REPLACE PACKAGE ���_������ {IS AS}
    ��������_��������� |
    ��������_������� |
    ����������_���������� |
    �����������_���� |
    ����������_��������������_�������� |
    ����������_������� |
END [���_������];

���� ������:                                    
CREATE OR REPLACE PACKAGE BODY ���_������ {IS AS}
    ���_�������������_��������� |
    ���_�������������_������� |
END [���_������];

 

�������� �����:
CREATE OR REPLACE PACKAGE my_pkg IS
    PROCEDURE my_proc(per1 IN INT);
    FUNCTION  my_func(per1 IN INT, per2 IN INT) RETURN INT;
END my_pkg;
/

CREATE OR REPLACE PACKAGE BODY my_pkg IS
  PROCEDURE my_proc(per1 IN INT)
  IS
  BEGIN
    DBMS_OUTPUT.enable;
    DBMS_OUTPUT.put_line('per1 + 2 = ' || TO_CHAR(2 + per1));
  END my_proc;
  
  FUNCTION my_func(per1 IN INT, per2 IN INT) RETURN INT
  IS
  BEGIN
    RETURN (per1 * per2);
  END my_func;
END my_pkg;
/


�������:
SET SERVEROUTPUT ON

BEGIN
  my_pkg.my_proc(12);
  my_pkg.my_proc(TO_CHAR(my_pkg.my_func(3,6))); 
END;
/