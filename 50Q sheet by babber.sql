CREATE DATABASE ORG;
SHOW DATABASES;
USE ORG;

CREATE TABLE Worker (
	WORKER_ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	FIRST_NAME CHAR(25),
	LAST_NAME CHAR(25),
	SALARY INT(15),
	JOINING_DATE DATETIME,
	DEPARTMENT CHAR(25)
);

INSERT INTO Worker 
	(WORKER_ID, FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT) VALUES
		(001, 'Monika', 'Arora', 100000, '14-02-20 09.00.00', 'HR'),
		(002, 'Niharika', 'Verma', 80000, '14-06-11 09.00.00', 'Admin'),
		(003, 'Vishal', 'Singhal', 300000, '14-02-20 09.00.00', 'HR'),
		(004, 'Amitabh', 'Singh', 500000, '14-02-20 09.00.00', 'Admin'),
		(005, 'Vivek', 'Bhati', 500000, '14-06-11 09.00.00', 'Admin'),
		(006, 'Vipul', 'Diwan', 200000, '14-06-11 09.00.00', 'Account'),
		(007, 'Satish', 'Kumar', 75000, '14-01-20 09.00.00', 'Account'),
		(008, 'Geetika', 'Chauhan', 90000, '14-04-11 09.00.00', 'Admin');
        
SELECT * FROM Worker;

CREATE TABLE Bonus (
	WORKER_REF_ID INT,
	BONUS_AMOUNT INT(10),
	BONUS_DATE DATETIME,
	FOREIGN KEY (WORKER_REF_ID)
		REFERENCES Worker(WORKER_ID)
        ON DELETE CASCADE
);

INSERT INTO Bonus 
	(WORKER_REF_ID, BONUS_AMOUNT, BONUS_DATE) VALUES
		(001, 5000, '16-02-20'),
		(002, 3000, '16-06-11'),
		(003, 4000, '16-02-20'),
		(001, 4500, '16-02-20'),
		(002, 3500, '16-06-11');
        
CREATE TABLE Title (
	WORKER_REF_ID INT,
	WORKER_TITLE CHAR(25),
	AFFECTED_FROM DATETIME,
	FOREIGN KEY (WORKER_REF_ID)
		REFERENCES Worker(WORKER_ID)
        ON DELETE CASCADE
);

INSERT INTO Title 
	(WORKER_REF_ID, WORKER_TITLE, AFFECTED_FROM) VALUES
 (001, 'Manager', '2016-02-20 00:00:00'),
 (002, 'Executive', '2016-06-11 00:00:00'),
 (008, 'Executive', '2016-06-11 00:00:00'),
 (005, 'Manager', '2016-06-11 00:00:00'),
 (004, 'Asst. Manager', '2016-06-11 00:00:00'),
 (007, 'Executive', '2016-06-11 00:00:00'),
 (006, 'Lead', '2016-06-11 00:00:00'),
 (003, 'Lead', '2016-06-11 00:00:00');

-- Q-1. Write an SQL query to fetch “FIRST_NAME” from Worker table using the alias name as <WORKER_NAME>.
select first_name as WORKER_NAME from Worker;



-- Q-2. Write an SQL query to fetch “FIRST_NAME” from Worker table in upper case.
select upper(first_name) from Worker;

-- Q-3. Write an SQL query to fetch unique values of DEPARTMENT from Worker table.
select distinct department from worker;

-- Q-4. Write an SQL query to print the first three characters of  FIRST_NAME from Worker table.
select substring(first_name,1,3) from worker;

-- Q-5. Write an SQL query to find the position of the alphabet (‘b’) in the first name column ‘Amitabh’ from Worker table.

select instr(first_name,'B') from worker where first_name = "Amitabh";
-- Q-6. Write an SQL query to print the FIRST_NAME from Worker table after removing white spaces from the right side.
select rtrim(first_name) from worker;

-- Q-7. Write an SQL query to print the DEPARTMENT from Worker table after removing white spaces from the left side.
select rtrim(first_name) from worker;

-- Q-8. Write an SQL query that fetches the unique values of DEPARTMENT from Worker table and prints its length.
select distinct department, length(department) from worker;

-- Q-9. Write an SQL query to print the FIRST_NAME from Worker table after replacing ‘a’ with ‘A’.
select replace(first_name,'a','A') from worker;


-- Q-10. Write an SQL query to print the FIRST_NAME and LAST_NAME from Worker table into a single column COMPLETE_NAME.
-- A space char should separate them.
select concat(first_name,' ',last_name) as complete_name from worker;


-- Q-11. Write an SQL query to print all Worker details from the Worker table order by FIRST_NAME Ascending.
select * from worker order by first_name asc; 

-- Q-12. Write an SQL query to print all Worker details from the Worker table order by 
-- FIRST_NAME Ascending and DEPARTMENT Descending.

select * from worker order by first_name asc, department desc; 


-- Q-13. Write an SQL query to print details for Workers with the first name as “Vipul” and “Satish” from Worker table.
select * from worker where first_name=  "vipul" or first_name= 'satish' ;
-- other to or
select * from worker where first_name in('vipul','satish');

-- Q-14. Write an SQL query to print details of workers excluding first names, “Vipul” and “Satish” from Worker table.
select * from worker where first_name!= "vipul" and first_name!= 'satish' ;
-- other to and 
select * from worker where first_name not in('vipul','satish');
 
-- Q-15. Write an SQL query to print details of Workers with DEPARTMENT name as “Admin*”.
select * from worker where department like 'admin%';

-- Q-16. Write an SQL query to print details of the Workers whose FIRST_NAME contains ‘a’.
select * from worker where first_name like '%a%' ;


-- Q-17. Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘a’
select * from worker where first_name like '%a' ;

-- Q-18. Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘h’ and contains six alphabets.
select * from worker where first_name like '%a' and length(first_name)=6 ;

-- Q-19. Write an SQL query to print details of the Workers whose SALARY lies between 100000 and 500000.
select * from worker where salary>=100000 and salary<=500000;
-- or 
select * from worker where salary between 100000 and 500000;

-- Q-20. Write an SQL query to print details of the Workers who have joined in Feb’2014.
select * from worker where joining_date like '2014-02%';
-- or 
select * from worker where year(joining_date)=2014 and month(joining_date)=2;

-- Q-21. Write an SQL query to fetch the count of employees working in the department ‘Admin’.
-- select department, count(*) from worker group by department ; 
select department, count(*) from worker where department = 'admin' ; 


-- Q-22. Write an SQL query to fetch worker full names with salaries >= 50000 and <= 100000.
select concat(first_name," ",last_name) as full_name from worker where salary between 50000 and 100000;


-- Q-23. Write an SQL query to fetch the no. of workers for each department in the descending order.
select department, count(*) as count from worker group by department order by count desc;

-- Q-24. Write an SQL query to print details of the Workers who are also Managers.
select * from worker_clone;

select t1.* from worker t1 inner join title t2 on t1.WORKER_ID = t2.WORKER_REF_ID where t2.WORKER_TITLE = 'Manager';

-- Q-25. Write an SQL query to fetch number (more than 1) of same titles in the ORG of different types.
select WORKER_TITLE,count(*) as number from title group by WORKER_TITLE having count(WORKER_TITLE)>1; 

-- Q-26. Write an SQL query to show only odd rows from a table.
select * from worker where mod(worker_id,2)!=0;

-- Q-27. Write an SQL query to show only even rows from a table. 
select * from worker where mod(worker_id,2)=0;

-- Q-28. Write an SQL query to clone a new table from another table.
create table worker_clone like worker;
insert into worker_clone select * from worker;

-- Q-29. Write an SQL query to fetch intersecting records of two tables.
select * from worker inner join bonus on worker.worker_id = bonus.worker_ref_id;

-- Q-30. Write an SQL query to show records from one table that another table does not have.
-- MINUS

select t1.* from worker t1 inner join title t2 on t1.worker_id = t2.worker_ref_id where t2.worker_ref_id is null;


-- Q-31. Write an SQL query to show the current date and time.
-- DUAL
SELECT CURRENT_TIMESTAMP;
select curdate();
select now();

-- Q-32. Write an SQL query to show the top n (say 5) records of a table order by descending salary.
select * from worker order by salary desc limit 5;

-- Q-33. Write an SQL query to determine the nth (say n=5) highest salary from a table.
select first_name,salary as nth_highest_salary from worker order by salary desc limit 4,1;

-- Q-34. Write an SQL query to determine the 5th highest salary without using LIMIT keyword.
-- need to learn co related subquery
select salary from worker w1
WHERE 4 = (
SELECT COUNT(DISTINCT (w2.salary))
from worker w2
where w2.salary >= w1.salary
);

 
-- Q-35. Write an SQL query to fetch the list of employees with the same salary.
select * from worker;
select * from worker w1, worker w2  where w1.salary = w2.salary and  w1.worker_id != w2.worker_id;

-- Q-36. Write an SQL query to show the second highest salary from a table using sub-query.
select * from worker where salary = (
	select salary from worker order by salary desc limit 1,1
);


SELECT *
FROM worker
WHERE salary = (
    SELECT MAX(salary)
    FROM worker
    WHERE salary < (
        SELECT MAX(salary)
        FROM worker
    )
);

select max(salary) from worker 
where salary not in ( select max(salary) from worker);

SELECT MAX(salary)
FROM worker
WHERE salary < (SELECT MAX(salary) FROM worker);

-- third highest 

SELECT MAX(salary) FROM worker
WHERE salary NOT IN (
    SELECT MAX(salary) FROM worker
    WHERE salary NOT IN (
        SELECT MAX(salary)FROM worker
    )
);

-- Q-37. Write an SQL query to show one row twice in results from a table.
select * from worker
UNION ALL   -- only union will give distinct values so use all with it 
select * from worker ORDER BY worker_id;

-- Q-38. Write an SQL query to list worker_id who does not get bonus.
select * from bonus;

select WORKER_ID from worker where worker_id not in (
	select WORKER_REF_ID from bonus
    );

select t1.WORKER_ID from worker t1 left join bonus t2 on t1.WORKER_ID = t2.WORKER_REF_ID where t2.WORKER_REF_ID is null; 

-- Q-39. Write an SQL query to fetch the first 50% records from a table.
select * from worker where worker_id <= (select count(WORKER_ID)/2 from worker ) ;

-- Q-40. Write an SQL query to fetch the departments that have less than 4 people in it.
select department, count(department) as depcount from worker group by department having depcount<4;

-- Q-41. Write an SQL query to show all departments along with the number of people in there.
select department, count(department) as peoplecount from worker group by department;

-- Q-42. Write an SQL query to show the last record from a table.
select * from worker where WORKER_ID= (
select max(WORKER_ID) from worker
);

-- Q-43. Write an SQL query to fetch the first row of a table.
select * from worker where WORKER_ID= (select min(WORKER_ID) from worker);

select * from worker limit 0,1;
select * from worker limit 1;

-- Q-44. Write an SQL query to fetch the last five records from a table.
(select * from worker order by worker_id desc limit 0,5) order by WORKER_ID asc;
(select * from worker order by worker_id desc limit 5) order by WORKER_ID asc;

-- Q-45. Write an SQL query to print the name of employees having the highest salary in each department.
select * from worker;
select * from worker where salary = ( select max(salary)from worker where DEPARTMENT = 'account') union
select * from worker where salary = ( select max(salary)from worker where DEPARTMENT = 'admin') union
select * from worker where salary = ( select max(salary)from worker where DEPARTMENT = 'hr') ;

select department, max(salary) as max_salary from worker group by DEPARTMENT;

select w.department, w.first_name, w.salary from
 (select max(salary) as maxsal, department from worker group by department) temp
inner join worker w on temp.department = w.department and temp.maxsal = w.salary;


-- Q-46. Write an SQL query to fetch three max salaries from a table using co-related subquery
select distinct salary from worker w1
where 3 >= (select count(distinct salary) from worker w2 where w1.salary <= w2.salary) order by w1.salary desc;
-- DRY RUN AFTER REVISING THE CORELATED SUBQUERY CONCEPT FROM LEC-9.
select distinct salary from worker order by salary desc limit 3;

-- Q-47. Write an SQL query to fetch three min salaries from a table using co-related subquery
select distinct salary from worker w1
where 3 >= (select count(distinct salary) from worker w2 where w1.salary >= w2.salary) order by w1.salary desc;

-- Q-48. Write an SQL query to fetch nth max salaries from a table.
select salary from worker order by salary desc limit 5,1;

select distinct salary from worker w1
where n >= (select count(distinct salary) from worker w2 where w1.salary <= w2.salary) order by w1.salary desc;

-- Q-49. Write an SQL query to fetch departments along with the total salaries paid for each of them.
select department, sum(salary) as total_salary from worker group by DEPARTMENT; 

-- Q-50. Write an SQL query to fetch the names of workers who earn the highest salary.
select first_name from worker where salary = (select max(salary) from worker);







 