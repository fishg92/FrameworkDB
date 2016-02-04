-- Stored Procedure

----------------------------------------------------------------------------
-- Update a single record in FormPath
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormPathUpdate]
(	  @pkFormPath decimal(10, 0)
	, @fkFormName decimal(10, 0) = NULL
	, @Path varchar(500) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	FormPath
SET	fkFormName = ISNULL(@fkFormName, fkFormName),
	Path = ISNULL(@Path, Path)
WHERE 	pkFormPath = @pkFormPath
