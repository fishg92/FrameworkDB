-- Stored Procedure

----------------------------------------------------------------------------
-- Update a single record in SavedQueryCriteria
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspSavedQueryCriteriaUpdate]
(	  @pkSavedQueryCriteria decimal(10, 0)
	, @fkSavedQuery decimal(10, 0) = NULL
	, @fkKeyword varchar(50) = NULL
	, @KeywordValue varchar(50) = NULL
	, @KeywordStartDate smalldatetime = NULL
	, @KeywordEndDate smalldatetime = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	SavedQueryCriteria
SET	fkSavedQuery = ISNULL(@fkSavedQuery, fkSavedQuery),
	fkKeyword = ISNULL(@fkKeyword, fkKeyword),
	KeywordValue = ISNULL(@KeywordValue, KeywordValue),
	KeywordStartDate = ISNULL(@KeywordStartDate, KeywordStartDate),
	KeywordEndDate = ISNULL(@KeywordEndDate, KeywordEndDate)
WHERE 	pkSavedQueryCriteria = @pkSavedQueryCriteria
