create database sample;

drop database sample;

use sample;

create table dept(
deptno int unsigned,
danme varchar(50),
loc varchar(50),
primary key (deptno));


create table employee(
empno int unsigned NOT NULL UNIQUE,
ename varchar(40),
job varchar(40) default 'Clerk',
mgr int unsigned,
hiredate date,
sal decimal(6,2),
comm decimal(6,2),
deptno int unsigned,
check (sal>0),
foreign key (deptno) references dept(deptno));

insert into dept values
(10,'OPERATIONS','BOSTON'),
(20,'RESEARCH','DALLAS'),
(30,'SALES','CHICAGO'),
(40,'ACCOUNTING','NEW YORK');

select * from dept;

insert into employee values 
(7369,'SMITH','CLERK',7902,'1890-12-17',800.00,NULL,20),
(7499,'ALLEN','SALESMAN',7698,'1981-02-20',1600.00,300.00,30),
(7521,'WARD','SALESMAN',7698,'1981-02-22',1250.00,500.00,30),
(7566,'JONES','MANAGER',7839,'1981-04-02',2975.00,NULL,20),
(7654,'MARTIN','SALESMAN',7698,'1981-09-28',1250.00,1400.00,30),
(7698,'BLAKE','MANAGER',7839,'1981-05-01',2850.00,NULL,30),
(7782,'CLARK','MANAGER',7839,'1981-06-09',2450.00,NULL,10),
(7788,'SCOTT','ANALYST',7566,'1987-04-19',3000.00,NULL,20),
(7839,'KING','PRESIDENT',NULL,'1981-11-17',5000.00,NULL,10),
(7844,'TURNER','SALESMAN',7698,'1981-09-08',1500.00,0.00,30),
(7876,'ADAMS','CLERK',7788,'1987-05-23',1100.00,NULL,20),
(7900,'JAMES','CLERK',7698,'1981-12-03',950.00,NULL,30),
(7902,'FORD','ANALYST',7566,'1981-12-03',3000.00,NULL,20),
(7934,'MILLER','CLERK',7782,'1982-01-23',1300.00,NULL,10); 

select * from employee;

-- QUESTION 3.	List the Names and salary of the employee whose salary is greater than 1000
select ename AS "Employee Name",sal AS "Salary"
from employee 
where sal>1000;

-- QUESTION 4.	List the details of the employees who have joined before end of September 81.
select * from employee
where hiredate<('1981-09-30');

-- QUESTION 5.	List Employee Names having I as second character.
select ename AS "Employee Name"
from employee
where ename like '_I%';

-- Question 6.	List Employee Name, Salary, Allowances (40% of Sal), P.F. (10 % of Sal) and Net Salary. Also assign the alias name for the columns
select ename AS "Employee Name",sal AS "Salary",sal*0.4 Allowance,sal*0.1 PF
from employee; 

-- QUESTION 7.	  List Employee Names with designations who does not report to anybody
select * from employee
where job='PRESIDENT';

-- QUESTION 8.	List Empno, Ename and Salary in the ascending order of salary.
select empno,ename,sal
from employee
order by sal ASC;

-- QUESTION 9.	How many jobs are available in the Organization ?
SELECT COUNT(DISTINCT job) 
FROM employee;

-- QUESTION 10.	Determine total payable salary of salesman category
select job,sum(sal) 
from employee
where job='SALESMAN';

-- QUESTION 11.	List average monthly salary for each job within each department   
select job,avg(sal)
from employee
group by job;

-- QUESTION 12.	Use the Same EMP and DEPT table used in the Case study to Display EMPNAME, SALARY and DEPTNAME in which the employee is working
select ename AS "EMPNAME",sal AS "SALARY",danme AS "DEPTNAME"
from employee,dept
where employee.deptno=dept.deptno;

-- QUESTION 13.	  Create the Job Grades Table as below
create table job_grades(
grade varchar(10),
lowest_sal int unsigned,
highest_sal int unsigned);

insert into job_grades values
('A',0,999),
('B',1000,1999),
('C',2000,2999),
('D',3000,3999),
('E',4000,5000);

select * from job_grades;

-- QUESTION 14.	Display the last name, salary and  Corresponding Grade.
select ename AS "Employee Name",sal AS "Salary",grade
from employee
join job_grades
on sal between lowest_sal and highest_sal;

-- QUESTION 15.	Display the Emp name and the Manager name under whom the Employee works in the below format .
select e.ename AS "Employee Name",m.ename AS "Manager"
from employee e
left outer join employee m
on e.mgr=m.empno;

-- QUESTION 16.	Display Empname and Total sal where Total Sal (sal + Comm)
select ename AS "Employee Name",(sal+ifnull(comm,0)) AS "Total Salary"
from employee;

-- QUESTION 17.	Display Empname and Sal whose empno is a odd number
select ename AS "Employee Name",sal AS "Salary",empno
from employee
where empno%2<>0;

-- QUESTION 18.	Display Empname , Rank of sal in Organisation , Rank of Sal in their department

SELECT Deptno Ename, Sal FROM Employee 
WHERE (Deptno,Sal) IN (SELECT Deptno, MAX(Sal) 
FROM Employee GROUP BY Deptno);

-- QUESTION 19.	Display Top 3 Empnames based on their Salary
SELECT * FROM employee
ORDER BY sal DESC limit 3;

-- QUESTION 20.	 Display Empname who has highest Salary in Each Department.
select ename,deptno,sal
from employee
where employee.sal in
(select max(sal)
from employee
group by deptno)order by sal desc;


