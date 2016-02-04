


CREATE  Proc [dbo].[spCPImportCPJoinClientClientCaseV2] (
	@fkCPClient decimal (18,0)
	,@fkCPClientCase decimal (18,0)
	,@PrimaryParticipantOnCase tinyint
	,@IgnorePrimaryParticipantOnCase tinyint = 0  --Added parameter to ignore the above variable as there are cases when we have already added a client and do not want to change their status, however run into them on a different part of the import
	,@EffectiveDate datetime = null --not used but left for compatability
	,@pkCPJoinClientClientCase decimal (18,0) Output
	,@pkCPRefImportLogEventType decimal (18,0) = Null Output
)
as

declare
	@HostName varchar(100)
	,@PrimaryParticipantOnCaseCurrent decimal
	,@fkCPRefClientRelationshipTypeCurrent decimal
	,@bCaseHeadSwitch tinyint
	,@pkCPJoinClientClientCasePreviousCaseHead decimal
	,@fkCPRefClientRelationshipTypePreviousCaseHead decimal
	,@fkCPClientPreviousCaseHead decimal
	,@pkCPImportLog decimal

select @HostName = host_name()

set @pkCPJoinClientClientCase = 0

select @pkCPJoinClientClientCase = pkCPJoinClientClientCase
	,@PrimaryParticipantOnCaseCurrent = PrimaryParticipantOnCase
	,@fkCPRefClientRelationshipTypeCurrent = fkCPRefClientRelationshipType
from CPJoinClientClientCase j with (nolock)
where j.fkCPClient = @fkCPClient
and j.fkCPClientCase = @fkCPClientCase

if @pkCPJoinClientClientCase <> 0 begin
	exec dbo.spCPInsertCPImportLog
		@pkCPImportLog = @pkCPImportLog Output
		,@fkCPRefImportLogEventType = 9
		,@fkCPJoinClientClientCase = @pkCPJoinClientClientCase

	if @PrimaryParticipantOnCaseCurrent <> @PrimaryParticipantOnCase
	begin
		if @PrimaryParticipantOnCase = 1 and @PrimaryParticipantOnCaseCurrent = 0 begin
			set @bCaseHeadSwitch = 1 
		end

		exec dbo.uspCPJoinClientClientCaseUpdate
			@pkCPJoinClientClientCase=@pkCPJoinClientClientCase
			, @fkCPClientCase=@fkCPClientCase
			, @fkCPClient=@fkCPClient
			, @PrimaryParticipantOnCase=@PrimaryParticipantOnCase
			, @fkCPRefClientRelationshipType=@fkCPRefClientRelationshipTypeCurrent
			, @LUPUser=@HostName
			, @LUPMac=@HostName
			, @LUPIP=@HostName
			, @LUPMachine=@HostName

		exec dbo.spCPInsertCPImportLog
			@pkCPImportLog = @pkCPImportLog Output
			,@fkCPRefImportLogEventType = 10
			,@fkCPJoinClientClientCase = @pkCPJoinClientClientCase

	end
end else begin
	if @PrimaryParticipantOnCase = 1 begin
		set @bCaseHeadSwitch = 1 
	end
	exec dbo.uspCPJoinClientClientCaseInsert
		  @fkCPClientCase=@fkCPClientCase
		, @fkCPClient=@fkCPClient
		, @PrimaryParticipantOnCase=@PrimaryParticipantOnCase
		, @fkCPRefClientRelationshipType=@fkCPRefClientRelationshipTypeCurrent
		, @LUPUser=@HostName
		, @LUPMac=@HostName
		, @LUPIP=@HostName
		, @LUPMachine=@HostName
		, @pkCPJoinClientClientCase=@pkCPJoinClientClientCase

	exec dbo.spCPInsertCPImportLog
		@pkCPImportLog = @pkCPImportLog Output
		,@fkCPRefImportLogEventType = 8
		,@fkCPJoinClientClientCase = @pkCPJoinClientClientCase


end



If @bCaseHeadSwitch = 1 begin
	set @pkCPJoinClientClientCasePreviousCaseHead = 0

	select @pkCPJoinClientClientCasePreviousCaseHead = pkCPJoinClientClientCase
		,@fkCPRefClientRelationshipTypePreviousCaseHead = fkCPRefClientRelationshipType
		,@fkCPClientPreviousCaseHead = fkCPClient
	from CPJoinClientClientCase j with (nolock)
	where j.fkCPClient <> @fkCPClient
	and j.fkCPClientCase = @fkCPClientCase
	and PrimaryParticipantOnCase = 1

	if @pkCPJoinClientClientCasePreviousCaseHead <> 0 begin
		exec dbo.uspCPJoinClientClientCaseUpdate
			@pkCPJoinClientClientCase=@pkCPJoinClientClientCasePreviousCaseHead
			, @fkCPClientCase=@fkCPClientCase
			, @fkCPClient=@fkCPClientPreviousCaseHead
			, @PrimaryParticipantOnCase=0
			, @fkCPRefClientRelationshipType=@fkCPRefClientRelationshipTypePreviousCaseHead
			, @LUPUser=@HostName
			, @LUPMac=@HostName
			, @LUPIP=@HostName
			, @LUPMachine=@HostName

		exec dbo.spCPInsertCPImportLog
			@pkCPImportLog = @pkCPImportLog Output
			,@fkCPRefImportLogEventType = 10
			,@fkCPJoinClientClientCase = @pkCPJoinClientClientCase

	end

end
