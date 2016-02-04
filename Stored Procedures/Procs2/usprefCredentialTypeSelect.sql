----------------------------------------------------------------------------
-- Select a single record from RefCredentialType
----------------------------------------------------------------------------
CREATE PROC [dbo].[usprefCredentialTypeSelect]
(	@pkRefCredentialType decimal(18, 0) = NULL,
	@Description varchar(255) = NULL
)
AS

SELECT	pkRefCredentialType,
	Description
FROM	RefCredentialType
WHERE 	(@pkRefCredentialType IS NULL OR pkRefCredentialType = @pkRefCredentialType)
 AND 	(@Description IS NULL OR Description LIKE @Description + '%')