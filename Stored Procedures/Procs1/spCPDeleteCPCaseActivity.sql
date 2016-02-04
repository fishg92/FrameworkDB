CREATE proc [dbo].[spCPDeleteCPCaseActivity]
(	
	@pkCPCaseActivity decimal(18,0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
as

set nocount on
exec dbo.SetAuditDataContext @LupUser, @LupMachine

DELETE FROM CPCaseActivity 
where pkCPCaseActivity = @pkCPCaseActivity
