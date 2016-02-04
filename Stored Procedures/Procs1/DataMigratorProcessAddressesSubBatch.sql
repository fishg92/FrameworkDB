



CREATE proc [dbo].[DataMigratorProcessAddressesSubBatch]
	@fkCPImportBatch decimal
	,@SubBatchID int
as

declare @CheckSumForBlankAddress int
set @CheckSumForBlankAddress = checksum('','','','','','','')

insert into CPClientAddress	
	(fkCPRefClientAddressType
	,Street1
	,Street2
	,Street3
	,City
	,State
	,Zip
	,ZipPlus4
	)
	select 
	distinct
	1
	,case when s.MailingAddressStreet1 = '' then MailingAddressStreet1 else s.MailingAddressStreet1 end
	,case when s.MailingAddressStreet2 = '' then MailingAddressStreet2 else s.MailingAddressStreet2 end
	,case when s.MailingAddressStreet3 = '' then MailingAddressStreet3 else s.MailingAddressStreet3 end
	,case when s.MailingAddressCity = '' then MailingAddressCity else s.MailingAddressCity end
	,case when s.MailingAddressState = '' then MailingAddressState else s.MailingAddressState end
	,case when s.MailingAddressZip = '' then MailingAddressZip else s.MailingAddressZip end
    ,case when s.MailingAddressZipPlus4 = '' then MailingAddressZipPlus4 else s.MailingAddressZipPlus4 end
	from DataMigratorStaging s
	where s.ExclusionFlag = 0
	and s.fkCPClientAddressMailing is null
	and s.SubBatchID = @SubBatchID
	and s.MailingAddressChecksum <> @CheckSumForBlankAddress 
	and not exists (select * from cpClientAddress ca 
		where ca.DataCheckSum = s.MailingAddressChecksum
			and ca.fkCPRefClientAddressType = 1)
			
		

insert into CPClientAddress	
	(fkCPRefClientAddressType
	,Street1
	,Street2
	,Street3
	,City
	,State
	,Zip
	,ZipPlus4
	)
	select 
	distinct
	2
	,case when s.PhysicalAddressStreet1 = '' then PhysicalAddressStreet1 else s.PhysicalAddressStreet1 end
	,case when s.PhysicalAddressStreet2 = '' then PhysicalAddressStreet2 else s.PhysicalAddressStreet2 end
	,case when s.PhysicalAddressStreet3 = '' then PhysicalAddressStreet3 else s.PhysicalAddressStreet3 end
	,case when s.PhysicalAddressCity = '' then PhysicalAddressCity else s.PhysicalAddressCity end
	,case when s.PhysicalAddressState = '' then PhysicalAddressState else s.PhysicalAddressState end
	,case when s.PhysicalAddressZip = '' then PhysicalAddressZip else s.PhysicalAddressZip end
    ,case when s.PhysicalAddressZipPlus4 = '' then PhysicalAddressZipPlus4 else s.PhysicalAddressZipPlus4 end
	from DataMigratorStaging s
	where s.ExclusionFlag = 0
	and s.fkCPClientAddressPhysical is null
	and s.SubBatchID = @SubBatchID
	and s.PhysicalAddressChecksum <> @CheckSumForBlankAddress 
	and not exists (select * from cpClientAddress ca 
		where ca.DataCheckSum = s.PhysicalAddressChecksum
			and ca.fkCPRefClientAddressType = 2)

	/* find the fk to any address matching the data and type */
	update DataMigratorStaging
	set fkCPClientAddressMailing = addr.pkCPClientAddress
	from DataMigratorStaging s
	join CPClientAddress addr
		on s.MailingAddressChecksum = addr.DataCheckSum 
		and addr.fkCPRefClientAddressType = 1
		and s.MailingAddressChecksum <> @CheckSumForBlankAddress 
	where s.fkCPImportBatch = @fkCPImportBatch
	and s.ExclusionFlag = 0
	and s.fkCPClientAddressMailing is  null
	and s.SubBatchID = @SubBatchID


	update DataMigratorStaging
	set fkCPClientAddressPhysical = addr.pkCPClientAddress
	from DataMigratorStaging s
	join CPClientAddress addr
		on s.PhysicalAddressChecksum = addr.DataCheckSum 
		and addr.fkCPRefClientAddressType = 2
		and s.PhysicalAddressChecksum <> @CheckSumForBlankAddress 
	where s.fkCPImportBatch = @fkCPImportBatch
	and s.ExclusionFlag = 0
	and s.fkCPClientAddressPhysical is  null
	and s.SubBatchID = @SubBatchID

	update CPJoinClientClientAddress 
		set fkCPClientAddress = s.fkCPClientAddressMailing
		from CPJoinClientClientAddress  j
	inner join DataMigratorStaging s
		 on j.fkCPClient = isnull(s.fkCPClient,-1)
		 and s.fkCPClientAddressMailing <> j.fkCPClientAddress
		 and s.fkCPClientAddressMailing is not null
		and s.fkCPImportBatch = @fkCPImportBatch
		and s.ExclusionFlag = 0			
		and s.SubBatchID = @SubBatchID
	where j.fkCPRefClientAddressType = 1			
	
		update CPJoinClientClientAddress 
		set fkCPClientAddress = s.fkCPClientAddressPhysical
		from CPJoinClientClientAddress  j
	inner join DataMigratorStaging s
		 on j.fkCPClient = isnull(s.fkCPClient,-1)
		 and s.fkCPClientAddressPhysical <> j.fkCPClientAddress
		 and s.fkCPClientAddressPhysical is not null
		and s.fkCPImportBatch = @fkCPImportBatch
		and s.ExclusionFlag = 0			
		and s.SubBatchID = @SubBatchID
	where j.fkCPRefClientAddressType = 2

/*		
	delete from CPJoinClientClientAddress 
		from CPJoinClientClientAddress  j
		inner join DataMigratorStaging s
		 on j.fkCPClient = isnull(s.fkCPClient,-1)
		 and s.fkCPClientAddressMailing <> j.fkCPClientAddress
		 and s.fkCPClientAddressMailing is not null
		and s.fkCPImportBatch = @fkCPImportBatch
		and s.ExclusionFlag = 0			
		and s.SubBatchID = @SubBatchID
	where j.fkCPRefClientAddressType = 1			
	
	delete from CPJoinClientClientAddress 
		from CPJoinClientClientAddress j
		inner join DataMigratorStaging s
		 on j.fkCPClient = isnull(s.fkCPClient,-1)
		 and s.fkCPClientAddressPhysical <> j.fkCPClientAddress
		 and s.fkCPClientAddressPhysical is not null
		 and s.fkCPImportBatch = @fkCPImportBatch
		and s.ExclusionFlag = 0			
		and s.SubBatchID = @SubBatchID
	where j.fkCPRefClientAddressType = 2				
*/

/* now that we have enough info to create join records, create them	*/
	insert into CPJoinClientClientAddress
		(fkCPClient,fkCPClientAddress,fkCPRefClientAddressType)
	select distinct s.fkCPClient
		,s.fkCPClientAddressMailing
		,1
		from DataMigratorStaging s
		where s.fkCPClient is not null
		and s.fkCPClientAddressMailing is not null
		and s.fkCPImportBatch = @fkCPImportBatch
		and s.SubBatchID = @SubBatchID
		and s.ExclusionFlag = 0			
		and not exists (select * from CPJoinClientClientAddress j where 
			j.fkCPClient = s.fkCPClient and j.fkCPClientAddress = s.fkCPClientAddressMailing
			and j.fkCPRefClientAddressType = 1)

	insert into CPJoinClientClientAddress
		(fkCPClient,fkCPClientAddress,fkCPRefClientAddressType)
	select distinct s.fkCPClient
		,s.fkCPClientAddressPhysical
		,2
		from DataMigratorStaging s
		where s.fkCPClient is not null
		and s.fkCPClientAddressPhysical is not null
		and s.fkCPImportBatch = @fkCPImportBatch
		and s.ExclusionFlag = 0			
		and s.SubBatchID = @SubBatchID
		and not exists (select * from CPJoinClientClientAddress j where 
			j.fkCPClient = s.fkCPClient and j.fkCPClientAddress = s.fkCPClientAddressPhysical
			and j.fkCPRefClientAddressType = 2)
			

	/* Remove any orphaned addresses */
	delete from CPClientAddress
		where pkCPClientAddress not in 
			(select fkCPClientAddress from CPJoinClientClientAddress)

