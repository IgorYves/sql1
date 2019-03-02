

����� ������� ����������� �� PostgreSQL � PL/pgSQL


���� ������ ������� �����������: http://snakeproject.ru/


�������� � �������� ����������� - ������� ��� ������ ����


����� ������������ ����� � ��. �����: https://www.postgresql.org/

���� ���� ������� ������������� �� ��: https://postgrespro.ru/


��������������, ��� ����������� PostgreSQL ��� ���������� �� ���������� � ����� ������������, ����������� ���� ��� �� �����.


���� �������� ���� �� ������������ �� ������� ����� ������� PostgresPRO - https://postgrespro.ru/docs


��� ������� � ������� � �� ����� ������������ ����������� ���������� pgAdmin: https://www.pgadmin.org/

��� EMS SQL Manager for PostgreSQL: https://www.sqlmanager.net/products/postgresql/Manager



������ � PostgreSQL


PostgreSQL � ����������� ���� ������ � �������� �������� �����


� ����������� ���� ������ ���������� �������� � ���� ������ � ��������� � ��������


����� ������ PostgreSQL ���������� ������:

1. ������� "POSTMASTER" �� ������� �������� ������ �� �����������

2. ��� �������� ����������� �������� POSTMASTER ������ ���� �����

3. ����� �������������� � ����� ������ ������� ���� ��� ����� �����


����� ���������(��������� �������� ��� ������)


�� Windows ��������������� ����� ������ ����� �������� ��� ��������� ��� ������� �������� � ����������� �� ��������� ����������, �� ����� ��������� ������� � ������� ������ ���� ��������� initdb � pg_ctl, ��� ����� � �������� bin, �������� - D:\Postgres\bin


����� ��������� PostgreSQL ����� ������� ������� ��� ������

� ������ ������ ��� ����� ���, ������� ����� ����������� ����� ����������� �������

���� ��������� PostgreSQL ����� ��������� � �������������� ����� ��� ������, ������� ����������� ���� �� �����, �� ������������� ����� ���� � ��� �� ����� TCP/IP ��� UNIX


����� ��������������� ��������� �������� �������� � �������:

initdb � ������� ����� PostgreSQL �������� ��� ������

���������- initdb [ option �] [ �pgdata | -D ] directory


�������� ����������������� �������� �� ����������� ������ -D :

$ sudo postgres

$ initdb -D /usr/local/pgsql/data


���� ���:

$ sudo postgres

$ pg_ctl -D /usr/local/pgsql/data initdb


����� ����� ����� ����� ����������� ��������� ������ - sudo service postgresql start


���� ���� ��������


��������� postmaster � �������� ������:

$ postmaster � D /usr/local/pgsql/data


������ � ������� ������ � ������� pg_ctl:

$ pg_ctl � D /usr/local/pgsql/data � 1 /tmp/postgresql.log start


������� �������� pg_ctl:


����� �������:

$ pg_ctl start


��������� �������:

$ pg_ctl stop


���������� �������:

$ pg_ctl restart


������ �������:

$ pg_ctl status


������� psql


� ����������� �������� � �������� � ������� postgresql-client ��� ����������������� ���� ������� psql, ������� ��������� �������� �� ����������� (������� ��� Windows � Linux �����)


� Linux - su � postgres, Windows � cmd � psql


psql --help - �������


��������� ��������� �������:

psql -l � ������� ������ ��� ������

psql -d database - ������������ � ���� ������ � ������ �database�

psql -f script.sql - ��������� SQL ������ �script.sql�

psql -d test -H -c "SELECT * FROM students" -o D:\Postgres\f.html � ��������� ������ � ����


����� ������ ���������������� ������:

psql > SELECT name, setting FROM pg_settings WHERE category = 'File Locations';


����� ������ �������� ������:

psql > SELECT * FROM pg_stat_activity;


����� ������:

--������ id �������

SELECT datname as database,

pid,

usename as username,

application_name as application,

client_addr as client_address,

query

FROM pg_stat_activity;


--��������� id ������ � ��

SELECT pg_terminate_backend(id ������)

FROM pg_stat_activity

WHERE datname = '��';


������� pgdump(��������� ����� ����� ����)


������� � pg_dump �help


���������: pg_dump ?Fc "���� ������" > "�����"

������: pg_dump -Fc "test" > "D:\Postgres\testBackup.sql"


������ ������ ������ ��� ������������ ������� "table_test":

pg_dump -a -t table_test -f file_test.sql database_test


��������� �����:

-h host - ����� �����

-p port - ���� ����� (�� ��������� 5432)

-u - �����

-a, --data-only - ���� ������ ��� �����

-s, --schema-only - ���� ������ �����

-C, --create - ������� ������� �������� ���� ������

-c - ������� ������� �������� (drop) ��������

-t, --table=TABLE - ������������ ������� ��� �������� �����


������� pgdumpall(��������� ����� ���� ���)


pg_dumpall > bases.sql


������� psql � pgrestore(�������������� ��������� �����)


psql - ����������� ������ �� ��������� ����� ���� plain text

pg_restore - ����������� ������ �� ������� ���� tar


�������������� ����� ������ � �������������� ������:

psql -h localhost -U Login -d DBName -f backup.sql


�������������� �� ������:

pg_restore -C -d postgres db.dump


-C ��� --create

������� ���� ������, ������ ��� ��������������� ������.

���� ����� ������ �������� --clean, ������� � ����������� ������� ���� ������ ����� ������������ � ���.

��� ������ ����������������� � ���� ������, ��� ������� �������� � ������.



� ���������������� ������


postmaster.opts � �������� ������ ������� � ����������� ��� ���� PostgreSQL

�������� ���: D:/Postgres/bin/postgres.exe "-D" "D:\Postgres\data"
���� ���� - �D:\Postgres\data� ����� � ���������� $PGDATA


pg_hba.conf � �������� �� ������ �������������(��������� ������������� ��� ���������� ������� initdb)

�� ��������� PostgreSQL ��������� ������������ ���������� ������������ � ����������� ��������� �� � ��������������� ������ �������, ���� ����� ���� ������ ����������


��� ����������� � ���� ������ �� ���� ���������� ��������� listen_addresses � postgresql.conf


���� ��������


������ ���� �������� �� ���������� ������ � ����� �� �� ������:

host all all 127.0.0.1/32 md5


������ � ���� test ������ mike � ������ 1.1.1.1 �� �������:

host test mike 1.1.1.1/32 trust


postgresql.conf � �������� �� ��������� �������


��� ����� ������� ���������������, ����� �����������:

listen_addresses - �������������� �����

port - �������������� ����

max_connections - ����������� ����������

superuser_reserved_connections - ���������������� ���������� ��� �����������������


���� ������ �������� � ���������� �pg_log�


�������� ����������� ��������:

logging_collector = on


����� �������� �����:

log_destination = 'stderr'


������� ������� �����:

log_rotation_age = 1d


������ ������� �����:

log_rotation_size = 10MB


������ ����� �����:

log_filename = 'postgresql-%Y-%m-%d_%H%M%S.log'


���������� ����������� �����:

log_truncate_on_rotation = on


���������� �������


���������� ���������� � Linux � ��������� � 3 �������

watch -n 3 'ps auxww | grep ^postgres'


���� �������� �������� �� �����, ��� ������� ������������ ��������� ���� ��������� POSTMASTER, ����� ������� ���-�� ���� postgres: "������������" "����" "����" "������":

������������ ������� - /usr/bin/postmaster -p 5432 -D /var/lib/pgsql/data

������� ������������ - postgres: postgres mike 127.0.0.1(37047) idle


���� ������ � ������� ����������


�� ��������� ��������� �� postgres, template0 � template1

� �� postgres ������ ���-���� �� �������������, ������������ ����� PostgreSQL

� �� template0 ������������� ������ ���-���� ������

� �� template1 ����������� ������� ���������


������ �������\�������\blob �.�. �������� ��� ���� ��� ��������� ������ � �������� ��


����������, ��� �������� �� � psql - show data_directory;


���� � PostgreSQL ����� ID ������ ����� ���:

SELECT oid from pg_database WHERE datname = 'test';


��� ����� � ���� ����� �� ����� � ����� data/base � ������������� ����


ID ������� ����� ����� ���(������������ � ����� �� psql -d test):

SELECT relname, relfilenode FROM pg_class WHERE relname = 'students';


��� ����� ��� ����� ������ ����� ������ �������� ����


� WIndows $PGDATA �� ��������� ��������� � ������� "data" ��������� ��� ��������� ��� ������������� �������� � ������ ��������� � postmaster.opts


pg_xlog


� postgresql.conf �� ������ ����� �������� �������� - max_wal_size


���� - $PGDATA/pg_xlog (� Windows ��� PostgresPRO ����� � D:\Postgres\data\pg_wal)


�� ���������� ���������� PostgreSQL ���������� ������ � ������ ���������� WAL - Write-ahead log, � ��� ����� � ���� ���� ������


���� ����� �������� ���� - '0000000100000000000000A2', ������� �������� ������ ������ ��������� ����������. ��� ������� ����� ������������ ��� �������� ����������


������ �������\���������� ��� ������, �������� �������� � ���������������� ����������� ���� ������


������� ����� ���������� ��� ������������� ���������� � ������� SLAVE ��� ����������� ����������


pg_clog


���� - $PGDATA/pg_clog �������� ������� ���������� ����������, ���������� ���������� � ����������\������������ ����������

������ �����-�� ����������, �� �� � ���� ������ ������� ����� ������ ������, ��� ��� ������������ ���� ������ �� ������


�� SQL



�������� ������ �������� ������ SQL


� PostgreSQL �������������� ��� �������� �������\��������� ����� SQL


���� ��������� ������� � ������� ��������� ����������:




����� � ���� (DCL � Data Control Language)



����� ��������� ��� ������ ������������ postgres � ��������� �������


��������� (��� Linux: sudo su � postgres)


���� PostgreSQL ��������� �������� ��� ������ �����

���������� ���� - ����� � psql - ������� \du


����� ���-�� �������:

List of roles

Role name | Attributes | Member of

-----------+------------------------------------------------+-----------

postgres | Superuser, Create role, Create DB, Replication | {}


��� Windows �� ����� ���������� ����������� ��������� ���������� ���������, ���������� ����� ���� �������:

chcp 1251


�������� ���� ������:

CREATE DATABASE test;


������� ����� ����:

CREATE ROLE test_role;


������� ���� ����� ���:

DROP ROLE test_role;


���������� ����� ��� �������� ���� ����� ���:

\h CREATE ROLE


������ � ������ - �����, ��������� � �����, ����� ����� ���������� ����������:

CREATE ROLE test_role WITH LOGIN;



������� ������ ������������ ����� � ������� �������:

CREATE USER test_user;

�������� ��������, ��� ������ � ������������� ��������� ���� test_user � ����������� ����������


������ ������ ������������:

\password test_user


��� � ������� sql:

CREATE USER test_user WITH password 'password';


�������� ������������:

DROP USER IF EXISTS test_user;


�������� ������������ ���� ����� ��� - GRANT test TO test_user;


������ ������� ������������ test_user ����� �� ���� test � ������� ����:

������ � ���� - \c test


���� ��� ���������� ����:

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO GROUP test_user;


��� ������ ����������:

GRANT SELECT, UPDATE, INSERT ON ALL TABLES IN SCHEMA public TO test_user;


������� - \q


��������� ����� ��� ������������� - psql -U test_user -d test -h 127.0.0.1 -W


�������� ������, ��������: select * from students


������� ���������� ���� ����� ���:

REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public FROM GROUP test_user;


�� �������� � ����� �������������:

\c test

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO test_user;

REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public FROM test_user;


������� ���������� ��, ��������� �������� �� ����������� �� ������ �� ����� � ������� ������:

ALTER DATABASE test OWNER TO test_user;

GRANT TEMP ON DATABASE test TO test_user WITH GRANT OPTION;

GRANT CREATE ON DATABASE test TO test_user WITH GRANT OPTION;

GRANT CONNECT ON DATABASE test TO test_user;


����� ��� ����� (��������\�������������\��������) ��������� ����� ���:

ALTER SCHEMA public OWNER TO test_user;

GRANT USAGE ON SCHEMA public TO test_user;

GRANT CREATE ON SCHEMA public TO test_user;

������ ������������� �������� � ��������� �������:

SELECT * FROM pg_shadow;



���� ������



�������������� ��������� ��������� � ������� ����:

��������:: ���

CAST (�������� AS ���)


�������:

SELECT pg_typeof( CAST ('50' AS INTEGER) );

SELECT pg_typeof( '50'::INTEGER );


SELECT pg_typeof( CAST (50 AS VARCHAR) );

SELECT pg_typeof( 50::VARCHAR );


� PostrgreSQL ���� �������� ������� ����� �� ����� ������


�������� ����� � ���� ����� SQL


������������ � ���� ������ ����� PostgreSQL


��������� ���� ������ ����� ��������


��� �������� ���� �� ������ �� ����� ���������� ��������



� ��������� ���� ��� ������ ��� �������� ��������� � ������ ����� ������� ����


����� ���������� ����������� ���� � ������� CREATE TYPE



��������� ������� ����� ������ c ���������:




DDL - data definition language (���� �������� ������)



--������ �������� �������:

CREATE TABLE Table1

( id INTEGER,

name CHAR(25) );



--���������� �������

ALTER TABLE Table1 ADD lastname VARCHAR(30) NOT NULL;

--���������� ������� � ������������ ������������

ALTER TABLE Table1 ADD address VARCHAR(50) NOT NULL CONSTRAINT address_unique UNIQUE;


--�������� �����������

ALTER TABLE Table1 DROP CONSTRAINT address_unique;


--�������������� ������� � ��������� ���� ������

ALTER TABLE Table1 ALTER COLUMN lastname TYPE CHAR(20);


--�������� �������

ALTER TABLE Table1 DROP COLUMN address ;


--������ �������� ������������� �������:

CREATE INDEX Tname ON Table1 (name);


--������ �������� ����������� �������:

CREATE UNIQUE INDEX Tid ON Table1 (id);


--�������� �������:

DROP INDEX Tid;


-- �������� �������

DROP TABLE Table1


--�������� ������� � ��������� ������(������� ���������� ����� ��� ����� ������):

CREATE TABLE Table1

( id INTEGER,

name CHAR(25),

PRIMARY KEY (id));


--�������� ������ � ���������� ������� � �������(�����������):

CREATE TABLE firsttable

( ID INT NOT NULL PRIMARY KEY,

name VARCHAR (50) NULL,

lastname VARCHAR (100) NULL );


CREATE TABLE secondtable

( ID INT NOT NULL PRIMARY KEY,

sname VARCHAR (50) NULL,

slastname VARCHAR (100) NULL,

mainID INT NOT NULL,

CONSTRAINT FK_ToFirsttable FOREIGN KEY (mainID)

REFERENCES firsttable (ID) );


--������� ���������(�����):

ALTER TABLE secondtable DROP CONSTRAINT FK_ToFirsttable;


--������ ���������(�����) ����� �����, �� �������� � ���������� ��������:

ALTER TABLE secondtable ADD CONSTRAINT FK_ToFirsttable FOREIGN KEY (mainID) REFERENCES firsttable (ID);



DML - ���� ��������������� �������


--������� ������ � �������

INSERT INTO firsttable(ID,name, lastname)

VALUES ('1','name1', 'lastname1');

INSERT INTO firsttable(ID,name, lastname)

VALUES ('2','name2', 'lastname2');

INSERT INTO firsttable(ID,name, lastname)

VALUES ('3','name3', 'lastname3');

INSERT INTO secondtable(ID,sname, slastname,mainID)

VALUES ('1','name1', 'lastname1','1');

INSERT INTO secondtable(ID,sname, slastname,mainID)

VALUES ('2','name2', 'lastname2','2');

INSERT INTO secondtable(ID,sname, slastname,mainID)

VALUES ('3','name3', 'lastname3','3');


--������ ������

DELETE FROM secondtable WHERE ID = 3;


--������� ������

UPDATE firsttable SET name = 'name3_New' WHERE ID = 3;


--������� ��������� �������:

TRUNCATE TABLE firsttable, secondtable;



�������� SELECT


--����������� SELECT:

--1 - SELECT (DISTINCT LIMIT)

--2 - FROM

--3 - WHERE

--4 - GROUP BY

--5 - HAVING

--6 - ORDER BY


--������������������ ���������� ��������� SELECT

--1 - FROM

--2 - WHERE

--3 - GROUP BY

--4 - HAVING

--5 - SELECT (DISTINCT LIMIT)

--6 - ORDER BY


--(DISTINCT LIMIT) ���������� ��� ����������� ������ ���������� �������

--FROM ��������� ���� ������� (�������� �������)

--WHERE ��������� ������� ������

--GROUP BY ���������� ���� ��� �����������

--ORDER BY ���������� ���� ��� ����������, ASC - �� �����������,DESC - �� ��������


��� �������� ������ ������� ������ � ��� ������� �� ���������� ����� DDL:


TRUNCATE TABLE firsttable, secondtable;


INSERT INTO firsttable(ID,name, lastname)

VALUES ('1','name1', 'lastname1');

INSERT INTO firsttable(ID,name, lastname)

VALUES ('2','name2', 'lastname2');

INSERT INTO firsttable(ID,name, lastname)

VALUES ('3','name3', 'lastname3');

INSERT INTO firsttable(ID,name, lastname)

VALUES ('4','name4', 'lastname4');

INSERT INTO firsttable(ID,name, lastname)

VALUES ('5','name5', 'lastname5');

INSERT INTO firsttable(ID,name, lastname)

VALUES ('6','name6', 'lastname6');

INSERT INTO secondtable(ID,sname, slastname,mainID)

VALUES ('1','name1', 'lastname1','1');

INSERT INTO secondtable(ID,sname, slastname,mainID)

VALUES ('2','name2', 'lastname2','2');

INSERT INTO secondtable(ID,sname, slastname,mainID)

VALUES ('3','name3', 'lastname3','3');

INSERT INTO secondtable(ID,sname, slastname,mainID)

VALUES ('4','name3_2', 'lastname3_2','3');

INSERT INTO secondtable(ID,sname, slastname,mainID)

VALUES ('5','name3_2_3', 'lastname3_2_3','3');

INSERT INTO secondtable(ID,sname, slastname,mainID)

VALUES ('6','name1_2_New', 'lastname3_2_New','3');

INSERT INTO secondtable(ID,sname, slastname,mainID)

VALUES ('7','name3', NULL,'3');


--������ ������� (��� �������)

SELECT 1, 25 - 7, 'Test' AS word;


--������������ ����� ������� � ������

SELECT * FROM firsttable limit 2;


--����� ���������� ��������

SELECT DISTINCT mainid FROM secondtable;


--����� � ��������

SELECT * FROM firsttable WHERE id > 1 AND id < 4;


--����� � ����������� �� �������

SELECT * FROM firsttable ORDER BY id DESC;


--����� � ������������ �� �������� (� ������ ������� ������� COUNT - ������� ������, � �� ������������ �������)

SELECT mainid, COUNT(*) FROM secondtable GROUP BY mainid;


--����� � ������������ �� �������� � HAVING - ������� ��� �����������

SELECT mainid, COUNT(*) FROM secondtable GROUP BY mainid HAVING mainid IN (2,3);


--����� � ��������� �� "������"\"��������" �������� NULL\NOT NULL

SELECT * FROM secondtable WHERE slastname IS NULL;

SELECT * FROM secondtable WHERE slastname IS NOT NULL;


--����������

SELECT f.name, (SELECT s.slastname FROM secondtable AS s WHERE f.id = s.mainid limit 1) AS slastname FROM firsttable as f;


������ �������, ��� �������� � ������ � ������ ������ ������, ������, XML, ���������, ���������� ��������� � ���, ��� ������ ����� ������������ ��� ������������� � ��������:

https://postgrespro.ru/docs/postgrespro/10/functions

� ���� ����� �������� �� �������� �������� ������� ���������� �������� �� PostgresPRO, ������ ����������� ������� ������ �� �������\������� � �. �. � ���� ����������� ���, ����� �� ��������� �� ��������� ������������.


� ������� ���������� ������� � ����������, ���������, ����������������� � ���������������.


���������� � JOIN


������� �� ���������� ������ � ����������� �� ���������


--���������� ���������� (����� ����������� id - mainid)

SELECT

A.id AS "id from firsttable"

,B.mainid AS "mainid from secondtable"

,A.name AS "name from firsttable"

,B.slastname AS "slastname from secondtable"

FROM

firsttable AS A INNER JOIN secondtable AS B

ON A.id = B.mainid;


--���������� �� ���� ��������� ����� �������

SELECT

A.id AS "id from firsttable"

,B.mainid AS "mainid from secondtable"

,A.name AS "name from firsttable"

,B.slastname AS "slastname from secondtable"

FROM

firsttable AS A LEFT JOIN secondtable AS B

ON A.id = B.mainid;




--���������� �� ���� ��������� ������ �������

SELECT

A.id AS "id from firsttable"

,B.mainid AS "mainid from secondtable"

,A.name AS "name from firsttable"

,B.slastname AS "slastname from secondtable"

FROM

firsttable AS A RIGHT JOIN secondtable AS B

ON A.id = B.mainid;

--������ ����������

SELECT

A.id AS "id from firsttable"

,B.mainid AS "mainid from secondtable"

,A.name AS "name from firsttable"

,B.slastname AS "slastname from secondtable"

FROM

firsttable AS A FULL JOIN secondtable AS B

ON A.id = B.mainid;

--������������ ����������

SELECT

A.id AS "id from firsttable"

,B.mainid AS "mainid from secondtable"

,A.name AS "name from firsttable"

,B.slastname AS "slastname from secondtable"

FROM

firsttable AS A CROSS JOIN secondtable AS B;


--���������� � ��������

SELECT

A.id AS "id from firsttable"

,B.mainid AS "mainid from secondtable"

,A.name AS "name from firsttable"

,B.slastname AS "slastname from secondtable"

FROM

firsttable AS A INNER JOIN secondtable AS B

ON A.id = B.mainid

WHERE A.name <> 'lastname3' and B.slastname <> 'lastname3';


Sequence - ������������������


������������������ ��� sequence � PostgreSQL - ������ ��, ������������ ������������� ��������������� �����


INSERT INTO public.firsttable(name, lastname) VALUES('name_sequence1','lastname_sequence1');

������ ��-�� ���������� �����, ��� ���������� ��������� ����

������: ������� �������� � ������� "id" �������� ����������� NOT NULL

DETAIL: ��������� ������ �������� (null, name_sequence1, lastname_sequence1).


--�������� �������������

CREATE SEQUENCE firsttable_sec_id_seq

INCREMENT BY 1

NO MAXVALUE

MINVALUE 0;


--�������� ������� � �������������������

CREATE TABLE public.firsttable_sec (

id integer DEFAULT nextval('firsttable_sec_id_seq') NOT NULL,

name VARCHAR(50) NULL,

lastname VARCHAR(100) NULL

);

INSERT INTO public.firsttable_sec(name, lastname) VALUES('name_sequence1','lastname_sequence1');

INSERT INTO public.firsttable_sec(name, lastname) VALUES('name_sequence2','lastname_sequence2');

SELECT * FROM public.firsttable_sec;


--���������� ������������������ ��� ������� ������������ �������

ALTER TABLE public.firsttable ALTER COLUMN id SET DEFAULT nextval('firsttable_sec_id_seq');


--������������������ ��������, �������� ���� ��� ���� ������ �� ������������ ������������������

SELECT setval('firsttable_sec_id_seq', (SELECT max(id) FROM public.firsttable));


--������ �� ������� ������

INSERT INTO public.firsttable(name, lastname) VALUES('name_sequence1','lastname_sequence1');


--�������� ������������������

ALTER TABLE public.firsttable ALTER COLUMN id DROP DEFAULT;


�������� �������



�������� ��������� � PostgreSQL ��� ������� �����������, �� �������� �������� �������


��������� �������� �������������� ���:

CREATE [OR REPLACE] FUNCTION ���_������� (���������_�������)

RETURNS return_datatype AS $variable_name$

DECLARE

declaration;

[...]

BEGIN

< ����_������� >

[...]

RETURN { variable_name | value }

END; LANGUAGE { plpgsql, sql, C };


���_������� - ��� ����������� �������

����_������� - ����������� ��� � ����� �������

���������_������� - �������������, ����� �������������� ����������� ���������

�������������� ����� [OR REPLACE] ��������� �������� ��� ������������ �������

RETURN - ������������ ������������ ��������

�������� ����� AS ��������� �� �������� ���������� �������

plpgsql, C ��� sql - �������� ����� ��� �������


����� ������� � ��������� ����������� ������ ���������� ��������� ��������, ���������� ������� RETURNS SETOF

����� �������� ���������� ���������, ������������ RETURNS SETOF record

����� ������ ����, ������������ RETURNS SETOF ���������_���


�������� ����� IMMUTABLE | STABLE | VOLATILE (������������ �� ���������, ���� ���� �� �������) - ����������� ����������� �������� � ��������� �������


IMMUTABLE (����������) - �������, ��� ������� �� ����� �������������� ���� ������ � ������ ���������� ���� � ��� �� ��������� ��� ����������� ��������� ����������

�� ����, ��� �� ���������� � ���� ������ � �� ���������� ����������, �� ���������� �� ���� � ������ ����������

���� ������� ����� ����� ��������������, ����� � ����� � �����������-����������� ����� ���������� �������� ��������� �������


STABLE (����������) - �������, ��� ������� �� ����� �������������� �� � � ������ ������ ������������ ������� ������ ���������� ���� � ��� �� ��������� ��� ����������� �������� ����������

���� ��������� ����� ���� ������ � ������ ���������� SQL

��� ���������� ����� ��� �������, ���������� ������� ������� �� ����������� ���� ������ � ������������� ���������� (��������, �������� �������� �����)

�� ���� ������� �� �������� ��� ��������� AFTER, �������� ��������� ������, ��������� ������� ��������

����� ��������, ��� ������� ��������� current_timestamp ����� ��������� �����������, ��� ��� �� ���������� �� �������� ������ ����������


VOLATILE (����������) - �������, ��� ��������� ������� ����� �������� ���� � ������ ������ ������������ �������, ��� ��� � ������ ������ ��������������

��������� � ���� ������ ������������ �������� ������� ��� ������, ��������: random(), currval() � timeofday()

�� ��������, ��� ����� ������� � ��������� ��������� ������ ���� ���������������� ��� ����������, ���� ���� � ��������� ������ �����������, ����� � ������ �� ���� ���������������

������ ����� �������: setval()


--������� �� ������ ����� SQL, ������� - SETOF

CREATE OR REPLACE FUNCTION sel_name_from_firsttable()

RETURNS SETOF record AS '

SELECT id, name FROM firsttable;

' LANGUAGE sql;


--����� ������� � ������� � ���� �������

SELECT sel_name_from_firsttable();


--����� ������� � ������� � ������ �������

select a, b from sel_name_from_firsttable() f(a int, b varchar(50));


--������� �������

DROP FUNCTION sel_name_from_firsttable();



$$ - ������� ������������, ���������, ��� ����� ���� ����� ����� �� �����-�� �����, � ������ ���� ������ - LANGUAGE sql


�.�. � ������� ���� ��� ������� �� ������ SQL


--������� �� ������ ����� SQL � ���������, ������������ ���������

CREATE FUNCTION sel_name_from_firsttable()

RETURNS TABLE(id int, name varchar(50)) AS $$

SELECT id, name FROM firsttable;

$$ LANGUAGE sql;


--����� �������

SELECT * FROM sel_name_from_firsttable();



--������� �� plpgsql � ������������ �������� ���������� � ������������ �����������

CREATE FUNCTION count_sum(foo1 integer, foo2 integer)

RETURNS integer AS $total$

DECLARE

total integer;

BEGIN

SELECT foo1 + foo2 INTO total;

RETURN total;

END;

$total$ LANGUAGE plpgsql;


SELECT count_sum(2, 5);


--������ ������� ��� �������� ����������(������� �������� ���������), �������� �������� ����� void, � ���������� ������, ���� ������ ����� ���������� ��� - https://postgrespro.ru/docs/postgrespro/10/errcodes-appendix :


CREATE OR REPLACE FUNCTION public.func_ins (

foo_id integer,

foo_name varchar,

foo_lastname varchar

)

RETURNS void AS'

BEGIN

INSERT INTO firsttable(id, name, lastname) VALUES (foo_id, foo_name, foo_lastname);

EXCEPTION

WHEN others THEN

RAISE NOTICE ''���������� �������� ������! SQLSTATE: %'', SQLSTATE;

RAISE;

END;

'LANGUAGE 'plpgsql'

VOLATILE

CALLED ON NULL INPUT;


--��������� ������, ���������� ������ �� ������������ �� ������ ������

SELECT func_ins(7, 'name7', 'lastname7');

SELECT func_ins(7, 'name7', 'lastname7');

���������: ���������� �������� ������! SQLSTATE: 23505

������: ������������� �������� ����� �������� ����������� ������������ "firsttable_pkey"

DETAIL: ���� "(id)=(7)" ��� ����������.

CONTEXT: SQL-��������: "INSERT INTO firsttable(id, name, lastname) VALUES (foo_id, foo_name, foo_lastname)"

������� PL/pgSQL func_ins(integer,character varying,character varying), ������ 3, �������� SQL-��������





����������


���������� ������������ �������� ������


--�������� ����������

BEGIN;

UPDATE firsttable SET name = 'name1New1' WHERE name = 'name1';

--������ ����� ���������� ���������

SAVEPOINT Your_savepoint;

UPDATE firsttable SET name = 'name1New2' WHERE name = 'name1';

--���������� ��������� �� ����� ���������� ���������

ROLLBACK TO Your_savepoint;

--��������� ����������

COMMIT;


�������������


--������� �������������

CREATE VIEW v_ft(v_name, v_lastname)

AS SELECT '���: ' || name, '�������: ' || lastname FROM firsttable;


--��������� �������������

CREATE OR REPLACE VIEW v_ft(v_name, v_lastname)

AS SELECT '��� ��������: ' || name, '������� ��������: ' || lastname FROM firsttable;


--������� �� �������������

SELECT * FROM v_ft;


--�������� �������������

DROP VIEW v_ft;


��������


����� ���������:

CREATE TRIGGER ��������_��������

{ BEFORE | AFTER } { ������� [ OR ������� ] } ON �������

FOR EACH { ROW | STATEMENT }

EXECUTE PROCEDURE ������� ( ��������� )


{ BEFORE | AFTER } - ���������� ���� �� ��� ����� ���������� ����� ��������


{ ������� [ OR ������� ] } - ��� �������������� �� ��������: INSERT\UPDATE\DELETE


ON - �������, �� ������� ����� ������� �������


FOR EACH { ROW | STATEMENT } - ROW - ������� ���������� ��� ������ �������������� ������, STATEMENT - ���� ���


EXECUTE PROCEDURE ������� ( ��������� ) - ��� ���������� ������� � �� ���������


--�������, � ������� ����� ������ ��������� ������ �� ���������� ���������

CREATE TABLE firsttable_old

( ID INT NULL,

name VARCHAR (50) NULL,

lastname VARCHAR (100) NULL );



--�������� ���������� �������

CREATE OR REPLACE FUNCTION firsttable_delete_trigger_del() RETURNS trigger AS '

BEGIN

if (select count(*) from firsttable a where id = OLD.id) > 0

then insert into firsttable_old(id,name,lastname) VALUES(OLD.id,OLD.name,OLD.lastname);

end if;

return OLD;

END;

' LANGUAGE plpgsql;



-- �������� ��������

CREATE TRIGGER firsttable_delete_trigger

BEFORE DELETE ON firsttable FOR EACH ROW

EXECUTE PROCEDURE firsttable_delete_trigger_del();


--�������� ������ ��������

DELETE FROM firsttable WHERE id=6;

SELECT * FROM firsttable_old;


PL/pgSQL ( Procedural Language/PostGres Structured Query Language ) � ����������� ���������� ����� SQL


����� ����������� ����������� (�������\�������\�������), ���������� �� PL/pgSQL, �������� ���:


[ <<�����>> ] - ��� �������� ����� ���� DO $$

[ DECLARE

���������� ���������� ]

BEGIN

���� ���������

END [ ����� ]; - ��� �������� ����� ���� END $$;


--������� ������ ��������� �������

DO $$

DECLARE foo1 VARCHAR(50) = 'name_1_plpg'; foo2 VARCHAR(50) = 'name_2_plpg';

BEGIN

--������ �����������

/*

������

��������������

�����������

*/

--���������� �������� ����������

foo1 := 'name_1_plpg:=';

UPDATE firsttable SET name = foo1 WHERE id = 1;

UPDATE firsttable SET name = foo2 WHERE id = 2;

END

$$ LANGUAGE plpgsql;


--������ �������� ������������ ����� PL/pgSQL

DO $$

DECLARE

--���������� ����������

foo1 int := 1;

foo2 int := 2;

--����������� ������ ��� ���������

f1 ALIAS FOR foo1;

--���������� ��������� (������������ ����������)

const1 CONSTANT int := 3;

--���������� ���� ROWTYPE (���������� ����, �������� ����� ���� ��������� ������ ������� SELECT)

--�������� ���: SELECT * INTO row_data FROM public.firsttable_old WHERE if < 3 ;

row_data public.firsttable_old%ROWTYPE;

--���������� ���� TYPE (��� ���������� �������)

column_name_data public.firsttable_old.name%TYPE;

BEGIN

--���������� ���������� �������� �� ������� � ������� ��������� ����� INTO

SELECT INTO foo1 MAX(id) FROM public.firsttable_old;

SELECT INTO foo1, foo2 MIN(id), MAX(id) FROM public.firsttable_old;

INSERT INTO public.firsttable_old(id, name) VALUES(f1, 'Name_For_Alias_Min');

INSERT INTO public.firsttable_old(id, name) VALUES(foo2, 'Name_Not_Alias_Max');

--����������� IF THEN - �������� �������

IF const1 = 3 THEN

INSERT INTO public.firsttable_old(id, name) VALUES(const1, 'Name_Not_Alias_Const_IN_IF_3');

ELSEIF const1 = 5 THEN

INSERT INTO public.firsttable_old(id, name) VALUES(const1, 'Name_Not_Alias_Const_IN_IF_5');

ELSE

INSERT INTO public.firsttable_old(id, name) VALUES(const1, 'Name_Not_Alias_Const_IN_IF_ELSE');

END IF;

f1 := 1;

foo2 := 3;

--���� � �������� ������

LOOP

f1 := f1 + f1;

INSERT INTO public.firsttable_old(id, name) VALUES(f1, 'Name_For_Alias_LOOP');

EXIT WHEN f1 > foo2;

END LOOP;

f1 := 1;

foo2 := 3;

--���� WHILE � ��������

WHILE f1 < foo2 LOOP

f1 := f1 + f1;

INSERT INTO public.firsttable_old(id, name) VALUES(f1, 'Name_For_Alias_WHILE');

END LOOP;

--���� FOR (������� ��������)

FOR i IN 1..3 LOOP

INSERT INTO public.firsttable_old(id, name) VALUES(i, 'Name_For_i');

END LOOP;

--���� FOR (������� ��������) �� ������� � ���������� � ����������� ���� ROWTYPE

FOR row_data IN SELECT * FROM public.firsttable_old WHERE name = 'Name_For_i' LOOP

column_name_data := row_data.name;

INSERT INTO public.firsttable_old(id, name) VALUES(row_data.id, column_name_data || '_FOR');

END LOOP;

END

$$ LANGUAGE plpgsql;


--��������� ��������� �������� ���������� �������� ������� � ��������� � ���:


�� plpgsql:

CREATE OR REPLACE FUNCTION public.temp_func_ft()

RETURNS TABLE ( _id int, _name varchar, _lastname varchar )

AS $$

BEGIN

RETURN QUERY

SELECT id, name, lastname FROM public.firsttable;

END;

$$ LANGUAGE plpgsql;


SELECT _id, _name, _lastname FROM public.temp_func_ft();


�� plpgsql � ������������ ������� ��������:

CREATE OR REPLACE FUNCTION public.temp_func_ft_col()

RETURNS TABLE ( id int, name varchar, lastname varchar )

AS $$

BEGIN

RETURN QUERY

SELECT ft.id, ft.name, ft.lastname FROM public.firsttable AS ft;

END;

$$ LANGUAGE plpgsql;


SELECT id, name, lastname FROM public.temp_func_ft_col();


�� sql - SETOF record:

CREATE OR REPLACE FUNCTION public.temp_func_ft_rec()

RETURNS SETOF record

AS $$

SELECT id, name, lastname FROM public.firsttable;

$$ LANGUAGE 'sql';


SELECT id, name, lastname FROM public.temp_func_ft_rec() f(id int, name varchar, lastname varchar);


�� sql - TABLE:

CREATE OR REPLACE FUNCTION public.temp_func_ft_sqltable()

RETURNS TABLE ( id int, name varchar, lastname varchar )

AS $$

SELECT id, name, lastname FROM public.firsttable;

$$ LANGUAGE 'sql';


SELECT id, name, lastname FROM public.temp_func_ft_sqltable();


--������ � ���������� ��������� � �������� �������:

CREATE OR REPLACE FUNCTION public.temp_func()

RETURNS TABLE ( _id int, _name varchar, _lastname varchar )

AS $$

BEGIN

CREATE TEMP TABLE IF NOT EXISTS temp_table AS

SELECT id, name, lastname FROM public.firsttable;


INSERT INTO public.firsttable_old(id, name, lastname)

SELECT id, name, lastname FROM temp_table;


RETURN QUERY

SELECT id, name, lastname FROM temp_table;


DROP TABLE IF EXISTS temp_table;

END;

$$ LANGUAGE plpgsql;


SELECT _id, _name, _lastname FROM public.temp_func();


--������� ��� �������� �������� �� ������� - RETURN NEXT:

CREATE OR REPLACE FUNCTION get_all_firsttable() RETURNS SETOF public.firsttable AS

$BODY$

DECLARE

r public.firsttable%rowtype;

BEGIN

FOR r IN

SELECT id, name FROM public.firsttable

LOOP

--�� ������ ����� �������� ���������� ������

RETURN NEXT r; --��������� ������� ������ ������� � ������������� ����������

END LOOP;

RETURN;

END

$BODY$

LANGUAGE plpgsql;


SELECT id, name FROM get_all_firsttable();


--������ ������������� ������ � RETURN NEXT:

CREATE OR REPLACE FUNCTION insert_all_from_firsttable_to_firsttable_old()

RETURNS TABLE(_id int, _name varchar, _lastname varchar) AS $$

BEGIN

FOR _id, _name, _lastname IN

SELECT id, name FROM public.firsttable

LOOP

INSERT INTO public.firsttable_old(id, name, lastname) VALUES(_id, _name || ' in LOOP', _lastname || ' in LOOP');

RETURN NEXT;

END LOOP;

END

$$ LANGUAGE plpgsql;


SELECT _id, _name, _lastname FROM insert_all_from_firsttable_to_firsttable_old();



�������


������ - ������, ���������� � �������� ������ ������


���������:

CUR - ���������� �������

OPEN - �������� �������

FETCH ... INTO - ������� ������� ������ �� ��������������� ������ �������

CLOSE - �������� �������



--������� � ��������

CREATE OR REPLACE FUNCTION public.cursor()

RETURNS void

AS $$

DECLARE

val public.firsttable%rowtype;

--������

cur CURSOR IS SELECT id, name FROM public.firsttable;

BEGIN

OPEN cur;

LOOP

FETCH cur INTO val;


--����� ��� ��������� �������

EXIT WHEN not FOUND;

val.name := 'New_Name_' || val.id;

UPDATE public.firsttable SET name = val.name WHERE id = val.id;

END LOOP;

CLOSE cur;

END;

$$

LANGUAGE plpgsql;


--�����

SELECT public.cursor();


REINDEX

��������������� (�������������\������ ������) ������������ ������� � ��������


��������� �������:

REINDEX { TABLE | DATABASE | INDEX } ���_������� [ FORCE ]


��������� �������:

TABLE DATABASE INDEX - ���� ������������� ��������

FORCE - �������������� �������� ��� ���� ������������� ��������, ���� �������� �� ����� - ����������������� ������ ������������ �������


������:

--��������� ������� ��������������� ��� ������������ ������� ��� ������� public.firsttable:

REINDEX TABLE public.firsttable;



VACUUM

������� ��������� ������ ����������, ����������� ��, ��������� ����������

���� ������� ANALYZE, ����������� �������������� ���������� ��� ������

���������� ����� ������� ������� �������������� ��


��������� �������:

VACUUM [ VERBOSE ] [ ANALYZE ] [ ������� ]

VACUUM [ VERBOSE ] ANALYZE [ ������� [ (���� [. ...] ) ] ]


��������� �������:

VERBOSE - ��������� ����� �� ������������ ��������

ANALYZE - ������������� ���������� ��� ������������

���� ������� �� �������, VACUUM ���������� ��� ������� ��

���� ������������ ��� ���������� ���������� ��� ������������



������:

--��������� ������� ���������� � �������� ������ VERBOSE ��� ������� public.firsttable:

VACUUM VERBOSE public.firsttable;



�������� ��������� ����������

SELECT

current_catalog, current_role, current_schema, current_user, session_user, user,

current_database(), current_query(),

inet_client_addr(), inet_client_port(), inet_server_addr(), inet_server_port(),

version();
