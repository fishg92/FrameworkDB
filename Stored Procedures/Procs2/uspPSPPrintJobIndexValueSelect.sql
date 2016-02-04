----------------------------------------------------------------------------
-- Select a single record from PSPPrintJobIndexValue
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspPSPPrintJobIndexValueSelect]
(	@pkPSPPrintJobIndexValue decimal(18, 0) = NULL,
	@fkPSPPrintJob decimal(18, 0) = NULL,
	@KeywordName varchar(255) = NULL,
	@KeywordValue varchar(255) = NULL
)
AS

SELECT	pkPSPPrintJobIndexValue,
	fkPSPPrintJob,
	KeywordName,
	KeywordValue
FROM	PSPPrintJobIndexValue
WHERE 	(@pkPSPPrintJobIndexValue IS NULL OR pkPSPPrintJobIndexValue = @pkPSPPrintJobIndexValue)
 AND 	(@fkPSPPrintJob IS NULL OR fkPSPPrintJob = @fkPSPPrintJob)
 AND 	(@KeywordName IS NULL OR KeywordName LIKE @KeywordName + '%')
 AND 	(@KeywordValue IS NULL OR KeywordValue LIKE @KeywordValue + '%')
