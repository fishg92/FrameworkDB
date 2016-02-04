----------------------------------------------------------------------------
-- Insert a single record into AgencyConfig
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspAgencyConfigInsert]
(	  @AgencyName varchar(100)
	, @fkSupervisor decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkAgencyConfig decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT AgencyConfig
(	  AgencyName
	, fkSupervisor
)
VALUES 
(	  @AgencyName
	, COALESCE(@fkSupervisor, (-1))

)

SET @pkAgencyConfig = SCOPE_IDENTITY()
