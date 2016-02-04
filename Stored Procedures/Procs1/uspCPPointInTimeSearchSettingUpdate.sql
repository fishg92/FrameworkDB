

----------------------------------------------------------------------------
-- Update a single record in CPPointInTimeSearchSetting
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPPointInTimeSearchSettingUpdate]
(	  @pkCPPointInTimeSearchSetting decimal(18, 0)
	, @fkDocumentType varchar(50) = NULL
	, @DaysBefore int = NULL
	, @DaysAfter int = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	CPPointInTimeSearchSetting
SET	fkDocumentType = ISNULL(@fkDocumentType, fkDocumentType),
	DaysBefore = ISNULL(@DaysBefore, DaysBefore),
	DaysAfter = ISNULL(@DaysAfter, DaysAfter)
WHERE 	pkCPPointInTimeSearchSetting = @pkCPPointInTimeSearchSetting
