
----------------------------------------------------------------------------
-- Update a single record in AutoPopulateKeyword
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspAutoPopulateKeywordUpdate]
(	  @pkAutoPopulateKeyword decimal(18, 0)
	, @fkKeyword varchar(50) = NULL
	, @ValueID smallint = NULL
	, @CanBeOverridden bit = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	AutoPopulateKeyword
SET	fkKeyword = ISNULL(@fkKeyword, fkKeyword),
	ValueID = ISNULL(@ValueID, ValueID),
	CanBeOverridden = ISNULL(@CanBeOverridden, CanBeOverridden)
WHERE 	pkAutoPopulateKeyword = @pkAutoPopulateKeyword
