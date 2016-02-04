-- Stored Procedure

----------------------------------------------------------------------------
-- Update a single record in WorkShareAssignment
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspWorkShareAssignmentUpdate]
(	  @pkWorkShareAssignment decimal(18, 0)
	, @fksharer decimal(18, 0) = NULL
	, @fksharee decimal(18, 0) = NULL
	, @fkrefWorkSharingType decimal(18,0) = NULL
	, @LUPUser varchar(50) = NULL
	, @LUPMac char(17) = NULL
	, @LUPIP varchar(15) = NULL
    , @LUPMachine varchar(15) = NULL
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	WorkShareAssignment
SET	fksharer = ISNULL(@fksharer, fksharer),
	fksharee = ISNULL(@fksharee, fksharee),
	fkrefWorkSharingType = ISNULL(@fkrefWorkSharingType, fkrefWorkSharingType)
WHERE 	pkWorkShareAssignment = @pkWorkShareAssignment
