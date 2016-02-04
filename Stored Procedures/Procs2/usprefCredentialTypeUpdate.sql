-- Stored Procedure

----------------------------------------------------------------------------
-- Update a single record in RefCredentialType
----------------------------------------------------------------------------
CREATE PROC [dbo].[usprefCredentialTypeUpdate]
(	  @pkRefCredentialType decimal(18, 0)
	, @Description varchar(255) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	RefCredentialType
SET	Description = ISNULL(@Description, Description)
WHERE 	pkRefCredentialType = @pkRefCredentialType
