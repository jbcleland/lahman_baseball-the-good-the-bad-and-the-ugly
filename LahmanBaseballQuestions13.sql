13. 
--It is thought that since left-handed pitchers are more rare, causing batters to face them less often, that they are more effective. 
--Investigate this claim and present evidence to either support or dispute this claim. 


--First, determine just how rare left-handed pitchers are compared with right-handed pitchers. 
SELECT round(count(*)::numeric / 
	(SELECT count(*)
	FROM pitching left join people 
	USING (playerid))*100)
FROM pitching left join people 
USING (playerid)
WHERE throws = 'L'
--Are left-handed pitchers more likely to win the Cy Young Award? 


SELECT count(*)
from awardsplayers left join people
ON awardsplayers.playerid=people.playerid
left join pitching  
ON pitching.playerid=people.playerid
where awardid like 'Cy%'
--and throws = 'L'

SELECT count(*)::numeric /
	(SELECT count(*)
	from awardsplayers left join people
	ON awardsplayers.playerid=people.playerid
	left join pitching  
	ON pitching.playerid=people.playerid
	where awardid like 'Cy%')*100
from awardsplayers left join people
ON awardsplayers.playerid=people.playerid
left join pitching  
ON pitching.playerid=people.playerid
where awardid like 'Cy%'
and throws = 'L'


--Are they more likely to make it into the hall of fame?
SELECT count(*)::numeric /
	(SELECT count(*)
	from halloffame left join people
	ON halloffame.playerid=people.playerid
	left join pitching  
	ON pitching.playerid=people.playerid
	where halloffame.inducted = 'Y')
from halloffame left join people
ON halloffame.playerid=people.playerid
left join pitching  
ON pitching.playerid=people.playerid
where halloffame.inducted = 'Y'
and throws = 'L'

