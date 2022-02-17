--	8. 
--	Using the attendance figures from the homegames table, 
--	(where average attendance is defined as total attendance divided by number of games). 
--	Only consider parks where there were at least 10 games played. 
--	Report the park name, team name, and average attendance. 

--	find the teams and parks which had the top 5 average attendance per game in 2016 
SELECT 
	DISTINCT t.park,
	t.name,
	h.attendance/h.games AS average_attendance
FROM homegames AS h JOIN teams AS t
ON h.team = t.teamid
WHERE year = 2016
	AND yearid = 2016
	AND games > 9
ORDER BY average_attendance DESC
LIMIT 5;

--	Repeat for the lowest 5 average attendance.
SELECT 
	DISTINCT t.park,
	t.name,
	h.attendance/h.games AS average_attendance
FROM homegames AS h JOIN teams AS t
ON h.team = t.teamid
WHERE year = 2016
	AND yearid = 2016
	AND games > 9
ORDER BY average_attendance
LIMIT 5;