-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into FormQuickListFormName
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspFormQuickListFormNameInsert]
(	  @fkFormName decimal(10, 0)
	, @fkFormUser decimal(10, 0)
	, @QuickListFormName varchar(255)
	, @DateAdded smalldatetime = NULL
	, @Inactive tinyint = NULL
	, @FormOrder int
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	, @pkFormQuickListFormName decimal(10, 0) = NULL OUTPUT 
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT FormQuickListFormName
(	  fkFormName
	, fkFormUser
	, QuickListFormName
	, DateAdded
	, Inactive
	, FormOrder
)
VALUES 
(	  @fkFormName
	, @fkFormUser
	, @QuickListFormName
	, COALESCE(@DateAdded, getdate())
	, COALESCE(@Inactive, 0)
	, @FormOrder

)

SET @pkFormQuickListFormName = SCOPE_IDENTITY()
