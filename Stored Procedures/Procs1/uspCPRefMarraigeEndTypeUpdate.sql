----------------------------------------------------------------------------
-- Update a single record in CPRefMarraigeEndType
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPRefMarraigeEndTypeUpdate]
(	  @pkCPRefMarraigeEndType decimal(18, 0)
	, @Description varchar(100) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	CPRefMarraigeEndType
SET	Description = ISNULL(@Description, Description)
WHERE 	pkCPRefMarraigeEndType = @pkCPRefMarraigeEndType
