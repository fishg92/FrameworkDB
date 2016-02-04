----------------------------------------------------------------------------
-- Update a single record in TaskFormCompletion
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspTaskFormCompletionUpdate]
(	  @pkTaskFormCompletion decimal(18, 0)
	, @fkTask varchar(50) = NULL
	, @fkCPClient decimal(18, 0) = NULL
	, @fkFormName decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	TaskFormCompletion
SET	fkTask = ISNULL(@fkTask, fkTask),
	fkCPClient = ISNULL(@fkCPClient, fkCPClient),
	fkFormName = ISNULL(@fkFormName, fkFormName)
WHERE 	pkTaskFormCompletion = @pkTaskFormCompletion
