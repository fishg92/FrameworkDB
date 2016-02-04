----------------------------------------------------------------------------
-- Insert a single record into AutofillSchemaDataViewColumns
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspAutofillSchemaDataViewColumnsInsert]
(	  @fkAutofillSchemaColumns decimal(18, 0)
	, @fkAutofillSchemaDataView decimal(18, 0)
	, @FriendlyName varchar(150)
	, @Visible tinyint
	, @SortOrder int
	, @IsUniqueID tinyint = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkAutofillSchemaDataViewColumns decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT AutofillSchemaDataViewColumns
(	  fkAutofillSchemaColumns
	, fkAutofillSchemaDataView
	, FriendlyName
	, Visible
	, SortOrder
	, IsUniqueID
)
VALUES 
(	  @fkAutofillSchemaColumns
	, @fkAutofillSchemaDataView
	, @FriendlyName
	, @Visible
	, @SortOrder
	, COALESCE(@IsUniqueID, (0))

)

SET @pkAutofillSchemaDataViewColumns = SCOPE_IDENTITY()
