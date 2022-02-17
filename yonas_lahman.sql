-Q 1. What range of years for baseball games played does the provided database cover? 

SELECT MIN(yearid), Max(yearid)
FROM managers

---2.17 AwardsManagers table

playerID       Manager ID code
awardID        Name of award won
yearID         Year
lgID           League
tie            Award was a tie (Y or N)
notes          Notes about the award
-- Q 9--- Which managers have won the TSN Manager of the Year award in both the National League (NL) 
and the American League (AL)? Give their full name and the teams that they were managing when they 
won the award.

WITH dual AS
(SELECT
	playerid,
	CASE WHEN lgid = 'NL' THEN true
		ELSE null END AS National_league,
	CASE WHEN lgid = 'AL' THEN true
		ELSE null END AS American_League
FROM awardsmanagers
WHERE awardid = 'TSN Manager of the Year'
AND lgid <> 'ML')
SELECT
	DISTINCT playerid,
	COUNT (national_league) AS a, --OVER (PARTITION BY playerid),
	COUNT (american_league) --OVER (PARTITION BY playerid)
FROM dual
GROUP BY playerid

--Q 6 --Find the player who had the most success stealing bases in 2016, where __success__ is measured as 
the percentage of stolen base attempts which are successful. (A stolen base attempt results either 
in a stolen base or being caught stealing.) Consider only players who attempted _at least_ 20 stolen bases.
	
SELECT sb, cs,namefirst, namelast ,round((sb::numeric/(sb::numeric + cs::numeric)* 100),2) AS SB_PER
FROM batting AS b JOIN people AS P ON B.PLAYERID = P.PLAYERID
where yearid = '2016' and  cs + sb >= 20
ORDER BY SB_PER DESC

--
select sb,cs,namefirst,namelast ,ROUND((sb::numeric/(sb::numeric + cs::numeric)* 100)) as sb_per
from batting as b join people as p on b.playerid = p.playerid
where yearid = '2016' and cs + sb >= 20
ORDER BY SB_PER DESC