
--Create Employees Table to load csv
CREATE TABLE Employees (
	emp_no BIGINT NOT NULL PRIMARY KEY,
	emp_title_id VARCHAR(30) NOT NULL,
	birth_date VARCHAR(30) NOT NULL,
	first_name VARCHAR(30) NOT NULL,
	last_name VARCHAR(30) NOT NULL,
	sex VARCHAR(5) NOT NULL,
	hire_date VARCHAR(30) NOT NULL
);

--Create Employee_Department Table to load csv
CREATE TABLE Employee_Department (
	emp_no BIGINT NOT NULL,
	dept_no VARCHAR(10) NOT NULL
);

--Create Salaries Table to load csv
CREATE TABLE Salaries (
	emp_no BIGINT NOT NULL,
	salary bigint NOT NULL
);

--Create Titles Table to load csv
CREATE TABLE Titles (
	title_id VARCHAR(10) NOT NULL PRIMARY KEY,
	title VARCHAR(30) NOT NULL
);

--Create Departments Table to load csv
CREATE TABLE Departments (
	dept_no VARCHAR(10) NOT NULL PRIMARY KEY,
	dept_name VARCHAR(30) NOT NULL
);

--Create Department_Management Table to load csv
CREATE TABLE Department_Management (
	dept_no VARCHAR(10) NOT NULL,
	emp_no bigint NOT NULL
);


--Join Tables to create comprehensive employee table
CREATE TABLE add_dept AS
SELECT employees.emp_no, employees.emp_title_id, employees.birth_date, 
employees.first_name, employees.last_name, employees.sex, employees.hire_date,
employee_department.dept_no
FROM employees
LEFT OUTER JOIN employee_department
ON employees.emp_no = employee_department.emp_no;

CREATE TABLE add_salaries AS
SELECT add_dept.emp_no, add_dept.emp_title_id, add_dept.birth_date, 
add_dept.first_name, add_dept.last_name, add_dept.sex, add_dept.hire_date,
add_dept.dept_no, salaries.salary
FROM add_dept
LEFT OUTER JOIN salaries
ON add_dept.emp_no = salaries.emp_no;

CREATE TABLE add_departments AS
SELECT add_salaries.emp_no, add_salaries.emp_title_id, add_salaries.birth_date, 
add_salaries.first_name, add_salaries.last_name, add_salaries.sex, add_salaries.hire_date,
add_salaries.dept_no, add_salaries.salary, departments.dept_name
FROM add_salaries
LEFT OUTER JOIN departments
ON add_salaries.dept_no = departments.dept_no;

CREATE TABLE add_titles AS
SELECT add_departments.emp_no, add_departments.emp_title_id, add_departments.birth_date, 
add_departments.first_name, add_departments.last_name, add_departments.sex, add_departments.hire_date,
add_departments.dept_no, add_departments.salary, add_departments.dept_name,
titles.title
FROM add_departments
LEFT OUTER JOIN titles
ON add_departments.emp_title_id = titles.title_id;

-- Finalized combined Employee Table
CREATE TABLE employee_data AS
SELECT add_titles.emp_no as "Employee Number", add_titles.first_name as "First Name", 
add_titles.last_name as "Last Name",  add_titles.birth_date as "DOB", 
add_titles.sex as "Sex", add_titles.hire_date as "Hire Date", add_titles.dept_name as "Department",
add_titles.title as "Title", add_titles.salary as "Salary"
FROM add_titles;


--Join Tables to create comprehensive Manager table
CREATE TABLE manager_add_department AS
SELECT department_management.emp_no, department_management.dept_no, departments.dept_name
FROM department_management
LEFT OUTER JOIN departments
ON department_management.dept_no = departments.dept_no;

-- Finalized combined Manager Table
CREATE TABLE manager_data AS
SELECT manager_add_department.emp_no, manager_add_department.dept_name, 
manager_add_department.dept_no, employees.first_name, employees.last_name
FROM manager_add_department
LEFT OUTER JOIN employees
ON manager_add_department.emp_no = employees.emp_no;