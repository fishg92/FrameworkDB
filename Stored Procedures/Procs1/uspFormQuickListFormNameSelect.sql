
----------------------------------------------------------------------------
-- Select a single record from FormQuickListFormName
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormQuickListFormNameSelect]
(	@pkFormQuickListFormName decimal(10, 0) = NULL,
	@fkFormName decimal(10, 0) = NULL,
	@fkFormUser decimal(10, 0) = NULL,
	@QuickListFormName varchar(255) = NULL,
	@DateAdded smalldatetime = NULL,
	@Inactive tinyint = NULL,
	@FormOrder int = NULL
)
AS

SELECT	pkFormQuickListFormName,
	fkFormName,
	fkFormUser,
	QuickListFormName,
	DateAdded,
	Inactive,
	FormOrder
	
FROM	FormQuickListFormName
WHERE 	(@pkFormQuickListFormName IS NULL OR pkFormQuickListFormName = @pkFormQuickListFormName)
 AND 	(@fkFormName IS NULL OR fkFormName = @fkFormName)
 AND 	(@fkFormUser IS NULL OR fkFormUser = @fkFormUser)
 AND 	(@QuickListFormName IS NULL OR QuickListFormName LIKE @QuickListFormName + '%')
 AND 	(@DateAdded IS NULL OR DateAdded = @DateAdded)
 AND 	(@Inactive IS NULL OR Inactive = @Inactive)
 AND 	(@FormOrder IS NULL OR FormOrder = @FormOrder)

