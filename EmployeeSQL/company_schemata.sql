-- If need to drop tables to restart.
-- DROP TABLE employees, salaries, titles, departments, dept_emp, dept_manager;

-- Only empties the table but the table still exist; Data gone and cannot be recovered.
-- Delete will delete the table and everything but there's a log for it so it can be recovered.
-- TRUNCATE TABLE departments, dept_emp, dept_manager, employees, salaries, titles;

-- Creating all tables needed for company
-- Tables: employees, salaries, titles, departments, dept_emp, dept_manager
CREATE TABLE departments (
    dept_no VARCHAR NOT NULL,
    dept_name VARCHAR NOT NULL,
    CONSTRAINT pk_departments PRIMARY KEY (dept_no)
);

CREATE TABLE dept_emp (
    emp_no INTEGER NOT NULL,
    dept_no VARCHAR NOT NULL
);

CREATE TABLE dept_manager (
    dept_no VARCHAR NOT NULL,
    emp_no INTEGER NOT NULL
);

CREATE TABLE employees (
    emp_no INTEGER NOT NULL,
    emp_title_id VARCHAR NOT NULL,
    birth_date VARCHAR NOT NULL,
    first_name VARCHAR NOT NULL,
    last_name VARCHAR NOT NULL,
    sex VARCHAR NOT NULL,
    hire_date VARCHAR NOT NULL,
    CONSTRAINT pk_employees PRIMARY KEY (emp_no)
);

CREATE TABLE salaries (
    emp_no INTEGER NOT NULL,
    salary_no INTEGER NOT NULL,
    CONSTRAINT pk_salaries PRIMARY KEY (emp_no)
);

CREATE TABLE titles (
    title_id VARCHAR NOT NULL,
    title VARCHAR NOT NULL,
    CONSTRAINT pk_titles PRIMARY KEY (title_id)
);

-- Alter tables
ALTER TABLE dept_emp ADD CONSTRAINT fk_dept_emp_emp_no FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);

ALTER TABLE dept_emp ADD CONSTRAINT fk_dept_emp_dept_no FOREIGN KEY(dept_no)
REFERENCES departments (dept_no);

ALTER TABLE dept_manager ADD CONSTRAINT fk_dept_manager_dept_no FOREIGN KEY(dept_no)
REFERENCES departments (dept_no);

ALTER TABLE dept_manager ADD CONSTRAINT fk_dept_manager_emp_no FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);

ALTER TABLE employees ADD CONSTRAINT fk_employees_emp_title_id FOREIGN KEY(emp_title_id)
REFERENCES titles (title_id);

ALTER TABLE salaries ADD CONSTRAINT fk_salaries_emp_no FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);

-- Copying data from csv files
-- Will only work on my computer because of the filepath to the csv files.
-- https://stackoverflow.com/questions/2987433/how-to-import-csv-file-data-into-a-postgresql-table
-- https://www.postgresql.org/docs/current/sql-copy.html
COPY departments FROM '/Users/rmbp2015/Dropbox (Personal)/DABC/Challenges/07__SQL__sql-challenge/data/departments.csv' DELIMITER ',' CSV HEADER;
COPY dept_emp FROM '/Users/rmbp2015/Dropbox (Personal)/DABC/Challenges/07__SQL__sql-challenge/data/dept_emp.csv' DELIMITER ',' CSV HEADER;
COPY dept_manager FROM '/Users/rmbp2015/Dropbox (Personal)/DABC/Challenges/07__SQL__sql-challenge/data/dept_manager.csv' DELIMITER ',' CSV HEADER;
COPY employees FROM '/Users/rmbp2015/Dropbox (Personal)/DABC/Challenges/07__SQL__sql-challenge/data/employees.csv' DELIMITER ',' CSV HEADER;
COPY salaries FROM '/Users/rmbp2015/Dropbox (Personal)/DABC/Challenges/07__SQL__sql-challenge/data/salaries.csv' DELIMITER ',' CSV HEADER;
COPY titles FROM '/Users/rmbp2015/Dropbox (Personal)/DABC/Challenges/07__SQL__sql-challenge/data/titles.csv' DELIMITER ',' CSV HEADER;

-- See the current directory
SHOW data_directory;

-- Querying tables
SELECT * FROM departments;
SELECT * FROM dept_emp;
SELECT * FROM dept_manager;
SELECT * FROM employees;
SELECT * FROM salaries;
SELECT * FROM titles;

-- Querying tables to check length of tables
SELECT COUNT(*) FROM departments;  -- 9
SELECT COUNT(*) FROM dept_emp;     -- 331603
SELECT COUNT(*) FROM dept_manager; -- 24
SELECT COUNT(*) FROM employees;    -- 300024
SELECT COUNT(*) FROM salaries;     -- 300024
SELECT COUNT(*) FROM titles;       -- 7

-- There are duplicates in the data; 31579 duplicates
SELECT emp_no, COUNT(*) FROM dept_emp GROUP BY emp_no HAVING COUNT(*) > 1;