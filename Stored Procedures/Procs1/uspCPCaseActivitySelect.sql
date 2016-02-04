----------------------------------------------------------------------------
-- Select a single record from CPCaseActivity
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPCaseActivitySelect]
(	@pkCPCaseActivity decimal(18, 0) = NULL,
	@fkCPCaseActivityType decimal(18, 0) = NULL,
	@fkCPClientCase decimal(18, 0) = NULL,
	@Description varchar(MAX) = NULL,
	@fkCPClient decimal(18, 0) = NULL
)
AS

SELECT	pkCPCaseActivity,
	fkCPCaseActivityType,
	fkCPClientCase,
	Description,
	fkCPClient
FROM	CPCaseActivity
WHERE 	(@pkCPCaseActivity IS NULL OR pkCPCaseActivity = @pkCPCaseActivity)
 AND 	(@fkCPCaseActivityType IS NULL OR fkCPCaseActivityType = @fkCPCaseActivityType)
 AND 	(@fkCPClientCase IS NULL OR fkCPClientCase = @fkCPClientCase)
 AND 	(@Description IS NULL OR Description LIKE @Description + '%')
 AND 	(@fkCPClient IS NULL OR fkCPClient = @fkCPClient)

