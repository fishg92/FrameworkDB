-- Stored Procedure

----------------------------------------------------------------------------
-- Delete a single record from FormAnnotationValue
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspFormAnnotationValueDelete]
(	@pkFormAnnotationValue decimal(10, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

DELETE	FormAnnotationValue
WHERE 	pkFormAnnotationValue = @pkFormAnnotationValue
