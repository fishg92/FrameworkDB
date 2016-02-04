----------------------------------------------------------------------------
-- Update a single record in AutofillSchemaDataViewColumns
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspAutofillSchemaDataViewColumnsUpdate]
(	  @pkAutofillSchemaDataViewColumns decimal(18, 0)
	, @fkAutofillSchemaColumns decimal(18, 0) = NULL
	, @fkAutofillSchemaDataView decimal(18, 0) = NULL
	, @FriendlyName varchar(150) = NULL
	, @Visible tinyint = NULL
	, @SortOrder int = NULL
	, @IsUniqueID tinyint = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	AutofillSchemaDataViewColumns
SET	fkAutofillSchemaColumns = ISNULL(@fkAutofillSchemaColumns, fkAutofillSchemaColumns),
	fkAutofillSchemaDataView = ISNULL(@fkAutofillSchemaDataView, fkAutofillSchemaDataView),
	FriendlyName = ISNULL(@FriendlyName, FriendlyName),
	Visible = ISNULL(@Visible, Visible),
	SortOrder = ISNULL(@SortOrder, SortOrder),
	IsUniqueID = ISNULL(@IsUniqueID, IsUniqueID)
WHERE 	pkAutofillSchemaDataViewColumns = @pkAutofillSchemaDataViewColumns
