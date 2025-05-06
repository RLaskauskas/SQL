SELECT column_name, COUNT(*) AS duplicate_count
FROM `your_project.your_dataset.your_table`
GROUP BY column_name
HAVING COUNT(*) > 1;

---------------------------

WITH duplicate_cte AS (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY column_name ORDER BY another_column) AS row_num
    FROM `your_project.your_dataset.your_table`
)
SELECT * FROM duplicate_cte WHERE row_num > 1;

---------------------------

DELETE FROM `your_project.your_dataset.your_table`
WHERE row_id IN (
    SELECT row_id FROM duplicate_cte WHERE row_num > 1
);