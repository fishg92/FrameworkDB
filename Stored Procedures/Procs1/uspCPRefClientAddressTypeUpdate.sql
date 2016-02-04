----------------------------------------------------------------------------
-- Update a single record in CPRefClientAddressType
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPRefClientAddressTypeUpdate]
(	  @pkCPRefClientAddressType decimal(18, 0)
	, @Description varchar(255) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	CPRefClientAddressType
SET	Description = ISNULL(@Description, Description)
WHERE 	pkCPRefClientAddressType = @pkCPRefClientAddressType
