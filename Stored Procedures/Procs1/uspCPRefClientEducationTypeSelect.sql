----------------------------------------------------------------------------
-- Select a single record from CPRefClientEducationType
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPRefClientEducationTypeSelect]
(	@pkCPRefClientEducationType decimal(18, 0) = NULL,
	@Description varchar(255) = NULL
)
AS

SELECT	pkCPRefClientEducationType,
	Description
FROM	CPRefClientEducationType
WHERE 	(@pkCPRefClientEducationType IS NULL OR pkCPRefClientEducationType = @pkCPRefClientEducationType)
 AND 	(@Description IS NULL OR Description LIKE @Description + '%')

