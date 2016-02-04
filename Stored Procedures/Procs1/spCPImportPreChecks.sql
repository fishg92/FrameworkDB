
CREATE Proc [dbo].[spCPImportPreChecks] 
as

declare 
	@HostName varchar(100)
	,@EffectiveDate datetime
	,@pkCPImportLog decimal
	,@pkCPJoinClientClientPhoneToDelete decimal
	,@pkCPJoinClientClientAddressToDelete decimal

select @HostName = host_name()
select @EffectiveDate = dbo.today()

-- Make sure the fkCPClientCaseHead in dbo.CPClientCase has been set properly
Update cc
set fkCPClientCaseHead = j.fkCPClient
from CPClientCase cc
inner join CPJoinClientClientCase j on j.fkCPClientCase = cc.pkCPClientCase
where PrimaryParticipantOnCase = 1
and isnull(cc.fkCPClientCaseHead,0) <> j.fkCPClient

-- Make sure the fkCPRefPhoneType in dbo.CPJoinClientClientPhone has been set properly
Update j
set fkCPRefPhoneType = p.fkCPRefPhoneType
from  CPJoinClientClientPhone j
inner join CPClientPhone p on j.fkCPClientPhone = p.pkCPClientPhone
and isnull(j.fkCPRefPhoneType,0) <> p.fkCPRefPhoneType

-- Make sure the fkCPRefClientAddressType in dbo.CPJoinClientClientAddress has been set properly
Update j
set fkCPRefClientAddressType = a.fkCPRefClientAddressType
from  CPJoinClientClientAddress j
inner join dbo.CPClientAddress a on j.fkCPClientAddress = a.pkCPClientAddress
and isnull(j.fkCPRefClientAddressType,0) <> a.fkCPRefClientAddressType

