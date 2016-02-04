-- Stored Procedure

----------------------------------------------------------------------------
-- Update a single record in FormJoinFormStaticKeywordNameFormStaticKeywordValue
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormJoinFormStaticKeywordNameFormStaticKeywordValueUpdate]
(	  @pkFormJoinFormStaticKeywordNameFormStaticKeywordValue decimal(10, 0)
	, @fkFormStaticKeywordName decimal(10, 0) = NULL
	, @fkFormStaticKeywordValue decimal(10, 0) = NULL
	, @fkFormName decimal(10, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	FormJoinFormStaticKeywordNameFormStaticKeywordValue
SET	fkFormStaticKeywordName = ISNULL(@fkFormStaticKeywordName, fkFormStaticKeywordName),
	fkFormStaticKeywordValue = ISNULL(@fkFormStaticKeywordValue, fkFormStaticKeywordValue),
	fkFormName = ISNULL(@fkFormName, fkFormName)
WHERE 	pkFormJoinFormStaticKeywordNameFormStaticKeywordValue = @pkFormJoinFormStaticKeywordNameFormStaticKeywordValue
