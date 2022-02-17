SELECT *
FROM teams;

SELECT yearid, franchid, attendance
FROM teams
WHERE attendance IS NOT null
	  AND wswin = 'Y'
ORDER BY yearid DESC;
	  
SELECT yearid, franchid, attendance, w, wswin, divwin, wcwin, lgwin
FROM teams
WHERE franchid = 'CHW'
ORDER BY yearid DESC;

SELECT yearid, franchid, attendance, w
FROM teams
WHERE franchid = 'CHW'
ORDER BY yearid DESC;

SELECT franchid, ROUND(AVG(attendance),2) AS avg_attendance, ROUND(AVG(w),2) AS wins
FROM teams
WHERE wswin = 'Y' OR wswin = 'N'
GROUP BY franchid
ORDER BY avg_attendance DESC;


SELECT DISTINCT tw1.yearid AS first_year,
	tw1.name AS team,
		tw1.w AS first_year_wins,
			tw1.l AS first_year_losses,
				tw1.attendance AS first_year_attendance,
					tw2.yearid AS second_year,
						tw2.w AS second_year_wins,
							tw2.l AS second_year_losses,
								tw2.attendance AS second_year_attendance	
FROM teams AS tw1 INNER JOIN teams AS tw2 
USING(teamid)
WHERE tw1.attendance IS NOT NULL
	AND tw2.attendance IS NOT NULL
		AND tw1.attendance<tw2.attendance
			AND tw2.yearid=(tw1.yearid+1)
				AND tw1.w<tw2.w;
-- Results include 859 rows.

SELECT DISTINCT tw1.yearid AS first_year,
	tw1.name AS team,
		tw1.w AS first_year_wins,
			tw1.l AS first_year_losses,
				tw1.attendance AS first_year_attendance,
					tw2.yearid AS second_year,
						tw2.w AS second_year_wins,
							tw2.l AS second_year_losses,
								tw2.attendance AS second_year_attendance	
FROM teams AS tw1 INNER JOIN teams AS tw2 
USING(teamid)
WHERE tw1.attendance IS NOT NULL
	AND tw2.attendance IS NOT NULL
	 AND tw1.attendance<tw2.attendance
		AND tw2.yearid=(tw1.yearid+1)	
			AND tw1.w>tw2.w;
-- When changing the greater than/less than symbol, lower wins brings back 372 rows. 
-- Generally speaking, as wins increase, attendance also increases

SELECT tw1.name AS team_name,
	tw1.yearid AS Winning_season,
		tw1.attendance AS winning_Attendance,
			tw2.yearid AS next_season,
				tw2.attendance AS next_season_attendance
FROM teams AS tw1 INNER JOIN teams AS tw2
USING(teamid)
WHERE (tw1.wcwin='Y'
AND tw2.yearid=(tw1.yearid+1)
	 AND tw1.yearid<tw2.yearid
		AND tw1.attendance<tw2.attendance)
			OR (tw1.divwin='Y'
				AND tw1.yearid<tw2.yearid
					AND tw2.yearid=(tw1.yearid+1)
			   			AND tw1.attendance<tw2.attendance);
-- Appears to be a gain in attendance						


SELECT tw1.name AS team,
	tw1.yearid AS winning_season,
		tw1.attendance AS winning_attendance,
			tw2.yearid AS following_season,
				tw2.attendance AS following_season_attendance
FROM teams AS tw1 INNER JOIN teams AS tw2
USING(teamid)
WHERE (tw1.wcwin='Y'
	AND tw1.yearid<tw2.yearid
		AND tw2.yearid=(tw1.yearid+1)
			AND tw1.attendance>tw2.attendance);

-- Appears to be a drop off after winning
	  

