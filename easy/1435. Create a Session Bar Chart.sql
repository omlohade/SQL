
-- Table: Sessions

-- +---------------------+---------+
-- | Column Name         | Type    |
-- +---------------------+---------+
-- | session_id          | int     |
-- | duration            | int     |
-- +---------------------+---------+
-- session_id is the primary key for this table.
-- duration is the time in seconds that a user has visited the application.
 

-- You want to know how long a user visits your application. You decided to create bins of "[0-5>", "[5-10>", "[10-15>" and "15 minutes or more" and count the number of sessions on it.

-- Write an SQL query to report the (bin, total) in any order.

-- The query result format is in the following example.

-- Sessions table:
-- +-------------+---------------+
-- | session_id  | duration      |
-- +-------------+---------------+
-- | 1           | 30            |
-- | 2           | 199           |
-- | 3           | 299           |
-- | 4           | 580           |
-- | 5           | 1000          |
-- +-------------+---------------+

-- Result table:
-- +--------------+--------------+
-- | bin          | total        |
-- +--------------+--------------+
-- | [0-5>        | 3            |
-- | [5-10>       | 1            |
-- | [10-15>      | 0            |
-- | 15 or more   | 1            |
-- +--------------+--------------+

-- For session_id 1, 2 and 3 have a duration greater or equal than 0 minutes and less than 5 minutes.
-- For session_id 4 has a duration greater or equal than 5 minutes and less than 10 minutes.
-- There are no session with a duration greater or equial than 10 minutes and less than 15 minutes.
-- For session_id 5 has a duration greater or equal than 15 minutes.

-- Solution 2
-- First SELECT statement: Count the number of sessions where the duration is less than 5 minutes.
(SELECT '[0-5>' AS bin, 
        -- Calculate the total number of sessions where duration is less than 5 minutes.
        SUM(CASE WHEN duration / 60 < 5 THEN 1 ELSE 0 END) AS total 
 FROM Sessions)

-- UNION to combine with the next SELECT statement.
UNION

-- Second SELECT statement: Count the number of sessions where the duration is between 5 and 10 minutes.
(SELECT '[5-10>' AS bin, 
        -- Calculate the total number of sessions where duration is greater than or equal to 5 minutes
        -- but less than 10 minutes.
        SUM(CASE WHEN (duration / 60 >= 5 AND duration / 60 < 10) THEN 1 ELSE 0 END) AS total 
 FROM Sessions)

-- UNION to combine with the next SELECT statement.
UNION

-- Third SELECT statement: Count the number of sessions where the duration is between 10 and 15 minutes.
(SELECT '[10-15>' AS bin, 
        -- Calculate the total number of sessions where duration is greater than or equal to 10 minutes
        -- but less than 15 minutes.
        SUM(CASE WHEN (duration / 60 >= 10 AND duration / 60 < 15) THEN 1 ELSE 0 END) AS total 
 FROM Sessions)

-- UNION to combine with the next SELECT statement.
UNION

-- Fourth SELECT statement: Count the number of sessions where the duration is 15 minutes or more.
(SELECT '15 or more' AS bin, 
        -- Calculate the total number of sessions where duration is greater than or equal to 15 minutes.
        SUM(CASE WHEN duration / 60 >= 15 THEN 1 ELSE 0 END) AS total 
 FROM Sessions)
