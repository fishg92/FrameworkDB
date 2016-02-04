----------------------------------------------------------------------------
-- Select a single record from JoinProfileAutoFillSchemaDataView
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinProfileAutoFillSchemaDataViewSelect]
(	@pkJoinProfileAutoFillSchemaDataView decimal(18, 0) = NULL,
	@fkProfile decimal(18, 0) = NULL,
	@fkAutoFillSchemaDataView decimal(18, 0) = NULL
)
AS

SELECT	pkJoinProfileAutoFillSchemaDataView,
	fkProfile,
	fkAutoFillSchemaDataView

FROM	JoinProfileAutoFillSchemaDataView
WHERE 	(@pkJoinProfileAutoFillSchemaDataView IS NULL OR pkJoinProfileAutoFillSchemaDataView = @pkJoinProfileAutoFillSchemaDataView)
 AND 	(@fkProfile IS NULL OR fkProfile = @fkProfile)
 AND 	(@fkAutoFillSchemaDataView IS NULL OR fkAutoFillSchemaDataView = @fkAutoFillSchemaDataView)


