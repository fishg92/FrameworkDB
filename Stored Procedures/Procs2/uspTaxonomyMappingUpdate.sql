----------------------------------------------------------------------------
-- Update a single record in TaxonomyMapping
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspTaxonomyMappingUpdate]
(	  @pkTaxonomyMapping decimal(18, 0)
	, @DocTypeID varchar(50) = NULL
	, @DocType varchar(100) = NULL
	, @DocTypeGroup varchar(100) = NULL
	, @DocExamples varchar(MAX) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	TaxonomyMapping
SET	DocTypeID = ISNULL(@DocTypeID, DocTypeID),
	DocType = ISNULL(@DocType, DocType),
	DocTypeGroup = ISNULL(@DocTypeGroup, DocTypeGroup),
	DocExamples = ISNULL(@DocExamples, DocExamples)
WHERE 	pkTaxonomyMapping = @pkTaxonomyMapping