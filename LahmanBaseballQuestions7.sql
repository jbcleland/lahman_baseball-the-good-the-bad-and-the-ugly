



--#7.  From 1970 – 2016, what is the largest number of wins for a team that did not win the world series? 
SELECT yearid, teamid, wswin, max(w)
FROM teams
WHERE wswin = 'N'
and yearid between 1970 and 2016
group by yearid, teamid, wswin
order by max desc
limit 1;

--What is the smallest number of wins for a team that did win the world series? 
SELECT yearid, teamid, wswin, min(w)
FROM teams
WHERE wswin = 'Y'
and yearid between 1970 and 2016
group by yearid, teamid, wswin
order by min asc
limit 1

--Doing this will probably result in an unusually small number of wins for a world series champion 
--determine why this is the case. Then redo your query, excluding the problem year. 

SELECT yearid, teamid, wswin, min(w)
FROM teams
WHERE wswin = 'Y'
and yearid between 1970 and 2016
and yearid <> 1981
group by yearid, teamid, wswin
order by min asc
limit 1;

--How often from 1970 – 2016 was it the case that a team with the most wins also won the world series? 

	--max winners
		SELECT distinct yearid, teamid,
			--max(W) OVER(partition by yearid) as highest_wins
			max(W)
		FROM teams
		WHERE yearid between 1970 and 2016
		and ws_win = 'Y'
		--AND higest_wins 
		--GROUP BY yearid, teamid, name, wswin
		GROUP BY yearid, teamid
		order by yearid;
	
	--world series winners
		SELECT  yearid, teamid,w
		FROM  teams
		WHERE wswin = 'Y'
		AND yearid between 1970 and 2016
		GROUP BY yearid, teamid,w
		order by yearid
	
	--ws winner by year
			WITH ws_winners as (SELECT  yearid, teamid,w
			FROM  teams
			WHERE wswin = 'Y'
			and yearid between 1970 and 2016
			GROUP BY yearid, teamid,w
			order by yearid)
		SELECT teamid, yearid, w
		FROM ws_winners
		GROUP BY teamid, yearid, w
		ORDER BY yearid;
		
		--CTE
			
		WITH big_winners AS (SELECT distinct yearid, 
						MAX(W) OVER(partition by yearid) as highest_wins
						FROM teams
						WHERE yearid between 1970 and 2016
						ORDER BY yearid)
		SELECT count(distinct big_winners.yearid)
		FROM big_winners FULL JOIN teams on big_winners.yearid=teams.yearid
		WHERE  wswin = 'Y';

		
	
SELECT distinct yearid, teamid, max(w)
from teams
WHERE yearid between 1970 and 2016
and wswin = 'Y'
group by  (yearid, teamid )
order by max desc
limit 46;

SELECT teamid, yearid, w
FROM teams
WHERE wswin = 'Y'
AND yearid between 1970 and 2016
ORDER BY yearid;


SELECT teamid, yearid, w, wswin
FROM teams
WHERE yearid between 1970 and 2016
GROUP BY teamid, yearid, wswin,w
ORDER BY yearid;
	

		--What percentage of the time?
