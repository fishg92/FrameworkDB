----------------------------------------------------------------------------
-- Insert a single record into TaskFormCompletion
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspTaskFormCompletionInsert]
(	  @fkTask varchar(50)
	, @fkCPClient decimal(18, 0)
	, @fkFormName decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkTaskFormCompletion decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT TaskFormCompletion
(	  fkTask
	, fkCPClient
	, fkFormName
)
VALUES 
(	  @fkTask
	, @fkCPClient
	, @fkFormName

)

SET @pkTaskFormCompletion = SCOPE_IDENTITY()
