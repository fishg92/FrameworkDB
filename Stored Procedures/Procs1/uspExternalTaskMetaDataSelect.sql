----------------------------------------------------------------------------
-- Select a single record from ExternalTaskMetaData
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspExternalTaskMetaDataSelect]
(	@pkExternalTaskMetaData decimal(18, 0) = NULL,
	@fkExternalTask varchar(50) = NULL,
	@fkrefTaskPriority decimal(18, 0) = NULL,
	@fkrefTaskStatus decimal(18, 0) = NULL,
	@fkrefTaskOrigin decimal(18, 0) = NULL,
	@SourceModuleID int = NULL
)
AS

SELECT	pkExternalTaskMetaData,
	fkExternalTask,
	fkrefTaskPriority,
	fkrefTaskStatus,
	fkrefTaskOrigin,
	SourceModuleID
FROM	ExternalTaskMetaData
WHERE 	(@pkExternalTaskMetaData IS NULL OR pkExternalTaskMetaData = @pkExternalTaskMetaData)
 AND 	(@fkExternalTask IS NULL OR fkExternalTask LIKE @fkExternalTask + '%')
 AND 	(@fkrefTaskPriority IS NULL OR fkrefTaskPriority = @fkrefTaskPriority)
 AND 	(@fkrefTaskStatus IS NULL OR fkrefTaskStatus = @fkrefTaskStatus)
 AND 	(@fkrefTaskOrigin IS NULL OR fkrefTaskOrigin = @fkrefTaskOrigin)
 AND 	(@SourceModuleID IS NULL OR SourceModuleID = @SourceModuleID)
