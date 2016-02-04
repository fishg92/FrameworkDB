CREATE PROC [dbo].[UserTaskTypeDeselectedDelete]
(	@fkApplicationUser decimal(18, 0)
	,@fkrefTaskType decimal(18,0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15) 
	, @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

DELETE	UserTaskTypeDeselected
WHERE 	fkApplicationUser = @fkApplicationUser
and		fkrefTaskType = @fkrefTaskType
