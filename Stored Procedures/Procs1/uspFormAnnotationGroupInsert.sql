-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into FormAnnotationGroup
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspFormAnnotationGroupInsert]
(	  @Name varchar(50)
	, @Description varchar(250) = NULL
	, @Type int
	, @fkAutofillDataSource decimal(18,0) = NULL
	, @UseAutofillForIndexing bit = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	, @pkFormAnnotationGroup decimal(18, 0) = NULL OUTPUT 
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT FormAnnotationGroup
(	  Name
	, [Description]
	, [Type]
	, fkAutofillDataSource
	, UseAutofillForIndexing
)
VALUES 
(	  @Name
	, @Description
	, @Type
	, @fkAutofillDataSource
	, @UseAutofillForIndexing
)

SET @pkFormAnnotationGroup = SCOPE_IDENTITY()
