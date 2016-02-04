
--exec [GetMemberCities]
CREATE proc [dbo].[GetMemberCities]
	
as

select top 20 City = ltrim(rtrim(City))
from CPClientAddress
where DATALENGTH(ltrim(rtrim(City))) > 0
group by ltrim(rtrim(City))
order by count(*) desc