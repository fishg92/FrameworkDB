-- Stored Procedure

CREATE PROC [dbo].[uspFormAddStaticKeyword]
(
	  @fkFormName decimal(18, 0)
	, @fkKeywordType varchar(50)
	, @KeywordValue varchar(100)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)

)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

	DECLARE @pkFormStaticKeywordName decimal(18, 0),
			@pkFormStaticKeywordValue decimal(18, 0)

	/* Try to retrieve the keyword name from the existing set of keywords to avoid redundancy */

	SET @pkFormStaticKeywordName = (SELECT pkFormStaticKeywordName FROM FormStaticKeywordName WHERE UPPER(fkKeywordType) = UPPER(@fkKeywordType))
	IF ISNULL(@pkFormStaticKeywordname,0) = 0 
	BEGIN

		/* This is the first occurrance of this keyword, add its name to our DB */
		INSERT INTO FormStaticKeywordName
		(	fkKeywordType)
		VALUES
		(	UPPER(@fkKeywordType))

		SET @pkFormStaticKeywordName = SCOPE_IDENTITY()

	END


	/* Again, to avoid redundancy, try to retrieve the keyword value */

	SET @pkFormStaticKeywordValue = (SELECT pkFormStaticKeywordValue FROM FormStaticKeywordValue WHERE StaticKeywordValue = @KeywordValue)
	IF ISNULL(@pkFormStaticKeywordValue,0) = 0 
	BEGIN

		INSERT INTO FormStaticKeywordValue
		(	StaticKeywordValue)
		VALUES
		(	@KeywordValue)

		SET @pkFormStaticKeywordValue = SCOPE_IDENTITY()

	END


	/* Associate the keyword name with the keyword value and back to the form itself */

	INSERT INTO FormJoinFormStaticKeywordNameFormStaticKeywordValue
	(	  fkFormStaticKeywordName
		, fkFormStaticKeywordValue
		, fkFormName)
	VALUES
	(	  @pkFormStaticKeywordName
		, @pkFormStaticKeywordValue
		, @fkFormName)
