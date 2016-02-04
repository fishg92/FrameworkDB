


CREATE procedure [dbo].[MergeDuplicateMembers]
(
	@pkCPClientMain decimal,
	@LUPUser varchar(50),
	@LUPMac char(17),
	@LUPIP varchar(15),
	@LUPMachine varchar(15),
	@MergeNote varchar (max)
)

as

set nocount on
begin tran

declare @DupMemberPK decimal,
		@MainMemberCompassNumber varchar(50),
		@ErrorOccurred tinyint

select @MainMemberCompassNumber = NorthwoodsNumber
from CPClient
where pkCPClient = @pkCPClientMain

declare DupMembers cursor
for select fkCPClientDuplicate from DuplicateMembers
	where fkCPClientMain = @pkCPClientMain

open DupMembers

fetch next from DupMembers
into @DupMemberPK

create table #PKHolder
(
	PK decimal
)

while @@fetch_status = 0
	begin
		-------	Update Case Joins -------------------------------------------------------------- 
		insert into #PKHolder
		select pkCPJoinClientClientCase
		from CPJoinClientClientCase 
		where fkCPClient = @DupMemberPK

		declare @pkJoinClientClientCase decimal,
				@fkCPClient decimal,
				@fkCPClientCase decimal,
				@LockUser varchar(50),
				@LockDate datetime

		set @ErrorOccurred = 0

		declare CaseJoins cursor
		for select #PKHolder.PK,
				   cj.fkCPClientCase,
				   cj.LockedUser,
				   cj.LockedDate 
		    from #PKHolder
			join CPJoinClientClientCase cj on cj.pkCPJoinClientClientCase = #PKHolder.PK
			
		open CaseJoins

		fetch next from CaseJoins
		into @pkJoinClientClientCase, @fkCPClientCase, @LockUser, @LockDate

		while @@fetch_status = 0
			begin
				if exists(select pkCPJoinClientClientCase 
						  from CPJoinClientClientCase
						  where fkCPClientCase = @fkCPClientCase
						  and fkCPClient = @pkCPClientMain)
					begin
						exec uspCPJoinClientClientCaseDelete @pkJoinClientClientCase, @LUPUser, @LUPMac, @LUPIP, @LUPMachine
					end
				else
					begin
						declare @isMainMemberCaseHead tinyint
						Select @isMainMemberCaseHead = (select dbo.IsCaseHead(@fkCPClientCase, @pkCPClientMain))
					
						exec uspCPJoinClientClientCaseInsert @fkCPClientCase, @pkCPClientMain, @isMainMemberCaseHead, Null, @LockUser, @LockDate, @LUPUser, @LUPMac, @LUPIP, @LUPMachine
						exec uspCPJoinClientClientCaseDelete @pkJoinClientClientCase, @LUPUser, @LUPMac, @LUPIP, @LUPMachine
					end
	
				if @@error <> 0
					begin
						set @ErrorOccurred = 1
						break
					end
				
				fetch next from CaseJoins
				into @pkJoinClientClientCase, @fkCPClientCase, @LockUser, @LockDate
			end

		close CaseJoins
		deallocate CaseJoins
		truncate table #PKHolder
		----------------------------------------------------------------------------------------

		if @ErrorOccurred = 0
			begin
				-------	Remove Address Join ----------------------------------------------------
				insert into #PKHolder
				select pkCPJoinClientClientAddress
				from CPJoinClientClientAddress 
				where fkCPClient = @DupMemberPK

				declare @pkJoinClientClientAddress decimal
				
				declare AddressJoins cursor
				for select PK from #PKHolder
					
				open AddressJoins

				fetch next from AddressJoins
				into @pkJoinClientClientAddress

				while @@fetch_status = 0
					begin
						exec uspCPJoinClientClientAddressDelete @pkJoinClientClientAddress, @LUPUser, @LUPMac, @LUPIP, @LUPMachine 
						
						if @@error <> 0
							begin
								set @ErrorOccurred = 1
								break
							end
						
						fetch next from AddressJoins
						into @pkJoinClientClientAddress
					end

				close AddressJoins
				deallocate AddressJoins
				truncate table #PKHolder
				--------------------------------------------------------------------------------
			end
	
		if @ErrorOccurred = 0
			begin
			    -------	Remove Phone Join ------------------------------------------------------
				insert into #PKHolder
				select pkCPJoinClientClientPhone
				from CPJoinClientClientPhone 
				where fkCPClient = @DupMemberPK

				declare @pkCPJoinClientClientPhone decimal
				
				declare PhoneJoins cursor
				for select PK from #PKHolder
					
				open PhoneJoins

				fetch next from PhoneJoins
				into @pkCPJoinClientClientPhone

				while @@fetch_status = 0
					begin
						exec uspCPJoinClientClientPhoneDelete @pkCPJoinClientClientPhone, @LUPUser, @LUPMac, @LUPIP, @LUPMachine 
						
						if @@error <> 0
							begin
								set @ErrorOccurred = 1
								break
							end
						
						fetch next from PhoneJoins
						into @pkCPJoinClientClientPhone
					end

				close PhoneJoins
				deallocate PhoneJoins
				truncate table #PKHolder
				--------------------------------------------------------------------------------
			end

		if @ErrorOccurred = 0
			begin
				-------	Remove Employment Join -------------------------------------------------
				insert into #PKHolder
				select pkCPJoinClientEmployer
				from CPJoinClientEmployer 
				where fkCPClient = @DupMemberPK

				declare @pkCPJoinClientEmployer decimal
				
				declare EmployerJoins cursor
				for select PK from #PKHolder
					
				open EmployerJoins

				fetch next from EmployerJoins
				into @pkCPJoinClientEmployer

				while @@fetch_status = 0
					begin
						exec uspCPJoinClientEmployerDelete @pkCPJoinClientEmployer, @LUPUser, @LUPMac, @LUPIP, @LUPMachine 
						
						if @@error <> 0
							begin
								set @ErrorOccurred = 1
								break
							end
						
						fetch next from EmployerJoins
						into @pkCPJoinClientEmployer
					end

				close EmployerJoins
				deallocate EmployerJoins
				truncate table #PKHolder
				--------------------------------------------------------------------------------
			end

		if @ErrorOccurred = 0
			begin
				-------	Remove Client Alerts ---------------------------------------------------
				insert into #PKHolder
				select pkCPJoinClientAlertFlagTypeNT
				from CPJoinClientAlertFlagTypeNT 
				where fkCPClient = @DupMemberPK

				declare @pkCPJoinClientAlertFlagTypeNT decimal
				
				declare AlertJoins cursor
				for select PK from #PKHolder
					
				open AlertJoins

				fetch next from AlertJoins
				into @pkCPJoinClientAlertFlagTypeNT

				while @@fetch_status = 0
					begin
						exec uspCPJoinClientAlertFlagTypeNTDelete @pkCPJoinClientAlertFlagTypeNT, @LUPUser, @LUPMac, @LUPIP, @LUPMachine 
						
						if @@error <> 0
							begin
								set @ErrorOccurred = 1
								break
							end
						
						fetch next from AlertJoins
						into @pkCPJoinClientAlertFlagTypeNT
					end

				close AlertJoins
				deallocate AlertJoins
				truncate table #PKHolder
				--------------------------------------------------------------------------------
			end

		if @ErrorOccurred = 0
			begin
				-------	Remove Marriage Records ------------------------------------------------
				insert into #PKHolder
				select pkCPClientMarriageRecord
				from CPClientMarriageRecord 
				where fkCPClient = @DupMemberPK

				declare @pkCPClientMarriageRecord decimal
				
				declare MarriageJoins cursor
				for select PK from #PKHolder
					
				open MarriageJoins

				fetch next from MarriageJoins
				into @pkCPClientMarriageRecord

				while @@fetch_status = 0
					begin
						exec uspCPClientMarriageRecordDelete @pkCPClientMarriageRecord, @LUPUser, @LUPMac, @LUPIP, @LUPMachine 
						
						if @@error <> 0
							begin
								set @ErrorOccurred = 1
								break
							end
						
						fetch next from MarriageJoins
						into @pkCPClientMarriageRecord
					end

				close MarriageJoins
				deallocate MarriageJoins
				truncate table #PKHolder
				--------------------------------------------------------------------------------
			end

		if @ErrorOccurred = 0
			begin
				-------	Remove Military Records ------------------------------------------------
				insert into #PKHolder
				select pkCPClientMilitaryRecord
				from CPClientMilitaryRecord 
				where fkCPClient = @DupMemberPK

				declare @pkCPClientMilitaryRecord decimal
				
				declare MilitaryJoins cursor
				for select PK from #PKHolder
					
				open MilitaryJoins

				fetch next from MilitaryJoins
				into @pkCPClientMilitaryRecord

				while @@fetch_status = 0
					begin
						exec uspCPClientMilitaryRecordDelete @pkCPClientMilitaryRecord, @LUPUser, @LUPMac, @LUPIP, @LUPMachine 
						
						if @@error <> 0
							begin
								set @ErrorOccurred = 1
								break
							end
						
						fetch next from MilitaryJoins
						into @pkCPClientMilitaryRecord
					end

				close MilitaryJoins
				deallocate MilitaryJoins
				truncate table #PKHolder
				--------------------------------------------------------------------------------
			end

		if @ErrorOccurred = 0
			begin
				-------	Remove Client Relationship Records -------------------------------------
				insert into #PKHolder
				select pkCPJoinCPClientCPClientrefRelationship
				from CPJoinCPClientCPClientrefRelationship
				where fkCPClientParent = @DupMemberPK
				or fkCPClientChild = @DupMemberPK

				declare @pkCPJoinCPClientCPClientrefRelationship decimal
				
				declare RelatedClientJoins cursor
				for select PK from #PKHolder
					
				open RelatedClientJoins

				fetch next from RelatedClientJoins
				into @pkCPJoinCPClientCPClientrefRelationship

				while @@fetch_status = 0
					begin
						exec uspCPJoinCPClientCPClientrefRelationshipDelete @pkCPJoinCPClientCPClientrefRelationship, @LUPUser, @LUPMac, @LUPIP, @LUPMachine 
						
						if @@error <> 0
							begin
								set @ErrorOccurred = 1
								break
							end
						
						fetch next from RelatedClientJoins
						into @pkCPJoinCPClientCPClientrefRelationship
					end

				close RelatedClientJoins
				deallocate RelatedClientJoins
				truncate table #PKHolder
				--------------------------------------------------------------------------------
			end

		if @ErrorOccurred = 0
			begin
				-------	Update Client Notes ----------------------------------------------------
				insert into #PKHolder
				select pkCPCaseActivity
				from CPCaseActivity 
				where fkCPClient = @DupMemberPK

				declare @pkCPCaseActivity decimal
				
				declare ActivityJoins cursor
				for select PK from #PKHolder
					
				open ActivityJoins

				fetch next from ActivityJoins
				into @pkCPCaseActivity

				while @@fetch_status = 0
					begin
						exec uspCPCaseActivityUpdate @pkCPCaseActivity, null, null, null, @pkCPClientMain, @LUPUser, @LUPMac, @LUPIP, @LUPMachine 
						
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
				-------	Update Barcode Compass Number ------------------------------------------
				declare @DupCompassNumber varchar(50),
						@pkBarcodeDocumentKeyword decimal

				select @DupCompassNumber = NorthwoodsNumber
				from CPClient
				where pkCPClient = @DupMemberPK

				if isnull(@DupCompassNumber, '') <> '' and isnull(@MainMemberCompassNumber, '') <> ''
					begin
						insert into #PKHolder
						select pkBarcodeDocumentKeyword
						from BarcodeDocumentKeyword
						where KeywordName = 'Compass Number'
						and KeywordValue = @DupCompassNumber
	
						declare BarcodeCompassNumbers cursor
						for select PK from #PKHolder
							
						open BarcodeCompassNumbers

						fetch next from BarcodeCompassNumbers
						into @pkBarcodeDocumentKeyword

						while @@fetch_status = 0
							begin
								exec uspBarcodeDocumentKeywordUpdate @pkBarcodeDocumentKeyword, null, null, null, @MainMemberCompassNumber, null, @LUPUser, @LUPMac, @LUPIP, @LUPMachine
								
								if @@error <> 0
									begin
										set @ErrorOccurred = 1
										break
									end
								
								fetch next from BarcodeCompassNumbers
								into @pkBarcodeDocumentKeyword
							end

						close BarcodeCompassNumbers
						deallocate BarcodeCompassNumbers
						truncate table #PKHolder
					end
				--------------------------------------------------------------------------------
			end

		if @ErrorOccurred = 0
			begin
				-------	Transfer Task Tracker tasks ------------------------------------
				truncate table #PKHolder
				
				insert	#PKHolder
				select	pkJoinTaskCPClient
				from	JoinTaskCPClient
				where	fkCPClient = @DupMemberPK
				
				declare @pkJoinTaskCPClient decimal
				
				declare crTaskJoin insensitive cursor for
				select	PK
				from	#PKHolder
				
				open crTaskJoin

				fetch next from crTaskJoin
				into @pkJoinTaskCPClient
				
				while @@fetch_status = 0
					begin
					
					declare @fkTask decimal
					select	@fkTask = fkTask
					from	JoinTaskCPClient
					where	pkJoinTaskCPClient = @pkJoinTaskCPClient
					
					if not exists (	select	*
									from	JoinTaskCPClient
									where	fkTask = @fkTask
									and		fkCPClient = @pkCPClientMain)
						begin
						exec dbo.uspJoinTaskCPClientUpdate
								@pkJoinTaskCPClient = @pkJoinTaskCPClient
								,@fkCPClient = @pkCPClientMain
								,@LUPUser = @LUPUser
								,@LUPMac = @LUPMac
								,@LUPIP = @LUPIP
								,@LUPMachine = @LUPMachine
						end
					else
						begin
						exec dbo.uspJoinTaskCPClientDelete
								@pkJoinTaskCPClient = @pkJoinTaskCPClient
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
					into @pkJoinTaskCPClient
					end
				
				close crTaskJoin
				deallocate crTaskJoin
				truncate table #PKHolder
				--------------------------------------------------------------------------------
		    end


		if @ErrorOccurred = 0
			begin
				-------	Transfer external task references ------------------------------------
				truncate table #PKHolder
				
				insert	#PKHolder
				select	pkJoinExternalTaskMetaDataCPClient
				from	JoinExternalTaskMetaDataCPClient
				where	fkCPClient = @DupMemberPK
				
				declare @pkJoinExternalTaskMetaDataCPClient decimal
				
				declare crExternalTaskJoin insensitive cursor for
				select	PK
				from	#PKHolder
				
				open crExternalTaskJoin

				fetch next from crExternalTaskJoin
				into @pkJoinExternalTaskMetaDataCPClient
				
				while @@fetch_status = 0
					begin
					
					declare @fkExternalTaskMetaData decimal
					select	@fkExternalTaskMetaData = fkExternalTaskMetaData
					from	JoinExternalTaskMetaDataCPClient
					where	pkJoinExternalTaskMetaDataCPClient = @pkJoinExternalTaskMetaDataCPClient
					
					if not exists (	select	*
									from	JoinExternalTaskMetaDataCPClient
									where	fkExternalTaskMetaData = @fkExternalTaskMetaData
									and		fkCPClient = @pkCPClientMain)
						begin
						exec dbo.uspJoinExternalTaskMetaDataCPClientUpdate
								@pkJoinExternalTaskMetaDataCPClient = @pkJoinExternalTaskMetaDataCPClient
								,@fkCPClient = @pkCPClientMain
								,@LUPUser = @LUPUser
								,@LUPMac = @LUPMac
								,@LUPIP = @LUPIP
								,@LUPMachine = @LUPMachine
						end
					else
						begin
						exec dbo.uspJoinExternalTaskMetaDataCPClientDelete
								@pkJoinExternalTaskMetaDataCPClient = @pkJoinExternalTaskMetaDataCPClient
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
					into @pkJoinExternalTaskMetaDataCPClient
					end
				
				close crExternalTaskJoin
				deallocate crExternalTaskJoin
				truncate table #PKHolder
				--------------------------------------------------------------------------------
		    end

		if @ErrorOccurred = 0
			begin
				-------	Transfer external system IDs ------------------------------------
				truncate table #PKHolder
				
				insert	#PKHolder
				select	s.pkCPClientExternalID
				from	CPClientExternalID s
				where	fkCPClient = @DupMemberPK
				and not exists (select	* 
								from	CPClientExternalID t
								where	t.fkCPClient = @pkCPClientMain
								and		t.ExternalSystemName = s.ExternalSystemName)
				
				declare @pkCPClientExternalID decimal
				
				declare crExternalID insensitive cursor for
				select	PK
				from	#PKHolder
				
				open crExternalID

				fetch next from crExternalID
				into @pkCPClientExternalID
				
				while @@fetch_status = 0
					begin
					
					exec dbo.uspCPClientExternalIDUpdate
						@pkCPClientExternalID = @pkCPClientExternalID
						, @fkCPClient = @pkCPClientMain
						,@LUPUser = @LUPUser
						,@LUPMac = @LUPMac
						,@LUPIP = @LUPIP
						,@LUPMachine = @LUPMachine
						
				
					if @@error <> 0
						begin
							set @ErrorOccurred = 1
							break
						end

					fetch next from crExternalID
					into @pkCPClientExternalID
					end
				
				close crExternalID
				deallocate crExternalID
				
				truncate table #PKHolder
				
				
				--Delete orphaned records
				declare crExternalIDDelete insensitive cursor for 
				select pkCPClientExternalID
				from CPClientExternalID
				where fkCPClient = @DupMemberPK
				
				open crExternalIDDelete
				
				fetch next from crExternalIDDelete
				into @pkCPClientExternalID
				
				while @@fetch_status = 0
					begin
					exec dbo.uspCPClientExternalIDDelete
						@pkCPClientExternalID = @pkCPClientExternalID
						,@LUPUser = @LUPUser
						,@LUPMac = @LUPMac
						,@LUPIP = @LUPIP
						,@LUPMachine = @LUPMachine
					
					fetch next from crExternalIDDelete
					into @pkCPClientExternalID
					end
				
				close crExternalIDDelete
				deallocate crExternalIDDelete

					
				
				--------------------------------------------------------------------------------
		    end



		if @ErrorOccurred = 0
			begin
				-------	Insert MergeNote into Client record ------------------------------------
			if len(ltrim(rtrim(@MergeNote))) > 0
				begin							
					exec uspCPCaseActivityInsert
						@fkCPCaseActivityType = 1,
						@fkCPClientCase = 0,
						@Description = @MergeNote,
						@fkCPClient = @pkCPClientMain,
						@LUPUser = @LUPUser,
						@LUPMac = @LUPMac,
						@LUPIP = @LUPIP,
						@LUPMachine = @LUPMachine
					
					if @@error <> 0
						begin
							set @ErrorOccurred = 1
							break
						end
				end
					--------------------------------------------------------------------------------
		    end

		if @ErrorOccurred = 0
			begin
				-------	Remove Duplicate Member From SmartFill ---------------------------------
				declare @DupMemberCompassNumber varchar(50)
				
				select @DupMemberCompassNumber = NorthwoodsNumber 
				from CPClient 
				where pkCPClient = @DupMemberPK
	
				exec uspSmartFillDataDeleteAllByCompassNumber @DupMemberCompassNumber, @LUPUser, @LUPMac, @LUPIP, @LUPMachine 
						
				if @@error <> 0
					begin
						set @ErrorOccurred = 1
					end
				--------------------------------------------------------------------------------
			end

		if @ErrorOccurred = 0
			begin
				-------	Remove Duplicate Member ------------------------------------------------
				exec uspCPClientDelete @DupMemberPK, @LUPUser, @LUPMac, @LUPIP, @LUPMachine 
						
				if @@error <> 0
					begin
						set @ErrorOccurred = 1
					end
				--------------------------------------------------------------------------------
			end
	
		if @ErrorOccurred = 0
			begin
				-------	Create Merge Record ----------------------------------------------------
				insert into MergedMembers (fkCPDuplicateMember, fkCPMergeMember)
							values (@DupMemberPK, @pkCPClientMain)

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
		
		fetch next from DupMembers
		into @DupMemberPK
	end

close DupMembers
deallocate DupMembers
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