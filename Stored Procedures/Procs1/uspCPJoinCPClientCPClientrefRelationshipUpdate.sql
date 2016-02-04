----------------------------------------------------------------------------
-- Update a single record in CPJoinCPClientCPClientrefRelationship
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPJoinCPClientCPClientrefRelationshipUpdate]
(	  @pkCPJoinCPClientCPClientrefRelationship decimal(18, 0)
	, @fkCPClientParent decimal(18, 0) = NULL
	, @fkCPClientChild decimal(18, 0) = NULL
	, @fkParentCPrefClientRelationshipType decimal(18, 0) = NULL
	, @fkChildCPrefClientRelationshipType decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	CPJoinCPClientCPClientrefRelationship
SET	fkCPClientParent = ISNULL(@fkCPClientParent, fkCPClientParent),
	fkCPClientChild = ISNULL(@fkCPClientChild, fkCPClientChild),
	fkParentCPrefClientRelationshipType = ISNULL(@fkParentCPrefClientRelationshipType, fkParentCPrefClientRelationshipType),
	fkChildCPrefClientRelationshipType = ISNULL(@fkChildCPrefClientRelationshipType, fkChildCPrefClientRelationshipType)
WHERE 	pkCPJoinCPClientCPClientrefRelationship = @pkCPJoinCPClientCPClientrefRelationship
