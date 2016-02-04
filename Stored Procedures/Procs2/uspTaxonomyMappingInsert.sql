----------------------------------------------------------------------------
-- Insert a single record into TaxonomyMapping
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspTaxonomyMappingInsert]
(	  @DocTypeID varchar(50)
	, @DocType varchar(100)
	, @DocTypeGroup varchar(100)
	, @DocExamples varchar(MAX)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkTaxonomyMapping decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT TaxonomyMapping
(	  DocTypeID
	, DocType
	, DocTypeGroup
	, DocExamples
)
VALUES 
(	  @DocTypeID
	, @DocType
	, @DocTypeGroup
	, @DocExamples

)

SET @pkTaxonomyMapping = SCOPE_IDENTITY()