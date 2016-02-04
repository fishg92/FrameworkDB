-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into SavedQueryCriteria
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspSavedQueryCriteriaInsert]
(	  @fkSavedQuery decimal(10, 0)
	, @fkKeyword varchar(50)
	, @KeywordValue varchar(50) = NULL
	, @KeywordStartDate smalldatetime = NULL
	, @KeywordEndDate smalldatetime = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	, @pkSavedQueryCriteria decimal(10, 0) = NULL OUTPUT 
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT SavedQueryCriteria
(	  fkSavedQuery
	, fkKeyword
	, KeywordValue
	, KeywordStartDate
	, KeywordEndDate
)
VALUES 
(	  @fkSavedQuery
	, @fkKeyword
	, @KeywordValue
	, @KeywordStartDate
	, @KeywordEndDate

)

SET @pkSavedQueryCriteria = SCOPE_IDENTITY()
