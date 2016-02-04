-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into TaskFilterTaskTypeDeselected
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspTaskFilterTaskTypeDeselectedInsert]
(	  @fkTaskFilter decimal(18, 0)
	, @fkrefTaskType decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkTaskFilterTaskTypeDeselected decimal(18, 0) = NULL OUTPUT 
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT TaskFilterTaskTypeDeselected
(	  pkTaskFilterTaskTypeDeselected
	, fkTaskFilter
	, fkrefTaskType
)
VALUES 
(	  @pkTaskFilterTaskTypeDeselected
	, @fkTaskFilter
	, @fkrefTaskType

)

SET @pkTaskFilterTaskTypeDeselected = SCOPE_IDENTITY()
