-- Stored Procedure

CREATE PROCEDURE [dbo].[uspPSPRemovePSPDocType]
(
	  @fkPSPDocType decimal(18,0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

	UPDATE PSPDocType SET Deleted = 1 WHERE pkPSPDocType = @fkPSPDocType