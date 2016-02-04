----------------------------------------------------------------------------
-- Select a single record from TaskFormCompletion
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspTaskFormCompletionSelect]
(	@pkTaskFormCompletion decimal(18, 0) = NULL,
	@fkTask varchar(50) = NULL,
	@fkCPClient decimal(18, 0) = NULL,
	@fkFormName decimal(18, 0) = NULL
)
AS

SELECT	pkTaskFormCompletion,
	fkTask,
	fkCPClient,
	fkFormName
FROM	TaskFormCompletion
WHERE 	(@pkTaskFormCompletion IS NULL OR pkTaskFormCompletion = @pkTaskFormCompletion)
 AND 	(@fkTask IS NULL OR fkTask LIKE @fkTask + '%')
 AND 	(@fkCPClient IS NULL OR fkCPClient = @fkCPClient)
 AND 	(@fkFormName IS NULL OR fkFormName = @fkFormName)
