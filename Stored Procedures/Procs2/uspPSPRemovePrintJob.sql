CREATE PROCEDURE [dbo].[uspPSPRemovePrintJob]
(
	@pkPSPPrintJob decimal(18,0)
)
AS

	DELETE FROM PSPPrintJob WHERE pkPSPPrintJob = @pkPSPPrintJob
	DELETE FROM PSPPrintJobPage WHERE fkPSPPrintJob = @pkPSPPrintJob
	DELETE FROM PSPPrintJobIndexValue WHERE fkPSPPrintJob = @pkPSPPrintJob