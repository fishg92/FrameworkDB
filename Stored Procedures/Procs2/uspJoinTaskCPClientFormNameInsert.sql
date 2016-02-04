----------------------------------------------------------------------------
-- Insert a single record into JoinTaskCPClientFormName
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspJoinTaskCPClientFormNameInsert]
(	  @fkJoinTaskCPClient decimal(18, 0)
	, @fkFormName decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkJoinTaskCPClientFormName decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT JoinTaskCPClientFormName
(	  fkJoinTaskCPClient
	, fkFormName
)
VALUES 
(	  @fkJoinTaskCPClient
	, @fkFormName

)

SET @pkJoinTaskCPClientFormName = SCOPE_IDENTITY()
