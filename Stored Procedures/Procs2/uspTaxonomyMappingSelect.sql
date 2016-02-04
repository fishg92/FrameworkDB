----------------------------------------------------------------------------
-- Select a single record from TaxonomyMapping
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspTaxonomyMappingSelect]
(	@pkTaxonomyMapping decimal(18, 0) = NULL,
	@DocTypeID varchar(50) = NULL,
	@DocType varchar(100) = NULL,
	@DocTypeGroup varchar(100) = NULL,
	@DocExamples varchar(MAX) = NULL,
	@LUPUser varchar(50) = NULL,
	@LUPDate datetime = NULL,
	@CreateUser varchar(50) = NULL,
	@CreateDate datetime = NULL
)
AS

SELECT	pkTaxonomyMapping,
	DocTypeID,
	DocType,
	DocTypeGroup,
	DocExamples,
	LUPUser,
	LUPDate,
	CreateUser,
	CreateDate
FROM	TaxonomyMapping
WHERE 	(@pkTaxonomyMapping IS NULL OR pkTaxonomyMapping = @pkTaxonomyMapping)
 AND 	(@DocTypeID IS NULL OR DocTypeID LIKE @DocTypeID + '%')
 AND 	(@DocType IS NULL OR DocType LIKE @DocType + '%')
 AND 	(@DocTypeGroup IS NULL OR DocTypeGroup LIKE @DocTypeGroup + '%')
 AND 	(@DocExamples IS NULL OR DocExamples LIKE @DocExamples + '%')
 AND 	(@LUPUser IS NULL OR LUPUser LIKE @LUPUser + '%')
 AND 	(@LUPDate IS NULL OR LUPDate = @LUPDate)
 AND 	(@CreateUser IS NULL OR CreateUser LIKE @CreateUser + '%')
 AND 	(@CreateDate IS NULL OR CreateDate = @CreateDate)