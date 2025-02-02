-- Question 115
-- Write an SQL query to report the distinct titles of the kid-friendly movies streamed in June 2020.

-- Return the result table in any order.

-- The query result format is in the following example.

 

-- TVProgram table:
-- +--------------------+--------------+-------------+
-- | program_date       | content_id   | channel     |
-- +--------------------+--------------+-------------+
-- | 2020-06-10 08:00   | 1            | LC-Channel  |
-- | 2020-05-11 12:00   | 2            | LC-Channel  |
-- | 2020-05-12 12:00   | 3            | LC-Channel  |
-- | 2020-05-13 14:00   | 4            | Disney Ch   |
-- | 2020-06-18 14:00   | 4            | Disney Ch   |
-- | 2020-07-15 16:00   | 5            | Disney Ch   |
-- +--------------------+--------------+-------------+

-- Content table:
-- +------------+----------------+---------------+---------------+
-- | content_id | title          | Kids_content  | content_type  |
-- +------------+----------------+---------------+---------------+
-- | 1          | Leetcode Movie | N             | Movies        |
-- | 2          | Alg. for Kids  | Y             | Series        |
-- | 3          | Database Sols  | N             | Series        |
-- | 4          | Aladdin        | Y             | Movies        |
-- | 5          | Cinderella     | Y             | Movies        |
-- +------------+----------------+---------------+---------------+

-- Result table:
-- +--------------+
-- | title        |
-- +--------------+
-- | Aladdin      |
-- +--------------+
-- "Leetcode Movie" is not a content for kids.
-- "Alg. for Kids" is not a movie.
-- "Database Sols" is not a movie
-- "Alladin" is a movie, content for kids and was streamed in June 2020.
-- "Cinderella" was not streamed in June 2020.

-- Write your SQL query statement below

SELECT DISTINCT c.title
FROM TVProgram t
JOIN Content c
ON t.content_id = c.content_id
WHERE c.Kids_content = 'Y'
AND t.program_date >= '2020-06-01'
AND t.program_date < '2020-07-01'
AND c.content_type = 'Movies';

-- explanation
-- The query joins the TVProgram table with the Content table on the content_id column.
-- It selects the distinct titles of kid-friendly movies streamed in June 2020 by filtering the rows based on the Kids_content, program_date, and content_type columns.
-- The WHERE clause filters the rows where Kids_content is 'Y', program_date is in June 2020, and content_type is 'Movies'.
-- The DISTINCT keyword ensures that only distinct titles are returned in the result set.
-- The query returns the distinct titles of kid-friendly movies streamed in June 2020.


--using subquery

select distinct title
from
(select content_id, title
from content
where kids_content = 'Y' and content_type = 'Movies') a
join
tvprogram using (content_id)
where month(program_date) = 6 and year(program_date) = 2020;

-- explanation
-- The subquery selects the content_id and title from the Content table where Kids_content is 'Y' and content_type is 'Movies'.
-- The main query joins the subquery with the TVProgram table using the content_id column.
-- The WHERE clause filters the rows where the program_date is in June 2020.
-- The DISTINCT keyword ensures that only distinct titles are returned in the result set.
-- The query returns the distinct titles of kid-friendly movies streamed in June 2020.
-- This approach uses a subquery to filter the content table before joining it with the TVProgram table, which can help improve query performance by reducing the number of rows processed in the join operation.
