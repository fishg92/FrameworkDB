-- spCPGetCaseActivity -1, 15922

CREATE proc [dbo].[spCPGetCaseActivity] 
@pkCase decimal(18,0),
@pkClient decimal(18,0) 

as

set nocount on



Declare @Temp Table
  (     pkCPCaseActivity Decimal(18,0),
		fkCPCaseActivityType decimal(18,0),
		[Description] varchar(MAX),
		CreateDate datetime,
		CreateUser varchar(50),
		fkCPClientCase decimal(18,0),
		fkCPClient decimal(18,0),     
		CaseActivityTypeName varchar(50) ,
		Username varchar(100)
  )
	  
	  Insert Into @Temp
	  (     pkCPCaseActivity,
			fkCPCaseActivityType,
			[Description],
			CreateDate,
			CreateUser,
			fkCPClientCase,
			fkCPClient,
			CaseActivityTypeName,
			Username
	  )

	  /*  New rows of data mean that there were additions to case membership */
	  Select    distinct  Null as pkCPCaseActivity,
			3 as fkCPCaseActivityType,
			dbo.fnGetClientNameFriendly(c.pkCPClient)
			+ ' was added to the case' as 'Description',
			CreateDate = j.CreateDate,
			CreateUser = isnull(j.CreateUser,'unknown') ,
			j.fkCPClientCase,
			j.fkCPClient,
			CaseActivityTypeName = 'Member Change',
			Username = ''
	  
	  From CPJoinClientClientCase j with (NoLock)
	  Join  CPClient c with (noLock) on j.fkCPClient = c.pkCPClient
	  Where fkCPClientCase = @pkCase
	  
	  union all
	  
	  /* Deleted records mean a client was removed */
	  select  distinct * from (Select top 10000 Null as pkCPCaseActivity,
				  fkCPCaseActivityType = case when isnull(mm.pkMergedMembers, 0) <> 0 then 6 else 3 end,
				  [Description] = dbo.fnGetClientNameFriendly(ch.pkCPClient) 
				  + ' was removed from the case.' + 
									case when isnull(c.pkCPClient, 0) <> 0 then char(13) + 'They were merged into '
									+ dbo.fnGetClientNameFriendly(c.pkCPClient) 
				  + ' (' + c.NorthwoodsNumber + ').' else '' end,
				  CreateDate = jh.AuditStartDate,
				  CreateUser = isnull(jh.AuditUser,'unknown'),
				  jh.fkCPClientCase,
				  jh.fkCPClient,
				  CaseActivityTypeName = case when isnull(mm.pkMergedMembers, 0) <> 0 then 'Member Merged' else 'Member Change' end,                   
				  Username = ''
	  From        CPJoinClientClientCaseAudit jh with (NoLock)
	  Join        CPClientAudit ch with (noLock) on jh.fkCPClient = ch.pkCPClient
	  Left Join   CPJoinClientClientCase j with (NoLock) on jh.pkCPJoinClientClientCase = j.pkCPJoinClientClientCase
	  left join   MergedMembers mm (NoLock) on mm.fkCPDuplicateMember = ch.pkCPClient
	  left join   CPClient c (NoLock) on c.pkCPClient = mm.fkCPMergeMember
	  Where       jh.fkCPClientCase = @pkCase
	  And         IsNull(j.pkCPJoinClientClientCase,0) = 0
	  and		  jh.AuditDeleted = 1
	  order by jh.pk desc) deletedMembers
	  
	  union all 
	  
	  /* an address join record shows an address addition , however, deletes and additions to a join mean that an address was changed  */
	  
	  Select    distinct  Null as pkCPCaseActivity,
				  2 as fkCPCaseActivityType,
				  case when ja.fkCPRefClientAddressType = 1 then 'Mailing Address: ' else 'Physical Address: ' end + char(13) + 
				  IsNull(a.Street1,'') + case when IsNull(a.Street1,'') = '' then '' else char(13) end + 
				  IsNull(a.Street2,'') + case when IsNull(a.Street2,'') = '' then '' else char(13) end + 
				  IsNull(a.Street3 + case when IsNull(a.Street3,'') = '' then '' else char(13) end ,'') + 
				  IsNull(a.City,'') + ' ' + IsNull(a.State,'') + ', ' + IsNull(a.Zip,'') +
				  case when IsNull(a.ZipPlus4,'') = '' then '' else '-' + a.ZipPlus4 end as 'Description',
				  CreateDate = ja.CreateDate,
				  CreateUser = isnull(ja.CreateUser,'unknown'),
				  jc.fkCPClientCase,
				  jc.fkCPClient,
				  CaseActivityTypeName = 'Address Change',
				  Username = ''
			
	  From        CPJoinClientClientCase jc with (Nolock) 
	  Join        CPJoinClientClientAddress ja with (noLock) on jc.fkCPClient = ja.fkCPClient
	  Join        CPClient c with (NoLock) on jc.fkCPClient = c.pkCPClient
	  Join        CPClientAddress a with (NoLock) on ja.fkCPClientAddress = a.pkCPClientAddress
	  
	  Where       jc.fkCPClientCase = @pkCase
	  
	  /*  Get all of the narratives for the case as well, these are only in the case activity logs under a single type */
	  
	  Union All
	  
	  select a.pkCPCaseActivity,
			a.fkCPCaseActivityType,
			a.[Description],
			CreateDate = a.EffectiveCreateDate,
			CreateUser = isnull(a.CreateUser,'unknown'),
			a.fkCPClientCase,
			a.fkCPClient,
			CaseActivityTypeName = c.[Description],
			Username = ''
	  From CPCaseActivity a With (NoLock)
	  Join CPCaseActivityType c With (NoLock) on c.pkCPCaseActivityType = a.fkCPCaseActivityType
	  where       ((a.fkCPClientCase = @pkCase OR a.fkCPClient = @pkClient)
	  OR          a.fkCPClient IN (SELECT jcc.fkCPClient FROM CPJoinClientClientCase jcc WHERE jcc.fkCPClientCase = @pkCase))
	  and   a.fkCPCaseActivityType = 1

	  Union All
	  
	  select a.pkCPCaseActivity,
			a.fkCPCaseActivityType,
			a.[Description],
			CreateDate = a.EffectiveCreateDate,
			CreateUser = isnull(a.CreateUser,'unknown'),
			a.fkCPClientCase,
			a.fkCPClient,
			CaseActivityTypeName = c.[Description],
			Username = ''
	  From CPCaseActivity a With (NoLock)
	  Join CPCaseActivityType c With (NoLock) on c.pkCPCaseActivityType = a.fkCPCaseActivityType
	  where a.fkCPClientCase = @pkCase
	  and   a.fkCPCaseActivityType = 9

	  Union All

	  select a.pkCPCaseActivity,
			8 as fkCPCaseActivityType,
			a.[Description],
			CreateDate = '01/01/1900',
			CreateUser = '',
			a.fkCPClientCase,
			a.fkCPClient,
			CaseActivityTypeName = c.[Description],
			Username = ''
	  From CPCaseActivityAudit a With (NoLock)
	  Join CPCaseActivityType c With (NoLock) on c.pkCPCaseActivityType = a.fkCPCaseActivityType
	  where       ((a.fkCPClientCase = @pkCase OR a.fkCPClient = @pkClient)
	  OR          a.fkCPClient IN (SELECT jcc.fkCPClient FROM CPJoinClientClientCase jcc WHERE jcc.fkCPClientCase = @pkCase))
	  and   a.fkCPCaseActivityType = 1 and a.auditdeleted = 1

	  Union All
	  
	  select distinct  a.pkCPCaseActivity,
			a.fkCPCaseActivityType,
			a.[Description],
			CreateDate = a.EffectiveCreateDate,
			CreateUser = isnull(a.CreateUser,'unknown') ,
			a.fkCPClientCase,
			a.fkCPClient,
			CaseActivityTypeName = c.[Description],
			Username = ''
	  From CPCaseActivity a With (NoLock)
	  Join CPCaseActivityType c With (NoLock) on c.pkCPCaseActivityType = a.fkCPCaseActivityType
	  where       a.fkCPClientCase = @pkCase
	  and   a.fkCPCaseActivityType = 7

	  Update @Temp 
	  set Username = au.Username
	  from ApplicationUser au inner join @Temp t on rtrim(cast(au.pkApplicationUser as varchar(100))) = t.CreateUser

	
	  Declare   @ClientAddressCount int,
				@Count int,
				@FetchStatus int

	  Set @ClientAddressCount = 0
	  Set @Count = 0 
	  Set @FetchStatus = 0

	  Declare @arClientAddress Table
		(     pkarClientAddress decimal(18,0) Identity(1,1),
			  pkCPClient decimal(18,0),
			  Street1 varchar(100),
			  Street2 varchar(100),
			  Street3 varchar(100),
			  City varchar(100),
			  [State] varchar(50),
			  Zip char(5),
			  ZipPlus4 char(4),
			  AuditStartDate datetime,
			  AuditUser varchar(50),
			  fkCPRefClientAddressType decimal(18,0)
		)

	  Insert Into @arClientAddress
	  (     pkCPClient,
			Street1,
			Street2,
			Street3,
			City,
			[State],
			Zip,
			ZipPlus4,
			AuditStartDate,
			AuditUser,
			fkCPRefClientAddressType
	  )
	  Select  c.pkCPClient,
			  isnull(a.Street1, ''),
			  isnull(a.Street2, ''),
			  isnull(a.Street3, ''),
			  isnull(a.City, ''),
			  isnull(a.State, ''),
			  isnull(a.Zip, ''),
			  isnull(a.ZipPlus4, ''),
			  aa.AuditStartDate,
			  aa.AuditUser,
			  aa.fkCPRefClientAddressType
	  From CPJoinClientClientCase jc with (Nolock) 
	  Join CPJoinClientClientAddressAudit aa with (noLock) on jc.fkCPClient = aa.fkCPClient
	  Join CPClient c with (NoLock) on jc.fkCPClient = c.pkCPClient
	  Join CPClientAddress a with (NoLock) on aa.fkCPClientAddress = a.pkCPClientAddress
	  Where jc.fkCPClientCase = @pkCase
	  Order By aa.AuditStartDate

	  Set @ClientAddressCount = (Select Count(*) From @arClientAddress)
	  Set @Count = 1

	  While @Count <= @ClientAddressCount 
		  begin
				declare @pkCPClient decimal(18,0),
						@Street1 varchar(100),
						@Street2 varchar(100),
						@Street3 varchar(100),
						@City varchar(100),
						@State varchar(50),
						@Zip char(5),
						@ZipPlus4 char(4),
						@AuditStartDate datetime,
						@AuditUser varchar(50),
						@fkCPRefClientAddressType decimal(18,0),
						@Description varchar(MAX)

				select  @pkCPClient =a.pkCPClient,
						@Street1 = a.Street1,
						@Street2 = a.Street2,
						@Street3 = a.Street3,
						@City = a.City,
						@State = a.State,
						@Zip = a.Zip,
						@ZipPlus4 = a.ZipPlus4,
						@AuditStartDate = a.AuditStartDate,
						@AuditUser = a.AuditUser,
						@fkCPRefClientAddressType = a.fkCPRefClientAddressType
				From  @arClientAddress a
				Where pkarClientAddress = @Count

				select @Description = case when @fkCPRefClientAddressType = 1 then 'Mailing Address: ' else 'Physical Address: ' end + char(13)
				
				if isnull(@Street1, '') <> ''
					begin
						select @Description = @Description + @Street1 + char(13)
					end
	
				if isnull(@Street2, '') <> ''
					begin
						select @Description = @Description + @Street2 + char(13)
					end

				if isnull(@Street3, '') <> ''
					begin
						select @Description = @Description + @Street3 + char(13)
					end
				
				select @Description = @Description + @City + ' ' + @State + ', ' + @Zip +
					   case when IsNull(@ZipPlus4,'') = '' then '' else '-' + @ZipPlus4 end
				
				Insert Into @Temp
				(     pkCPCaseActivity,
					  fkCPCaseActivityType,
					  [Description],
					  CreateDate,
					  CreateUser,
					  fkCPClientCase,
					  fkCPClient,
					  CaseActivityTypeName
				)
				Select Null,
					   2,
					   @Description,
					   @AuditStartDate,
					   @AuditUser,
					   @pkCase,
					   @pkCPClient,
					   'Address Change'

				Set @Count = @Count + 1
			end 
	
	Update @Temp 
	set Username = au.Username
	from ApplicationUser au inner join @Temp t on rtrim(cast(au.pkApplicationUser as varchar(100))) = t.CreateUser
		   
	/* Finally... */
	-- Need to exclude case status as they will be manually added later in this sp
	Select  Max(CreateDate) as CreateDate2, Description as Description2, fkCPClient as fkCPClient2 into #UniqueRows
	from @Temp
	WHERE fkCPCaseActivityType <> 1 and fkCPCaseActivityType <> 9 
	group by  Description, CaseActivityTypeName, fkCPClient

	/* For PCR 10423 moving the DISTINCT to the individual select statements except for the 
		naratives. */
	-- Manually add the case status changes to be returned
	INSERT INTO #UniqueRows 
	Select	CreateDate,Description,fkCPClient	
	from @Temp
	WHERE fkCPCaseActivityType = 1 or fkCPCaseActivityType = 9
	group by  Description, CaseActivityTypeName, fkCPClient, CreateDate

	Select * into #ReturnTable from @Temp T
	Inner join #UniqueRows UN on UN.CreateDate2 = T.CreateDate and UN.Description2 = T.Description  
	and UN.fkCPClient2 = T.fkCPClient
	/* Backed out changes for PCR 10423 by readding distinct restriction to case activity results - MBS*/
	/*Select * into #ReturnTable from @Temp */
	
	/*    This is my hack to having access to a identity field, we need to create identities conditionally
			if the row is a narrative, then we need to use the pk that actually came in from the narrative */
	Declare @RowCount Decimal(18,0),
			@FetchCount int

	begin try
		Select @RowCount = max(pkCPCaseActivity) from #ReturnTable
	end try
	begin catch
		set @RowCount = 0
	end catch

	if isnull(@RowCount, 0) = 0
	begin
		  set @RowCount = 0
	end

	Set @FetchCount = 1

	While @FetchCount >= 1
	begin
		Set @RowCount = @RowCount + 1
		Set RowCount 1

		Update #ReturnTable
		Set pkCpCaseActivity = @RowCount
		From #ReturnTable
		Where pkCPCaseActivity is Null

		set RowCount 0
		Set @FetchCount = (Select Count(*)
						   From  #ReturnTable
						   Where pkCPCaseActivity is Null)
	end

	--Need to get the create date and create user for the deleted narratives/notes
	select pk, AuditStartDate, AuditUser, CPCaseActivityAudit.pkCPCaseActivity
	into #TempDeletedNarrativeInfo
	from CPCaseActivityAudit 
	inner join #ReturnTable r on r.pkCPCaseActivity = CPCaseActivityAudit.pkCPCaseActivity
	where r.fkCPCaseActivityType = 8

	--make sure we use the first audit entry to get the original create date and user
	delete from #TempDeletedNarrativeInfo
	where pk not in (select min(pk) from #TempDeletedNarrativeInfo group by pkCPCaseActivity) 
	
	--update our return table with the create date for deleted notes/narratives
	Update #ReturnTable 
	set CreateDate = #TempDeletedNarrativeInfo.AuditStartDate,
		CreateUser = #TempDeletedNarrativeInfo.AuditUser
	from #ReturnTable t 
	inner join #TempDeletedNarrativeInfo on #TempDeletedNarrativeInfo.pkCPCaseActivity = t.pkCPCaseActivity 
	
	--update our return table with the create user for deleted notes/narratives
	Update #ReturnTable 
	set Username = au.Username
	from ApplicationUser au inner join #ReturnTable t on rtrim(cast(au.pkApplicationUser as varchar(100))) = t.CreateUser

	select * from #ReturnTable

	select * from CPCaseActivityType

	--Get the availble types for the type dropdown
	select fkCPCaseActivityType from #ReturnTable
	group by fkCPCaseActivityType

	--Get the availble users for the user dropdown
	select ActivityUsers = CreateUser
			,Username from #ReturnTable 
	group by CreateUser, Username

	SELECT DISTINCT c.pkCPClient, c.LastName, c.FirstName, c.MiddleName, c.Suffix 
	FROM CPClient c
	JOIN #ReturnTable rt ON c.pkCPClient = rt.fkCPClient

	drop table #ReturnTable
	drop table #UniqueRows
	drop table #TempDeletedNarrativeInfo