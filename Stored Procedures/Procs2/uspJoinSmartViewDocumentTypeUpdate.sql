----------------------------------------------------------------------------
-- Update a single record in JoinSmartViewDocumentType
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinSmartViewDocumentTypeUpdate]
(	  @pkJoinSmartViewDocumentType decimal(18, 0)
	, @NumberOfDisplayedDocs int = NULL
	, @NumberOfDaysToDisplay decimal(18, 0) = NULL
	, @NumberOfMonthsToDisplay decimal(18, 0) = NULL
	, @NumberOfYearsToDisplay decimal(18, 0) = NULL
	, @fkSmartView decimal(18, 0) = NULL
	, @fkDocumentType varchar(255) = NULL
	, @IncludeInSmartView bit = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	JoinSmartViewDocumentType
SET	NumberOfDisplayedDocs = ISNULL(@NumberOfDisplayedDocs, NumberOfDisplayedDocs),
	NumberOfDaysToDisplay = ISNULL(@NumberOfDaysToDisplay, NumberOfDaysToDisplay),
	fkSmartView = ISNULL(@fkSmartView, fkSmartView),
	fkDocumentType = ISNULL(@fkDocumentType, fkDocumentType),
	IncludeInSmartView = ISNULL(@IncludeInSmartView, IncludeInSmartView),
	NumberOfMonthsToDisplay = ISNULL(@NumberOfMonthsToDisplay, NumberOfMonthsToDisplay),
	NumberOfYearsToDisplay = ISNULL(@NumberOfYearsToDisplay, NumberOfYearsToDisplay)
WHERE 	pkJoinSmartViewDocumentType = @pkJoinSmartViewDocumentType
