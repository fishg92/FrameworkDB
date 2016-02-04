--[uspAddAgencyConfig] 'Another Agency',1,9,'12/11/2007','01-AA-BB-CC-DD-EE','255.255.255.255',0
CREATE proc [dbo].[uspAddAgencyConfig]
(	@AgencyName varchar(100)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	,@pkAgencyConfig decimal(18, 0) output
)
as

	exec dbo.SetAuditDataContext @LupUser, @LupMachine

	Insert into AgencyConfig
	(	AgencyName
	)
	Values
	(	@AgencyName
	)

	Set @pkAgencyConfig = Scope_Identity()
