-- Stored Procedure

----------------------------------------------------------------------------
-- Delete a single record from SavedQueryCriteria
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspSavedQueryCriteriaDelete]
(	@pkSavedQueryCriteria int
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

DELETE	SavedQueryCriteria
WHERE 	pkSavedQueryCriteria = @pkSavedQueryCriteria
