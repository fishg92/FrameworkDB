/*
exec [GetMembersMatchingSearchExact] @SSN = '111223333', @FirstName = 'George', @LastName = 'Washington', @DOB = '04/04/2000'
*/

CREATE proc [dbo].[GetMembersMatchingSearchExact]
(
	@SSN varchar(9) = null
   ,@FirstName varchar(100) = null
   ,@LastName varchar(100) = null
   ,@DOB datetime = null
)

as

--Clean up inputs
SET @SSN = LTRIM(RTRIM(ISNULL(@SSN,'')))
SET @FirstName = LTRIM(RTRIM(ISNULL(@FirstName,'')))
SET @LastName = LTRIM(RTRIM(ISNULL(@LastName,'')))
SET @DOB = ISNULL(@DOB, '1/1/1900')

DECLARE @Count int

select @Count = count(*) from cpClient c (NOLOCK)
where 
	(
		@SSN not in 
		(
			select LTRIM(RTRIM(REPLACE(itemvalue,'-',''))) from configuration
			where itemkey like 'SSNException%'
		)
		and @SSN = c.SSN
	)	

if @Count = 1 begin
	select c.* from cpClient c (NOLOCK)
	where 
		(
			@SSN not in 
			(
				select LTRIM(RTRIM(REPLACE(itemvalue,'-',''))) from configuration
				where itemkey like 'SSNException%'
			)
			and @SSN = c.SSN
		)	
end else begin
	
	select c.* from cpClient c (NOLOCK)
	where 
		(
			@DOB = c.BirthDate
			and
			@FirstName = c.FirstName
			and 
			@LastName = c.LastName
		)
end
