----------------------------------------------------------------------------
-- Select a single record from SmartView
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspSmartViewSelect]
(	@pkSmartView decimal(18, 0) = NULL,
	@Description varchar(100) = NULL,
	@IsDefault bit = NULL
)
AS

SELECT	pkSmartView,
	Description,
	IsDefault
FROM	SmartView
WHERE 	(@pkSmartView IS NULL OR pkSmartView = @pkSmartView)
 AND 	(@Description IS NULL OR Description LIKE @Description + '%')
 AND 	(@IsDefault IS NULL OR IsDefault = @IsDefault)
