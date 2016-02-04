CREATE  PROC [dbo].[usp_GetFieldNameRegEx]
(
	@strFieldName varchar (150)
)	
AS
BEGIN
Select pkrefFieldNameRegEx,regExValues,regFieldName, FriendlyName
from refFieldNameRegEx (nolock)
where @strFieldName = regFieldName


END
