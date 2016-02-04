
----------------------------------------------------------------------------
-- Select a single record from AutoPopulateKeyword
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspAutoPopulateKeywordSelect]
(	@pkAutoPopulateKeyword decimal(18, 0) = NULL,
	@fkKeyword varchar(50) = NULL,
	@ValueID smallint = NULL,
	@CanBeOverridden bit = NULL
)
AS

SELECT	pkAutoPopulateKeyword,
	fkKeyword,
	ValueID,
	CanBeOverridden
FROM	AutoPopulateKeyword
WHERE 	(@pkAutoPopulateKeyword IS NULL OR pkAutoPopulateKeyword = @pkAutoPopulateKeyword)
 AND 	(@fkKeyword IS NULL OR fkKeyword = @fkKeyword)
 AND 	(@ValueID IS NULL OR ValueID = @ValueID)
 AND 	(@CanBeOverridden IS NULL OR CanBeOverridden = @CanBeOverridden)
 

