----------------------------------------------------------------------------
-- Update a single record in refFieldNameRegEx
----------------------------------------------------------------------------
CREATE PROC [dbo].[usprefFieldNameRegExUpdate]
(	  @pkrefFieldNameRegEx decimal(18, 0)
	, @regExValues varchar(150) = NULL
	, @regFieldName varchar(250) = NULL
	, @FriendlyName varchar(250) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	refFieldNameRegEx
SET	regExValues = ISNULL(@regExValues, regExValues),
	regFieldName = ISNULL(@regFieldName, regFieldName),
	FriendlyName = ISNULL(@FriendlyName, FriendlyName)
WHERE 	pkrefFieldNameRegEx = @pkrefFieldNameRegEx
