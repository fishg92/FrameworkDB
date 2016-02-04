




CREATE Proc [dbo].[spCPImportCPCaseWorkerAltIdsV2] (
	@WorkerId varchar(50)
	, @fkApplicationUser decimal
	, @EffectiveDate datetime = null --not used but left for compatability
	, @pkCPCaseWorkerAltId decimal(18, 0) = NULL OUTPUT 
)
as


Declare 
	@HostName varchar(100)
	
select @HostName = host_name()

If not exists(	
				Select 	fkApplicationUser
				From	CPCaseWorkerAltId with (nolock)
				Where	fkApplicationUser = @fkApplicationUser
				and WorkerId = @WorkerId
			  ) 
Begin
	Exec uspCPCaseWorkerAltIdInsert
		@workerId = @workerId
		,@fkApplicationUser = @fkApplicationUser
		,@fkCPCaseworker = null
		, @LockedDate = null
		, @LockedUser = null
		, @LUPUser=@HostName
		, @LUPMac=@HostName
		, @LUPIP=@HostName
		, @LUPMachine=@HostName
		,@pkCPCaseWorkerAltId = @pkCPCaseWorkerAltId Output
End







