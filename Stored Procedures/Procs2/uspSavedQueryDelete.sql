-- Stored Procedure

----------------------------------------------------------------------------
-- Delete a single record from SavedQuery
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspSavedQueryDelete]
(	@pkSavedQuery int
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

delete	SavedQueryCriteria
where	fkSavedQuery = @pkSavedQuery

DELETE	SavedQuery
WHERE 	pkSavedQuery = @pkSavedQuery
