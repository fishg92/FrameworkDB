
--CanReceiveToastNotification 32,8680

Create PROC [dbo].[CanReceiveToastNotification]
(	  @fkApplicationUser decimal(18, 0)
	, @fkTask decimal(18, 0) = NULL
)
AS

DECLARE @fkRefTaskType int
declare @ret tinyint
set @ret = 0

SET @fkRefTaskType = (SELECT fkRefTaskType FROM dbo.Task WHERE pkTask = @fkTask)
 
IF dbo.IsNotificationExcluded(@fkApplicationUser, 'refTaskType', @fkRefTaskType) = 0 
begin
	set @ret = 1 
end
 
select @ret
