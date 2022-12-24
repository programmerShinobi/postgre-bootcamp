-- RUN 1
-- START CURSOR FOR
BEGIN;
-- DECLARE CURSOR FOR
DECLARE my_cursor CURSOR FOR
SELECT * FROM employees;

-- RUN 2
--FETCH awal
FETCH FIRST FROM my_cursor; 

-- RUN  3
--FETCH terakhir
FETCH LAST FROM my_cursor; 

-- RUN  4
--FETCH selanjutnya
FETCH NEXT FROM my_cursor;

-- RUN  5
--FETCH sebelumnya
FETCH PRIOR FROM my_cursor;

-- RUN  6
--FETCH sebanyak jumlah diinput : 10
FETCH 201 FROM my_cursor; 

-- STOP CURSOR FOR
COMMIT;
