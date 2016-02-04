


--exec spCPGetRelatedClientData @EffectiveDate = '5/9/2008', @LastName = 'smith', @pkCPClient = 8
CREATE    Proc [dbo].[spCPGetRelatedClientData]
(		@SSN varchar(10) = null,
		@NorthwoodsNumber varchar(50) = null,
		@StateIssuedNumber varchar(50) = null,
		@LastName varchar(100) = null,
		@FirstName varchar(100) = null,
		@MiddleName varchar(100) = null,
		@pkCPClient Decimal(18,0) = null,
		@pkCPClientCase Decimal(18,0) = null
)

as
	Set Transaction isolation level read uncommitted 

		select 	
			StateCaseNumber = isnull(cpc.StateCaseNumber, '')
			,LocalCaseNumber = isnull(cpc.LocalCaseNumber, '')
			,FirstName = isnull(cc.FirstName, '')
			,MiddleName = isnull(cc.MiddleName, '')
			,LastName = isnull(cc.LastName, '')
			,SSN = isnull(cc.SSN, '')
			,NorthwoodsNumber = isnull(cc.NorthwoodsNumber, '')
			,StateIssuedNumber = isnull(cc.StateIssuedNumber, '')
			,PrimaryParticipate = isnull(j.PrimaryParticipantOnCase, 0)
			,BirthDate = isnull(cc.BirthDate, convert(datetime, '1/1/1900'))
			,Sex = isnull(cc.Sex,'')
			,cc.pkCPClient
			,cpc.pkCPClientCase
			,CaseMembershipStart = j.CreateDate 
			,CaseMembershipEnd = GetDate()
		from 	CPClient cc with (NoLock)
		Join	CPJoinClientClientCase j with (NoLock) on j.fkCPClient = cc.pkCPClient
		Join	CPClientCase cpc with (NoLock) on cpc.pkCPClientCase = j.fkCPClientCase
		Where 	(@pkCPClient is Null or cc.pkCPClient = @pkCPClient)
		and	(@pkCPClientCase is Null or cpc.pkCPClientCase = @pkCPClientCase)
		and	(@FirstName is null or cc.FirstName = @FirstName)
		and   	(@LastName is null or cc.LastName = @LastName)
		and   	(@MiddleName is null or cc.MiddleName = @MiddleName)
		and   	(@SSN is null or cc.SSN = @SSN)
		and   	(@NorthwoodsNumber is null or cc.NorthwoodsNumber = @NorthwoodsNumber)
		and   	(@StateIssuedNumber is null or cc.StateIssuedNumber = @StateIssuedNumber)
