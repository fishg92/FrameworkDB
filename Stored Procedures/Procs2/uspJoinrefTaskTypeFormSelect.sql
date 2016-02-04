----------------------------------------------------------------------------
-- Select a single record from JoinrefTaskTypeForm
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinrefTaskTypeFormSelect]
(	@pkJoinrefTaskTypeForm decimal(18, 0) = NULL,
	@fkrefTaskType decimal(18, 0) = NULL,
	@fkFormName decimal(18, 0) = NULL
)
AS

SELECT	pkJoinrefTaskTypeForm,
	fkrefTaskType,
	fkFormName
FROM	JoinrefTaskTypeForm
WHERE 	(@pkJoinrefTaskTypeForm IS NULL OR pkJoinrefTaskTypeForm = @pkJoinrefTaskTypeForm)
 AND 	(@fkrefTaskType IS NULL OR fkrefTaskType = @fkrefTaskType)
 AND 	(@fkFormName IS NULL OR fkFormName = @fkFormName)

