----------------------------------------------------------------------------
-- Select a single record from FormConversion
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormConversionSelect]
(	@pkFormConversion decimal(18, 0) = NULL,
	@Username varchar(255) = NULL,
	@MachineName varchar(255) = NULL,
	@PCLFile varbinary(MAX) = NULL
)
AS

SELECT	pkFormConversion,
	Username,
	MachineName,
	PCLFile
FROM	FormConversion
WHERE 	(@pkFormConversion IS NULL OR pkFormConversion = @pkFormConversion)
 AND 	(@Username IS NULL OR Username LIKE @Username + '%')
 AND 	(@MachineName IS NULL OR MachineName LIKE @MachineName + '%')
