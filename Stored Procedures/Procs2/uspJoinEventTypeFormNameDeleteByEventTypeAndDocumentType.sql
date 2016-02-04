-- Stored Procedure

----------------------------------------------------------------------------
-- Delete a single record from JoinTransferTypeEventType
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinEventTypeFormNameDeleteByEventTypeAndDocumentType]
(	  @fkEventType decimal(18, 0) = NULL
	, @fkFormName decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15) 
	, @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

		DELETE	JoinEventTypeFormName
		WHERE 	fkFormName = ISNULL(@fkFormName, fkFormName)
		AND		fkEventType = ISNULL(@fkEventType, fkEventType)
