CREATE FUNCTION RemoveLeadingZerosFromVarChar

(
      @inputStr varchar(500)

)

RETURNS varchar(500)

AS

BEGIN

      DECLARE @Result varchar(500)
 
      SELECT @Result = replace(replace(ltrim(replace(

          replace(ltrim(@inputStr), ' ', '¬') 
          , '0', ' ') 
          ) 
          , ' ', '0') 
          , '¬', ' ') 
 
      RETURN @Result

END

