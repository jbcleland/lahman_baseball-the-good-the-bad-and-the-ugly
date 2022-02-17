-- 3. 
--   Find all players in the database who played at Vanderbilt University. 
--   Create a list showing each player’s first and last names as well as the total salary they earned in the major leagues. 
--   Sort this list in descending order by the total salary earned. 
--   Which Vanderbilt player earned the most money in the majors? David Price

WITH salary AS
	(SELECT 
		s.playerid,
		SUM (salary::numeric) AS earnings
	FROM salaries AS s JOIN collegeplaying as cp
	ON s.playerid = cp.playerid
	WHERE cp.schoolid = 'vandy'
	GROUP BY s.playerid)
SELECT
	p.namefirst,
	p.namelast,
	earnings::money
FROM people AS p JOIN salary AS s
ON p.playerid = s.playerid
ORDER BY earnings DESC;