
/*No of records*/
SELECT COUNT(*) FROM dbo.Olympics

/*Count of Total Medals by Edition*/
SELECT Year,City , 
Count(CASE When Medal = 'GOLD'
THEN Medal end)  as Gold,
Count(CASE When Medal = 'SILVER'
THEN Medal end)  as SILVER,
Count(CASE When Medal = 'BRONZE'
THEN Medal end)  as BRONZE,
--Count (Silver) as Silver, Count(Bronze) as Bronze
Count(Medal) as Total
FROM dbo.Olympics
GROUP BY Year,City
ORDER by Year

/*Count of Total Medals Won Sorted by Gender across all editions*/ 
SELECT Count(Medal)as TotalMedals,Gender
FROM dbo.Olympics
GROUP BY Gender

/*Count of Medals Won Sorted by Gender for Each Edition*/
SELECT Distinct(Year), City, Count(Medal)as TotalMedals,Gender
FROM dbo.Olympics
GROUP BY Gender,Year,City
ORDER BY Year

/*Medals Won by Gender*/
SELECT Distinct(Year), City, Count(Medal)as TotalMedals,Gender
FROM dbo.Olympics
GROUP BY Gender,Year,City
ORDER BY Year

/*Most Medals Won by a Country in each edition*/
SELECT a.Year, a.City,b.Country,  Count(a.Medal)as TotalMedals
INTO #TopCountry
FROM dbo.Olympics as a
INNER JOIN dbo.Country as b
ON a.Country = b.Code
GROUP BY a.Year,a.City,b.Country
ORDER BY a.Year, TotalMedals Desc


with cte (year,city,country,totalmedals,a) as(
select Year, City, Country, totalmedals,
Rank() 
          over (Partition BY Year, City
                ORDER BY TotalMedals DESC ) as a
				from #TopCountry)
				select year,city,country,totalmedals from cte
				where a=1

/* Total Medals won by each Country sorted by Gender*/
SELECT b.Country,b.Code,
Count(CASE When a.Gender = 'Men'
THEN Medal end)  as Male,
Count(CASE When a.Gender = 'Women'
THEN Medal end)  as Female,
Count(Medal) as TotalMedal
FROM dbo.Olympics as a
INNER JOIN dbo.Country as b
ON a.Country = b.Code
GROUP BY b.Country,b.Code
ORDER BY TotalMedal Desc 


/*Top Athlete in Each Sport*/
SELECT Athlete
INTO #TopAthlete
FROM dbo.Olympics as a
INNER JOIN dbo.Country as b
ON a.Country = b.Code
GROUP BY a.Discipline
ORDER BY TotalMedals Desc

with cte (year,city,country,totalmedals,a) as(
select Year, City, Country, totalmedals,
Rank() 
          over (Partition BY Year, City
                ORDER BY TotalMedals DESC ) as a
				from #TopAthlete)
				select year,city,country,totalmedals from cte
				where a=1


SELECT TOP 1 Count(Medal) as TotalMedals,Athlete,Country 
FROM dbo.Olympics
GROUP BY Discipline,Athlete
ORDER BY TotalMedals


/*Top Male & Female Athlete*/
SELECT TOP 1 Max(Medal) as TotalMedals,Athlete,Country 
FROM dbo.Olympics
GROUP BY Discipline,Athlete
ORDER BY TotalMedals

/*Top Athlete from each country*/




