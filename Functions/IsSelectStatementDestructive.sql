-- =============================================
-- Author:		Jerrel Blankenship/James Neno
-- Create date: 06/14/2010
-- Description:	Returns whether or not the select query contains potentially destructive commands
-- =============================================

-- select dbo.IsSelectStatementDestructive('SELECT password, FIRSTNAME from Dual')
CREATE FUNCTION IsSelectStatementDestructive 
(
	-- Add the parameters for the function here
	@QueryText varchar(max)
)
RETURNS tinyint
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result tinyint
	DECLARE @KeywordText varchar(max)
	DECLARE @KeywordName varchar(max)
	SET @Result = 0
	SET @KeywordText = '<row itemKey="PASSWORD" /><row itemKey="CREATE " /><row itemKey="ALTER " /><row itemKey="INSERT " /><row itemKey="DELETE " /><row itemKey="UPDATE " /><row itemKey="DROP " />'
	
	-- remove any carriage returns from the query text before validating
	set @QueryText = replace(@QueryText, char(13) + char(10), ' ')
	
	-- pass query text to function that will remove additional whitespace so that validating the text is easier
	set @QueryText = dbo.fnRemoveMultipleSpaces(@QueryText)
	
	DECLARE CriteriaCursor Cursor FOR

	select itemKey from dbo.fnSplitKeysList(@KeywordText)

	Open CriteriaCursor 

	DECLARE @itemKey varchar(max)
	DECLARE @InvalidKeywordFound integer

	Fetch NEXT FROM CriteriaCursor INTO @itemKey

	While (@@FETCH_STATUS <> -1)
	BEGIN
		IF (@@FETCH_STATUS <> -2)			
				select @KeywordName = @itemKey
				set @KeywordName = '%' + @KeywordName + '%'
				
				set @InvalidKeywordFound = patindex(UPPER(@KeywordName), UPPER(@QueryText))
				
				if @InvalidKeywordFound > 0
				begin
				-- Invlaid keyword was found, exit the proc
					set @Result = 1
					return @Result
				end
		Fetch NEXT FROM CriteriaCursor INTO @itemKey
	END
	CLOSE CriteriaCursor
	DEALLOCATE CriteriaCursor
	
	return @Result

END
