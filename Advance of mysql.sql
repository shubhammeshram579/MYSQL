SELECT * FROM portpolio..coviddeaths

--SELECT data that used are going to be using --

SELECT location ,date,total_cases,total_deaths,new_cases,population 
FROM portpolio..coviddeaths
ORDER by 1,2,3

--locking at total cases vs total deaths --
--show likehood of dying if ypou contract covid in you countery--

SELECT location ,date,(total_deaths/total_cases)*100 as deathpercentages 
FROM portpolio..coviddeaths
WHERE location like '%INDIA%'
ORDER by 1,2,3




--Looking at total cases vs population --
--show what percentages of population got covind --

SELECT location ,date,(total_cases/population)*100 as deathspercentages  
FROM portpolio..coviddeaths
ORDER by 1,2,3

--looking for all countries total sum deaths and new cases --

SELECT continent, location,sum(population),sum(total_cases),sum(new_cases),sum(population)
FROM portpolio..coviddeaths
WHERE continent is not null
GROUP by continent,location
ORDER by location desc

--looking at all  counties max deaths and new cases --

SELECT continent, location,max(population),max(total_cases),max(new_cases),max(population)
FROM portpolio..coviddeaths
WHERE continent is not null
GROUP by continent,location
ORDER by location desc

--looking for second  highst death and new cases --

SELECT location,max(total_deaths)
FROM portpolio..coviddeaths
WHERE total_deaths in (SELECT max(total_deaths) FROM portpolio..coviddeaths)
GROUP by location
union
SELECT location,max(total_cases)
FROM portpolio..coviddeaths
WHERE total_cases in (SELECT max(total_cases) FROM portpolio..coviddeaths)
GROUP by location


--looking at counties with highste infecctite rate comper to population --

SELECT location ,population,max(total_cases) as highhestpercentagecount ,max((total_cases/population ))*100 as percentagespopulationinfected
FROM portpolio..coviddeaths
GROUP by location,population
ORDER by 1,2

--showing counties with hihhest deaths count per population--

SELECT location ,max(cast(total_deaths as int)) as totaldeathscount
FROM portpolio..coviddeaths
GROUP by location 
ORDER by totaldeathscount desc

--lest breck this down by continent--

SELECT location ,max(cast(total_deaths as int)) as totaldeathscount
FROM portpolio..coviddeaths
WHERE continent is not null
GROUP by location 
ORDER by totaldeathscount desc


-- continent is null --
SELECT location ,max(cast(total_deaths as int)) as totaldeathscount
FROM portpolio..coviddeaths
WHERE continent is  null
GROUP by location 
ORDER by totaldeathscount desc



--showing continent with in light death count per population --

SELECT continent ,max(cast(total_deaths as int)) as totaldeathscount
FROM portpolio..coviddeaths
WHERE continent is not null
GROUP by continent 
ORDER by totaldeathscount desc


SELECT * FROM portpolio..coviddeaths d
JOIN portpolio..vaccination v
on d.location = v.location
and d.date = v.date


drop table if exists pvsd
with pvsd (location,date,population,new_vaccination,rollingpeoplevaccination)
as
(
SELECT  d.location,d.date,d.population,v.new_vaccinations,sum(convert(int,v.new_vaccinations))
over (partition by d.location ORDER by d.location,d.date,d.population) as rollingpeoplevaccination
FROM portpolio..coviddeaths d
JOIN portpolio..vaccination v
on d.location = v.location
and d.date = v.date 
WHERE d.continent is not  null 
ORDER by 2,3
)
SELECT * 
FROM pvsd