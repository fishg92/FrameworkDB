----------------------------------------------------------------------------
-- Insert a single record into refFieldNameRegEx
----------------------------------------------------------------------------
CREATE Proc [dbo].[usprefFieldNameRegExInsert]
(	  @regExValues varchar(150)
	, @regFieldName varchar(250)
	, @FriendlyName varchar(250) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkrefFieldNameRegEx decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT refFieldNameRegEx
(	  regExValues
	, regFieldName
	, FriendlyName
)
VALUES 
(	  @regExValues
	, @regFieldName
	, @FriendlyName

)

SET @pkrefFieldNameRegEx = SCOPE_IDENTITY()
