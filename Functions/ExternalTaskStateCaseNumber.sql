CREATE function [dbo].[ExternalTaskStateCaseNumber]
	(
		@fkExternalTask varchar(50)
	)
returns varchar(255)
as
	begin

	declare @CaseNumber varchar(255)
			,@pkCPClient decimal
			,@pkCPClientCase decimal
			,@CaseCount int
			,@pkExternalTaskMetaData decimal
			
	select	@pkExternalTaskMetaData = pkExternalTaskMetaData
	from	ExternalTaskMetaData
	where	fkExternalTask = @fkExternalTask
		
	set @CaseNumber = ''
				
	select	@CaseCount = count(*)
	from	JoinExternalTaskMetaDataCPClientCase
	join CPClientCase
		on JoinExternalTaskMetaDataCPClientCase.fkCPClientCase = CPClientCase.pkCPClientCase
	where	JoinExternalTaskMetaDataCPClientCase.fkExternalTaskMetaData = @pkExternalTaskMetaData
	
	if @CaseCount = 1
		begin
		select @CaseNumber = isnull(StateCaseNumber,'')
		from	CPClientCase
		where	pkCPClientCase = (select fkCPClientCase
								from JoinExternalTaskMetaDataCPClientCase
								where fkExternalTaskMetaData = @pkExternalTaskMetaData)
		end
	
	set @CaseNumber = isnull(@CaseNumber,'')
	
	if @CaseNumber = ''
		begin
		select @CaseCount = count(*)
		from JoinExternalTaskMetaDataCPClient
		join CPClient
			on JoinExternalTaskMetaDataCPClient.fkCPClient = CPClient.pkCPClient
		join CPJoinClientClientCase
			on CPJoinClientClientCase.fkCPClient = CPClient.pkCPClient
		join CPClientCase
			on CPClientCase.pkCPClientCase = CPJoinClientClientCase.fkCPClientCase
		where JoinExternalTaskMetaDataCPClient.fkExternalTaskMetaData = @pkExternalTaskMetaData
		
		if @CaseCount = 1
			begin

			select @CaseNumber = StateCaseNumber
			from JoinExternalTaskMetaDataCPClient
			join CPClient
				on JoinExternalTaskMetaDataCPClient.fkCPClient = CPClient.pkCPClient
			join CPJoinClientClientCase
				on CPJoinClientClientCase.fkCPClient = CPClient.pkCPClient
			join CPClientCase
				on CPClientCase.pkCPClientCase = CPJoinClientClientCase.fkCPClientCase
			where JoinExternalTaskMetaDataCPClient.fkExternalTaskMetaData = @pkExternalTaskMetaData
			end
		end
		
	if @CaseCount > 1
		--set @CaseNumber = '(Multiple)'
		begin
		set @CaseNumber = ''
		
		declare crCaseNumber cursor local for 
		select distinct CPClientCase.StateCaseNumber
		from JoinExternalTaskMetaDataCPClient
		join CPClient
			on JoinExternalTaskMetaDataCPClient.fkCPClient = CPClient.pkCPClient
		join CPJoinClientClientCase
			on CPJoinClientClientCase.fkCPClient = CPClient.pkCPClient
		join CPClientCase
			on CPClientCase.pkCPClientCase = CPJoinClientClientCase.fkCPClientCase
		where JoinExternalTaskMetaDataCPClient.fkExternalTaskMetaData = @pkExternalTaskMetaData
		
		declare @tempCase varchar(20)
		
		open crCaseNumber
		fetch next from crCaseNumber into @tempCase
		while @@fetch_status = 0
			begin
			if @CaseNumber <> ''
				set @CaseNumber = @CaseNumber + ', '
			set @CaseNumber = @CaseNumber + @tempCase
			fetch next from crCaseNumber into @tempCase
			end
		close crCaseNumber
		deallocate crCaseNumber
		end

	return @CaseNumber
	end


