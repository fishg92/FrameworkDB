-- Stored Procedure

CREATE PROCEDURE [dbo].[uspFormQuickListRemoveFolder]
(
	  @fkFormQuickListFolder decimal(10, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

	IF ISNULL(@fkFormQuickListFolder,0) = 0
	BEGIN
		RAISERROR ('Parent folder was not initialized.', 11, 1)
		RETURN
	END

exec dbo.SetAuditDataContext @LupUser, @LupMachine

	DECLARE   @pkFormQuickListFolder decimal(10, 0)
			, @Count int
			, @Total int
			, @LocalNest int

	DECLARE	@SubFolder Table
	(	
		  pkSubFolder decimal(10, 0) IDENTITY(1,1)
		, pkFormQuickListFolder decimal(10, 0)
	)

	/* Before we do anything float the nesting level of the procedure call so it cannot be modified
	by any other transactions calling this procedure */
	SET @LocalNest = @@NestLevel

	INSERT INTO @SubFolder
	(pkFormQuickListFolder)
	SELECT pkFormQuickListFolder 
	FROM FormQuickListFolder 
	WHERE fkFormQuickListFolder = @fkFormQuickListFolder

	SET @Total = ISNULL((SELECT MAX(pkSubFolder) FROM @SubFolder), 0)
	SET @Count = 1 

	WHILE @Count <= @Total
	BEGIN

		SET @pkFormQuickListFolder = (SELECT pkFormQuickListFolder FROM @SubFolder WHERE pkSubFolder = @Count)

		/* Call this proc recursively to clear off the folders it houses */
		EXEC uspFormQuickListRemoveFolder @pkFormQuickListFolder
										, @LUPUser
										, @LUPMac
										, @LUPIP
										, @LUPMachine

		/* associate all forms with the root node (0) */
		UPDATE FormJoinQuickListFormFolderQuickListFormName
		SET fkFormQuickListFolder = 0
		WHERE fkFormQuickListFolder = @pkFormQuickListFolder

		/* Remove this folder */
		DELETE FormQuickListFolder
		WHERE pkFormQuickListFolder = @pkFormQuickListFolder

		SET @Count = @Count + 1
	END

	/* If we are at the base nesting level, then we can remove the folder passed into the proc 
	as we have cleaned off all of its children already */
	IF @LocalNest = 1 
	BEGIN
		UPDATE FormJoinQuickListFormFolderQuickListFormName
		SET fkFormQuickListFolder = 0
		WHERE fkFormQuickListFolder = @fkFormQuickListFolder	

		DELETE FormQuickListFolder
		WHERE pkFormQuickListFolder = @fkFormQuickListFolder
	END
