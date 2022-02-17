--	11. 
--	Is there any correlation between number of wins and team salary? 
--	Use data from 2000 and later to answer this question. 
--	As you do this analysis, keep in mind that salaries across the whole league tend to increase together, 
--	so you may want to look on a year-by-year basis.

WITH cte AS
		(SELECT
			DISTINCT s.teamid,
			s.yearid AS season,
			SUM(salary::text::money) 
				OVER (PARTITION BY s.teamid, s.yearid) AS team_salary,
		 	CONCAT (s.teamid::text, s.yearid::text) AS primkey
		FROM salaries AS s LEFT JOIN teams AS t
		USING (teamid)
		WHERE s.yearid > 1999
		ORDER BY s.teamid, s.yearid),
cte2 AS 
		(SELECT
			DISTINCT t.name AS team,
			teamid,
			t.w AS wins,
		 	--t.yearid AS season,
		 	CONCAT (teamid::text, t.yearid::text) AS primkey
		FROM teams as T
		WHERE t.yearID > 1999
		ORDER BY teamid)
SELECT
	team,
	season,
	team_salary,
	wins
FROM cte AS a INNER JOIN cte2 AS b
USING (primkey);



