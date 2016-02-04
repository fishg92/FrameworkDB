CREATE Function [dbo].[IsNotificationExcluded]
(
	@ApplicationUser int
	, @TableName varchar(200)
	, @FkType int
)
RETURNS bit
AS
BEGIN
	DECLARE @ReturnValue bit
	
	if exists (	
					select *
					FROM NotificationExclusions
					WHERE fkApplicationUser = @ApplicationUser
					AND TableName = @TableName
					AND fkType = @FkType
				)
		set @ReturnValue = 1
	else
		set @ReturnValue = 0
		
	RETURN @ReturnValue

END
