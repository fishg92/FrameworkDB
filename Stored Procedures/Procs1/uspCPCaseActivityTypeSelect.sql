----------------------------------------------------------------------------
-- Select a single record from CPCaseActivityType
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPCaseActivityTypeSelect]
	@pkCPCaseActivityType decimal(18, 0) = NULL,
	@Description varchar(100) = NULL

AS

SELECT	pkCPCaseActivityType,
	Description
FROM	CPCaseActivityType
WHERE 	(@pkCPCaseActivityType IS NULL OR pkCPCaseActivityType = @pkCPCaseActivityType)
 AND 	(@Description IS NULL OR Description LIKE @Description + '%')

