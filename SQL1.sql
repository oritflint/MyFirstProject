--1.
select * from country;

--2.
SELECT * 
FROM COUNTRY 
WHERE CODE='ISL';

--3.
SELECT *
FROM COUNTRY 
WHERE CODE='LBR' OR CODE='IOT' OR CODE='TKL';

--4.
SELECT * 
FROM COUNTRY 
WHERE country.continent = 'Asia';

--5.
SELECT * 
FROM COUNTRY 
WHERE country.Name like '%n' AND length(country.name) = 10 ;

--6.
SELECT name, IndepYear, Population
FROM COUNTRY 
WHERE IndepYear BETWEEN 1000 AND 1400;

--7.
select *
FROM country 
WHERE IndepYear IS NULL;

--8.
SELECT code, name, Continent, region, SurfaceArea, IndepYear ,round(cast(population as float)/1000000, 3) as Population, LifeExpectancy, GNP, GNPOld
FROM COUNTRY 
WHERE country.Name like 'z%';

--9.
select *
FROM country 
WHERE GNP > GNPOld*2;

--11.
SELECT count(1) AS TOTAL_COUNTRIES
FROM country;

--12.
SELECT count(1) AS TOTAL_COUNTRIES
FROM country
WHERE LifeExpectancy is not null;

--13.
SELECT count(distinct continent)
FROM Country;

--14.
SELECT avg(LifeExpectancy) as LifeExpectancy_avg
FROM Country;

--15.
SELECT avg(LifeExpectancy) as LifeExpectancy_avg
FROM Country
where SurfaceArea>1000000;

--16.
SELECT name, max(SurfaceArea)
FROM Country;

--17.
SELECT name, min(SurfaceArea)
FROM Country;

--18.
SELECT *
FROM Country
WHERE region like (SELECT Region
				FROM country 
				WHERE name = 'Armenia')
ORDER BY Population DESC;

--19.
/**--FIX------------------------------*/
-- SELECT TOP (10) *
-- FROM COUNTRY
-- --WHERE Population < (SELECT avg(Population) FROM COUNTRY)
-- ORDER BY Population;

--21.
SELECT COUNTRY.*, popAvgByReg.*
FROM COUNTRY, (SELECT region, round(avg(Population),2) avgPop
					FROM COUNTRY 
					Group By Region) as popAvgByReg 
WHERE COUNTRY.region = popAvgByReg.region 
AND COUNTRY.Population > popAvgByReg.avgPop*5;

--22.
SELECT name, Population, totalp, subtotalp, round(cast(Population as float)/cast(totalp as float),5) as ISR_prs_wrld, round(cast(Population as float)/cast(subtotalp as float),5) as ISR_prs_Reg
FROM COUNTRY, 
	(select sum(population) as totalp from country) as total_wrld, 
	(select region, sum(population) as subtotalp from country group by region) as total_regn 
WHERE name = 'Israel'AND total_regn.region = Country.region;

