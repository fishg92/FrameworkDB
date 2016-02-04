
/*
IF [dbo].GetConfigSettingValue('Blah') IS NULL
	PRINT 'Yay!'
ELSE
	PRINT 'Boo!'

IF [dbo].GetConfigSettingValue('DisplayTaskTypeCount') IS NULL
	PRINT 'Yay!'
ELSE
	PRINT 'Boo!'

UPDATE Configuration SET ItemValue = 'True' WHERE ItemKey = 'DisplayTaskTypeCount'
SELECT * FROM COnfiguration
*/

CREATE FUNCTION [dbo].GetConfigSettingValue
(
	@ItemKey varchar(200)
)
RETURNS nvarchar(300)
AS
BEGIN
	DECLARE @ItemValue nvarchar(300)

	SELECT @ItemValue = ISNULL(ItemValue, -1) FROM Configuration WHERE ItemKey = @ItemKey
	
	RETURN @ItemValue
END
