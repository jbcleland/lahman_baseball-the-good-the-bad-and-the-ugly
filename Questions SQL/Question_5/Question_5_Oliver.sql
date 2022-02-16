-- Find the average number of strikeouts per game by decade since 1920. 
-- Round the numbers you report to 2 decimal places. Do the same for home runs per game. Do you see any trends?

WITH so_hr_by_decade AS (SELECT CONCAT(LEFT(yearid::text, 3), '0s') AS decade,
	SUM(so)::numeric AS so_batting,
	SUM(soa)::numeric AS so_pitching,
	SUM(hr)::numeric AS hr_batting,
	SUM(hra)::numeric AS hra_pitching,
	(SUM(g)/2)::numeric AS games_played
FROM teams
WHERE yearid>1919
GROUP BY decade
ORDER BY decade)
SELECT decade,
ROUND((so_batting/games_played),2) AS avg_so_game_batting,
ROUND((so_pitching/games_played),2) AS avg_so_game_pitching,
ROUND((hr_batting/games_played),2) AS avg_hr_game_batting,
ROUND((hra_pitching/games_played),2) AS avg_hra_game_pitching
FROM so_hr_by_decade;