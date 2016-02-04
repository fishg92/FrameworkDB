----------------------------------------------------------------------------
-- Select a single record from JoinProfileSmartView
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinProfileSmartViewSelect]
(	@pkJoinProfileSmartView decimal(18, 0) = NULL,
	@fkProfile decimal(18, 0) = NULL,
	@fkSmartView decimal(18, 0) = NULL,
	@LUPUser varchar(50) = NULL,
	@LUPDate datetime = NULL,
	@CreateUser varchar(50) = NULL,
	@CreateDate datetime = NULL
)
AS

SELECT	pkJoinProfileSmartView,
	fkProfile,
	fkSmartView,
	LUPUser,
	LUPDate,
	CreateUser,
	CreateDate
FROM	JoinProfileSmartView
WHERE 	(@pkJoinProfileSmartView IS NULL OR pkJoinProfileSmartView = @pkJoinProfileSmartView)
 AND 	(@fkProfile IS NULL OR fkProfile = @fkProfile)
 AND 	(@fkSmartView IS NULL OR fkSmartView = @fkSmartView)
 AND 	(@LUPUser IS NULL OR LUPUser LIKE @LUPUser + '%')
 AND 	(@LUPDate IS NULL OR LUPDate = @LUPDate)
 AND 	(@CreateUser IS NULL OR CreateUser LIKE @CreateUser + '%')
 AND 	(@CreateDate IS NULL OR CreateDate = @CreateDate)

