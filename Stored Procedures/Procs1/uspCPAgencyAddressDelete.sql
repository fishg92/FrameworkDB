----------------------------------------------------------------------------
-- Delete a single record from CPAgencyAddress
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspCPAgencyAddressDelete]
(	@pkCPAgencyAddress decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15) 
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

DELETE	CPAgencyAddress
WHERE 	pkCPAgencyAddress = @pkCPAgencyAddress
