SELECT * FROM [PROJ PORT]..CovidDeaths
ORDER BY 3,4
SELECT COUNT(iso_code) from [PROJ PORT]..CovidDeaths

--SELECTING DATA
select location, date, total_cases, new_cases,total_deaths, population 
from [PROJ PORT]..CovidDeaths
order by 1,2

--total cases vs total deaths
select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as death_percentage
from [PROJ PORT]..CovidDeaths
where location like '%ind%'
order by 1,2

--total cases vs population,% of people get infected
select location, date, total_cases, population, (total_cases/population)*100 as infected_percentage
from [PROJ PORT]..CovidDeaths
where location like '%ind%'
order by 1,2

--highest deathcount per population
select location,  max(total_deaths) as highest_death_count, population, max((total_deaths/population))*100 as death_percentage
from [PROJ PORT]..CovidDeaths
--where location like '%ind%'
group by location,population
order by 4 desc

-- max infection rate
select location,  max(total_cases) as highest_infection_count, population, max((total_cases/population))*100 as infected_percentage
from [PROJ PORT]..CovidDeaths
--where location like '%ind%'
group by location,population
order by 4 desc

--max deaths counts
select location,  max(cast(total_deaths as int)) as highest_death_count, population
from [PROJ PORT]..CovidDeaths
--where location like '%ind%'
where continent is null
group by location,population
order by 2 desc

--the continents  with highest death counts
select continent,  max(cast(total_deaths as int)) as total_death_count
from [PROJ PORT]..CovidDeaths
where continent is not null
group by continent
order by 2 desc

--global death
select date, SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_death
,SUM(CAST(new_deaths as int))/SUM(new_cases)*100 as death_percent
from [PROJ PORT]..CovidDeaths
where continent is not  null
group by date
order by 1,2
 
select * from [PROJ PORT]..CovidVACCINATION

--looking at the vaccination vs population
select  d.continent,d.location,d.date,d.population, V.new_vaccinations,
sum(convert(int, v.new_vaccinations)) over (partition by d.location order by d.location,d.date) as vaccination_sum
from [PROJ PORT]..CovidDeaths d join [PROJ PORT]..CovidVACCINATION v on 
d.location=v.location and d.date = v.date
where d.continent is not null
order by 2,3


--with cte
with popvsvac(continent, location,date,population,new_vaccination,vaccination_sum)
as(
select  d.continent,d.location,d.date,d.population, V.new_vaccinations,
sum(convert(int, v.new_vaccinations)) over (partition by d.location order by d.location,d.date) as vaccination_sum
from [PROJ PORT]..CovidDeaths d join [PROJ PORT]..CovidVACCINATION v on 
d.location=v.location and d.date = v.date
where d.continent is not null
)
select *,(vaccination_sum/population)*100  as vaccination_percentage from popvsvac


--with popvsvac( location,population,new_vaccination,vaccination_sum,vaccination_percentage)
--as(
--select  d.location,d.population, V.new_vaccinations,max((vaccination_sum/population))*100  as vaccination_percentage,
--sum(convert(int, v.new_vaccinations)) over (partition by d.location order by d.location) as vaccination_sum
--from [PROJ PORT]..CovidDeaths d join [PROJ PORT]..CovidVACCINATION v on 
--d.location=v.location 
-- d.continent is not null
--group by d.location,d.population, v.new_vaccinations
-)
--select * , max((vaccination_sum/population))*100  as vaccination_percentage from popvsvac

--temp table
drop table if exists #percentpopulationvaccinated
create table #percentpopulationvaccinated
(
continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
new_vaccinations numeric,
vaccination_sum numeric,
)

insert into  #percentpopulationvaccinated

select  d.continent,d.location,d.date,d.population, V.new_vaccinations,
sum(convert(int, v.new_vaccinations)) over (partition by d.location order by d.location,d.date) as vaccination_sum
from [PROJ PORT]..CovidDeaths d join [PROJ PORT]..CovidVACCINATION v on 
d.location=v.location and d.date = v.date
where d.continent is not null

select *,(vaccination_sum/population)*100  as vaccination_percentage from #percentpopulationvaccinated

--creating a view
create view percentpopulationvaccinated as
select  d.continent,d.location,d.date,d.population, V.new_vaccinations,
sum(convert(int, v.new_vaccinations)) over (partition by d.location order by d.location,d.date) as vaccination_sum
from [PROJ PORT]..CovidDeaths d join [PROJ PORT]..CovidVACCINATION v on 
d.location=v.location and d.date = v.date
where d.continent is not null

select * from  percentpopulationvaccinated 

--queries for table au
select  SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_death
,SUM(CAST(new_deaths as int))/SUM(new_cases)*100 as death_percent
from [PROJ PORT]..CovidDeaths
where continent is not  null
--group by date
order by 1,2

--2
select location,SUM(CAST(new_deaths as int)) as totaldeathcount
from [PROJ PORT]..CovidDeaths
where continent is null and location not in ('World','European Union','International')
group by location
order by totaldeathcount desc

--3
select location, population,  max(total_cases) as highest_infection_count, max((total_cases/population))*100 as infected_percentage
from [PROJ PORT]..CovidDeaths
--where location like '%ind%'
group by location,population
order by 4 desc
--4

select location, population,date,  max(total_cases) as highest_infection_count, max((total_cases/population))*100 as infected_percentage
from [PROJ PORT]..CovidDeaths
--where location like '%ind%'
group by location,population,date
order by infected_percentage desc
