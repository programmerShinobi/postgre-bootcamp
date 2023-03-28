-- create table in postgres database

-- create table regions
CREATE TABLE regions (
	region_id SERIAL,
	region_name VARCHAR(25),
	CONSTRAINT region_id_pk 
		PRIMARY KEY (region_id)
);

-- insert values table regioons
INSERT INTO regions(region_name)
	VALUES
	('asia'),
	('america'), 
	('australia');

-- update region_name
UPDATE regions 
	SET region_name = 'eropa' 
		WHERE region_id = 2;

-- view all field table regions
SELECT * FROM regions;

-- create table countries
CREATE TABLE countries (
	country_id SERIAL,
	country_name VARCHAR(25),
	region_id INT,
	CONSTRAINT country_id_pk 
		PRIMARY KEY (country_id)
);

-- add constraint fk_region_id in table countries (region_id)
ALTER TABLE countries 
	ADD CONSTRAINT fk_region_id 
		FOREIGN KEY (region_id)
			REFERENCES regions(region_id);

--insert values in countries
INSERT INTO countries(
	country_name,
	region_id
) VALUES (
	'indonesia',
	1
),(
	'germany',
	2
),(
	'queensland',
	3
);

-- view join table regions & countries
SELECT * 
	FROM regions re
	LEFT JOIN countries co 
		ON co.region_id = re.region_id
		ORDER BY re.region_id 
			DESC;

-- add field table regions
ALTER TABLE regions 
	ADD COLUMN region_x VARCHAR(30);

-- edit field region_x in table regions
ALTER TABLE regions 
	RENAME COLUMN region_x
		TO region_y;

-- edit lenght field region_y to VARCHAR(60)
ALTER TABLE regions 
	ALTER COLUMN region_y 
		TYPE VARCHAR(60);

-- delete field region_y in table regions
ALTER TABLE regions 
	DROP COLUMN region_y;

-- drop table regions
DROP TABLE regions;

-- drop table region CASCADE
DROP TABLE regions CASCADE;

