----------------------------------------------------------------------------
-- Insert a single record into JoinSmartViewDocumentType
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspJoinSmartViewDocumentTypeInsert]
(	  @NumberOfDisplayedDocs int = NULL
	, @NumberOfDaysToDisplay decimal(18, 0) = NULL
	, @NumberOfMonthsToDisplay decimal(18, 0) = NULL
	, @NumberOfYearsToDisplay decimal(18, 0) = NULL
	, @fkSmartView decimal(18, 0)
	, @fkDocumentType varchar(255)
	, @IncludeInSmartView bit
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkJoinSmartViewDocumentType decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT JoinSmartViewDocumentType
(	  NumberOfDisplayedDocs
	, NumberOfDaysToDisplay
	, fkSmartView
	, fkDocumentType
	, IncludeInSmartView
	,NumberOfMonthsToDisplay
	,NumberOfYearsToDisplay
)
VALUES 
(	  COALESCE(@NumberOfDisplayedDocs, (0))
	, COALESCE(@NumberOfDaysToDisplay, (0))
	, @fkSmartView
	, @fkDocumentType
	, @IncludeInSmartView
	, @NumberOfMonthsToDisplay
	, @NumberOfYearsToDisplay

)

SET @pkJoinSmartViewDocumentType = SCOPE_IDENTITY()
