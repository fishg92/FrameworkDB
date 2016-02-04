----------------------------------------------------------------------------
-- Select a single record from CPCaseWorkerPhone
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPCaseWorkerPhoneSelect]
(	@pkCPCaseWorkerPhone decimal(18, 0) = NULL,
	@fkCPRefPhoneType decimal(18, 0) = NULL,
	@Number varchar(10) = NULL,
	@Extension varchar(10) = NULL
)
AS

SELECT	pkCPCaseWorkerPhone,
	fkCPRefPhoneType,
	Number,
	Extension
FROM	CPCaseWorkerPhone
WHERE 	(@pkCPCaseWorkerPhone IS NULL OR pkCPCaseWorkerPhone = @pkCPCaseWorkerPhone)
 AND 	(@fkCPRefPhoneType IS NULL OR fkCPRefPhoneType = @fkCPRefPhoneType)
 AND 	(@Number IS NULL OR Number LIKE @Number + '%')
 AND 	(@Extension IS NULL OR Extension LIKE @Extension + '%')
