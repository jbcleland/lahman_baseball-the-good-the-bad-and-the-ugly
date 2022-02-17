--	10. 
--	Find all players who hit their career highest number of home runs in 2016. 
--	Consider only players who have played in the league for at least 10 years, 
--		and who hit at least one home run in 2016. 
--	Report the players' first and last names and the number of home runs they hit in 2016.
/*
SELECT *
FROM batting
LIMIT 5
*/


--CTE Counts Career Length and Lists HR count from highest year.
WITH clhr AS
	(SELECT 
		DISTINCT playerid,
		yearid,
		hr,
		MAX (hr) OVER (PARTITION BY playerid) AS maxhr,
		COUNT (yearid) OVER (Partition BY playerid) AS careerlength
	FROM batting)
SELECT 
	p.namefirst,
	p.namelast,
	c.maxhr
FROM clhr AS c INNER JOIN people AS p
ON c.playerid = p.playerid
WHERE careerlength > 9
AND yearid = 2016
AND hr <> 0
AND hr = maxhr
ORDER BY maxhr DESC;

 




