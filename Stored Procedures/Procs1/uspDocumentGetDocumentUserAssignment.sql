CREATE PROC [dbo].[uspDocumentGetDocumentUserAssignment]
(	@pkDocumentUserAssignment decimal(18, 0) = NULL,
	@fkDocument varchar(50) = NULL,
	@fkrefAssignmentType decimal(18, 0) = NULL,
	@UserAssigned varchar(20) = NULL,
	@FollowUpDate smalldatetime = NULL
)
AS

IF @fkDocument = '0'
	SET @fkDocument = NULL

SELECT    n.pkDocumentUserAssignment 
		, n.fkDocument
		, n.fkrefAssignmentType
		, n.UserAssigned
		, n.FollowUpDate 
		, n.LUPDate AS 'CreateDate'
		, COALESCE(a.UserName, n.LUPUser, '0') AS 'CreateUser'
		, n.Note
FROM DocumentUserAssignment n WITH (NOLOCK)
LEFT JOIN ApplicationUser a 
	ON
		CASE
			WHEN ISNUMERIC(n.LUPUser) = 1 
				THEN n.LUPUser 
			ELSE 0 
		END = a.pkApplicationUser 
WHERE (@pkDocumentUserAssignment IS NULL OR n.pkDocumentUserAssignment = @pkDocumentUserAssignment)
AND   (@fkDocument IS NULL OR n.fkDocument = @fkDocument)
AND   (@fkrefAssignmentType IS NULL OR n.fkrefAssignmentType = @fkrefAssignmentType)
AND   (@UserAssigned IS NULL OR n.UserAssigned = @UserAssigned)
AND   (@FollowUpDate IS NULL OR n.FollowUpDate = @FollowUpDate)