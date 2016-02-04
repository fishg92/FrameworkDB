----------------------------------------------------------------------------
-- Select a single record from JoinSmartViewDocumentType
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinSmartViewDocumentTypeSelect]
(	@pkJoinSmartViewDocumentType decimal(18, 0) = NULL,
	@NumberOfDisplayedDocs int = NULL,
	@NumberOfDaysToDisplay decimal(18, 0) = NULL,
	@fkSmartView decimal(18, 0) = NULL,
	@fkDocumentType varchar(255) = NULL,
	@IncludeInSmartView bit = NULL
)
AS

SELECT	pkJoinSmartViewDocumentType,
	NumberOfDisplayedDocs,
	NumberOfDaysToDisplay,
	fkSmartView,
	fkDocumentType,
	IncludeInSmartView,
	NumberOfMonthsToDisplay,
	NumberOfYearsToDisplay
FROM	JoinSmartViewDocumentType
WHERE 	(@pkJoinSmartViewDocumentType IS NULL OR pkJoinSmartViewDocumentType = @pkJoinSmartViewDocumentType)
 AND 	(@NumberOfDisplayedDocs IS NULL OR NumberOfDisplayedDocs = @NumberOfDisplayedDocs)
 AND 	(@NumberOfDaysToDisplay IS NULL OR NumberOfDaysToDisplay = @NumberOfDaysToDisplay)
 AND 	(@fkSmartView IS NULL OR fkSmartView = @fkSmartView)
 AND 	(@fkDocumentType IS NULL OR fkDocumentType LIKE @fkDocumentType + '%')
 AND 	(@IncludeInSmartView IS NULL OR IncludeInSmartView = @IncludeInSmartView)

