Select  * from [PROJ PORT]..VILLASFORSALE

--standardize date format
select SaledateConverted , convert(date,SaleDate) 
from [PROJ PORT]..VILLASFORSALE

update VILLASFORSALE
set SaleDate = convert(date,SaleDate) 

alter table VILLASFORSALE
add SaleDateConverted Date;
update VILLASFORSALE
set SaleDateConverted = convert(date,SaleDate) 


--populate property address data
select PropertyAddress
from [PROJ PORT]..VILLASFORSALE
where PropertyAddress is null
order by ParcelID



select a.PropertyAddress,a.ParcelID,b.PropertyAddress,b.ParcelID,ISNULL(a.PropertyAddress,b.PropertyAddress)
from [PROJ PORT]..VILLASFORSALE a join [PROJ PORT]..VILLASFORSALE b
on a.ParcelID =b.ParcelID and a.[UniqueID ]<> b.[UniqueID ]
where a.PropertyAddress is null

update a
set PropertyAddress =ISNULL(a.PropertyAddress,b.PropertyAddress)
from [PROJ PORT]..VILLASFORSALE a join [PROJ PORT]..VILLASFORSALE b
on a.ParcelID =b.ParcelID and a.[UniqueID ]<> b.[UniqueID ]
where a.PropertyAddress is null

--breaking down adress into individual coloumn

select PropertyAddress
from [PROJ PORT]..VILLASFORSALE
--where PropertyAddress is null

select SUBSTRING( PropertyAddress ,1,CHARINDEX(',',PropertyAddress)-1) as propertyaddress,
SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+1,LEN(PropertyAddress) ) as propertycity
from [PROJ PORT].dbo.VILLASFORSALE
 
 use [PROJ PORT]
 alter table VILLASFORSALE
add property_address nvarchar(255);
update VILLASFORSALE
set property_address= SUBSTRING( PropertyAddress ,1,CHARINDEX(',',PropertyAddress)-1)


 use [PROJ PORT]
alter table  [dbo].[VILLASFORSALE]
add propertycity nvarchar(255);
update VILLASFORSALE
set propertycity= SUBSTRING( PropertyAddress ,CHARINDEX(',',PropertyAddress)+1,LEN(PropertyAddress))

select * from VILLASFORSALE

select 
PARSENAME(replace(OwnerAddress,',','.'),1),
PARSENAME(replace(OwnerAddress,',','.'),2),
PARSENAME(replace(OwnerAddress,',','.'),3)
from [PROJ PORT]..VILLASFORSALE

use [PROJ PORT]
 alter table VILLASFORSALE
add owner_address nvarchar(255);
update VILLASFORSALE
set owner_address= PARSENAME(replace(OwnerAddress,',','.'),3)


 use [PROJ PORT]
alter table  [dbo].[VILLASFORSALE]
add ownerycity nvarchar(255);
update VILLASFORSALE
set ownerycity= PARSENAME(replace(OwnerAddress,',','.'),2)

 use [PROJ PORT]
alter table  [dbo].[VILLASFORSALE]
add ownerstate nvarchar(255);
update VILLASFORSALE
set ownerstate= PARSENAME(replace(OwnerAddress,',','.'),1)

--chane y and n to yes and no
select distinct SoldAsVacant from [PROJ PORT]..VILLASFORSALE

--update SoldAsVacant
--set N= 'No'

select SoldAsVacant, case when SoldAsVacant='Y' then 'Yes'
when SoldAsVacant='N' then 'No'
else SoldAsVacant end
from  [PROJ PORT]..VILLASFORSALE

use [PROJ PORT]
update VILLASFORSALE
set SoldAsVacant=case when SoldAsVacant='Y' then 'Yes'
when SoldAsVacant='N' then 'No'
else SoldAsVacant end

--REMOVE DUPLICATES
SELECT * from  [PROJ PORT]..VILLASFORSALE

with ctern as(

SELECT *,
ROW_NUMBER() over (partition by ParcelID,PropertyAddress,SaleDate,SalePrice,LegalReference
order by UniqueID) rn
from  [PROJ PORT]..VILLASFORSALE
-- order by ParcelID
 )
 delete 
 from ctern 
 where rn >1


 --delete unused coloumn
 use [PROJ PORT]
 alter table VILLASFORSALE
 drop column PropertyAddress

  use [PROJ PORT]
 alter table VILLASFORSALE
 drop column OwnerAddress

 select * from [PROJ PORT]..VILLASFORSALE