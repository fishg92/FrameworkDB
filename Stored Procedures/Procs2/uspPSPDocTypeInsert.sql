----------------------------------------------------------------------------
-- Insert a single record into PSPDocType
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspPSPDocTypeInsert]
(	  @DocName varchar(255)
	, @MatchString varchar(255)
	, @SendToOnBase bit
	, @DMSDocType varchar(50)
	, @DMSDocTypeName varchar(500)
	, @Snapshot varbinary(MAX)
	, @X1 decimal(9, 3)
	, @X2 decimal(9, 3)
	, @Y1 decimal(9, 3)
	, @Y2 decimal(9, 3)
	, @AdjustedX1 decimal(9, 3)
	, @AdjustedX2 decimal(9, 3)
	, @AdjustedY1 decimal(9, 3)
	, @AdjustedY2 decimal(9, 3)
	, @X1Inches decimal(9, 3)
	, @Y1Inches decimal(9, 3)
	, @X2Inches decimal(9, 3)
	, @Y2Inches decimal(9, 3)
	, @RemoveStartCharacters int
	, @RemoveEndCharacters int
	, @IncludeAsKeyword bit
	, @Deleted bit
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @BarcodeDocType varchar(50)
	, @PrintBarcode smallint
	, @RouteDocument smallint
	, @pkPSPDocType decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT PSPDocType
(	  DocName
	, MatchString
	, SendToOnBase
	, DMSDocType
	, DMSDocTypeName
	, [Snapshot]
	, X1
	, X2
	, Y1
	, Y2
	, AdjustedX1
	, AdjustedX2
	, AdjustedY1
	, AdjustedY2
	, X1Inches
	, Y1Inches
	, X2Inches
	, Y2Inches
	, RemoveStartCharacters
	, RemoveEndCharacters
	, IncludeAsKeyword
	, Deleted
	, BarcodeDocType
	, PrintBarcode
	, RouteDocument
)
VALUES 
(	  @DocName
	, @MatchString
	, @SendToOnBase
	, UPPER(@DMSDocType)
	, @DMSDocTypeName
	, @Snapshot
	, @X1
	, @X2
	, @Y1
	, @Y2
	, @AdjustedX1
	, @AdjustedX2
	, @AdjustedY1
	, @AdjustedY2
	, @X1Inches
	, @Y1Inches
	, @X2Inches
	, @Y2Inches
	, @RemoveStartCharacters
	, @RemoveEndCharacters
	, @IncludeAsKeyword
	, @Deleted
	, @BarcodeDocType
	, @PrintBarcode
	, @RouteDocument
)

SET @pkPSPDocType = SCOPE_IDENTITY()
