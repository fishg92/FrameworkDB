
/*
EXEC usp_TaskFilterDeleteByView 123
*/

CREATE PROC [dbo].[usp_TaskFilterDeleteByView]
(	@fkTaskView decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15) 
	, @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

DELETE	TaskFilter
WHERE 	fkTaskView = @fkTaskView
