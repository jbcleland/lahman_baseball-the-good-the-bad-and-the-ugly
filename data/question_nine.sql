--  9. 
--  Which managers have won the TSN Manager of the Year award 
--  in both the National League (NL) and the American League (AL)? 
--  Give their full name and the teams that they were managing 
--	when they won the award.

WITH 
	cte AS
			(SELECT
				DISTINCT (playerid) AS finalanswer,
				COUNT (DISTINCT (lgid)) AS lgw
			FROM awardsmanagers
			WHERE awardid = 'TSN Manager of the Year'
				AND lgid <> 'ML'
			GROUP BY playerid
			ORDER BY COUNT (DISTINCT (lgid)) DESC),
	years AS
			(SELECT 
				yearid AS year_won,
				lgid AS NLorAL,
				playerid
			FROM awardsmanagers),
	test AS
			(SELECT
				playerid,
				namefirst,
				namelast
			FROM people),
	teamnames AS
			(SELECT
			 	teamid,
				name AS theteam
			FROM teams
			WHERE yearid > 1970)
SELECT  
	DISTINCT year_won,
	namefirst,
	namelast,
	theteam
FROM cte as cte LEFT JOIN years AS y
	ON finalanswer = y.playerid 
LEFT JOIN test AS p
	ON y.playerid = p.playerid
LEFT JOIN managers AS m
	ON p.playerid = m.playerid
LEFT JOIN teamnames AS t
	ON m.teamid = t.teamid
WHERE lgw > 1
	AND year_won = m.yearid
ORDER BY year_won;



/* 

This approach did not work very well:

SELECT *
FROM managers
	WHERE 
		(SELECT COUNT (national_league) OVER (PARTITION BY playerid) AS NLcount
		 FROM dual) > 0
	--AND
		--(SELECT COUNT (american_league) OVER (PARTITION BY playerid) AS ALcount
		-- FROM dual) > 0
WITH dual AS
	(SELECT
		playerid,
		CASE WHEN lgid = 'NL' THEN true
			ELSE null END AS National_league,
		CASE WHEN lgid = 'AL' THEN true
			ELSE null END AS American_League
	FROM awardsmanagers
	WHERE awardid = 'TSN Manager of the Year'
	AND lgid <> 'ML'),
merged AS
(SELECT
		DISTINCT playerid,
		COUNT (national_league) OVER (PARTITION BY playerid) AS NLcount,
		COUNT (american_league) OVER (PARTITION BY playerid) AS ALcount
	FROM dual)
*/




