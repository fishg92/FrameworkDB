-- Stored Procedure

----------------------------------------------------------------------------
-- Update a single record in FormAnnotationGroup
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormAnnotationGroupUpdate]
(	  @pkFormAnnotationGroup decimal(18, 0)
	, @Name varchar(50) = NULL
	, @Description varchar(250) = NULL
	, @Type int = NULL
	, @fkAutofillDataSource decimal(18,0) = NULL
	, @UseAutofillForIndexing bit = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	FormAnnotationGroup
SET	Name = ISNULL(@Name, Name),
	[Description] = ISNULL(@Description, [Description]),
	[Type] = ISNULL(@Type, [Type]),
	fkAutofillDataSource = ISNULL(@fkAutofillDataSource, fkAutofillDataSource),
	UseAutofillForIndexing = ISNULL(@UseAutofillForIndexing, UseAutofillForIndexing)
WHERE 	pkFormAnnotationGroup = @pkFormAnnotationGroup
