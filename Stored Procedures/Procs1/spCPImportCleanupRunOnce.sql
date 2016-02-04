
CREATE Proc [dbo].[spCPImportCleanupRunOnce] 
as

declare 
	@HostName varchar(100)
	,@pkCPImportLog decimal
	,@pkCPJoinClientClientPhoneToDelete decimal
	,@pkCPClientPhoneToDelete decimal
	,@pkCPJoinClientClientAddressToDelete decimal
	,@pkCPJoinClientClientAddressToKeep decimal
	,@pkCPJoinClientClientCaseToUpdate decimal
	,@pkCPClientPhoneToKeep decimal
	,@pkCPClientAddressToDelete decimal
	,@pkCPClientAddressToKeep decimal
	,@fkCPClientCase decimal
	,@fkCPClient decimal
	,@fkCPRefClientRelationshipType decimal
	,@fkCPRefClientAddressType decimal
	,@fkCPRefPhoneType decimal
	,@Street1 varchar(100)
	,@Street2 varchar(100)
	,@Street3 varchar(100)
	,@City varchar(100)
	,@State varchar(100)
	,@Zip varchar(100)
	,@Number varchar(100)
	,@Extension varchar(100)

select @HostName = host_name()


-- Make sure the fkCPClientCaseHead in dbo.CPClientCase has been set properly
Update cc
set fkCPClientCaseHead = j.fkCPClient
from CPClientCase cc
inner join CPJoinClientClientCase j on j.fkCPClientCase = cc.pkCPClientCase
where PrimaryParticipantOnCase = 1
and isnull(cc.fkCPClientCaseHead,0) <> j.fkCPClient

-- Unmark extraneous case heads if there were inadvertently more than one marked
Update j
set PrimaryParticipantOnCase = 0
from CPClientCase cc
inner join CPJoinClientClientCase j on j.fkCPClientCase = cc.pkCPClientCase
where PrimaryParticipantOnCase = 1
and isnull(cc.fkCPClientCaseHead,0) <> j.fkCPClient

-- The design only allows only one case head per case
--	Therefore, we need to mark any extraneous ones
select @pkCPJoinClientClientCaseToUpdate = max(pkCPJoinClientClientCase)
from CPJoinClientClientCase
where PrimaryParticipantOnCase = 1
group by fkCPClientCase
having count(*) > 1

while @@ROWCOUNT > 0 begin
	select @fkCPClientCase = fkCPClientCase
		,@fkCPClient = fkCPClient
		,@fkCPRefClientRelationshipType = fkCPRefClientRelationshipType
	from CPJoinClientClientCase
	where pkCPJoinClientClientCase = @pkCPJoinClientClientCaseToUpdate

	exec dbo.uspCPJoinClientClientCaseUpdate
		@pkCPJoinClientClientCase = @pkCPJoinClientClientCaseToUpdate
		, @fkCPClientCase=@fkCPClientCase
		, @fkCPClient=@fkCPClient
		, @PrimaryParticipantOnCase=0
		, @fkCPRefClientRelationshipType=@fkCPRefClientRelationshipType
		, @LUPUser = @HostName
		, @LUPMac = @HostName
		, @LUPIP = @HostName
		, @LUPMachine = @HostName

	exec dbo.spCPInsertCPImportLog
		@pkCPImportLog = @pkCPImportLog Output
		,@fkCPRefImportLogEventType = 10
		,@fkCPJoinClientClientCase = @pkCPJoinClientClientCaseToUpdate

	select @pkCPJoinClientClientCaseToUpdate = max(pkCPJoinClientClientCase)
	from CPJoinClientClientCase
	where PrimaryParticipantOnCase = 1
	group by fkCPClientCase
	having count(*) > 1
end


-- Get rid of duplicate phone records
select @pkCPClientPhoneToDelete = max(pkCPClientPhone)
	,@Number=Number
	,@Extension=isnull(Extension,'')
	,@fkCPRefPhoneType=fkCPRefPhoneType

from CPClientPhone
group by
	Number
	,isnull(Extension,'')
	,fkCPRefPhoneType
having count(*) > 1

while @@ROWCOUNT > 0 begin
	select @pkCPClientPhoneToKeep = min(pkCPClientPhone)
	from CPClientPhone
	where Number=@Number
	and isnull(Extension,'')=@Extension
	and fkCPRefPhoneType = @fkCPRefPhoneType

	Update dbo.CPJoinClientClientPhone
	set fkCPClientPhone = @pkCPClientPhoneToKeep
	where fkCPClientPhone = @pkCPClientPhoneToDelete

	exec dbo.uspCPClientPhoneDelete
		@pkCPClientPhone=@pkCPClientPhoneToDelete
		, @LUPUser=@HostName
		, @LUPMac=@HostName
		, @LUPIP=@HostName
		, @LUPMachine=@HostName

	select @pkCPClientPhoneToDelete = max(pkCPClientPhone)
	from CPClientPhone
	group by
		Number
		,isnull(Extension,'')
		,fkCPRefPhoneType
	having count(*) > 1

end

-- The design only allows a client to have only 1 phone of a given type
--	Therefore, we need to remove any extraneous ones
select @pkCPJoinClientClientPhoneToDelete = min(pkCPJoinClientClientPhone)
from CPJoinClientClientPhone
group by fkCPClient
	,fkCPRefPhoneType
having count(*) > 1

while @@ROWCOUNT > 0 begin
	exec dbo.uspCPJoinClientClientPhoneDelete
		@pkCPJoinClientClientPhone = @pkCPJoinClientClientPhoneToDelete
		, @LUPUser = @HostName
		, @LUPMac = @HostName
		, @LUPIP = @HostName
		, @LUPMachine = @HostName

	exec dbo.spCPInsertCPImportLog
		@pkCPImportLog = @pkCPImportLog Output
		,@fkCPRefImportLogEventType = 19
		,@fkCPJoinClientClientPhone = @pkCPJoinClientClientPhoneToDelete

	select @pkCPJoinClientClientPhoneToDelete = min(pkCPJoinClientClientPhone)
	from CPJoinClientClientPhone
	group by fkCPClient
		,fkCPRefPhoneType
	having count(*) > 1
end


-- Get rid of duplicate Address records

select @pkCPClientAddressToDelete = max(pkCPClientAddress)
	,@fkCPRefClientAddressType = fkCPRefClientAddressType
	,@Street1=isnull(Street1,'')
	,@Street2=isnull(Street2,'')
	,@Street3=isnull(Street3,'')
	,@City=isnull(City,'')
	,@State=isnull(State,'')
	,@Zip=isnull(Zip,'')
from CPClientAddress
group by
	fkCPRefClientAddressType
	,isnull(Street1,'')
	,isnull(Street2,'')
	,isnull(Street3,'')
	,isnull(City,'')
	,isnull(State,'')
	,isnull(Zip,'')
having count(*) > 1

while @@ROWCOUNT > 0 begin
	select @pkCPClientAddressToKeep = min(pkCPClientAddress)
	from CPClientAddress
	where @fkCPRefClientAddressType = fkCPRefClientAddressType
	and @Street1=isnull(Street1,'')
	and @Street2=isnull(Street2,'')
	and @Street3=isnull(Street3,'')
	and @City=isnull(City,'')
	and @State=isnull(State,'')
	and @Zip=isnull(Zip,'')

	Update dbo.CPJoinClientClientAddress
	set fkCPClientAddress = @pkCPClientAddressToKeep
	where fkCPClientAddress = @pkCPClientAddressToDelete

	exec dbo.uspCPClientAddressDelete
		@pkCPClientAddress=@pkCPClientAddressToDelete
		, @LUPUser=@HostName
		, @LUPMac=@HostName
		, @LUPIP=@HostName
		, @LUPMachine=@HostName

	select @pkCPClientAddressToDelete = max(pkCPClientAddress)
		,@fkCPRefClientAddressType = fkCPRefClientAddressType
		,@Street1=isnull(Street1,'')
		,@Street2=isnull(Street2,'')
		,@Street3=isnull(Street3,'')
		,@City=isnull(City,'')
		,@State=isnull(State,'')
		,@Zip=isnull(Zip,'')
	from CPClientAddress
	group by
		fkCPRefClientAddressType
		,isnull(Street1,'')
		,isnull(Street2,'')
		,isnull(Street3,'')
		,isnull(City,'')
		,isnull(State,'')
		,isnull(Zip,'')
	having count(*) > 1

end


-- The design only allows a client to have only 1 address of a given type
--	Therefore, we need to remove any extraneous ones
select @pkCPJoinClientClientAddressToDelete = min(pkCPJoinClientClientAddress)
from CPJoinClientClientAddress
group by fkCPClient
	,fkCPRefClientAddressType
having count(*) > 1

while @@ROWCOUNT > 0 begin
	exec dbo.uspCPJoinClientClientAddressDelete
		@pkCPJoinClientClientAddress = @pkCPJoinClientClientAddressToDelete
		, @LUPUser = @HostName
		, @LUPMac = @HostName
		, @LUPIP = @HostName
		, @LUPMachine = @HostName

	exec dbo.spCPInsertCPImportLog
		@pkCPImportLog = @pkCPImportLog Output
		,@fkCPRefImportLogEventType = 18
		,@fkCPJoinClientClientAddress = @pkCPJoinClientClientAddressToDelete

	select @pkCPJoinClientClientAddressToDelete = min(pkCPJoinClientClientAddress)
	from CPJoinClientClientAddress
	group by fkCPClient
		,fkCPRefClientAddressType
	having count(*) > 1
end

