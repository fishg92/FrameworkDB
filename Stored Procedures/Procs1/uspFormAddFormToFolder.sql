-- Stored Procedure

CREATE PROCEDURE [dbo].[uspFormAddFormToFolder]
(	  @fkFormFolder decimal(18, 0)
	, @fkFormName decimal(18, 0)
	, @CurrentpkFormFolder decimal(18,0)
	, @Copy tinyint = 0
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	, @pkFormJoinFormFolderFormName decimal(18, 0) output
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

	IF @Copy = 0 
	BEGIN

		DELETE FROM FormJoinFormFolderFormName 
		WHERE fkFormName = @fkFormName
		--AND fkFormFolder = @CurrentpkFormFolder

	END

	INSERT INTO FormJoinFormFolderFormName
	(	
		  fkFormFolder
		, fkFormName
	)
	VALUES
	(	
		  @fkFormFolder
		, @fkFormName
	)

	SET @pkFormJoinFormFolderFormName = SCOPE_IDENTITY()
