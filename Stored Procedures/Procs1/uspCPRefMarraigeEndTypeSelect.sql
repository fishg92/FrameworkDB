----------------------------------------------------------------------------
-- Select a single record from CPRefMarraigeEndType
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPRefMarraigeEndTypeSelect]
(	@pkCPRefMarraigeEndType decimal(18, 0) = NULL,
	@Description varchar(100) = NULL
)
AS

SELECT	pkCPRefMarraigeEndType,
	Description
FROM	CPRefMarraigeEndType
WHERE 	(@pkCPRefMarraigeEndType IS NULL OR pkCPRefMarraigeEndType = @pkCPRefMarraigeEndType)
 AND 	(@Description IS NULL OR Description LIKE @Description + '%')

