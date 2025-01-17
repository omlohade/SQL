-- Table: Views

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | article_id    | int     |
-- | author_id     | int     |
-- | viewer_id     | int     |
-- | view_date     | date    |
-- +---------------+---------+
-- There is no primary key (column with unique values) for this table, the table may have duplicate rows.
-- Each row of this table indicates that some viewer viewed an article (written by some author) on some date. 
-- Note that equal author_id and viewer_id indicate the same person.
 

-- Write a solution to find all the authors that viewed at least one of their own articles.

-- Return the result table sorted by id in ascending order.

-- The result format is in the following example.

 

-- Example 1:

-- Input: 
-- Views table:
-- +------------+-----------+-----------+------------+
-- | article_id | author_id | viewer_id | view_date  |
-- +------------+-----------+-----------+------------+
-- | 1          | 3         | 5         | 2019-08-01 |
-- | 1          | 3         | 6         | 2019-08-02 |
-- | 2          | 7         | 7         | 2019-08-01 |
-- | 2          | 7         | 6         | 2019-08-02 |
-- | 4          | 7         | 1         | 2019-07-22 |
-- | 3          | 4         | 4         | 2019-07-21 |
-- | 3          | 4         | 4         | 2019-07-21 |
-- +------------+-----------+-----------+------------+
-- Output: 
-- +------+
-- | id   |
-- +------+
-- | 4    |
-- | 7    |
-- +------+


-- Select the author IDs who have viewed their own articles
SELECT DISTINCT
    author_id AS id  -- Rename author_id to id as required in the output format
FROM
    Views
WHERE
    author_id = viewer_id  -- Filter rows where the author has viewed their own article
ORDER BY
    id ASC;  -- Sort the result by author ID in ascending order



-- Explanation:
-- SELECT DISTINCT author_id AS id:

-- The DISTINCT keyword ensures that duplicate author_id values are removed.
-- The column author_id is renamed to id as specified in the problem statement.
-- FROM Views:

-- Specifies the Views table as the source of data.
-- WHERE author_id = viewer_id:

-- Filters rows to include only those where the author_id matches the viewer_id. This condition ensures we only include authors who have viewed their own articles.
-- ORDER BY id ASC:

-- Ensures the result is sorted by the id column in ascending order.