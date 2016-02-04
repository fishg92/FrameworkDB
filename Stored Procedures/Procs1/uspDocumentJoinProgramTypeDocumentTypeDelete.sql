-- Stored Procedure

----------------------------------------------------------------------------
-- Delete a single record from DocumentJoinProgramTypeDocumentType
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspDocumentJoinProgramTypeDocumentTypeDelete]
(	@pkDocumentJoinProgramTypeDocumentType int
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

DELETE	DocumentJoinProgramTypeDocumentType
WHERE 	pkDocumentJoinProgramTypeDocumentType = @pkDocumentJoinProgramTypeDocumentType
