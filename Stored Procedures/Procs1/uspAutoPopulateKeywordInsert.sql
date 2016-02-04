
----------------------------------------------------------------------------
-- Insert a single record into AutoPopulateKeyword
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspAutoPopulateKeywordInsert]
(	  @fkKeyword varchar(50)
	, @ValueID smallint
	, @CanBeOverridden bit
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkAutoPopulateKeyword decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT AutoPopulateKeyword
(	  fkKeyword
	, ValueID
	, CanBeOverridden
)
VALUES 
(	  @fkKeyword
	, @ValueID
	, @CanBeOverridden

)

SET @pkAutoPopulateKeyword = SCOPE_IDENTITY()
