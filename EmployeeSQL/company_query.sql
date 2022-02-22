-- 1. List the following details of each employee: 
--	  employee number, last name, first name, sex, and salary.
SELECT emp.emp_no, emp.last_name, emp.first_name, emp.sex, sal.salary_no
FROM employees AS emp
JOIN salaries AS sal
ON emp.emp_no = sal.emp_no;


-- 2. List first name, last name, and hire date for employees who were hired in 1986.
SELECT emp.first_name, emp.last_name, emp.hire_date
FROM employees AS emp
WHERE emp.hire_date LIKE '%1986';


-- 3. List the manager of each department with the following information: 
--	  department number, department name, the manager's employee number, last name, first name.
SELECT dm.dept_no, dept.dept_name, dm.emp_no, emp.last_name, emp.first_name
FROM dept_manager AS dm
JOIN departments AS dept
ON dm.dept_no = dept.dept_no
JOIN employees AS emp
ON dm.emp_no = emp.emp_no;


-- 4. List the department of each employee with the following information: 
--	  employee number, last name, first name, and department name.
SELECT emp.emp_no, emp.last_name, emp.first_name, dept.dept_name
FROM employees AS emp
JOIN dept_emp AS de
ON emp.emp_no = de.emp_no
JOIN departments AS dept
ON de.dept_no = dept.dept_no;


-- 5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';


-- 6. List all employees in the Sales department, including their 
--	  employee number, last name, first name, and department name.
-- Want to keep this code because I was working on figuring out how to make WITH clause work
-- SELECT de.emp_no, dept.dept_name
-- FROM dept_emp AS de
-- JOIN departments AS dept
-- ON de.dept_no = dept.dept_no
-- WHERE dept.dept_name = 'Sales';

-- WITH sales AS
-- 	(SELECT *
-- 	 FROM departments AS dept
-- 	 WHERE dept.dept_name = 'Sales')
-- SELECT de.emp_no, s.dept_name
-- FROM dept_emp AS de
-- JOIN sales AS s
-- ON de.dept_no = s.dept_no;

WITH sales AS
	(SELECT *
	 FROM departments AS dept
	 WHERE dept.dept_name = 'Sales'),
	 sales_emp AS
	(SELECT *
	 FROM dept_emp AS de
	 JOIN sales AS s
	 ON de.dept_no = s.dept_no)
SELECT emp.emp_no, emp.last_name, emp.first_name, se.dept_name
FROM employees AS emp
JOIN sales_emp AS se
ON emp.emp_no = se.emp_no;


-- 7. List all employees in the Sales and Development departments, including their 
--	  employee number, last name, first name, and department name.
-- WITH clause version
WITH sale_dev AS
	(SELECT *
	 FROM departments AS dept
	 WHERE dept.dept_name = 'Sales' OR dept.dept_name = 'Development'),
	 sale_dev_emp AS
	(SELECT *
	 FROM dept_emp AS de
	 JOIN sale_dev AS sd
	 ON de.dept_no = sd.dept_no)
SELECT emp.emp_no, emp.last_name, emp.first_name, sde.dept_name
FROM employees AS emp
JOIN sale_dev_emp AS sde
ON emp.emp_no = sde.emp_no;

-- Multi-JOIN version
SELECT emp.emp_no, emp.last_name, emp.first_name, dept.dept_name
FROM dept_emp AS de
JOIN departments AS dept
ON de.dept_no = dept.dept_no
JOIN employees AS emp
ON emp.emp_no = de.emp_no
WHERE dept.dept_name = 'Sales' OR dept.dept_name = 'Development';


-- 8. In descending order, list the frequency count of employee last names
--    (i.e. how many employees share each last name.)
SELECT emp.last_name, COUNT(*)
FROM employees AS emp
GROUP BY emp.last_name
ORDER BY 2 DESC;