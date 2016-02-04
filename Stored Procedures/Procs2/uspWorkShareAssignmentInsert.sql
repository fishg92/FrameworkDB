-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into WorkShareAssignment
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspWorkShareAssignmentInsert]
(	  @fksharer decimal(18, 0)
	, @fksharee decimal(18, 0)
	, @fkrefWorkSharingType decimal(18,0)
	, @LUPUser varchar(50) = NULL
	, @LUPMac char(17) = NULL
	, @LUPIP varchar(15) = NULL
    , @LUPMachine varchar(15) = NULL
	, @pkWorkShareAssignment decimal(18, 0) = NULL OUTPUT 
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine


INSERT WorkShareAssignment
(	  fksharer
	, fksharee
	,fkrefWorkSharingType
)
VALUES 
(	  @fksharer
	, @fksharee
	, @fkrefWorkSharingType

)

SET @pkWorkShareAssignment = SCOPE_IDENTITY()
