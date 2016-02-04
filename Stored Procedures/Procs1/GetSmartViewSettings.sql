/*----------------------------------------------------------------------------

exec GetSmartViewSettings -1

----------------------------------------------------------------------------*/
CREATE PROC [dbo].[GetSmartViewSettings]
(	@pkSmartView decimal(18, 0) = -1
	,@fkDocumentType varchar(255) = ''
	,@isDefault bit = null
)
AS

	
select 
 j.pkJoinSmartViewDocumentType
,j.NumberOfDisplayedDocs
,j.NumberOfDaysToDisplay
,j.IncludeInSmartView
,j.fkDocumentType
,j.fkSmartView
,j.NumberOfMonthsToDisplay
,j.NumberOfYearsToDisplay
from SmartView sv
inner join JoinSmartViewDocumentType j
	on sv.pkSmartView = j.fkSmartView
where 
(sv.pkSmartView = @pkSmartView or @pkSmartView = -1)
and (j.fkDocumentType = @fkDocumentType or @fkDocumentType = '')
and (sv.isDefault = @isDefault or @isDefault is null)
