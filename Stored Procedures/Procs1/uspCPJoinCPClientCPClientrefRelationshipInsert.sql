----------------------------------------------------------------------------
-- Insert a single record into CPJoinCPClientCPClientrefRelationship
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspCPJoinCPClientCPClientrefRelationshipInsert]
(	  @fkCPClientParent decimal(18, 0) = NULL
	, @fkCPClientChild decimal(18, 0) = NULL
	, @fkParentCPrefClientRelationshipType decimal(18, 0) = NULL
	, @fkChildCPrefClientRelationshipType decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkCPJoinCPClientCPClientrefRelationship decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT CPJoinCPClientCPClientrefRelationship
(	  fkCPClientParent
	, fkCPClientChild
	, fkParentCPrefClientRelationshipType
	, fkChildCPrefClientRelationshipType
)
VALUES 
(	  @fkCPClientParent
	, @fkCPClientChild
	, @fkParentCPrefClientRelationshipType
	, @fkChildCPrefClientRelationshipType

)

SET @pkCPJoinCPClientCPClientrefRelationship = SCOPE_IDENTITY()
