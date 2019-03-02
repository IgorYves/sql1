���������� ���������� � ������������� �������� � ORACLE, ��� ����� ����.

--DBTIMEZONE - ����, ������������� � ���� ������
--SESSIONTIMEZONE - ���� � ������ ������������
SELECT DBTIMEZONE, SESSIONTIMEZONE FROM dual;

--CURRENT_DATE - ������� ����
--CURRENT_TIMESTAMP - ������� ���� + ����� � �����
--LOCALTIMESTAMP - ������� ���� + ����� ��� ����
SELECT CURRENT_DATE, CURRENT_TIMESTAMP, LOCALTIMESTAMP FROM dual;

--ADD_MONTHS(d, x)
--���������� ����, ���������� � ���������� ����������� ������ ��� ���������� �������. 
--���������� ������� �������� ���������� x, ������� ����� ���� �������������.
SELECT ADD_MONTHS (SYSDATE, -5) d FROM dual;

--LAST_DAY(d) - ���������� ��������� ����� ������
SELECT LAST_DAY (SYSDATE) d FROM dual;

--��������� ������� � ������
SELECT ROUND(to_date('14.08.2014', 'DD/MM/YYYY' )-SYSDATE,0) AS diff FROM dual;

--Truncate (��������) ���� � Oracle
SELECT TRUNC(SYSDATE) FROM dual;
--�������� �� ������:
SELECT TRUNC(SYSDATE,'mi') FROM dual;
--�������� �� ����:
SELECT TRUNC(SYSDATE,'hh') FROM dual;

--ADD_MONTHS ���������\�������� ������
--��������� ���� ������������ ��������
SELECT ADD_MONTHS(TRUNC(SYSDATE),-2) FROM dual;

--������� �����\�����\������ �� ����
SELECT 
  TO_NUMBER(EXTRACT (HOUR FROM a.dt)) hh, 
  TO_NUMBER(EXTRACT (MINUTE FROM a.dt)) mm, 
  TO_NUMBER(EXTRACT (SECOND FROM a.dt)) ss 
FROM (SELECT CAST(SYSDATE AS TIMESTAMP) dt FROM dual) a;


--���������� ���������
--�������� �������� ������� � �������� �������
CREATE TABLE test_regexp (val VARCHAR(30));

INSERT INTO test_regexp VALUES ('abcde');
INSERT INTO test_regexp VALUES ('12345');
INSERT INTO test_regexp VALUES ('1avbn');
INSERT INTO test_regexp VALUES ('1avfk');
INSERT INTO test_regexp VALUES ('123-5');
INSERT INTO test_regexp VALUES ('12.45');
INSERT INTO test_regexp VALUES ('1 3 5');
INSERT INTO test_regexp VALUES ('1  45');
INSERT INTO test_regexp VALUES ('a  b  c  d');
INSERT INTO test_regexp VALUES ('a b  c   d    e');
INSERT INTO test_regexp VALUES ('111.222.3333');
INSERT INTO test_regexp VALUES ('222.333.4444');
INSERT INTO test_regexp VALUES ('333.444.5555');
INSERT INTO test_regexp VALUES ('avfk');

--REGEXP_COUNT ���������� ��� �� ��������� REGEXP ������� � ������
--REGEXP_COUNT(<source_string>, <pattern>[[, <start_position>], [<match_parameter>]])
--� ������ ������� <start_position> �������������� ��������
SELECT REGEXP_COUNT(val, 'av', 2) RES FROM test_regexp;

SELECT REGEXP_COUNT(val, 'av', 1) RES FROM test_regexp;

--REGEXP_INSTR ���������� ����� ������� ������� ��������� REGEXP ������� � ������
--REGEXP_INSTR(<source_string>, <pattern>[[, <start_position>][, <occurrence>][, <return_option>][, <match_parameter>][, <sub_expression>]])
SELECT REGEXP_INSTR(val, '333', 1) RES FROM test_regexp;

--REGEXP_LIKE �������� ������, ������������� ������� ����������� ���������
--REGEXP_LIKE(<source_string>, <pattern>, <match_parameter>)
SELECT * FROM test_regexp WHERE REGEXP_LIKE(val, '333');

--REGEXP_REPLACE �������� ������ ����������� ��������� � ������ �� �������� ��������
--REGEXP_REPLACE(<source_string>, <pattern>,<replace_string>, <position>, <occurrence>, <match_parameter>)
SELECT REGEXP_REPLACE(val, ' ', '') RES FROM test_regexp;

--REGEXP_INSTR ���������� ����� ������� ������� ��������� ������� � ������
--REGEXP_INSTR(<source_string>, <pattern>[[, <start_position>][, <occurrence>][, <return_option>][, <match_parameter>][, <sub_expression>]])
SELECT REGEXP_INSTR(val, '5') RES FROM test_regexp;

--REGEXP_SUBSTR �������� �� ������ �������� ������
--REGEXP_SUBSTR(source_string, pattern[, position [, occurrence[, match_parameter]]])
SELECT REGEXP_SUBSTR(val, '1av') RES FROM test_regexp;

 

������� ���������� ��������� �� ��������� https://ru.wikipedia.org/wiki/%D0%E5%E3%F3%EB%FF%F0%ED%FB%E5_%E2%FB%F0%E0%E6%E5%ED%E8%FF
--���� �������� ������������� ���������� ���������
--������ ������ � 1 ��� 2
SELECT * FROM test_regexp WHERE REGEXP_LIKE(val, '[1-2]');
--����� ������ �� 5
SELECT * FROM test_regexp WHERE REGEXP_LIKE(val, '[$5]');
--� ����������� ������� ��� ���� (� ������ ������� �� ������� "������")
SELECT * FROM test_regexp WHERE REGEXP_LIKE(val, '1 {2}');

 

������� ������ �� ���������� http://psoug.org/reference/regexp
������� ������ �� ������� http://orasource.ru/materialyi-po-pl-sql/ispolzovanie-regulyarnyih-vyirazheniy-regexp-v-oracl.html