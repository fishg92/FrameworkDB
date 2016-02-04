----------------------------------------------------------------------------
-- Select a single record from AutofillSchemaDataViewColumns
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspAutofillSchemaDataViewColumnsSelect]
(	@pkAutofillSchemaDataViewColumns decimal(18, 0) = NULL,
	@fkAutofillSchemaColumns decimal(18, 0) = NULL,
	@fkAutofillSchemaDataView decimal(18, 0) = NULL,
	@FriendlyName varchar(150) = NULL,
	@Visible tinyint = NULL,
	@SortOrder int = NULL,
	@IsUniqueID tinyint = NULL,
	@LUPUser varchar(50) = NULL,
	@LUPDate datetime = NULL,
	@CreateUser varchar(50) = NULL,
	@CreateDate datetime = NULL
)
AS

SELECT	pkAutofillSchemaDataViewColumns,
	fkAutofillSchemaColumns,
	fkAutofillSchemaDataView,
	FriendlyName,
	Visible,
	SortOrder,
	IsUniqueID,
	LUPUser,
	LUPDate,
	CreateUser,
	CreateDate
FROM	AutofillSchemaDataViewColumns
WHERE 	(@pkAutofillSchemaDataViewColumns IS NULL OR pkAutofillSchemaDataViewColumns = @pkAutofillSchemaDataViewColumns)
 AND 	(@fkAutofillSchemaColumns IS NULL OR fkAutofillSchemaColumns = @fkAutofillSchemaColumns)
 AND 	(@fkAutofillSchemaDataView IS NULL OR fkAutofillSchemaDataView = @fkAutofillSchemaDataView)
 AND 	(@FriendlyName IS NULL OR FriendlyName LIKE @FriendlyName + '%')
 AND 	(@Visible IS NULL OR Visible = @Visible)
 AND 	(@SortOrder IS NULL OR SortOrder = @SortOrder)
 AND 	(@IsUniqueID IS NULL OR IsUniqueID = @IsUniqueID)
 AND 	(@LUPUser IS NULL OR LUPUser LIKE @LUPUser + '%')
 AND 	(@LUPDate IS NULL OR LUPDate = @LUPDate)
 AND 	(@CreateUser IS NULL OR CreateUser LIKE @CreateUser + '%')
 AND 	(@CreateDate IS NULL OR CreateDate = @CreateDate)

