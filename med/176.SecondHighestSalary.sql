-- Table: Employee

-- +-------------+------+
-- | Column Name | Type |
-- +-------------+------+
-- | id          | int  |
-- | salary      | int  |
-- +-------------+------+
-- id is the primary key (column with unique values) for this table.
-- Each row of this table contains information about the salary of an employee.
 

-- Write a solution to find the second highest distinct salary from the Employee table. If there is no second highest salary, return null (return None in Pandas).

-- The result format is in the following example.

 

-- Example 1:

-- Input: 
-- Employee table:
-- +----+--------+
-- | id | salary |
-- +----+--------+
-- | 1  | 100    |
-- | 2  | 200    |
-- | 3  | 300    |
-- +----+--------+
-- Output: 
-- +---------------------+
-- | SecondHighestSalary |
-- +---------------------+
-- | 200                 |
-- +---------------------+
-- Example 2:

-- Input: 
-- Employee table:
-- +----+--------+
-- | id | salary |
-- +----+--------+
-- | 1  | 100    |
-- +----+--------+
-- Output: 
-- +---------------------+
-- | SecondHighestSalary |
-- +---------------------+
-- | null                |
-- +---------------------+


-- Query to find the second highest distinct salary from the Employee table
-- If there is no second-highest salary, the query ensures NULL is returned

SELECT MAX(salary) AS SecondHighestSalary 
FROM Employee 
WHERE salary < (SELECT MAX(salary) FROM Employee);

-- Method 1: Using MAX and a subquery to find the second highest salary
-- Explanation:
-- 1. The inner query "SELECT MAX(salary) FROM Employee" fetches the highest salary.
-- 2. The outer query filters salaries less than the highest salary and finds the maximum among them.
-- 3. If there is no second-highest salary (i.e., only one distinct salary exists), the result is NULL.

SELECT 
    (SELECT DISTINCT salary 
     FROM Employee 
     ORDER BY salary DESC 
     LIMIT 1 OFFSET 1) AS SecondHighestSalary;

-- Method 2: Using DISTINCT, ORDER BY, LIMIT, and OFFSET to find the second highest salary
-- Explanation:
-- 1. The subquery "SELECT DISTINCT salary FROM Employee ORDER BY salary DESC" orders distinct salaries in descending order.
-- 2. "LIMIT 1 OFFSET 1" skips the first row (highest salary) and fetches the second row (second-highest salary).
-- 3. If there is no second row, the result is an empty set, which returns NULL when used in the outer query.
-- if subquery is not used it can return empty if no highest exist instead of null

