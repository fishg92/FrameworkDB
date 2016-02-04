
CREATE FUNCTION [dbo].[fnRemoveMultipleSpaces] 

               (@InputString VARCHAR(max)) 

RETURNS VARCHAR(max) 

AS
BEGIN 

    WHILE CHARINDEX('  ',@InputString) > 0  -- Checking for double spaces

      SET @InputString = 

        REPLACE(@InputString,'  ',' ') -- Replace 2 spaces with 1 space 
     

    RETURN @InputString 

  END
