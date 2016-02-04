-- Stored Procedure

----------------------------------------------------------------------------
-- Update a single record in SavedQuery
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspSavedQueryUpdate]
(	  @pkSavedQuery decimal(10, 0)
	, @fkApplicationUser decimal(10, 0) 
	, @QueryName varchar(255)
	, @ExpirationDate smalldatetime = NULL
	, @Notes varchar(500)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	SavedQuery
SET	fkApplicationUser = ISNULL(@fkApplicationUser, fkApplicationUser),
	QueryName = ISNULL(@QueryName, QueryName),
	ExpirationDate = @ExpirationDate
	,Notes = @Notes
WHERE 	pkSavedQuery = @pkSavedQuery
