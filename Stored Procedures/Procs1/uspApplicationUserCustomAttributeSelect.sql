----------------------------------------------------------------------------
-- Select a single record from ApplicationUserCustomAttribute
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspApplicationUserCustomAttributeSelect]
(	@pkApplicationUserCustomAttribute decimal(18, 0) = NULL,
	@fkApplicationUser decimal(18, 0) = NULL,
	@ItemKey varchar(200) = NULL,
	@ItemValue varchar(300) = NULL
)
AS

SELECT	pkApplicationUserCustomAttribute,
	fkApplicationUser,
	ItemKey,
	ItemValue,
	LUPUser,
	LUPDate,
	CreateUser,
	CreateDate
FROM	ApplicationUserCustomAttribute
WHERE 	(@pkApplicationUserCustomAttribute IS NULL OR pkApplicationUserCustomAttribute = @pkApplicationUserCustomAttribute)
 AND 	(@fkApplicationUser IS NULL OR fkApplicationUser = @fkApplicationUser)
 AND 	(@ItemKey IS NULL OR ItemKey LIKE @ItemKey + '%')
 AND 	(@ItemValue IS NULL OR ItemValue LIKE @ItemValue + '%')

