CREATE PROCEDURE [dbo].[uspFormSetActiveAutofill]
(
	  @fkFrameworkUserID decimal
	, @fkAutofillID decimal
)
AS

	IF EXISTS(SELECT TOP 1 fkActiveAutofill FROM FormUserSetting WHERE fkFrameworkUserID = @fkFrameworkUserID)
	BEGIN

		UPDATE FormUserSetting 
		SET fkActiveAutofill = @fkAutofillID
		WHERE fkFrameworkUserID = @fkFrameworkUserID

	END
	ELSE
	BEGIN
	
		INSERT INTO FormUserSetting
		(
				  fkFrameworkUserID
				, fkActiveAutofill
		)
		VALUES
		(
				  @fkFrameworkUserID
				, @fkAutofillID
		)

	END