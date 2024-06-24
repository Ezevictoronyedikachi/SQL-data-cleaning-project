--Cleaning data in SQL Queries

select * 
from PortforlioProject..NashvileHousingData

 

--Standardize the Date format

select SalesDateConverted, CONVERT(Date, [Sale Date])
from PortforlioProject..NashvileHousingData 


update NashvileHousingData
SET SalesDateConverted = CONVERT(date,[Sale Date])

ALTER TABLE NashvileHousingData
ADD SalesDateConverted date



--Populate the Property Address Data

select *
from PortforlioProject..NashvileHousingData 
--where [Property Address] is null
order by [Parcel ID]

select a.[Parcel ID],a.[Property Address],b.[Parcel ID],b.[Property Address], ISNULL(a.[Property Address],b.[Property Address])
from PortforlioProject..NashvileHousingData a
join PortforlioProject..NashvileHousingData b
on a.[Parcel ID]= b.[Parcel ID]
and a.[Unnamed: 0] <> b.[Unnamed: 0]
where a.[Property Address] is null



update a 
set a.[Property Address]=ISNULL(a.[Property Address],b.[Property Address])
from PortforlioProject..NashvileHousingData a
join PortforlioProject..NashvileHousingData b
on a.[Parcel ID]= b.[Parcel ID]
and a.[Unnamed: 0] <> b.[Unnamed: 0]
where a.[Property Address] is null


--Breaking out Address into individual columns ( Address, City, State)

select [Property Address]
from PortforlioProject..NashvileHousingData 
--where [Property Address] is null
--order by [Parcel ID]

SELECT
SUBSTRING([Property Address], 1,CHARINDEX(',', [Property Address],-1)) as Address
from PortforlioProject..NashvileHousingData



--Breaking off the Clustered address



select DISTINCT([Sold As Vacant]), count([Sold As Vacant])
from NashvileHousingData
group by [Sold As Vacant]
order by 2


select [Sold As Vacant],
CASE WHEN [Sold As Vacant]='Y' THEN 'Yes'
	when [Sold As Vacant]= 'N' then 'N'
	else [Sold As Vacant]
	end
from NashvileHousingData


update NashvileHousingData
set [Sold As Vacant]= CASE WHEN [Sold As Vacant]='Y' THEN 'Yes'
	when [Sold As Vacant]= 'N' then 'N'
	else [Sold As Vacant]
	end
from NashvileHousingData



---Rename the Duplicates thereof
WITH RowNumCTE AS (
select *,
	ROW_NUMBER() OVER (
	PARTITION by [Parcel ID],
				[Sale Date],
				[Sale Price],
				[Legal Reference]
				ORDER BY 
				UniqueID
				) row_num
from PortforlioProject..NashvileHousingData 
--order by [Parcel ID]
)
SELECT *
FROM RowNumCTE
--where row_num >1
order by [Property Address]


-----LEAVE THIS OUT!!
select [Owner Name],count([Owner Name]) as NumberOfHouses
from PortforlioProject..NashvileHousingData
group by [Owner Name]
order by 2



--TO DROP UNUSEFUL COLUMNS IN A DATABASE
select *
from PortforlioProject..NashvileHousingData

ALTER TABLE PortforlioProject..NashvileHousingData
DROP COLUMN [Sale Date]


--TO GET THE TOTAL INFO CONCERNING THE DATABASE YOU WANT TO WORK ON

SELECT * FROM SYS.objects




