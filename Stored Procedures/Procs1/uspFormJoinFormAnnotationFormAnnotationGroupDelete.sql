-- Stored Procedure

----------------------------------------------------------------------------
-- Delete a single record from FormJoinFormAnnotationFormAnnotationGroup
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspFormJoinFormAnnotationFormAnnotationGroupDelete]
(	@pkFormJoinFormAnnotationFormAnnotationGroup decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

DELETE	FormJoinFormAnnotationFormAnnotationGroup
WHERE 	pkFormJoinFormAnnotationFormAnnotationGroup = @pkFormJoinFormAnnotationFormAnnotationGroup
