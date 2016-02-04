-- Stored Procedure

----------------------------------------------------------------------------
-- Update a single record in TaskFilterTaskTypeDeselected
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspTaskFilterTaskTypeDeselectedUpdate]
(	  @pkTaskFilterTaskTypeDeselected decimal(18, 0)
	, @fkTaskFilter decimal(18, 0) = NULL
	, @fkrefTaskType decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	TaskFilterTaskTypeDeselected
SET	fkTaskFilter = ISNULL(@fkTaskFilter, fkTaskFilter),
	fkrefTaskType = ISNULL(@fkrefTaskType, fkrefTaskType)
WHERE 	pkTaskFilterTaskTypeDeselected = @pkTaskFilterTaskTypeDeselected
