----------------------------------------------------------------------------
-- Select a single record from CPJoinCPClientCPClientrefRelationship
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPJoinCPClientCPClientrefRelationshipSelect]
(	@pkCPJoinCPClientCPClientrefRelationship decimal(18, 0) = NULL,
	@fkCPClientParent decimal(18, 0) = NULL,
	@fkCPClientChild decimal(18, 0) = NULL,
	@fkParentCPrefClientRelationshipType decimal(18, 0) = NULL,
	@fkChildCPrefClientRelationshipType decimal(18, 0) = NULL
)
AS

SELECT	pkCPJoinCPClientCPClientrefRelationship,
	fkCPClientParent,
	fkCPClientChild,
	fkParentCPrefClientRelationshipType,
	fkChildCPrefClientRelationshipType
FROM	CPJoinCPClientCPClientrefRelationship
WHERE 	(@pkCPJoinCPClientCPClientrefRelationship IS NULL OR pkCPJoinCPClientCPClientrefRelationship = @pkCPJoinCPClientCPClientrefRelationship)
 AND 	(@fkCPClientParent IS NULL OR fkCPClientParent = @fkCPClientParent)
 AND 	(@fkCPClientChild IS NULL OR fkCPClientChild = @fkCPClientChild)
 AND 	(@fkParentCPrefClientRelationshipType IS NULL OR fkParentCPrefClientRelationshipType = @fkParentCPrefClientRelationshipType)
 AND 	(@fkChildCPrefClientRelationshipType IS NULL OR fkChildCPrefClientRelationshipType = @fkChildCPrefClientRelationshipType)

