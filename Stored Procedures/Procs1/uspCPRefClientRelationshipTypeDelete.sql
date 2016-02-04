----------------------------------------------------------------------------
-- Delete a single record from CPRefClientRelationshipType
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspCPRefClientRelationshipTypeDelete]
(	@pkCPRefClientRelationshipType decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15) 
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

DELETE	CPRefClientRelationshipType
WHERE 	pkCPRefClientRelationshipType = @pkCPRefClientRelationshipType
