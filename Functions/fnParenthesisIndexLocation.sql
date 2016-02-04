-- =============================================
-- Author:		Jerrel Blankenship/James Neno
-- Create date: 5/20/2010
-- Description:	Finds the location of the last right paren to the first left paren
-- =============================================
CREATE FUNCTION fnParenthesisIndexLocation 
(
	-- Add the parameters for the function here
	@StringText varchar(max)
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result int
	DECLARE @Counter int
	DECLARE @IndexLocation int
	DECLARE @StartCheck tinyint
	
	SET @Result = -1
	SET @IndexLocation = 1
	SET @Counter = 0
	SET @StartCheck = 0
	
	while (@Result = -1 and @IndexLocation <= len(@StringText))
	BEGIN
		
		if substring(@StringText, @IndexLocation, 1) = '('
		begin
			SET @StartCheck = 1
			SET @Counter = @Counter + 1
		end
		
		if substring(@StringText, @IndexLocation, 1) = ')'
		begin
			SET @Counter = @Counter - 1
		end
		
		if @StartCheck = 1 and @Counter = 0
		begin
			Set @Result = @IndexLocation
			BREAK
		end
		
		SET @IndexLocation = @IndexLocation + 1
	END

	-- Return the result of the function
	RETURN @Result

END
