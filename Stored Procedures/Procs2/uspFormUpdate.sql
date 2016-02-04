-- Stored Procedure

----------------------------------------------------------------------------
-- Update a single record in Form
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormUpdate]
(	  @pkForm int
	, @FormName varchar(500) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	Form
SET	FormName = ISNULL(@FormName, FormName)
WHERE 	pkForm = @pkForm
