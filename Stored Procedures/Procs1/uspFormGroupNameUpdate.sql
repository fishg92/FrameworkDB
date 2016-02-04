-- Stored Procedure

----------------------------------------------------------------------------
-- Update a single record in FormGroupName
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormGroupNameUpdate]
(	  @pkFormGroupName int
	, @Name varchar(255) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	FormGroupName
SET	Name = ISNULL(@Name, Name)
WHERE 	pkFormGroupName = @pkFormGroupName
