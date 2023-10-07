-- Create 'departments' table
CREATE TABLE departments (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    manager_id INT
);

-- Create 'employees' table
CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    hire_date DATE,
    job_title VARCHAR(50),
    department_id INT REFERENCES departments(id)
);

-- Create 'projects' table
CREATE TABLE projects (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    start_date DATE,
    end_date DATE,
    department_id INT REFERENCES departments(id)
);

-- Insert data into 'departments'
INSERT INTO departments (name, manager_id)
VALUES ('HR', 1), ('IT', 2), ('Sales', 3);

-- Insert data into 'employees'
INSERT INTO employees (name, hire_date, job_title, department_id)
VALUES ('John Doe', '2018-06-20', 'HR Manager', 1),
       ('Jane Smith', '2019-07-15', 'IT Manager', 2),
       ('Alice Johnson', '2020-01-10', 'Sales Manager', 3),
       ('Bob Miller', '2021-04-30', 'HR Associate', 1),
       ('Charlie Brown', '2022-10-01', 'IT Associate', 2),
       ('Dave Davis', '2023-03-15', 'Sales Associate', 3);

-- Insert data into 'projects'
INSERT INTO projects (name, start_date, end_date, department_id)
VALUES ('HR Project 1', '2023-01-01', '2023-06-30', 1),
       ('IT Project 1', '2023-02-01', '2023-07-31', 2),
       ('Sales Project 1', '2023-03-01', '2023-08-31', 3);
     SET SQL_SAFE_UPDATES = 0;  
       UPDATE departments
SET manager_id = (SELECT id FROM employees WHERE name = 'John Doe')
WHERE name = 'HR';

UPDATE departments
SET manager_id = (SELECT id FROM employees WHERE name = 'Jane Smith')
WHERE name = 'IT';

UPDATE departments
SET manager_id = (SELECT id FROM employees WHERE name = 'Alice Johnson')
WHERE name = 'Sales';

select * from departments;
select * from projects;
select * from employees;

/* Find the longest ongoing project for each department.*/
select d.name,datediff(p.end_date,p.start_date) as no_of_days
from projects p
join departments d on d.id = p.department_id
Order by no_of_days desc
limit 1;

/* Find all employees who are not managers.*/
select e.id,e.name 
from employees e
left join departments d on e.id = d.manager_id
where d.manager_id is null;

/* Find all employees who have been hired after the start of a project in their department.*/
select e.name as EmployeeName,d.name as DepartmentName
from employees e 
join departments d on e.department_id = d.id
join projects p on p.department_id = d.id
where e.hire_date > p.start_date;

/* Rank employees within each department based on their hire date (earliest hire gets the highest rank).*/
select e.name as EmployeeName,d.name as DepartmentName,e.hire_date,
rank() over(partition by d.name order by e.hire_date) as rnk
from employees e 
join departments d on e.department_id =d.id;

/* Find the duration between the hire date of each employee 
and the hire date of the next employee hired in the same department.*/

select e.name as employeename,d.name as departmentname,e.hire_date as current_hire_date,
lead(e.hire_date) over(partition by e.department_id order by e.hire_date) as next_hire_date,
datediff(lead(e.hire_date) over(partition by e.department_id order by e.hire_date),e.hire_date)
as duration_in_days
from employees e
join departments d on d.id = e.department_id;

