�������������� Oracle SQLExpress 11g

�������� ��������� �������� � regexp_like:

-- .* - ����� ��������� ����� ��������, a$ - ������������ �� a 
SELECT COUNTRY_ID, COUNTRY_NAME, REGION_ID FROM HR.COUNTRIES where regexp_like(COUNTRY_NAME, 'Argent.*a$');

-- (A|a) - ���� �� �������� � �������, 
SELECT COUNTRY_ID, COUNTRY_NAME, REGION_ID FROM HR.COUNTRIES where regexp_like(COUNTRY_NAME, '(A|a)rgentina');

-- ^arg - ���������� �, �������� i - ������������������� ����� (�������� �������� arg � Arg) 
SELECT COUNTRY_ID, COUNTRY_NAME, REGION_ID FROM HR.COUNTRIES where regexp_like(COUNTRY_NAME, '^arg.*', 'i');

-- [d-z] - �������� ��������
SELECT COUNTRY_ID, COUNTRY_NAME, REGION_ID FROM HR.COUNTRIES where regexp_like(COUNTRY_NAME, 'Arge[d-z]tina');

-- [fghnk] - ���� �� ��������
SELECT COUNTRY_ID, COUNTRY_NAME, REGION_ID FROM HR.COUNTRIES where regexp_like(COUNTRY_NAME, 'Arge[fghnk]tina');

-- . - ����� �� ��������
SELECT COUNTRY_ID, COUNTRY_NAME, REGION_ID FROM HR.COUNTRIES where regexp_like(COUNTRY_NAME, 'Arge.tina');