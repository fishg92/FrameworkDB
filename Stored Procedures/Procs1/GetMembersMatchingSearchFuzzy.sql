/*
exec [GetMembersMatchingSearchFuzzy] @SSN = '', @FirstName = '', @LastName = 'l', @DOB = null
*/

CREATE proc [dbo].[GetMembersMatchingSearchFuzzy]
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

if @SSN = '' and @FirstName = '' and @LastName = '' and @DOB = '1/1/1900' begin
	select * from cpClient c (NOLOCK)
	where 1=0
	option (recompile)
end else begin
	select * from cpClient c (NOLOCK)
	where 
		(SSN = @SSN or @SSN = '')
	and (FirstName like @FirstName + '%' or @FirstName = '')
	and (LastName like @LastName + '%' or @LastName = '')
	and (isnull(BirthDate, '1/1/1900') = @DOB or @DOB = '1/1/1900')
	
	option (recompile)
end

