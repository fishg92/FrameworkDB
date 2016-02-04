-- Stored Procedure

CREATE PROCEDURE [dbo].[uspFormQuickListAddAutoFillValue]
(	
	  @fkFormQuickListFormName decimal(10, 0)
	, @KeywordName varchar(50)
	, @FormQuickListAutoFillValue varchar(5000)
	, @AutoFillGrouName varchar (50)
	, @RowNumber int
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

if exists 
	(
		select	*
		from	FormQuickListAutoFillValue
		where	fkFormQuickListFormName = 	@fkFormQuickListFormName
		and		KeywordName = @KeywordName
		and		RowNumber = @RowNumber
		and		AutoFillGroupName = @AutoFillGrouName
	)
	begin

	update	FormQuickListAutoFillValue
	set		FormQuickListAutoFillValue = @FormQuickListAutoFillValue
	where	fkFormQuickListFormName = 	@fkFormQuickListFormName
	and		KeywordName = @KeywordName
	and		RowNumber = @RowNumber
	and		AutoFillGroupName = @AutoFillGrouName

	end
else
	begin

	INSERT INTO FormQuickListAutoFillValue
		(
			fkFormQuickListFormName,
			KeywordName,
			RowNumber,
			FormQuickListAutoFillValue,
			AutoFillGroupName
		) 
	VALUES
		(
			@fkFormQuickListFormName,
			@KeywordName,
			@RowNumber,
			@FormQuickListAutoFillValue,
			@AutoFillGrouName
		)
	end

/*
	DECLARE @Len   int,
			@pkRet decimal(10, 0)

	SET @Len = LEN(@FormQuickListAutoFillValue)
	IF @Len IS NULL
	BEGIN
		SET @Len = 0
	END	

	IF @Len <= 25
	BEGIN
		IF NOT EXISTS(SELECT pkFormQuickListAutoFillValueSmall FROM FormQuickListAutoFillValueSmall WHERE FormQuickListAutoFillValue = @FormQuickListAutoFillValue)
		BEGIN
			INSERT INTO FormQuickListAutoFillValueSmall
			(	FormQuickListAutoFillValue)
			VALUES
			(	@FormQuickListAutoFillValue)

			SET @pkRet = SCOPE_IDENTITY()
		END
		ELSE
		BEGIN
			SET @pkRet = (SELECT MAX(pkFormQuickListAutoFillValueSmall) FROM FormQuickListAutoFillValueSmall WHERE FormQuickListAutoFillValue = @FormQuickListAutoFillValue)
		END

		INSERT INTO FormQuickListAutoFillValue
		(	fkFormQuickListAutoFillValueSmall,
			fkFormQuickListFormName,
			KeywordName,
			RowNumber)
		VALUES
		(	@pkRet,
			@fkFormQuickListFormName,
			@KeywordName,
			@RowNumber)
	END
	ELSE IF @Len > 25 AND @Len <= 100
	BEGIN
		IF NOT EXISTS(SELECT pkFormQuickListAutoFillValueMedium FROM FormQuickListAutoFillValueMedium WHERE FormQuickListAutoFillValue = @FormQuickListAutoFillValue)
		BEGIN
			INSERT INTO FormQuickListAutoFillValueMedium 
			(	FormQuickListAutoFillValue)
			VALUES
			(	@FormQuickListAutoFillValue)

			SET @pkRet = SCOPE_IDENTITY()
		END
		ELSE
		BEGIN
			SET @pkRet = (SELECT MAX(pkFormQuickListAutoFillValueMedium) FROM FormQuickListAutoFillValueMedium WHERE FormQuickListAutoFillValue = @FormQuickListAutoFillValue)
		END

		INSERT INTO FormQuickListAutoFillValue
		(	fkFormQuickListAutoFillValueMedium,
			fkFormQuickListFormName,
			KeywordName,
			RowNumber)
		VALUES
		(	@pkRet,
			@fkFormQuickListFormName,
			@KeywordName,
			@RowNumber)
	END
	ELSE IF @Len > 100 AND @Len <= 500
	BEGIN
		IF NOT EXISTS(SELECT pkFormQuickListAutoFillValueLarge FROM FormQuickListAutoFillValueLarge WHERE FormQuickListAutoFillValue = @FormQuickListAutoFillValue)
		BEGIN
			INSERT INTO FormQuickListAutoFillValueLarge 
			(	FormQuickListAutoFillValue)
			VALUES
			(	@FormQuickListAutoFillValue)

			SET @pkRet = SCOPE_IDENTITY()
		END
		ELSE
		BEGIN
			SET @pkRet = (SELECT MAX(pkFormQuickListAutoFillValueLarge) FROM FormQuickListAutoFillValueLarge WHERE FormQuickListAutoFillValue = @FormQuickListAutoFillValue)
		END

		INSERT INTO FormQuickListAutoFillValue
		(	fkFormQuickListAutoFillValueLarge,
			fkFormQuickListFormName,
			KeywordName,
			RowNumber)
		VALUES
		(	@pkRet,
			@fkFormQuickListFormName,
			@KeywordName,
			@RowNumber)
	END
	ELSE IF @Len > 500 
	BEGIN
		IF NOT EXISTS(SELECT pkFormQuickListAutoFillValueHuge FROM FormQuickListAutoFillValueHuge WHERE FormQuickListAutoFillValue = @FormQuickListAutoFillValue)
		BEGIN
			INSERT INTO FormQuickListAutoFillValueHuge 
			(	FormQuickListAutoFillValue)
			VALUES
			(	@FormQuickListAutoFillValue)

			SET @pkRet = SCOPE_IDENTITY()
		END
		ELSE
		BEGIN
			SET @pkRet = (SELECT MAX(pkFormQuickListAutoFillValueHuge) FROM FormQuickListAutoFillValueHuge WHERE FormQuickListAutoFillValue = @FormQuickListAutoFillValue)
		END

		INSERT INTO FormQuickListAutoFillValue
		(	fkFormQuickListAutoFillValueHuge,
			fkFormQuickListFormName,
			KeywordName,
			RowNumber)
		VALUES
		(	@pkRet,
			@fkFormQuickListFormName,
			@KeywordName,
			@RowNumber)
	END




*/
