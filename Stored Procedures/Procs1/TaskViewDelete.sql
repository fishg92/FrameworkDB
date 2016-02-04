﻿
CREATE PROC [dbo].[TaskViewDelete]
(	@pkTaskView decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15) 
	, @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

delete	TaskFilter
where	fkTaskView = @pkTaskView

delete	TaskViewTaskTypeDeselected
where	fkTaskView = @pkTaskView

DELETE	TaskView
WHERE 	pkTaskView = @pkTaskView