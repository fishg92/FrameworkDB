----------------------------------------------------------------------------
-- Update a single record in Configuration
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspConfigurationUpdate]
(	  @pkConfiguration decimal(18, 0)
	, @Grouping varchar(200) = NULL
	, @ItemKey varchar(200) = NULL
	, @ItemValue nvarchar(300) = NULL
	, @ItemDescription varchar(300) = NULL
	, @AppID int = NULL
	, @Sequence int = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	Configuration
SET	Grouping = ISNULL(@Grouping, Grouping),
	ItemKey = ISNULL(@ItemKey, ItemKey),
	ItemValue = ISNULL(@ItemValue, ItemValue),
	ItemDescription = ISNULL(@ItemDescription, ItemDescription),
	AppID = ISNULL(@AppID, AppID),
	Sequence = ISNULL(COALESCE(@Sequence, (1)), Sequence)
WHERE 	pkConfiguration = @pkConfiguration
