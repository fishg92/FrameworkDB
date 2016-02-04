-- Stored Procedure

CREATE PROCEDURE [dbo].[uspFormEditFormFolder]
(	  @pkFormFolder decimal(18,0)
	, @pkParentFormFolder decimal(10, 0) = NULL
	, @FolderName varchar(255)
	, @Description varchar(500)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

	DECLARE @pkFormFolderName decimal(10, 0)

	IF ISNULL(@FolderName,'') <> '' OR ISNULL(@Description,'') <> ''
	BEGIN

		SET @pkFormFolderName = (SELECT pkFormFolderName FROM FormFolderName WHERE FolderName = @FolderName AND [Description] = @Description)

		IF ISNULL(@pkFormFolderName, 0) = 0 
		BEGIN

			INSERT INTO FormFolderName
			(	
				  FolderName	
				, [Description]
			)
			VALUES
			(
				  @FolderName
				, @Description
			)

			SET @pkFormFolderName = SCOPE_IDENTITY()

		END
	END

	UPDATE FormFolder
	SET fkFormFolder = ISNULL(@pkParentFormFolder, fkFormFolder),
		fkFormFolderName = ISNULL(@pkFormFolderName, fkFormFolderName)
	WHERE pkFormFolder = @pkFormFolder
