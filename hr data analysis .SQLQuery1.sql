select * from [PROJ PORT].dbo.HR

select COUNT(*) from [PROJ PORT].dbo.HR

select COUNT(*) from [PROJ PORT].dbo.HR where Education  ='High School'

select COUNT(*) from [PROJ PORT].dbo.HR where Department ='HR'
select COUNT(*) from [PROJ PORT].dbo.HR where Department ='R&D'
select COUNT(*) from [PROJ PORT].dbo.HR where Department ='Sales'

select SUM([Employee Count]) from [PROJ PORT].dbo.HR where [Education Field]='Medical'
select SUM([Employee Count]) from [PROJ PORT].dbo.HR where [Education Field]='Life Sciences'
select SUM([Employee Count]) from [PROJ PORT].dbo.HR where [Education Field]='Other'
select SUM([Employee Count]) from [PROJ PORT].dbo.HR where [Education Field]='Technical Degree'
select SUM([Employee Count]) from [PROJ PORT].dbo.HR where [Education Field]='Human Resources'
select SUM([Employee Count]) from [PROJ PORT].dbo.HR where [Education Field]='Marketing'


select COUNT(*) from [PROJ PORT].dbo.HR where [CF_attrition label] ='Ex-Employees'
select SUM([Employee Count]) from [PROJ PORT].dbo.HR where [CF_current Employee]='0'

select COUNT(*) from [PROJ PORT].dbo.HR where Attrition ='Yes' and Education='Doctoral Degree'

select COUNT(*) from [PROJ PORT].dbo.HR where Attrition ='Yes' and Department ='R&D'

select SUM([Employee Count]) as cur_med_emp from [PROJ PORT].dbo.HR where [Education Field]='Medical' and  [CF_current Employee]='0'
select SUM([Employee Count]) as cur_lyfsci_emp from [PROJ PORT].dbo.HR where [Education Field]='Life Sciences' and  [CF_current Employee]='0'
select SUM([Employee Count]) as cur_other_emp from [PROJ PORT].dbo.HR where [Education Field]='Other' and  [CF_current Employee]='0'
select SUM([Employee Count]) as cur_techfield_emp from [PROJ PORT].dbo.HR where [Education Field]='Technical Degree' and  [CF_current Employee]='0'
select SUM([Employee Count])  as cur_hr_emp from [PROJ PORT].dbo.HR where [Education Field]='Human Resources' and  [CF_current Employee]='0'
select SUM([Employee Count]) as cur_market_emp from [PROJ PORT].dbo.HR where [Education Field]='Marketing' and  [CF_current Employee]='0'


select  ((select count([CF_current Employee]) from [PROJ PORT].dbo.HR where [CF_current Employee]='0' and Department ='R&D' and [Education Field]='Medical')
/SUM([Employee Count]))*100 as attritio_rate 
from [PROJ PORT].dbo.HR
--where  [Education Field]='Medical'
where Department ='R&D' and [Education Field]='Medical'



select COUNT(*) from [PROJ PORT].dbo.HR where [CF_attrition label] ='Employee'
select SUM([Employee Count]) from [PROJ PORT].dbo.HR where [CF_current Employee]='1'


select REPLACE(Gender,' ','Male') from [PROJ PORT].dbo.HR 
select COUNT(*) from [PROJ PORT].dbo.HR where Attrition ='No' and Gender ='Male'

select SUM([Employee Count]) as cur_med_emp from [PROJ PORT].dbo.HR where Gender='Male' and  [CF_current Employee]='0'

select SUM([Employee Count]) as cur_med_emp from [PROJ PORT].dbo.HR where Gender='Female' and  [CF_current Employee]='0'

select Gender, SUM([Employee Count]) as cur_med_emp from [PROJ PORT].dbo.HR where  [CF_current Employee]='0' and Education ='High School'
group by Gender 

select Department,COUNT([CF_current Employee]),
round((cast(COUNT([CF_current Employee]) as numeric)/ (select COUNT(*) from [PROJ PORT].dbo.HR 
where [CF_current Employee]='0'))*100, 2)

from [PROJ PORT].dbo.HR
where [CF_current Employee]='0'
Group by Department


select COUNT(Attrition) ,[CF_age band] from [PROJ PORT].dbo.HR 
Where Attrition='Yes'
group by [CF_age band]


select COUNT(*) ,Age from [PROJ PORT].dbo.HR 
group by Age
order by Age

select [Education Field],COUNT(Attrition)  from [PROJ PORT].dbo.HR 
where Attrition='Yes'
group by [Education Field]
order by COUNT(Attrition)


select COUNT([CF_current Employee]) ,[CF_age band],Gender,
round((cast(COUNT([CF_current Employee]) as numeric)/ (select COUNT(*) from [PROJ PORT].dbo.HR where [CF_current Employee]='0'))*100, 2)
from [PROJ PORT].dbo.HR 
Where [CF_current Employee]='0'
group by [CF_age band],Gender
Order by [CF_age band],Gender

select [Job Satisfaction],[Job Role],COUNT(*)  from [PROJ PORT].dbo.HR 

group by [Job Role],[Job Satisfaction]