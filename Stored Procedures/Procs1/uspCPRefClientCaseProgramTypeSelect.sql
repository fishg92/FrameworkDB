----------------------------------------------------------------------------
-- Select a single record from CPRefClientCaseProgramType
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPRefClientCaseProgramTypeSelect]
(	@pkCPRefClientCaseProgramType decimal(18, 0) = NULL,
	@Description varchar(100) = NULL)
AS

SELECT	pkCPRefClientCaseProgramType,
	Description
FROM	CPRefClientCaseProgramType
WHERE 	(@pkCPRefClientCaseProgramType IS NULL OR pkCPRefClientCaseProgramType = @pkCPRefClientCaseProgramType)
 AND 	(@Description IS NULL OR Description LIKE @Description + '%')
 
