-- Stored Procedure

----------------------------------------------------------------------------
-- Update a single record in FormJoinStaticKeywordNameFormName
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormJoinStaticKeywordNameFormNameUpdate]
(	  @pkFormJoinStaticKeywordNameFormName decimal(10, 0)
	, @fkFormName decimal(10, 0) = NULL
	, @fkFormStaticKeywordName decimal(10, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	FormJoinStaticKeywordNameFormName
SET	fkFormName = ISNULL(@fkFormName, fkFormName),
	fkFormStaticKeywordName = ISNULL(@fkFormStaticKeywordName, fkFormStaticKeywordName)
WHERE 	pkFormJoinStaticKeywordNameFormName = @pkFormJoinStaticKeywordNameFormName
