----------------------------------------------------------------------------
-- Select a single record from JoinTaskDocument
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinTaskDocumentSelect]
(	@pkJoinTaskDocument decimal(18, 0) = NULL,
	@fkDocument varchar(50) = NULL,
	@fkTask decimal(18, 0) = NULL
)
AS

SELECT	pkJoinTaskDocument,
	fkDocument,
	fkTask
FROM	JoinTaskDocument
WHERE 	(@pkJoinTaskDocument IS NULL OR pkJoinTaskDocument = @pkJoinTaskDocument)
 AND 	(@fkDocument IS NULL OR fkDocument LIKE @fkDocument + '%')
 AND 	(@fkTask IS NULL OR fkTask = @fkTask)

