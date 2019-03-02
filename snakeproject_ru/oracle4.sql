ѕродолжаем знакомство с возможност€ми запросов в ORACLE, это п€тый урок.

--DBTIMEZONE - зона, установленна€ в базе данных
--SESSIONTIMEZONE - зона в сессии пользовател€
SELECT DBTIMEZONE, SESSIONTIMEZONE FROM dual;

--CURRENT_DATE - текуща€ дата
--CURRENT_TIMESTAMP - текуща€ дата + врем€ с зоной
--LOCALTIMESTAMP - текуща€ дата + врем€ без зоны
SELECT CURRENT_DATE, CURRENT_TIMESTAMP, LOCALTIMESTAMP FROM dual;

--ADD_MONTHS(d, x)
--¬озвращает дату, полученную в результате прибавлени€ одного или нескольких мес€цев. 
-- оличество мес€цев задаетс€ параметром x, который может быть отрицательным.
SELECT ADD_MONTHS (SYSDATE, -5) d FROM dual;

--LAST_DAY(d) - ¬озвращает последнее число мес€ца
SELECT LAST_DAY (SYSDATE) d FROM dual;

--¬ычислить разницу в сутках
SELECT ROUND(to_date('14.08.2014', 'DD/MM/YYYY' )-SYSDATE,0) AS diff FROM dual;

--Truncate (усечение) даты в Oracle
SELECT TRUNC(SYSDATE) FROM dual;
--усечение до минуты:
SELECT TRUNC(SYSDATE,'mi') FROM dual;
--усечение до часа:
SELECT TRUNC(SYSDATE,'hh') FROM dual;

--ADD_MONTHS добавл€ет\отнимает мес€цы
--¬ычислить дату двухмес€чной давности
SELECT ADD_MONTHS(TRUNC(SYSDATE),-2) FROM dual;

--¬ыборка часов\минут\секунд из даты
SELECT 
  TO_NUMBER(EXTRACT (HOUR FROM a.dt)) hh, 
  TO_NUMBER(EXTRACT (MINUTE FROM a.dt)) mm, 
  TO_NUMBER(EXTRACT (SECOND FROM a.dt)) ss 
FROM (SELECT CAST(SYSDATE AS TIMESTAMP) dt FROM dual) a;


--–егул€рные выражени€
--—оздадим тестовую таблицу и заполним данными
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

--REGEXP_COUNT определ€ет кол во вхождений REGEXP шаблона в строку
--REGEXP_COUNT(<source_string>, <pattern>[[, <start_position>], [<match_parameter>]])
--¬ данном примере <start_position> необ€зательный параметр
SELECT REGEXP_COUNT(val, 'av', 2) RES FROM test_regexp;

SELECT REGEXP_COUNT(val, 'av', 1) RES FROM test_regexp;

--REGEXP_INSTR определ€ет номер первого символа вхождени€ REGEXP шаблона в строку
--REGEXP_INSTR(<source_string>, <pattern>[[, <start_position>][, <occurrence>][, <return_option>][, <match_parameter>][, <sub_expression>]])
SELECT REGEXP_INSTR(val, '333', 1) RES FROM test_regexp;

--REGEXP_LIKE выбирает строки, соответвующие шаболну регул€рного выражени€
--REGEXP_LIKE(<source_string>, <pattern>, <match_parameter>)
SELECT * FROM test_regexp WHERE REGEXP_LIKE(val, '333');

--REGEXP_REPLACE замен€ет шаблон регул€рного выражени€ в строке на заданное значение
--REGEXP_REPLACE(<source_string>, <pattern>,<replace_string>, <position>, <occurrence>, <match_parameter>)
SELECT REGEXP_REPLACE(val, ' ', '') RES FROM test_regexp;

--REGEXP_INSTR определ€ет номер первого символа вхождени€ шаблона в строке
--REGEXP_INSTR(<source_string>, <pattern>[[, <start_position>][, <occurrence>][, <return_option>][, <match_parameter>][, <sub_expression>]])
SELECT REGEXP_INSTR(val, '5') RES FROM test_regexp;

--REGEXP_SUBSTR выдел€ет из строки заданный шаблон
--REGEXP_SUBSTR(source_string, pattern[, position [, occurrence[, match_parameter]]])
SELECT REGEXP_SUBSTR(val, '1av') RES FROM test_regexp;

 

Ўаблоны регул€рных выражений на википедии https://ru.wikipedia.org/wiki/%D0%E5%E3%F3%EB%FF%F0%ED%FB%E5_%E2%FB%F0%E0%E6%E5%ED%E8%FF
--ѕара примеров использовани€ регул€рных выражений
--Ќачало строки с 1 или 2
SELECT * FROM test_regexp WHERE REGEXP_LIKE(val, '[1-2]');
-- онец строки на 5
SELECT * FROM test_regexp WHERE REGEXP_LIKE(val, '[$5]');
--— повторением символа два раза (в данном примере на символе "пробел")
SELECT * FROM test_regexp WHERE REGEXP_LIKE(val, '1 {2}');

 

’ороша€ стать€ на английском http://psoug.org/reference/regexp
’ороша€ стать€ на русском http://orasource.ru/materialyi-po-pl-sql/ispolzovanie-regulyarnyih-vyirazheniy-regexp-v-oracl.html