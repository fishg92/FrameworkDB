-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into Configuration
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspConfigurationInsert]
(	  @Grouping varchar(200)
	, @ItemKey varchar(200)
	, @ItemValue nvarchar(300)
	, @ItemDescription varchar(300)
	, @AppID int
	, @Sequence int = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	, @pkConfiguration decimal(18, 0) = NULL OUTPUT 
)
AS
	exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT Configuration
(	  Grouping
	, ItemKey
	, ItemValue
	, ItemDescription
	, AppID
	, Sequence
)
VALUES 
(	  @Grouping
	, @ItemKey
	, @ItemValue
	, @ItemDescription
	, @AppID
	, COALESCE(@Sequence, (1))

)

SET @pkConfiguration = SCOPE_IDENTITY()
