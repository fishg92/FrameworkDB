







/*
exec [dbo].[uspGetSmartFillDataByUser] 555
exec [dbo].[uspGetSmartFillDataByUser] 5
*/

CREATE PROC [dbo].[uspGetSmartFillDataByUser]
(
	@pkUser decimal	
)
AS 

select	CreateDate = isnull(c.CreateDate ,'1/1/1900')
		,c.NorthwoodsNumber AS [Compass Number]
		,c.FirstName AS [First Name]
		,c.LastName AS [Last Name]
		,BirthDate = isnull(CONVERT(varchar(10), CONVERT(datetime, c.BirthDate, 101), 101),'1/1/1900')
		,Gender = isnull(c.Sex,'')
		,c.Suffix as [Suffix]
		,c.MiddleName as [Middle Name]
		--,SmartFillItemCreateDate =
		--isnull((select d.CreateDate from Smartfilldata d (NOLOCK)
		--	where d.fkApplicationUser = @pkUser and d.PeopleID = c.NorthwoodsNumber),'1/1/1900')
FROM  dbo.CPClient AS c WITH (NoLock) 
where c.NorthwoodsNumber in 
 (select PeopleID from SmartFillData with (NOLOCK) where fkApplicationUser = @pkUser)
		








