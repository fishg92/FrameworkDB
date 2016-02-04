

----------------------------------------------------------------------------
-- Select a single record from CPPointInTimeSearchSetting
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPPointInTimeSearchSettingSelect]
(	@pkCPPointInTimeSearchSetting decimal(18, 0) = NULL,
	@fkDocumentType varchar(50) = NULL,
	@DaysBefore int = NULL,
	@DaysAfter int = NULL
)
AS

SELECT	pkCPPointInTimeSearchSetting,
	fkDocumentType,
	DaysBefore,
	DaysAfter
FROM	CPPointInTimeSearchSetting
WHERE 	(@pkCPPointInTimeSearchSetting IS NULL OR pkCPPointInTimeSearchSetting = @pkCPPointInTimeSearchSetting)
 AND 	(@fkDocumentType IS NULL OR fkDocumentType = @fkDocumentType)
 AND 	(@DaysBefore IS NULL OR DaysBefore = @DaysBefore)
 AND 	(@DaysAfter IS NULL OR DaysAfter = @DaysAfter)



