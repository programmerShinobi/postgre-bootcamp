-- Create table regions
CREATE TABLE regions (
	region_id serial,
	region_name varchar(25),
	CONSTRAINT region_id_pk PRIMARY KEY (region_id)
);

-- view all field table regions
SELECT * FROM regions;

-- add field table regions
ALTER TABLE regions ADD COLUMN region_x VARCHAR(30);

-- add constraint region_x_pk
ALTER TABLE regions ADD CONSTRAINT region_x_pk PRIMARY KEY (region_x);

-- add constraint region_x_fk
ALTER TABLE regions ADD CONSTRAINT region_x_fk FOREIGN KEY table2(region_x);

-- edit field region_x in table regions
ALTER TABLE regions RENAME COLUMN region_x to region_y;

-- edit lenght field region_y to VARCHAR(60)
ALTER TABLE regions ALTER COLUMN region_y TYPE VARCHAR(60);

-- delete field region_y in table regions
ALTER TABLE regions DROP COLUMN region_y;

-- delete table regions
DROP TABLE regions;

-- drop field region_x
ALTER TABLE regions DROP COLUMN region_x;

-- drop table regions
DROP TABLE regions;

-- drop table region CASCADE
DROP TABLE regions CASCADE;

-- insert values table regioons
INSERT INTO regions(region_name) VALUES('malaysia');

-- update region_name
UPDATE regions SET region_name = 'Malaysia' WHERE region_id = 2;
