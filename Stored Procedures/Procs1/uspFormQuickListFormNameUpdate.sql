-- Stored Procedure

----------------------------------------------------------------------------
-- Update a single record in FormQuickListFormName
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormQuickListFormNameUpdate]
(	  @pkFormQuickListFormName decimal(10, 0)
	, @fkFormName decimal(10, 0) = NULL
	, @fkFormUser decimal(10, 0) = NULL
	, @QuickListFormName varchar(255) = NULL
	, @DateAdded smalldatetime = NULL
	, @Inactive tinyint = NULL
	, @FormOrder int = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	FormQuickListFormName
SET	fkFormName = ISNULL(@fkFormName, fkFormName),
	fkFormUser = ISNULL(@fkFormUser, fkFormUser),
	QuickListFormName = ISNULL(@QuickListFormName, QuickListFormName),
	DateAdded = ISNULL(COALESCE(@DateAdded, getdate()), DateAdded),
	Inactive = ISNULL(COALESCE(@Inactive, 0), Inactive),
	FormOrder = ISNULL(@FormOrder, FormOrder)
WHERE 	pkFormQuickListFormName = @pkFormQuickListFormName
