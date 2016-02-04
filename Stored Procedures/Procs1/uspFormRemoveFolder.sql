-- Stored Procedure

CREATE PROCEDURE [dbo].[uspFormRemoveFolder]
(
	  @fkFormFolder decimal(10, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

	exec dbo.SetAuditDataContext @LupUser, @LupMachine

	DECLARE   @pkFormFolder decimal(10, 0)
			, @Count int
			, @Total int
			, @localNest int

	DECLARE @SubFolder Table
	(	
		  pkSubFolder decimal(10, 0) IDENTITY(1,1) 
		, pkFormFolder decimal(10, 0)
	)

	/* Before we do anything float the nesting level of the procedure call so it cannot be modified
	by any other transactions calling this procedure */
	SET @LocalNest = @@NestLevel

	INSERT INTO @SubFolder
	(	pkFormFolder)
	SELECT pkFormFolder 
	FROM FormFolder 
	WHERE fkFormFolder = @fkFormFolder

	SET @Total = ISNULL((SELECT MAX(pkSubFolder) FROM @SubFolder),0)
	SET @Count = 1 

	WHILE @Count <= @Total
	BEGIN

		SET @pkFormFolder = (SELECT pkFormFolder FROM @SubFolder WHERE pkSubFolder = @Count)

		/* Call this proc recursively to clear off the folders it houses */
		EXEC uspFormRemoveFolder  @pkFormFolder	
								, @LUPUser
								, @LUPMac
								, @LUPIP

		/* associate all forms with the root node (0) */
		UPDATE FormJoinFormFolderFormName
		SET fkFormFolder = 0
		WHERE fkFormFolder = @pkFormFolder

		/* associate all Form Groups with the root node (0) */
		UPDATE FormJoinFormFolderFormGroup
		SET fkFormFolder = 0
		WHERE fkFormFolder = @pkFormFolder	

		/* associate all PSP Forms with the root node (0) */
		UPDATE PSPJoinDocTypeFormFolder
		SET fkFormFolder = 0
		WHERE fkFormFolder = @pkFormFolder

		/* Remove this folder */
		DELETE FormFolder
		WHERE pkFormFolder = @pkFormFolder

		SET @Count = @Count + 1

	END

	/* If we are at the base nesting level, then we can remove the folder passed into the proc 
	as we have cleaned off all of its children already */
	IF @LocalNest = 1 
	BEGIN

		UPDATE FormJoinFormFolderFormName
		SET fkFormFolder = 0
		WHERE fkFormFolder = @fkFormFolder

		UPDATE FormJoinFormFolderFormGroup
		SET fkFormFolder = 0
		WHERE fkFormFolder = @fkFormFolder

		UPDATE PSPJoinDocTypeFormFolder
		SET fkFormFolder = 0
		WHERE fkFormFolder = @fkFormFolder	

		DELETE FormFolder
		WHERE pkFormFolder = @fkFormFolder

	END
