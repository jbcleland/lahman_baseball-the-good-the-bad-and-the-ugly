SELECT *
FROM fielding;

WITH position_table AS (SELECT playerid,pos,po,yearid,
	 CASE WHEN pos = 'OF' THEN 'Outfield'
	 WHEN pos = 'SS' THEN 'Infield'
	 WHEN pos = '1B' THEN 'Infield'
     WHEN pos = '2B' THEN 'Infield'
	 WHEN pos = '3B' THEN 'Infield'
	 WHEN pos = 'P' THEN 'Battery'
	 WHEN pos = 'C' THEN 'Battery' END AS position FROM fielding)

SELECT position, SUM(po)
FROM position_table
WHERE yearid = '2016'
GROUP BY position;