CREATE TABLE "salaries" (
    "emp_no" int   NOT NULL,
    "salary" int   NOT NULL,
    CONSTRAINT "pk_salaries" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "employees" (
    "emp_no" int   NOT NULL,
    "emp_title_id" char(5)   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" varchar(20)   NOT NULL,
    "last_name" varchar(20)   NOT NULL,
    "sex" char(1)   NOT NULL,
    "hire_date" date   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "dept_manager" (
    "dept_no" char(4)   NOT NULL,
    "emp_no" int   NOT NULL,
    CONSTRAINT "pk_dept_manager" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" int   NOT NULL,
    "dept_no" char(4)   NOT NULL
);

CREATE TABLE "departments" (
    "dept_no" char(4)   NOT NULL,
    "dept_name" varchar(30)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "titles" (
    "title_id" char(6)   NOT NULL,
    "title" varchar   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);


ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title_id");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

--Data Analysis
--------------------------------Question 1
-- Salary by employee
SELECT  emp.emp_no,
        emp.last_name,
        emp.first_name,
        emp.sex,
        sal.salary
FROM employees as emp
    LEFT JOIN salaries as sal
    ON (emp.emp_no = sal.emp_no)
ORDER BY emp.emp_no;

---------------------------------Question 2
--Employees hired in 1986
SELECT first_name,
	last_name,
	hire_date
FROM employees
WHERE hire_date BETWEEN '1986-01-01' and '1986-12-31';

---------------------------------Question 3
--Manager of each department
SELECT dept.dept_no,
	dept_names.dept_name,
	emp.emp_no, 
	emp.last_name, 
	emp.first_name 
FROM employees as emp
    INNER JOIN dept_manager as dept
    ON (emp.emp_no = dept.emp_no)
    JOIN titles as dept_titles_managers
    ON (dept_titles_managers.title_id = emp.emp_title_id)
    JOIN departments as dept_names
	ON (dept_names.dept_no=dept.dept_no);
		
---------------------------------Question 4
SELECT dept_name_no.dept_no,
	emp.emp_no,
	emp.last_name,
	emp.first_name,
	depts.dept_name
FROM employees as emp
	INNER JOIN dept_emp as dept_name_no
	ON (emp.emp_no = dept_name_no.emp_no)
	JOIN departments AS depts
	ON (dept_name_no.dept_no= depts.dept_no);

---------------------------------Question 5
SELECT first_name,
	last_name,
	sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

---------------------------------Question 6

SELECT depts.dept_no,
	depts.dept_name,
	emp.emp_no, 
	emp.last_name, 
	emp.first_name 
FROM employees as emp
    JOIN dept_emp AS dept_employee
	ON (emp.emp_no=dept_employee.emp_no)
	JOIN departments as depts
	ON (depts.dept_no=dept_employee.dept_no)
WHERE dept_name = 'Sales';

---------------------------------Question 7
SELECT 
	depts.dept_name,
	emp.emp_no, 
	emp.last_name, 
	emp.first_name 
FROM employees as emp
    JOIN dept_emp AS dept_employee
	ON (emp.emp_no=dept_employee.emp_no)
	JOIN departments as depts
	ON (depts.dept_no=dept_employee.dept_no)
WHERE dept_name = 'Sales' OR dept_name ='Development';

---------------------------------Question 8
SELECT last_name, COUNT(last_name)
FROM employees
GROUP BY last_name
ORDER BY COUNT(last_name) DESC;


