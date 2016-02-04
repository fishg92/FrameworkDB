
----------------------------------------------------------------------------
-- Select a single record from NCPSystem
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspNCPSystemSelect]
(	@pkNCPSystem decimal(10, 0) = NULL,
	@Class varchar(50) = NULL,
	@Attribute varchar(50) = NULL,
	@AttributeValue varchar(255) = NULL
)
AS

SELECT	pkNCPSystem,
	Class,
	Attribute,
	AttributeValue
FROM	NCPSystem
WHERE 	(@pkNCPSystem IS NULL OR pkNCPSystem = @pkNCPSystem)
 AND 	(@Class IS NULL OR Class LIKE Class + '%')
 AND 	(@Attribute IS NULL OR Attribute LIKE Attribute + '%')
 AND 	(@AttributeValue IS NULL OR AttributeValue LIKE AttributeValue + '%')


