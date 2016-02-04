
create function dbo.IsBestPhysicalAddress
	(
		@pkDataMigratorStaging decimal
		,@ClientUniqueID varchar(50)
		,@PhysicalAddressScore int
		,@PhysicalAddressChecksum int
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
						PhysicalAddressScore > @PhysicalAddressScore
						or
						(
							PhysicalAddressScore = @PhysicalAddressScore
							and
							PhysicalAddressChecksum > @PhysicalAddressChecksum
						)
					)
				)
		begin
		set @isBest = 0
		end					
						
	return @isBest

end

