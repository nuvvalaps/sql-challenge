--1. List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT DISTINCT "Employee Number", "Last Name", "First Name", "Sex", "Salary" FROM employee_data ORDER BY "Employee Number";

--2. List first name, last name, and hire date for employees who were hired in 1986.
SELECT DISTINCT "Employee Number", "Last Name", "First Name", "Hire Date" FROM employee_data WHERE "Hire Date" LIKE '%1986' ORDER BY "Employee Number";

--3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
SELECT dept_no as "Department Number", dept_name as "Department", emp_no as "Employee Number", last_name as "Last Name", first_name as "First Name" FROM manager_data;

--4. List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT "Employee Number", "Last Name", "First Name", "Department" FROM employee_data;

--5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT "First Name", "Last Name", "Sex" FROM employee_data WHERE "First Name" LIKE 'Hercules' AND "Last Name" LIKE 'B%';

--6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT "Employee Number", "Last Name", "First Name", "Department" FROM employee_data WHERE "Department" LIKE 'Sales';

--7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT "Employee Number", "Last Name", "First Name", "Department" FROM employee_data WHERE "Department" LIKE 'Sales' OR "Department" LIKE 'Development';

--8. List the frequency count of employee last names (i.e., how many employees share each last name) in descending order.
Select COUNT ("Last Name") as ct, "Last Name" FROM employee_data GROUP BY "Last Name" ORDER BY ct DESC;