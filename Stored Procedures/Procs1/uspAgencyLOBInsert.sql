----------------------------------------------------------------------------
-- Insert a single record into AgencyLOB
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspAgencyLOBInsert]
(	  @AgencyLOBName varchar(100)
	, @fkAgency decimal(18, 0)
	, @fkSupervisor decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkAgencyLOB decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT AgencyLOB
(	  AgencyLOBName
	, fkAgency
	, fkSupervisor
)
VALUES 
(	  @AgencyLOBName
	, @fkAgency
	, COALESCE(@fkSupervisor, (-1))

)

SET @pkAgencyLOB = SCOPE_IDENTITY()
