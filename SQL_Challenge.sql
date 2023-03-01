--DATA ENGINEERING

CREATE TABLE departments(
	dept_no VARCHAR(30) PRIMARY KEY,
	dept_name VARCHAR(30)
);

SELECT * 
FROM departments

CREATE TABLE titles(
	title_id VARCHAR(30) PRIMARY KEY,
	title VARCHAR (30)

);

SELECT * 
FROM titles

Create TABLE employees(
	emp_no INT PRIMARY KEY,
	emp_title_id VARCHAR (30),
	FOREIGN KEY (emp_title_id) REFERENCES titles (title_id),
	birth_date DATE,
	first_name VARCHAR(30),
	last_name VARCHAR(30),
	sex VARCHAR(30),
	hire_date DATE
);

SELECT * 
FROM employees

CREATE TABLE dept_emp(
	emp_no INT,
	FOREIGN KEY (emp_no)REFERENCES employees (emp_no),
	dept_no VARCHAR(30),
	FOREIGN KEY (dept_no)REFERENCES departments(dept_no)
);

SELECT * 
FROM dept_emp

CREATE TABLE dept_manager(
	dept_no VARCHAR(30),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	emp_no INT,
	FOREIGN KEY (emp_no)REFERENCES employees (emp_no)
);

SELECT * 
FROM dept_manager

CREATE TABLE salaries(
	emp_no INT,
	FOREIGN KEY (emp_no)REFERENCES employees (emp_no),
	salary INT
);

SELECT * 
FROM salaries

--DATA ANALYSIS 
-- 1.List the employee number, last name, first name, sex, and salary of each employee
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees
INNER JOIN salaries ON
salaries.emp_no= employees.emp_no

--2.List the first name, last name, and hire date for the employees who were hired in 1986. 

SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-21';

--3.List the manager of each department along with their department number, department name, employee number, last name, and first name.

SELECT dept_manager.emp_no as manager_no, dept_manager.dept_no, departments.dept_name, employees.last_name, employees.first_name
FROM employees
INNER JOIN dept_manager ON
dept_manager.emp_no= employees.emp_no
INNER JOIN departments ON
dept_manager.dept_no= departments.dept_no

--4. List the department number for each employee along with that employee’s employee number, last name, first name, and department name.

SELECT dept_emp.dept_no, dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
INNER JOIN departments ON
departments.dept_no= dept_emp.dept_no
INNER JOIN employees ON
employees.emp_no=dept_emp.emp_no

--5.List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B. 

SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%'

--6. List each employee in the Sales department, including their employee number, last name, and first name
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
INNER JOIN dept_emp ON
dept_emp.emp_no= employees.emp_no
INNER JOIN departments ON
departments.dept_no = dept_emp.dept_no
WHERE departments.dept_name = 'Sales'

--7. List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
INNER JOIN dept_emp ON
dept_emp.emp_no= employees.emp_no
INNER JOIN departments ON
departments.dept_no = dept_emp.dept_no
WHERE departments.dept_name = 'Sales'
OR departments.dept_name='Development'

--8. List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT last_name, COUNT(last_name) AS "total_count"
FROM employees
GROUP BY last_name
ORDER BY "total_count" DESC
