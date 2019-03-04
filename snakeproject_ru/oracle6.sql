Использовалась Oracle SQLExpress 11g

Разберем несколько примеров с regexp_like:

-- .* - любое кличество любых символов, a$ - оканчивается на a 
SELECT COUNTRY_ID, COUNTRY_NAME, REGION_ID FROM HR.COUNTRIES where regexp_like(COUNTRY_NAME, 'Argent.*a$');

-- (A|a) - один из символов в скобках, 
SELECT COUNTRY_ID, COUNTRY_NAME, REGION_ID FROM HR.COUNTRIES where regexp_like(COUNTRY_NAME, '(A|a)rgentina');

-- ^arg - начинается с, аргумент i - регистронезависимый поиск (например совпадет arg и Arg) 
SELECT COUNTRY_ID, COUNTRY_NAME, REGION_ID FROM HR.COUNTRIES where regexp_like(COUNTRY_NAME, '^arg.*', 'i');

-- [d-z] - диапазон символов
SELECT COUNTRY_ID, COUNTRY_NAME, REGION_ID FROM HR.COUNTRIES where regexp_like(COUNTRY_NAME, 'Arge[d-z]tina');

-- [fghnk] - один из символов
SELECT COUNTRY_ID, COUNTRY_NAME, REGION_ID FROM HR.COUNTRIES where regexp_like(COUNTRY_NAME, 'Arge[fghnk]tina');

-- . - любой из символов
SELECT COUNTRY_ID, COUNTRY_NAME, REGION_ID FROM HR.COUNTRIES where regexp_like(COUNTRY_NAME, 'Arge.tina');