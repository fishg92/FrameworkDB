----------------------------------------------------------------------------
-- Update a single record in JoinrefTaskTyperefTaskEntityType
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinrefTaskTyperefTaskEntityTypeUpdate]
(	  @pkJoinrefTaskTyperefTaskEntityType decimal(18, 0)
	, @fkrefTaskType decimal(18, 0) = NULL
	, @fkrefTaskEntityType decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	JoinrefTaskTyperefTaskEntityType
SET	fkrefTaskType = ISNULL(@fkrefTaskType, fkrefTaskType),
	fkrefTaskEntityType = ISNULL(@fkrefTaskEntityType, fkrefTaskEntityType)
WHERE 	pkJoinrefTaskTyperefTaskEntityType = @pkJoinrefTaskTyperefTaskEntityType
