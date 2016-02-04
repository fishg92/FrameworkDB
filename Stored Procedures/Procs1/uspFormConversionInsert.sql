----------------------------------------------------------------------------
-- Insert a single record into FormConversion
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspFormConversionInsert]
(	  @Username varchar(255)
	, @MachineName varchar(255)
	, @PCLFile varbinary(MAX)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkFormConversion decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT FormConversion
(	  Username
	, MachineName
	, PCLFile
)
VALUES 
(	  @Username
	, @MachineName
	, @PCLFile

)

SET @pkFormConversion = SCOPE_IDENTITY()
