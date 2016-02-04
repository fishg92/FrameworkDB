-- Stored Procedure

CREATE PROCEDURE [dbo].[uspFormEditQuickListFolder]
(	  @QuickListFolderName varchar(255)
	, @Description varchar(500)
	, @pkFormQuickListFolder decimal(18,0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

	DECLARE @pkFormQuickListFolderName decimal(18,0)

	IF ISNULL(@QuickListFolderName,'') <> '' 
	BEGIN

		SET @pkFormQuickListFolderName = (SELECT pkFormQuickListFolderName FROM FormQuickListFolderName WHERE QuickListFolderName = @QuickListFolderName)

		IF ISNULL(@pkFormQuickListFolderName,0) = 0 
		BEGIN

			INSERT INTO FormQuickListFolderName
			(	
				  QuickListFolderName
				, [Description]
			)
			VALUES
			(	
				  @QuickListFolderName
				, @Description
			)

			SET @pkFormQuickListFolderName = SCOPE_IDENTITY()
		END

		UPDATE FormQuickListFolder
		SET fkFormQuickListFolderName = @pkFormQuickListFolderName
		WHERE pkFormQuickListFolder = @pkFormQuickListFolder

	END
