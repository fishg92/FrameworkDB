-- Stored Procedure

/*
uspJoinSmartViewDocumentTypeInsertCustom
 0
 ,1
 ,9
 ,-42
 ,1
 ,'1'
 ,'mac'
 ,'ip'
 ,'machine'
 */

----------------------------------------------------------------------------
-- Insert a single record into JoinSmartViewDocumentType if join doesn't already exist for that doc type and smart view
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinSmartViewDocumentTypeInsertCustom]
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

	IF not exists (select * from JoinSmartViewDocumentType where fkSmartView = @fkSmartView	
				and fkDocumentType = @fkDocumentType)
		begin

			exec dbo.uspJoinSmartViewDocumentTypeInsert
				@NumberOfDisplayedDocs
				, @NumberOfDaysToDisplay 
				, @NumberOfMonthsToDisplay
				, @NumberOfYearsToDisplay
				, @fkSmartView 
				, @fkDocumentType
				, @IncludeInSmartView
				, @LUPUser 
				, @LUPMac 
				, @LUPIP 
				, @LUPMachine 
				, @pkJoinSmartViewDocumentType  OUTPUT 
		end


SET @pkJoinSmartViewDocumentType = SCOPE_IDENTITY()
