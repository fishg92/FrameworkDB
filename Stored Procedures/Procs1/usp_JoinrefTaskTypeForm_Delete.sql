

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_JoinrefTaskTypeForm_Delete]
	@fkrefTaskType as decimal
	,@fkFormName as decimal
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15) 
	, @LUPMachine varchar(15)
AS
BEGIN

	declare @pkJoinrefTaskTypeForm as decimal (18,0)

	select @pkJoinrefTaskTypeForm = -1

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
		if (@fkFormName = -1)
		begin
			delete dbo.JoinrefTaskTypeForm 
			where fkrefTaskType = @fkrefTaskType
		end
		else
		begin
			select @pkJoinrefTaskTypeForm = pkJoinrefTaskTypeForm 
			from dbo.JoinrefTaskTypeForm 
			where fkrefTaskType = @fkrefTaskType and
				  fkFormName = @fkFormName

			if ( @pkJoinrefTaskTypeForm > -1 )
			begin
				exec uspJoinrefTaskTypeFormDelete @pkJoinrefTaskTypeForm
				, @LUPUser 
				, @LUPMac 
				, @LUPIP 
				, @LUPMachine
			end
		end
	
END


