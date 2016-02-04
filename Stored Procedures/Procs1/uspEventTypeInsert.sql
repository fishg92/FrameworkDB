----------------------------------------------------------------------------
-- Insert a single record into EventType
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspEventTypeInsert]
(	  @Description varchar(250) = NULL
	, @fkProgramType decimal(18, 0) = NULL
	, @fkSmartView decimal(18, 0) = NULL
	, @IncludeCaseworkerCases bit = NULL
	, @IncludeFavoriteCases bit = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkEventType decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT EventType
(	  Description
	, fkProgramType
	, fkSmartView
	, IncludeCaseworkerCases
	, IncludeFavoriteCases
)
VALUES 
(	  @Description
	, @fkProgramType
	, @fkSmartView
	, @IncludeCaseworkerCases
	, @IncludeFavoriteCases

)

SET @pkEventType = SCOPE_IDENTITY()
