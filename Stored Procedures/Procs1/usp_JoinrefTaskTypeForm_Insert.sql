


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_JoinrefTaskTypeForm_Insert]
	@fkrefTaskType as decimal
	,@fkFormName as decimal
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
AS
BEGIN

	
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @pkJoinrefTaskTypeForm as decimal (18,0)


    if not exists ( select 1 from dbo.JoinrefTaskTypeForm where fkrefTaskType = @fkrefTaskType and 
					fkFormName = @fkFormName )
	begin
		
		--insert into dbo.JoinrefTaskTypeForm
		--(fkrefTaskType,fkFormName)
		--values ( @fkrefTaskType,@fkFormName)
	

		exec [uspJoinrefTaskTypeFormInsert]
			 @fkrefTaskType
			, @fkFormName 
			, @LUPUser 
			, @LUPMac 
			, @LUPIP 
			, @LUPMachine 
			, @pkJoinrefTaskTypeForm  OUTPUT 


	end

	
END



