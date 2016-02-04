-- Stored Procedure

CREATE PROCEDURE [dbo].[uspPSPAddPSPDocTypeToFormFolder]
(
	  @fkFormFolder decimal(18, 0)
	, @fkPSPDocType decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	, @pkPSPJoinDocTypeFormFolder decimal(18, 0) OUTPUT
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

	-- First delete our existing join record, if any
	DELETE FROM PSPJoinDocTypeFormFolder
	WHERE fkPSPDocType = @fkPSPDocType

	--Next, add in the join record to tie the doc type to this folder
	INSERT INTO PSPJoinDocTypeFormFolder
	(	
		  fkFormFolder
		, fkPSPDocType
	)
	VALUES
	(	
		  @fkFormFolder
		, @fkPSPDocType
	)

	SET @pkPSPJoinDocTypeFormFolder = SCOPE_IDENTITY()
