-- Stored Procedure

----------------------------------------------------------------------------
-- Delete a single record from JoinProgramTypeDocumentType
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspJoinProgramTypeDocumentTypeDelete]
(	@pkJoinProgramTypeDocumentType int
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

DELETE	JoinProgramTypeDocumentType
WHERE 	pkJoinProgramTypeDocumentType = @pkJoinProgramTypeDocumentType
