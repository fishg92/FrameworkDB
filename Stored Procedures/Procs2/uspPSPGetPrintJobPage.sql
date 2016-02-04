CREATE PROCEDURE [dbo].[uspPSPGetPrintJobPage]
(
	  @fkPSPPrintJob decimal(18,0)
	, @PageNumber int
	, @Image varbinary(max) OUTPUT
)
AS

	SELECT @Image = PageData
	FROM PSPPrintJobPage
	WHERE fkPSPPrintJob = @fkPSPPrintJob
	AND PageNumber = @PageNumber