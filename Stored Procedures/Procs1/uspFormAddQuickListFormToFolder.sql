-- Stored Procedure

CREATE PROCEDURE [dbo].[uspFormAddQuickListFormToFolder]
(	  @fkFormQuickListFolderMoveTo decimal(18, 0)
	, @fkFormQuickListFolderMoveFrom decimal(18, 0)
	, @fkFormQuickListFormName decimal(18, 0)
	, @Copy tinyint = 0
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	, @pkFormJoinQuickListFormFolderQuickListFormName decimal(18, 0) OUTPUT
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

	/* By default the user will "Move" the files around by removing them from one folder
	and adding them to a new folder, should they choose to "Copy" the form, it will leave
	a copy of the form in its existing folder */

	IF ISNULL(@Copy,0) = 0 
	BEGIN
		DELETE FROM FormJoinQuickListFormFolderQuickListFormName
		WHERE fkFormQuickListFolder = @fkFormQuickListFolderMoveFrom
		AND fkFormQuickListFormName = @fkFormQuickListFormName
	END

	INSERT INTO FormJoinQuickListFormFolderQuickListFormName
	(	
		  fkFormQuickListFolder
		, fkFormQuickListFormName
	)
	VALUES
	(	
		  @fkFormQuickListFolderMoveTo
		, @fkFormQuickListFormName
	)

	SET @pkFormJoinQuickListFormFolderQuickListFormName = SCOPE_IDENTITY()
