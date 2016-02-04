----------------------------------------------------------------------------
-- Select a single record from refAutofillSchemaDataStoreType
----------------------------------------------------------------------------
CREATE PROC [dbo].[usprefAutofillSchemaDataStoreTypeSelect]
(	@pkrefAutofillSchemaDataStoreType decimal(18, 0) = NULL,
	@FriendlyName varchar(150) = NULL
)
AS

SELECT	pkrefAutofillSchemaDataStoreType,
	FriendlyName
FROM	refAutofillSchemaDataStoreType
WHERE 	(@pkrefAutofillSchemaDataStoreType IS NULL OR pkrefAutofillSchemaDataStoreType = @pkrefAutofillSchemaDataStoreType)
 AND 	(@FriendlyName IS NULL OR FriendlyName LIKE @FriendlyName + '%')
