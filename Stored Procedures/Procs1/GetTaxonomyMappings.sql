


Create PROC [dbo].[GetTaxonomyMappings]
AS

SELECT
	pkTaxonomyMapping, DocTypeID, DocType, DocTypeGroup, DocExamples
FROM TaxonomyMapping
order by DocTypeGroup, DocType

