----------------------------------------------------------------------------
-- Select a single record from AutoFillDataStore
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspAutoFillDataStoreSelect]
(	@pkAutoFillDataStore decimal(18, 0) = NULL,
	@FriendlyName varchar(100) = NULL,
	@ConnectionType varchar(100) = NULL,
	@ConnectionString varchar(500) = NULL,
	@Enabled bit = NULL
)
AS

SELECT	pkAutoFillDataStore,
	FriendlyName,
	ConnectionType,
	ConnectionString,
	Enabled
FROM	AutoFillDataStore
WHERE 	(@pkAutoFillDataStore IS NULL OR pkAutoFillDataStore = @pkAutoFillDataStore)
 AND 	(@FriendlyName IS NULL OR FriendlyName LIKE @FriendlyName + '%')
 AND 	(@ConnectionType IS NULL OR ConnectionType LIKE @ConnectionType + '%')
 AND 	(@ConnectionString IS NULL OR ConnectionString LIKE @ConnectionString + '%')
 AND 	(@Enabled IS NULL OR Enabled = @Enabled)

