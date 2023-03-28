-- create table in hr-db database

-- import 1
-- create table regions
CREATE TABLE regions (
	region_id INT,
	region_name VARCHAR (25) 
    DEFAULT NULL,
	CONSTRAINT pk_region_id 
    PRIMARY KEY(region_id)
);

-- create table countries
CREATE TABLE countries (
	country_id CHAR (2),
	country_name VARCHAR (40) 
    DEFAULT NULL,
	region_id INT NOT NULL,
	CONSTRAINT pk_country_id 
    PRIMARY KEY(country_id),
	CONSTRAINT fk_region_id 
    FOREIGN KEY (region_id) 
      REFERENCES regions (region_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);

-- create table locations
CREATE TABLE locations (
	location_id INT,
	street_address VARCHAR (40) 
    DEFAULT NULL,
	postal_code VARCHAR (12) 
    DEFAULT NULL,
	city VARCHAR (30) 
    DEFAULT NULL,
	state_province VARCHAR (25) 
    DEFAULT NULL,
	country_id CHAR 
    NOT NULL,
	CONSTRAINT pk_location_id 
    PRIMARY KEY (location_id),
	CONSTRAINT fk_country_id 
    FOREIGN KEY (country_id) 
      REFERENCES countries(country_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);

-- create table jobs
CREATE TABLE jobs(
	job_id VARCHAR(10),
	job_title VARCHAR(35),
	min_salary DECIMAL(8,2),
	max_salary DECIMAL(8,2),
	CONSTRAINT pk_job_id 
    PRIMARY KEY (job_id)
);


-- import 2
-- create table departments
CREATE TABLE departments (
	department_id INT,
	department_name VARCHAR(30),
	location_id INT,
	CONSTRAINT pk_department_id 
		PRIMARY KEY (department_id),
	CONSTRAINT fk_location_id 
		FOREIGN KEY (location_id) 
			REFERENCES locations(location_id) 
			ON DELETE CASCADE 
			ON UPDATE CASCADE
);

-- create table employees
CREATE TABLE employees (
	employee_id INT,
	first_name VARCHAR(20),
	last_name VARCHAR(25),
	email VARCHAR(25),
	phone_number VARCHAR(20),
	hire_date DATE,
	salary DECIMAL(8,2),
	commision_pct DECIMAL(2,2),
	job_id VARCHAR(10),
	department_id INT,
	CONSTRAINT pk_employee_id 
		PRIMARY KEY (employee_id),
	CONSTRAINT fk_job_id 
		FOREIGN KEY (job_id) 
			REFERENCES  jobs(job_id) 
				ON DELETE CASCADE 
        ON UPDATE CASCADE,
	CONSTRAINT fk_department_id 
    FOREIGN KEY (department_id) 
      REFERENCES departments(department_id) 
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- create table  job_history
CREATE TABLE job_history(
	employee_id INT,
	start_date DATE,
	end_date DATE,
	job_id VARCHAR(10),
	department_id INT,
	CONSTRAINT pk_employee_id_job_history 
    PRIMARY KEY (employee_id, start_date),
	CONSTRAINT fk_job_id_job_history 
    FOREIGN KEY (job_id) 
      REFERENCES jobs(job_id),
	CONSTRAINT fk_department_id_job_history 
    FOREIGN KEY (department_id) 
      REFERENCES departments(department_id)
);
