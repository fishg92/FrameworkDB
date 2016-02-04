----------------------------------------------------------------------------
-- Delete a single record from TaxonomyMapping
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspTaxonomyMappingDelete]
(	@pkTaxonomyMapping decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15) 
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

DELETE	TaxonomyMapping
WHERE 	pkTaxonomyMapping = @pkTaxonomyMapping
