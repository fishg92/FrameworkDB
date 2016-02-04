
CREATE PROCEDURE [dbo].[usp_GetJoinrefTaskTypeForm]
	@fkrefTaskType decimal
	,@fkTask varchar(50)
	,@fkCPClient decimal
AS

SET NOCOUNT ON

Select	JoinrefTaskTypeForm.fkFormName
		, FormName.FriendlyName
		, FormCompleted = 
			case 
				when exists (
					select	*
					from	TaskFormCompletion
					where	fkTask = @fkTask
					and		fkCPClient = @fkCPClient
					and		fkFormName = JoinrefTaskTypeForm.fkFormName ) 
				then  1
				else  0
			end 
		, FormName.SystemName
from	dbo.JoinrefTaskTypeForm
join	dbo.FormName
	on JoinrefTaskTypeForm.fkFormName = FormName.pkFormName
where JoinrefTaskTypeForm.fkrefTaskType = @fkrefTaskType	

