----------------------------------------------------------------------------
-- Update a single record in PSPDocType
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspPSPDocTypeUpdate]
(	  @pkPSPDocType decimal(18, 0)
	, @DocName varchar(255) = NULL
	, @MatchString varchar(255) = NULL
	, @SendToOnBase bit = NULL
	, @DMSDocType varchar(50) = NULL
	, @DMSDocTypeName varchar(500) = NULL
	, @Snapshot varbinary(MAX) = NULL
	, @X1 decimal(9, 3) = NULL
	, @X2 decimal(9, 3) = NULL
	, @Y1 decimal(9, 3) = NULL
	, @Y2 decimal(9, 3) = NULL
	, @AdjustedX1 decimal(9, 3) = NULL
	, @AdjustedX2 decimal(9, 3) = NULL
	, @AdjustedY1 decimal(9, 3) = NULL
	, @AdjustedY2 decimal(9, 3) = NULL
	, @X1Inches decimal(9, 3) = NULL
	, @Y1Inches decimal(9, 3) = NULL
	, @X2Inches decimal(9, 3) = NULL
	, @Y2Inches decimal(9, 3) = NULL
	, @RemoveStartCharacters int = NULL
	, @RemoveEndCharacters int = NULL
	, @IncludeAsKeyword bit = NULL
	, @Deleted bit = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @BarcodeDocType varchar(50) = NULL
	, @PrintBarcode smallint = NULL
	, @RouteDocument smallint = NULL
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	PSPDocType
SET	DocName = ISNULL(@DocName, DocName),
	MatchString = ISNULL(@MatchString, MatchString),
	SendToOnBase = ISNULL(@SendToOnBase, SendToOnBase),
	DMSDocType = ISNULL(UPPER(@DMSDocType), DMSDocType),
	DMSDocTypeName = ISNULL(@DMSDocTypeName, DMSDocTypeName),
	[Snapshot] = ISNULL(@Snapshot, [Snapshot]),
	X1 = ISNULL(@X1, X1),
	X2 = ISNULL(@X2, X2),
	Y1 = ISNULL(@Y1, Y1),
	Y2 = ISNULL(@Y2, Y2),
	AdjustedX1 = ISNULL(@AdjustedX1, AdjustedX1),
	AdjustedX2 = ISNULL(@AdjustedX2, AdjustedX2),
	AdjustedY1 = ISNULL(@AdjustedY1, AdjustedY1),
	AdjustedY2 = ISNULL(@AdjustedY2, AdjustedY2),
	X1Inches = ISNULL(@X1Inches, X1Inches),
	Y1Inches = ISNULL(@Y1Inches, Y1Inches),
	X2Inches = ISNULL(@X2Inches, X2Inches),
	Y2Inches = ISNULL(@Y2Inches, Y2Inches),
	RemoveStartCharacters = ISNULL(@RemoveStartCharacters, RemoveStartCharacters),
	RemoveEndCharacters = ISNULL(@RemoveEndCharacters, RemoveEndCharacters),
	IncludeAsKeyword = ISNULL(@IncludeAsKeyword, IncludeAsKeyword),
	Deleted = ISNULL(@Deleted, Deleted),
	BarcodeDocType = ISNULL(@BarcodeDocType, BarcodeDocType),
	PrintBarcode = ISNULL(@PrintBarcode, PrintBarcode),
	RouteDocument = ISNULL(@RouteDocument, RouteDocument)
WHERE 	pkPSPDocType = @pkPSPDocType
