

----------------------------------------------------------------------------
-- Insert a single record into CPPointInTimeSearchSetting
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspCPPointInTimeSearchSettingInsert]
(	  @fkDocumentType varchar(50)
	, @DaysBefore int
	, @DaysAfter int
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkCPPointInTimeSearchSetting decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT CPPointInTimeSearchSetting
(	  fkDocumentType
	, DaysBefore
	, DaysAfter
)
VALUES 
(	  @fkDocumentType
	, @DaysBefore
	, @DaysAfter

)

SET @pkCPPointInTimeSearchSetting = SCOPE_IDENTITY()
