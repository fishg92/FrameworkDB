----------------------------------------------------------------------------
-- Update a single record in FormConversion
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormConversionUpdate]
(	  @pkFormConversion decimal(18, 0)
	, @Username varchar(255) = NULL
	, @MachineName varchar(255) = NULL
	, @PCLFile varbinary(MAX) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	FormConversion
SET	Username = ISNULL(@Username, Username),
	MachineName = ISNULL(@MachineName, MachineName),
	PCLFile = ISNULL(@PCLFile, PCLFile)
WHERE 	pkFormConversion = @pkFormConversion
