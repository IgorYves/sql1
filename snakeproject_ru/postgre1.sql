

Очень краткое руководство по PostgreSQL и PL/pgSQL


Сайт автора данного руководства: http://snakeproject.ru/


Писалось в качестве справочника - записок для самого себя


Взять дистрибутивы можно с оф. Сайта: https://www.postgresql.org/

Либо есть вариант разработчиков из РФ: https://postgrespro.ru/


Предполагается, что дистрибутив PostgreSQL был установлен по инструкции с сайта дистрибутива, дублировать этот шаг не будем.


Хочу отметить труд по документации на русском языке команды PostgresPRO - https://postgrespro.ru/docs


Для доступа к серверу и БД можно использовать графический инструмент pgAdmin: https://www.pgadmin.org/

Или EMS SQL Manager for PostgreSQL: https://www.sqlmanager.net/products/postgresql/Manager



Кратко о PostgreSQL


PostgreSQL — реляционная база данных с открытым исходным кодом


В реляционной базе данных информация хранится в виде таблиц с колонками и строками


Схема работы PostgreSQL приложения такова:

1. Процесс "POSTMASTER" на сервере получает запрос на подключение

2. При успешной прохождении проверки POSTMASTER создаёт свою копию

3. Далее взаимодействие с базой данных клиента идет уже через копию


После установки(Настройка кластера баз данных)


На Windows инсталляционный пакет скорей всего пропишет все автоматом для запуска кластера в зависимости от указанной директории, но можно настроить кластер с помощью утилит ниже описанных initdb и pg_ctl, они будут в каталоге bin, например - D:\Postgres\bin


После установки PostgreSQL нужно создать кластер баз данных

В данном случае это набор баз, которые будут управляются одним экземпляром сервера

Один экземпляр PostgreSQL может запускать и контролировать набор баз данных, которые изолированы друг от друга, но обслуживаются через один и тот же сокет TCP/IP или UNIX


Можно воспользоваться вариантом создания кластера с помощью:

initdb — создает новый PostgreSQL кластера баз данных

Синтаксис- initdb [ option …] [ –pgdata | -D ] directory


Желаемое месторасположение кластера БД указывается опцией -D :

$ sudo postgres

$ initdb -D /usr/local/pgsql/data


Либо так:

$ sudo postgres

$ pg_ctl -D /usr/local/pgsql/data initdb


После этого можно будет попробовать запустить сервер - sudo service postgresql start


Либо есть варианты


Запустить postmaster в активном режиме:

$ postmaster – D /usr/local/pgsql/data


Запуск в фоновом режиме с помощью pg_ctl:

$ pg_ctl – D /usr/local/pgsql/data – 1 /tmp/postgresql.log start


Примеры действий pg_ctl:


Старт сервера:

$ pg_ctl start


Остановка сервера:

$ pg_ctl stop


Перезапуск сервера:

$ pg_ctl restart


Статус сервера:

$ pg_ctl status


Утилита psql


В стандартной поставке с сервером с пакетом postgresql-client для администрирования идет утилита psql, приведу несколько примеров ее функционала (примеры для Windows и Linux схожи)


В Linux - su – postgres, Windows – cmd – psql


psql --help - справка


Некоторые аргументы утилиты:

psql -l — выведет список баз данных

psql -d database - подключиться к базе данных с именем «database»

psql -f script.sql - исполнить SQL скрипт «script.sql»

psql -d test -H -c "SELECT * FROM students" -o D:\Postgres\f.html — результат вывода в файл


Вывод списка конфигурационных файлов:

psql > SELECT name, setting FROM pg_settings WHERE category = 'File Locations';


Вывод списка активных сессий:

psql > SELECT * FROM pg_stat_activity;


Убить сессию:

--Узнаем id сесссии

SELECT datname as database,

pid,

usename as username,

application_name as application,

client_addr as client_address,

query

FROM pg_stat_activity;


--Указываем id сессии и БД

SELECT pg_terminate_backend(id сессии)

FROM pg_stat_activity

WHERE datname = 'БД';


Утилита pgdump(резервная копия одной базы)


Справка — pg_dump –help


Синтаксис: pg_dump ?Fc "база данных" > "бэкап"

Пример: pg_dump -Fc "test" > "D:\Postgres\testBackup.sql"


Пример бэкапа данных для определенной таблицы "table_test":

pg_dump -a -t table_test -f file_test.sql database_test


Некоторые опции:

-h host - адрес хоста

-p port - порт хоста (по умолчанию 5432)

-u - логин

-a, --data-only - дамп данных без схемы

-s, --schema-only - дамп только схемы

-C, --create - добавит команду создания базы данных

-c - добавит команды удаления (drop) объектов

-t, --table=TABLE - определенная таблица для создания дампа


Утилита pgdumpall(резервная копия всех баз)


pg_dumpall > bases.sql


Утилиты psql и pgrestore(восстановление резервных копий)


psql - восстановит бэкапы из текстовых фалов типа plain text

pg_restore - восстановит бэкапы из архивов типа tar


Восстановление всего бекапа с игнорированием ошибок:

psql -h localhost -U Login -d DBName -f backup.sql


Восстановление из архива:

pg_restore -C -d postgres db.dump


-C или --create

Создать базу данных, прежде чем восстанавливать данные.

Если также указан параметр --clean, удалить и пересоздать целевую базу данных перед подключением к ней.

Все данные восстанавливаются в базу данных, имя которой записано в архиве.



О конфигурационных файлах


postmaster.opts — содержит строку запуска с параметрами для СУБД PostgreSQL

Например так: D:/Postgres/bin/postgres.exe "-D" "D:\Postgres\data"
Этот путь - «D:\Postgres\data» будет в переменной $PGDATA


pg_hba.conf — отвечает за доступ пользователей(создается автоматически при выполнении команды initdb)

По умолчанию PostgreSQL разрешает подключаться локальному пользователю с совпадающим названием БД с регистрационным именем клиента, если такая база данных существует


Для подключения к базе данных по сети необходимо настроить listen_addresses в postgresql.conf


Пара примеров


Доступ всем локально по совпадению логина и имени БД по паролю:

host all all 127.0.0.1/32 md5


Доступ к базе test логину mike с адреса 1.1.1.1 на доверии:

host test mike 1.1.1.1/32 trust


postgresql.conf — отвечает за настройки сервера


Все опции отлично документированы, самые необходимые:

listen_addresses - прослушиваемый адрес

port - прослушиваемый порт

max_connections - максимально соединений

superuser_reserved_connections - зарезервированые соединения для суперпользователя


Логи обычно хранятся в директории «pg_log»


Включает логирование действий:

logging_collector = on


Место хранения логов:

log_destination = 'stderr'


Частота ротации логов:

log_rotation_age = 1d


Размер ротации логов:

log_rotation_size = 10MB


Формат файла логов:

log_filename = 'postgresql-%Y-%m-%d_%H%M%S.log'


Перезапись ротационных логов:

log_truncate_on_rotation = on


Интересные команды


Посмотреть активность в Linux с задержкой в 3 секунды

watch -n 3 'ps auxww | grep ^postgres'


Выше обратите внимение на вывод, для каждого пользователя создается свой экземпляр POSTMASTER, можно увидеть что-то типа postgres: "пользователь" "база" "хост" "статус":

Родительский процесс - /usr/bin/postmaster -p 5432 -D /var/lib/pgsql/data

Процесс пользователя - postgres: postgres mike 127.0.0.1(37047) idle


Базы данных и журналы транзакций


По умолчанию создается БД postgres, template0 и template1

В БД postgres менять что-либо не рекомендуется, используется самим PostgreSQL

В БД template0 категорически нельзя что-либо менять

В БД template1 позволяется вносить изменения


Каждая таблица\индексы\blob т.п. хранятся как файл или несколько файлов в каталоге БД


Посмотреть, где хранятся БД — psql - show data_directory;


Базы в PostgreSQL имеют ID узнать можно так:

SELECT oid from pg_database WHERE datname = 'test';


Это число в виде папки мы видим в папке data/base — соответствует базе


ID таблицы можно найти так(подключитесь к самой БД psql -d test):

SELECT relname, relfilenode FROM pg_class WHERE relname = 'students';


Это число уже будет именем файла внутри каталога базы


В WIndows $PGDATA по умолчанию указывает в каталог "data" указанный при установке или инициализации кластера в строке параметра в postmaster.opts


pg_xlog


В postgresql.conf за размер логов отвечает параметр - max_wal_size


Путь - $PGDATA/pg_xlog (В Windows для PostgresPRO будет в D:\Postgres\data\pg_wal)


По завершении транзакций PostgreSQL записывает данные в журнал транзакций WAL - Write-ahead log, а уже после в саму базу данных


Сами файлы выглядят типа - '0000000100000000000000A2', которые содержат образы данных последних транзакций. Эти журналы также используются при бинарной репликации


Нельзя удалять\перемещать эти данные, возможно приведет к невосстановимому повреждению базы данных


Каталог может разростись при использовании репликации и падении SLAVE при настроенной репликации


pg_clog


Путь - $PGDATA/pg_clog содержит журналы метаданных транзакций, записывает информацию о завершении\незавершении транзакции

Врядли когда-то увеличится, но ни в коем случае удалять файлы оттуда нельзя, без них восстановить базы данных не выйдет


Об SQL



Приведем список основных команд SQL


В PostgreSQL поддерживаются все основные команды\операторы языка SQL


Ниже приведена таблица с кратким описанием операторов:




Права и роли (DCL – Data Control Language)



После установки был создан пользователь postgres с указанным паролем


Логинимся (для Linux: sudo su — postgres)


Сама PostgreSQL управляет доступом при помощи ролей

Посмотреть роли - зайти в psql - набрать \du


Будет что-то похожее:

List of roles

Role name | Attributes | Member of

-----------+------------------------------------------------+-----------

postgres | Superuser, Create role, Create DB, Replication | {}


Для Windows ОС может возникнуть потребность корректно отображать кодировки, необходимо будет дать команду:

chcp 1251


Создание базы данных:

CREATE DATABASE test;


Создать новую роль:

CREATE ROLE test_role;


Удалить роль можно так:

DROP ROLE test_role;


Посмотреть опции для создания роли можно так:

\h CREATE ROLE


Пример с опцией - логин, связанный с ролью, будет иметь привилегии соединения:

CREATE ROLE test_role WITH LOGIN;



Создать нового пользователя можно с помощью команды:

CREATE USER test_user;

Обратите внимание, что вместе с пользователем создастся роль test_user с привилегией соединения


Задать пароль пользователю:

\password test_user


или с помощью sql:

CREATE USER test_user WITH password 'password';


Удаление пользователя:

DROP USER IF EXISTS test_user;


Добавить пользователю роль можно так - GRANT test TO test_user;


Теперь зададим пользователю test_user права на базу test с помощью роли:

Входим в базу - \c test


Даем все привелегии роли:

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO GROUP test_user;


Или особые привелегии:

GRANT SELECT, UPDATE, INSERT ON ALL TABLES IN SCHEMA public TO test_user;


Выходим - \q


Проверяем досту под пользователем - psql -U test_user -d test -h 127.0.0.1 -W


Сделайте запрос, например: select * from students


Забрать привилегии роли можно так:

REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public FROM GROUP test_user;


По аналогии с самим пользователем:

\c test

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO test_user;

REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public FROM test_user;


Сделать владельцем БД, разрешить создание ил подключение на уровне БД можно с помощью команд:

ALTER DATABASE test OWNER TO test_user;

GRANT TEMP ON DATABASE test TO test_user WITH GRANT OPTION;

GRANT CREATE ON DATABASE test TO test_user WITH GRANT OPTION;

GRANT CONNECT ON DATABASE test TO test_user;


Права для схемы (владелец\использование\создание) назначить можно так:

ALTER SCHEMA public OWNER TO test_user;

GRANT USAGE ON SCHEMA public TO test_user;

GRANT CREATE ON SCHEMA public TO test_user;

Пароли пользователей хранятся в системной таблице:

SELECT * FROM pg_shadow;



Типы данных



Преобразование строковой константы к другому типу:

Значение:: Тип

CAST (Значение AS Тип)


Примеры:

SELECT pg_typeof( CAST ('50' AS INTEGER) );

SELECT pg_typeof( '50'::INTEGER );


SELECT pg_typeof( CAST (50 AS VARCHAR) );

SELECT pg_typeof( 50::VARCHAR );


В PostrgreSQL есть довольно широкий выбор из типов данных


Основная часть — типы языка SQL


Присутствуют и типы только самой PostgreSQL


Некоторые типы данных имеют синонимы


При переписи кода на другие БД могут возникнуть проблемы



В интернете есть ряд утилит для переноса структуры и данных между разными СУБД


Можно определять собственные типы с помощью CREATE TYPE



Приведена таблица типов данных c описанием:




DDL - data definition language (язык описания данных)



--Пример создания таблицы:

CREATE TABLE Table1

( id INTEGER,

name CHAR(25) );



--Добавление столбца

ALTER TABLE Table1 ADD lastname VARCHAR(30) NOT NULL;

--Добавление столбца с ограничением уникальности

ALTER TABLE Table1 ADD address VARCHAR(50) NOT NULL CONSTRAINT address_unique UNIQUE;


--Удаление ограничения

ALTER TABLE Table1 DROP CONSTRAINT address_unique;


--Переименование столбца и изменение типа данных

ALTER TABLE Table1 ALTER COLUMN lastname TYPE CHAR(20);


--Удаление столбца

ALTER TABLE Table1 DROP COLUMN address ;


--Пример создания неуникального индекса:

CREATE INDEX Tname ON Table1 (name);


--Пример создания уникального индекса:

CREATE UNIQUE INDEX Tid ON Table1 (id);


--Удаление индекса:

DROP INDEX Tid;


-- Удаление таблицы

DROP TABLE Table1


--Создание таблицы с первичным ключом(Столбцы первичного ключа уже имеют индекс):

CREATE TABLE Table1

( id INTEGER,

name CHAR(25),

PRIMARY KEY (id));


--Создание таблиц с первичными ключами и связями(отношениями):

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


--Удалить отношение(связь):

ALTER TABLE secondtable DROP CONSTRAINT FK_ToFirsttable;


--Задать отношение(связь) можно после, по аналогии с предыдущей таблицей:

ALTER TABLE secondtable ADD CONSTRAINT FK_ToFirsttable FOREIGN KEY (mainID) REFERENCES firsttable (ID);



DML - язык манипулирования данными


--Добавим строки в таблицы

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


--Удалим данные

DELETE FROM secondtable WHERE ID = 3;


--Изменим данные

UPDATE firsttable SET name = 'name3_New' WHERE ID = 3;


--Очистим полностью таблицы:

TRUNCATE TABLE firsttable, secondtable;



Оператор SELECT


--Конструкция SELECT:

--1 - SELECT (DISTINCT LIMIT)

--2 - FROM

--3 - WHERE

--4 - GROUP BY

--5 - HAVING

--6 - ORDER BY


--Последовательность логической обработки SELECT

--1 - FROM

--2 - WHERE

--3 - GROUP BY

--4 - HAVING

--5 - SELECT (DISTINCT LIMIT)

--6 - ORDER BY


--(DISTINCT LIMIT) уникальные или ограничения вывода количества записей

--FROM указывает цель запроса (например таблица)

--WHERE указывает условия отбора

--GROUP BY определяет поле для группировки

--ORDER BY определяет поле для сортировки, ASC - по возрастанию,DESC - по убыванию


Для примеров введем обратно данные в обе таблицы из предыдущей главы DDL:


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


--Пример запроса (без таблицы)

SELECT 1, 25 - 7, 'Test' AS word;


--Определенное число записей в выводе

SELECT * FROM firsttable limit 2;


--Вывод уникальных значений

SELECT DISTINCT mainid FROM secondtable;


--Вывод с условием

SELECT * FROM firsttable WHERE id > 1 AND id < 4;


--Вывод с сортировкой по столбцу

SELECT * FROM firsttable ORDER BY id DESC;


--Вывод с группировкой по столбцам (в данном примере функция COUNT - считает записи, а не определенный столбец)

SELECT mainid, COUNT(*) FROM secondtable GROUP BY mainid;


--Вывод с группировкой по столбцам и HAVING - условие для группировки

SELECT mainid, COUNT(*) FROM secondtable GROUP BY mainid HAVING mainid IN (2,3);


--Вывод с проверкой на "пустые"\"непустые" значения NULL\NOT NULL

SELECT * FROM secondtable WHERE slastname IS NULL;

SELECT * FROM secondtable WHERE slastname IS NOT NULL;


--Подзапросы

SELECT f.name, (SELECT s.slastname FROM secondtable AS s WHERE f.id = s.mainid limit 1) AS slastname FROM firsttable as f;


Список функций, для операций и работы с любыми типами данных, строки, XML, сравнение, регулярные выражения и все, что только может понадобиться для использования в запросах:

https://postgrespro.ru/docs/postgrespro/10/functions

В этом месте хотелось бы выразить огромное спасибо российским коллегам из PostgresPRO, смысла дублировать функции работы со строкми\числами и т. п. В этом руководстве нет, далее мы пройдемся по некоторым конструкциям.


И конечно рассмотрим примеры с триггерами, функциями, программированием и представлениями.


Соединения — JOIN


Выборка из нескольких таблиц с соединением по значениям


--Внутреннее соединение (общие совпадающие id - mainid)

SELECT

A.id AS "id from firsttable"

,B.mainid AS "mainid from secondtable"

,A.name AS "name from firsttable"

,B.slastname AS "slastname from secondtable"

FROM

firsttable AS A INNER JOIN secondtable AS B

ON A.id = B.mainid;


--Соединение ко всем значениям левой таблицы

SELECT

A.id AS "id from firsttable"

,B.mainid AS "mainid from secondtable"

,A.name AS "name from firsttable"

,B.slastname AS "slastname from secondtable"

FROM

firsttable AS A LEFT JOIN secondtable AS B

ON A.id = B.mainid;




--Соединение ко всем значениям правой таблицы

SELECT

A.id AS "id from firsttable"

,B.mainid AS "mainid from secondtable"

,A.name AS "name from firsttable"

,B.slastname AS "slastname from secondtable"

FROM

firsttable AS A RIGHT JOIN secondtable AS B

ON A.id = B.mainid;

--Полное соединение

SELECT

A.id AS "id from firsttable"

,B.mainid AS "mainid from secondtable"

,A.name AS "name from firsttable"

,B.slastname AS "slastname from secondtable"

FROM

firsttable AS A FULL JOIN secondtable AS B

ON A.id = B.mainid;

--Перекрестное соединение

SELECT

A.id AS "id from firsttable"

,B.mainid AS "mainid from secondtable"

,A.name AS "name from firsttable"

,B.slastname AS "slastname from secondtable"

FROM

firsttable AS A CROSS JOIN secondtable AS B;


--Соединение с условием

SELECT

A.id AS "id from firsttable"

,B.mainid AS "mainid from secondtable"

,A.name AS "name from firsttable"

,B.slastname AS "slastname from secondtable"

FROM

firsttable AS A INNER JOIN secondtable AS B

ON A.id = B.mainid

WHERE A.name <> 'lastname3' and B.slastname <> 'lastname3';


Sequence - последовательности


Последовательность или sequence в PostgreSQL - объект БД, представляет автоматически увеличивающееся число


INSERT INTO public.firsttable(name, lastname) VALUES('name_sequence1','lastname_sequence1');

Выдаст из-за первичного ключа, его необходимо добавлять явно

ОШИБКА: нулевое значение в столбце "id" нарушает ограничение NOT NULL

DETAIL: Ошибочная строка содержит (null, name_sequence1, lastname_sequence1).


--Назначим автоинкремент

CREATE SEQUENCE firsttable_sec_id_seq

INCREMENT BY 1

NO MAXVALUE

MINVALUE 0;


--Создание таблицы с последовательностью

CREATE TABLE public.firsttable_sec (

id integer DEFAULT nextval('firsttable_sec_id_seq') NOT NULL,

name VARCHAR(50) NULL,

lastname VARCHAR(100) NULL

);

INSERT INTO public.firsttable_sec(name, lastname) VALUES('name_sequence1','lastname_sequence1');

INSERT INTO public.firsttable_sec(name, lastname) VALUES('name_sequence2','lastname_sequence2');

SELECT * FROM public.firsttable_sec;


--Добавление последовательности для столбца существующей таблицы

ALTER TABLE public.firsttable ALTER COLUMN id SET DEFAULT nextval('firsttable_sec_id_seq');


--Установитьзначение счетчика, например если уже были записи до установления последовательности

SELECT setval('firsttable_sec_id_seq', (SELECT max(id) FROM public.firsttable));


--Теперь не вызовет ошибки

INSERT INTO public.firsttable(name, lastname) VALUES('name_sequence1','lastname_sequence1');


--Удаление последовательности

ALTER TABLE public.firsttable ALTER COLUMN id DROP DEFAULT;


Хранимые функции



Хранимые процедуры в PostgreSQL как таковые отсутствуют, их заменяют хранимые функции


Синтаксис выглядит приблизительно так:

CREATE [OR REPLACE] FUNCTION Имя_Функции (Аргументы_функции)

RETURNS return_datatype AS $variable_name$

DECLARE

declaration;

[...]

BEGIN

< Тело_Функции >

[...]

RETURN { variable_name | value }

END; LANGUAGE { plpgsql, sql, C };


Имя_Функции - имя создаваемой функции

Тело_Функции - исполняемый код в самой функции

Аргументы_функции - необязательно, могут присутствовать принимаемые аргументы

Необязательная опция [OR REPLACE] позволяет изменять уже существующую функцию

RETURN - обязательное возвращаемое значение

Ключевое слово AS указывает на создание автономной функции

plpgsql, C или sql - название языка для функции


Когда функция с выходными параметрами должна возвращать множество значений, необходимо указать RETURNS SETOF

Когда выходных параметров несколько, используется RETURNS SETOF record

Когда только один, используется RETURNS SETOF указанный_тип


Ключевые слова IMMUTABLE | STABLE | VOLATILE (используется по умолчанию, если явно не указано) - информируют оптимизатор запросов о поведении функции


IMMUTABLE (постоянная) - говорит, что функция не может модифицировать базу данных и всегда возвращает один и тот же результат при определённых значениях аргументов

то есть, она не обращается к базе данных и не использует информацию, не переданную ей явно в списке аргументов

Если функция имеет такую характеристику, любой её вызов с аргументами-константами можно немедленно заменить значением функции


STABLE (стабильная) - говорит, что функция не может модифицировать БД и в рамках одного сканирования таблицы всегда возвращает один и тот же результат для определённых значений аргументов

Этот результат может быть разным в разных операторах SQL

Это подходящий выбор для функций, результаты которых зависят от содержимого базы данных и настраиваемых параметров (например, текущего часового пояса)

Но этот вариант не подходит для триггеров AFTER, желающих прочитать строки, изменённые текущей командой

Также заметьте, что функции семейства current_timestamp также считаются стабильными, так как их результаты не меняются внутри транзакции


VOLATILE (изменчивая) - говорит, что результат функции может меняться даже в рамках одного сканирования таблицы, так что её вызовы нельзя оптимизировать

Изменчивы в этом смысле относительно немногие функции баз данных, например: random(), currval() и timeofday()

Но заметьте, что любая функция с побочными эффектами должна быть классифицирована как изменчивая, даже если её результат вполне предсказуем, чтобы её вызовы не были соптимизированы

Пример такой функции: setval()


--Функция на чистом языке SQL, вариант - SETOF

CREATE OR REPLACE FUNCTION sel_name_from_firsttable()

RETURNS SETOF record AS '

SELECT id, name FROM firsttable;

' LANGUAGE sql;


--Вызов функции с выводом в один столбец

SELECT sel_name_from_firsttable();


--Вызов функции с выводом в разные столбцы

select a, b from sel_name_from_firsttable() f(a int, b varchar(50));


--Удалить функцию

DROP FUNCTION sel_name_from_firsttable();



$$ - символы квотирования, указывают, что между ними будет текст на каком-то языке, в данном ниже случае - LANGUAGE sql


Т.е. В примере ниже код написан на чистом SQL


--Функция на чистом языке SQL с табличным, возвращаемым значением

CREATE FUNCTION sel_name_from_firsttable()

RETURNS TABLE(id int, name varchar(50)) AS $$

SELECT id, name FROM firsttable;

$$ LANGUAGE sql;


--Вызов функции

SELECT * FROM sel_name_from_firsttable();



--Функция на plpgsql с возвращением числовой переменной и принимаемыми аргументами

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


--Пример функции без выходных аргументов(подобно хранимой процедуре), указаоно ключевое слово void, с обработкой ошибки, коды ошибок можно посмотреть тут - https://postgrespro.ru/docs/postgrespro/10/errcodes-appendix :


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

RAISE NOTICE ''Невозможно добавить строку! SQLSTATE: %'', SQLSTATE;

RAISE;

END;

'LANGUAGE 'plpgsql'

VOLATILE

CALLED ON NULL INPUT;


--Добавляем строки, произойдет ошибка по уникальности на второй записи

SELECT func_ins(7, 'name7', 'lastname7');

SELECT func_ins(7, 'name7', 'lastname7');

ЗАМЕЧАНИЕ: Невозможно добавить строку! SQLSTATE: 23505

ОШИБКА: повторяющееся значение ключа нарушает ограничение уникальности "firsttable_pkey"

DETAIL: Ключ "(id)=(7)" уже существует.

CONTEXT: SQL-оператор: "INSERT INTO firsttable(id, name, lastname) VALUES (foo_id, foo_name, foo_lastname)"

функция PL/pgSQL func_ins(integer,character varying,character varying), строка 3, оператор SQL-оператор





Транзакции


Управление транзакциями довольно просто


--Начинаем транзакцию

BEGIN;

UPDATE firsttable SET name = 'name1New1' WHERE name = 'name1';

--Делаем точку сохранения изменений

SAVEPOINT Your_savepoint;

UPDATE firsttable SET name = 'name1New2' WHERE name = 'name1';

--Откатываем изменения до точки сохранения изменений

ROLLBACK TO Your_savepoint;

--Завершаем транзакцию

COMMIT;


Представления


--Создаем представление

CREATE VIEW v_ft(v_name, v_lastname)

AS SELECT 'Имя: ' || name, 'Фамилия: ' || lastname FROM firsttable;


--Изменение представления

CREATE OR REPLACE VIEW v_ft(v_name, v_lastname)

AS SELECT 'Имя человека: ' || name, 'Фамилия человека: ' || lastname FROM firsttable;


--Выборка из представления

SELECT * FROM v_ft;


--Удаление представления

DROP VIEW v_ft;


Триггеры


Общий синтаксис:

CREATE TRIGGER Название_триггера

{ BEFORE | AFTER } { событие [ OR событие ] } ON таблица

FOR EACH { ROW | STATEMENT }

EXECUTE PROCEDURE функция ( аргументы )


{ BEFORE | AFTER } - выполнение кода до или после выполнения самой операции


{ событие [ OR событие ] } - что обрабатывается из операций: INSERT\UPDATE\DELETE


ON - таблица, на которой будет записан триггер


FOR EACH { ROW | STATEMENT } - ROW - функция вызывается для каждой модифицируемой записи, STATEMENT - один раз


EXECUTE PROCEDURE функция ( аргументы ) - Имя вызываемой функции и ее аргументы


--Таблица, в которую будут падать удаленные строки из триггерной процедуры

CREATE TABLE firsttable_old

( ID INT NULL,

name VARCHAR (50) NULL,

lastname VARCHAR (100) NULL );



--Создание триггерной функции

CREATE OR REPLACE FUNCTION firsttable_delete_trigger_del() RETURNS trigger AS '

BEGIN

if (select count(*) from firsttable a where id = OLD.id) > 0

then insert into firsttable_old(id,name,lastname) VALUES(OLD.id,OLD.name,OLD.lastname);

end if;

return OLD;

END;

' LANGUAGE plpgsql;



-- Создание триггера

CREATE TRIGGER firsttable_delete_trigger

BEFORE DELETE ON firsttable FOR EACH ROW

EXECUTE PROCEDURE firsttable_delete_trigger_del();


--Проверка работы триггера

DELETE FROM firsttable WHERE id=6;

SELECT * FROM firsttable_old;


PL/pgSQL ( Procedural Language/PostGres Structured Query Language ) — процедурное расширение языка SQL


Любая программная конструкция (функция\триггер\правило), написанная на PL/pgSQL, выглядит так:


[ <<метка>> ] - это например может быть DO $$

[ DECLARE

объявления переменных ]

BEGIN

тело программы

END [ метка ]; - это например может быть END $$;


--Простой пример анонимной функции

DO $$

DECLARE foo1 VARCHAR(50) = 'name_1_plpg'; foo2 VARCHAR(50) = 'name_2_plpg';

BEGIN

--Пример комментария

/*

Пример

многострочного

комментария

*/

--Присвоение значения переменной

foo1 := 'name_1_plpg:=';

UPDATE firsttable SET name = foo1 WHERE id = 1;

UPDATE firsttable SET name = foo2 WHERE id = 2;

END

$$ LANGUAGE plpgsql;


--Пример основных возможностей языка PL/pgSQL

DO $$

DECLARE

--Объявление переменной

foo1 int := 1;

foo2 int := 2;

--Определение алиаса для перменной

f1 ALIAS FOR foo1;

--Объявление константы (неизменяемой переменной)

const1 CONSTANT int := 3;

--Переменная типа ROWTYPE (строкового типа, например может быть результат целого запроса SELECT)

--Например так: SELECT * INTO row_data FROM public.firsttable_old WHERE if < 3 ;

row_data public.firsttable_old%ROWTYPE;

--Переменная типа TYPE (для отдельного столбца)

column_name_data public.firsttable_old.name%TYPE;

BEGIN

--Присвоение переменной значения из выборки с помощью ключевого слова INTO

SELECT INTO foo1 MAX(id) FROM public.firsttable_old;

SELECT INTO foo1, foo2 MIN(id), MAX(id) FROM public.firsttable_old;

INSERT INTO public.firsttable_old(id, name) VALUES(f1, 'Name_For_Alias_Min');

INSERT INTO public.firsttable_old(id, name) VALUES(foo2, 'Name_Not_Alias_Max');

--Конструкция IF THEN - проверка условия

IF const1 = 3 THEN

INSERT INTO public.firsttable_old(id, name) VALUES(const1, 'Name_Not_Alias_Const_IN_IF_3');

ELSEIF const1 = 5 THEN

INSERT INTO public.firsttable_old(id, name) VALUES(const1, 'Name_Not_Alias_Const_IN_IF_5');

ELSE

INSERT INTO public.firsttable_old(id, name) VALUES(const1, 'Name_Not_Alias_Const_IN_IF_ELSE');

END IF;

f1 := 1;

foo2 := 3;

--Цикл с условием выхода

LOOP

f1 := f1 + f1;

INSERT INTO public.firsttable_old(id, name) VALUES(f1, 'Name_For_Alias_LOOP');

EXIT WHEN f1 > foo2;

END LOOP;

f1 := 1;

foo2 := 3;

--Цикл WHILE с условием

WHILE f1 < foo2 LOOP

f1 := f1 + f1;

INSERT INTO public.firsttable_old(id, name) VALUES(f1, 'Name_For_Alias_WHILE');

END LOOP;

--Цикл FOR (перебор значений)

FOR i IN 1..3 LOOP

INSERT INTO public.firsttable_old(id, name) VALUES(i, 'Name_For_i');

END LOOP;

--Цикл FOR (перебор значений) из выборки с обращением к перременной типа ROWTYPE

FOR row_data IN SELECT * FROM public.firsttable_old WHERE name = 'Name_For_i' LOOP

column_name_data := row_data.name;

INSERT INTO public.firsttable_old(id, name) VALUES(row_data.id, column_name_data || '_FOR');

END LOOP;

END

$$ LANGUAGE plpgsql;


--Несколько вариантов создания идентичных хранимых функций и обращения к ним:


На plpgsql:

CREATE OR REPLACE FUNCTION public.temp_func_ft()

RETURNS TABLE ( _id int, _name varchar, _lastname varchar )

AS $$

BEGIN

RETURN QUERY

SELECT id, name, lastname FROM public.firsttable;

END;

$$ LANGUAGE plpgsql;


SELECT _id, _name, _lastname FROM public.temp_func_ft();


На plpgsql с однозначными именами столбцов:

CREATE OR REPLACE FUNCTION public.temp_func_ft_col()

RETURNS TABLE ( id int, name varchar, lastname varchar )

AS $$

BEGIN

RETURN QUERY

SELECT ft.id, ft.name, ft.lastname FROM public.firsttable AS ft;

END;

$$ LANGUAGE plpgsql;


SELECT id, name, lastname FROM public.temp_func_ft_col();


На sql - SETOF record:

CREATE OR REPLACE FUNCTION public.temp_func_ft_rec()

RETURNS SETOF record

AS $$

SELECT id, name, lastname FROM public.firsttable;

$$ LANGUAGE 'sql';


SELECT id, name, lastname FROM public.temp_func_ft_rec() f(id int, name varchar, lastname varchar);


На sql - TABLE:

CREATE OR REPLACE FUNCTION public.temp_func_ft_sqltable()

RETURNS TABLE ( id int, name varchar, lastname varchar )

AS $$

SELECT id, name, lastname FROM public.firsttable;

$$ LANGUAGE 'sql';


SELECT id, name, lastname FROM public.temp_func_ft_sqltable();


--Работа с временными таблицами в хранимой функции:

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


--Команда для возврата значения из функции - RETURN NEXT:

CREATE OR REPLACE FUNCTION get_all_firsttable() RETURNS SETOF public.firsttable AS

$BODY$

DECLARE

r public.firsttable%rowtype;

BEGIN

FOR r IN

SELECT id, name FROM public.firsttable

LOOP

--На данном этапе возможна реализация логики

RETURN NEXT r; --Добавляет текущую строку запроса к возвращаемому результату

END LOOP;

RETURN;

END

$BODY$

LANGUAGE plpgsql;


SELECT id, name FROM get_all_firsttable();


--Пример использования логики в RETURN NEXT:

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



Курсоры


Курсор - объект, работающий с областью памяти данных


Директивы:

CUR - объявление курсора

OPEN - открытие курсора

FETCH ... INTO - выборка текущей записи из результирующего набора записей

CLOSE - закрытие курсора



--Функция с курсором

CREATE OR REPLACE FUNCTION public.cursor()

RETURNS void

AS $$

DECLARE

val public.firsttable%rowtype;

--Курсор

cur CURSOR IS SELECT id, name FROM public.firsttable;

BEGIN

OPEN cur;

LOOP

FETCH cur INTO val;


--Выход при окончании записей

EXIT WHEN not FOUND;

val.name := 'New_Name_' || val.id;

UPDATE public.firsttable SET name = val.name WHERE id = val.id;

END LOOP;

CLOSE cur;

END;

$$

LANGUAGE plpgsql;


--Вызов

SELECT public.cursor();


REINDEX

Восстанавливает (перестраивает\строит заново) поврежденные индексы в таблицах


Синтаксис команды:

REINDEX { TABLE | DATABASE | INDEX } имя_объекта [ FORCE ]


Параметры команды:

TABLE DATABASE INDEX - типы индексируемых объектов

FORCE - восстанавление индексов для всех перечисленных объектов, если параметр не задан - восстанавливаются только поврежденные индексы


Пример:

--Следующая команда восстанавливает все поврежденные индексы для таблицы public.firsttable:

REINDEX TABLE public.firsttable;



VACUUM

Удаляет временные данные транзакций, анализирует БД, обновляет статистику

Если указать ANALYZE, сгенерирует статистическую информацию про данные

Регулярный вызов команды повысит быстродействие БД


Синтаксис команды:

VACUUM [ VERBOSE ] [ ANALYZE ] [ таблица ]

VACUUM [ VERBOSE ] ANALYZE [ таблица [ (поле [. ...] ) ] ]


Параметры команды:

VERBOSE - детальный вывод по обработанным таблицам

ANALYZE - генерирование статистики для оптимизатора

Если таблица не указана, VACUUM обработает все таблицы БД

Поле используется при обновлении статистики для оптимизатора



Пример:

--Следующая команда выолняется с ключевым словом VERBOSE для таблицы public.firsttable:

VACUUM VERBOSE public.firsttable;



Основные системные переменные

SELECT

current_catalog, current_role, current_schema, current_user, session_user, user,

current_database(), current_query(),

inet_client_addr(), inet_client_port(), inet_server_addr(), inet_server_port(),

version();
