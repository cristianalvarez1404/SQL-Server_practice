--Generate a Sequence of numbers from 1 to 20

WITH Series AS (
	-- Anchor Query
	SELECT
	1 AS MyNumber
	UNION ALL 
	-- Recursive Query
	SELECT
	MyNumber + 1
	FROM Series
	WHERE MyNumber < 1000
)

-- MainQuery
SELECT * 
FROM Series
OPTION(MAXRECURSION 5000);