-- 1. What range of years for baseball games played does the provided database cover? 
--1871-2016

select min(yearid), max(yearid)
from managers;

--2. Find the name and height of the shortest player in the database. 
select 
playerid,
min(height)
from people
group by playerid
order by min(height) asc
limit 1;


--#How many games did he play in? 
SELECT  appearances.lgID,  people.playerid, count(appearances.G_all) as games_played
FROM people LEFT JOIN appearances
ON people.playerid=appearances.playerid
left join teams on teams.teamid=appearances.teamid
where people.playerid = 'gaedeed01'
group by appearances.lgID, people.playerid;


--#What is the name of the team for which he played?
SELECT  people.playerid, teams.teamid
FROM people LEFT JOIN appearances
ON people.playerid=appearances.playerid
left join teams on teams.teamid=appearances.teamid
where people.playerid = 'gaedeed01'
group by people.playerid, teams.teamid
limit 10;
