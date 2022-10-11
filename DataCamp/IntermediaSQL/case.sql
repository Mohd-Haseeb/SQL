/*
Data :
	Two Table -> teams_italt ; matches_italy

	teams_italy:

	id	team_api_id	team_long_name	team_short_name
	20513	8524	Atalanta	ATA
	20514	8551	Siena	SIE
	20515	8529	Cagliari	CAG

	matches_italy:

	id	country_id	season	stage	date	hometeam_id	awayteam_id	home_goal	away_goal
	11397	10257	2011/2012	1	2011-12-21	8524	9880	4	1
	11398	10257	2011/2012	1	2011-12-21	9857	8686	0	2
	11399	10257	2011/2012	1	2011-12-20	8529	8564	0	2
	11400	10257	2011/2012	1	2011-12-21	8636	9888	4	1
	11401	10257	2011/2012	1	2011-12-21	8543	8533	0	0
	11402	10257	2011/2012	1	2011-12-21	9875	10233	6	1


*/

-- Using Case in Where Conditon to get the team_api_id

SELECT
	team_long_name,
	team_api_id
FROM teams_italy
-- Filter for team long name
WHERE case
			when team_long_name='Bologna' then 'Keep'
			else 'Dont' 
			 end = 'Keep'




SELECT 
	season,
    date,
	home_goal,
	away_goal
FROM matches_italy
WHERE 
-- Exclude games not won by Bologna
	case when hometeam_id = 9857 and home_goal > away_goal then 'Bologna Win'
		when awayteam_id = 9857 and away_goal > home_goal then 'Bologna Win' 
		end IS NOT null;




-- CASE WHEN WITH AGGREGATED FUNCTIONS
 
 /*
 	case statements are great for
		-> Categorizing data
		-> Filtering Data
		-> Aggregating Data 
*/


-- Tables => country and match
-- country => id , name
-- match => id	country_id	season	stage	date	hometeam_id	awayteam_id	home_goal	away_goal


SELECT 
	c.name AS country,
    -- Count games from the 2012/2013 season
	Count(case when m.season = '2012/2013' 
        	then m.id ELSE null end) AS matches_2012_2013
FROM country AS c
LEFT JOIN match AS m
ON c.id = m.country_id
-- Group by country name alias
Group by c.name;




SELECT 
	c.name AS country,
    -- Count matches in each of the 3 seasons
	Count(case when m.season = '2012/2013' then m.id end) AS matches_2012_2013,
	Count(case when m.season = '2013/2014' then m.id end) AS matches_2013_2014,
	Count(case when m.season = '2014/2015' then m.id end) AS matches_2014_2015
FROM country AS c
LEFT JOIN match AS m
ON c.id = m.country_id
-- Group by country name alias
Group by c.name;



-- matches won in each season by home team
select c.name as country,
sum(case when m.season='2012/2013' and m.home_goal>away_goal then 1 else 0 end) as matches_2012_2013,
sum(case when m.season='2013/2014' and m.home_goal>away_goal then 1 else 0 end) as matches_2013_2014,
sum(case when m.season='2014/2015' and m.home_goal>away_goal then 1 else 0 end) as matches_2014_2015
from country c
left join match m
on c.id = m.country_id
Group by c.name




-- Calculating Percent with CASE and AVG

SELECT 
    c.name AS country,
    -- Count the home wins, away wins, and ties in each country
	count(case when m.home_goal > m.away_goal THEN m.id 
        END) AS home_wins,
	count(case when m.home_goal < m.away_goal THEN m.id 
        END) AS away_wins,
	count(case when m.home_goal = m.away_goal THEN m.id 
        END) AS ties
FROM country AS c
LEFT JOIN matches AS m
ON c.id = m.country_id
GROUP BY country;




SELECT 
	c.name AS country,
    -- Calculate the percentage of tied games in each season
	avg(case WHEN m.season='2013/2014' AND m.home_goal = m.away_goal THEN 1
			WHEN m.season='2013/2014' AND m.home_goal != m.away_goal THEN 0
			END) AS ties_2013_2014,
	avg(case WHEN m.season='2014/2015' and m.home_goal = m.away_goal THEN 1
			WHEN m.season='2014/2015' AND m.home_goal != m.away_goal THEN 0
			END) AS ties_2014_2015
FROM country AS c
LEFT JOIN matches AS m
ON c.id = m.country_id
GROUP BY country;






