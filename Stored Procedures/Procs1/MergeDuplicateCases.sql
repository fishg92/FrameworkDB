


CREATE procedure [dbo].[MergeDuplicateCases]
(
	@pkCPClientCaseMain decimal,
	@LUPUser varchar(50),
	@LUPMac char(17),
	@LUPIP varchar(15),
	@LUPMachine varchar(15),
	@MergeNarrative varchar (max),
	@MergeNarrativeAutoGen varchar (max)
)

as

set nocount on
begin tran

declare @DupCasePK decimal,
		@ErrorOccurred tinyint


declare DupCases cursor
for select fkCPClientCaseDuplicate from DuplicateCases
	where fkCPClientCaseMain = @pkCPClientCaseMain

open DupCases

fetch next from DupCases
into @DupCasePK

create table #PKHolder
(
	PK decimal
)

create table #MainCaseUsers
(
	PK decimal
)

while @@fetch_status = 0
	begin
		-------	Update Case Joins -------------------------------------------------------------- 
		insert into #PKHolder
		select pkCPJoinClientClientCase
		from CPJoinClientClientCase 
		where fkCPClientCase = @DupCasePK

		declare @pkJoinClientClientCase decimal,
				@fkCPClient decimal,
				@fkCPClientCase decimal

		set @ErrorOccurred = 0

		declare MemberJoins cursor
		for select #PKHolder.PK,
				   cj.fkCPClient
		    from #PKHolder
			join CPJoinClientClientCase cj on cj.pkCPJoinClientClientCase = #PKHolder.PK
			
		open MemberJoins

		fetch next from MemberJoins
		into @pkJoinClientClientCase, @fkCPClient

		while @@fetch_status = 0
			begin
				if exists(select pkCPJoinClientClientCase 
						  from CPJoinClientClientCase
						  where fkCPClient = @fkCPClient
						  and fkCPClientCase = @pkCPClientCaseMain)
					begin
						exec uspCPJoinClientClientCaseDelete @pkJoinClientClientCase, @LUPUser, @LUPMac, @LUPIP, @LUPMachine
					end
				else
					begin
					
						exec uspCPJoinClientClientCaseInsert @pkCPClientCaseMain, @fkCPClient, 0, Null, Null, Null, @LUPUser, @LUPMac, @LUPIP, @LUPMachine
						exec uspCPJoinClientClientCaseDelete @pkJoinClientClientCase, @LUPUser, @LUPMac, @LUPIP, @LUPMachine
					end
	
				if @@error <> 0
					begin
						set @ErrorOccurred = 1
						break
					end
				
				fetch next from MemberJoins
				into @pkJoinClientClientCase, @fkCPClient
			end

		close MemberJoins
		deallocate MemberJoins
		truncate table #PKHolder
		----------------------------------------------------------------------------------------
	
		if @ErrorOccurred = 0
			begin
				-------	Update Case Narratives ----------------------------------------------------
				insert into #PKHolder
				select pkCPCaseActivity
				from CPCaseActivity 
				where fkCPClientCase = @DupCasePK

				declare @pkCPCaseActivity decimal
				
				declare ActivityJoins cursor
				for select PK from #PKHolder
					
				open ActivityJoins

				fetch next from ActivityJoins
				into @pkCPCaseActivity

				while @@fetch_status = 0
					begin
						exec uspCPCaseActivityUpdate @pkCPCaseActivity, null, @pkCPClientCaseMain, null, null, @LUPUser, @LUPMac, @LUPIP, @LUPMachine 
						
						if @@error <> 0
							begin
								set @ErrorOccurred = 1
								break
							end
						
						fetch next from ActivityJoins
						into @pkCPCaseActivity
					end

				close ActivityJoins
				deallocate ActivityJoins
				truncate table #PKHolder
				--------------------------------------------------------------------------------
			end

		if @ErrorOccurred = 0
			begin
				-------	Transfer Task Tracker tasks ------------------------------------
				truncate table #PKHolder
				
				insert	#PKHolder
				select	pkJoinTaskCPClientCase
				from	JoinTaskCPClientCase
				where	fkCPClientCase = @DupCasePK
				
				declare @pkJoinTaskCPClientCase decimal
				
				declare crTaskJoin insensitive cursor for
				select	PK
				from	#PKHolder
				
				open crTaskJoin

				fetch next from crTaskJoin
				into @pkJoinTaskCPClientCase
				
				while @@fetch_status = 0
					begin
					
					declare @fkTask decimal
					select	@fkTask = fkTask
					from	JoinTaskCPClientCase
					where	pkJoinTaskCPClientCase = @pkJoinTaskCPClientCase
					
					if not exists (	select	*
									from	JoinTaskCPClientCase
									where	fkTask = @fkTask
									and		fkCPClientCase = @pkCPClientCaseMain)
						begin
						exec dbo.uspJoinTaskCPClientCaseUpdate
								@pkJoinTaskCPClientCase = @pkJoinTaskCPClientCase
								,@fkCPClientCase = @pkCPClientCaseMain
								,@LUPUser = @LUPUser
								,@LUPMac = @LUPMac
								,@LUPIP = @LUPIP
								,@LUPMachine = @LUPMachine
						end
					else
						begin
						exec dbo.uspJoinTaskCPClientDelete
								@pkJoinTaskCPClient = @pkJoinTaskCPClientCase
								,@LUPUser = @LUPUser
								,@LUPMac = @LUPMac
								,@LUPIP = @LUPIP
								,@LUPMachine = @LUPMachine
						end
				
					if @@error <> 0
						begin
							set @ErrorOccurred = 1
							break
						end

					fetch next from crTaskJoin
					into @pkJoinTaskCPClientCase
					end
				
				close crTaskJoin
				deallocate crTaskJoin
				truncate table #PKHolder
				--------------------------------------------------------------------------------
		    end


			if @ErrorOccurred = 0
			begin
				-------	Merge My Cases tasks ------------------------------------
				
				truncate table #MainCaseUsers
				
				insert	#MainCaseUsers
				select	fkApplicationUser 
				from	ApplicationUserFavoriteCase
				where	fkCPClientCase = @pkCPClientCaseMain
				
				truncate table #PKHolder
				
				insert	#PKHolder
				select	pkApplicationUserFavoriteCase 
				from	ApplicationUserFavoriteCase
				where	fkCPClientCase = @DupCasePK

				Insert into ApplicationUserFavoriteCase (fkApplicationUser, fkCPClientCase)
				select fkApplicationUser, @pkCPClientCaseMain
				from ApplicationUserFavoriteCase
				where fkCPClientCase = @DupCasePK
				and fkApplicationUser not in (select pk from #MainCaseUsers)


				delete A
				from ApplicationUserFavoriteCase A
				inner join #PkHolder p on p.PK = A.pkApplicationUserFavoriteCase 
				
				--------------------------------------------------------------------------------
		    end



		if @ErrorOccurred = 0
			begin
				-------	Transfer external task references ------------------------------------
				truncate table #PKHolder
				
				insert	#PKHolder
				select	pkJoinExternalTaskMetaDataCPClientCase
				from	JoinExternalTaskMetaDataCPClientCase
				where	fkCPClientCase = @DupCasePK
				
				declare @pkJoinExternalTaskMetaDataCPClientCase decimal
				
				declare crExternalTaskJoin insensitive cursor for
				select	PK
				from	#PKHolder
				
				open crExternalTaskJoin

				fetch next from crExternalTaskJoin
				into @pkJoinExternalTaskMetaDataCPClientCase
				
				while @@fetch_status = 0
					begin
					
					declare @fkExternalTaskMetaData decimal
					select	@fkExternalTaskMetaData = fkExternalTaskMetaData
					from	JoinExternalTaskMetaDataCPClientCase
					where	pkJoinExternalTaskMetaDataCPClientCase = @pkJoinExternalTaskMetaDataCPClientCase
					
					if not exists (	select	*
									from	JoinExternalTaskMetaDataCPClientCase
									where	fkExternalTaskMetaData = @fkExternalTaskMetaData
									and		fkCPClientCase = @pkCPClientCaseMain)
						begin
						exec dbo.uspJoinExternalTaskMetaDataCPClientCaseUpdate
								@pkJoinExternalTaskMetaDataCPClientCase = @pkJoinExternalTaskMetaDataCPClientCase
								,@fkCPClientCase = @pkCPClientCaseMain
								,@LUPUser = @LUPUser
								,@LUPMac = @LUPMac
								,@LUPIP = @LUPIP
								,@LUPMachine = @LUPMachine
						end
					else
						begin
						exec dbo.uspJoinExternalTaskMetaDataCPClientCaseDelete
								@pkJoinExternalTaskMetaDataCPClientCase = @pkJoinExternalTaskMetaDataCPClientCase
								,@LUPUser = @LUPUser
								,@LUPMac = @LUPMac
								,@LUPIP = @LUPIP
								,@LUPMachine = @LUPMachine
						end
				
					if @@error <> 0
						begin
							set @ErrorOccurred = 1
							break
						end

					fetch next from crExternalTaskJoin
					into @pkJoinExternalTaskMetaDataCPClientCase
					end
				
				close crExternalTaskJoin
				deallocate crExternalTaskJoin
				truncate table #PKHolder
				--------------------------------------------------------------------------------
		    end

		if @ErrorOccurred = 0
			begin
				-------	Insert MergeNote into Client record ------------------------------------

					Declare @pkCaseActivityNote as Decimal (18,0) 
					
					if len(ltrim(rtrim(@MergeNarrative))) > 0
						begin
							exec uspCPCaseActivityInsert 1, @pkCPClientCaseMain, @MergeNarrative, 0, null, @LUPUser, @LUPMac, @LUPIP, @LUPMachine, @pkCaseActivityNote 
						end

					
					exec uspCPCaseActivityInsert 7, @pkCPClientCaseMain, @MergeNarrativeAutoGen , 0, null, @LUPUser, @LUPMac, @LUPIP, @LUPMachine, @pkCaseActivityNote 
					
					if @@error <> 0
						begin
							set @ErrorOccurred = 1
							break
						end
			end
					--------------------------------------------------------------------------------

		if @ErrorOccurred = 0
			begin
				-------	Remove Duplicate Member ------------------------------------------------
				exec uspCPClientCaseDelete @DupCasePK, @LUPUser, @LUPMac, @LUPIP, @LUPMachine 
						
				if @@error <> 0
					begin
						set @ErrorOccurred = 1
					end
				--------------------------------------------------------------------------------
			end
	
		if @ErrorOccurred = 0
			begin
				-------	Create Merge Record ----------------------------------------------------
				insert into MergedCase (fkCPClientCaseDuplicate, fkCPMergeCase)
							values (@DupCasePK, @pkCPClientCaseMain)

				if @@error <> 0
					begin
						set @ErrorOccurred = 1
					end
				--------------------------------------------------------------------------------
			end
			
			
			

		if @ErrorOccurred <> 0
			begin
				break
			end
		
		fetch next from DupCases
		into @DupCasePK
	end

close DupCases
deallocate DupCases
drop table #PKHolder

if @ErrorOccurred <> 0
	begin
		rollback tran
		return @ErrorOccurred
	end
else
	begin
		commit tran
		return 0
	end