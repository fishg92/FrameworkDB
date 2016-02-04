create function dbo.IsBestMailingAddress
	(
		@pkDataMigratorStaging decimal
		,@ClientUniqueID varchar(50)
		,@MailingAddressScore int
		,@MailingAddressChecksum int
		,@fkCPImportBatch int
	)
returns bit
as

begin
	declare @isBest bit
	set @isBest  = 1
	
	if exists (	select	*
				from	DataMigratorStaging
				where	ClientUniqueID = @ClientUniqueID
				and		pkDataMigratorStaging <> @pkDataMigratorStaging
				and		fkCPImportBatch = @fkCPImportBatch
				and		ExclusionFlag = 0
				and		
					(
						MailingAddressScore > @MailingAddressScore
						or
						(
							MailingAddressScore = @MailingAddressScore
							and
							MailingAddressChecksum > @MailingAddressChecksum
						)
					)
				)
		begin
		set @isBest = 0
		end					
						
	return @isBest

end

