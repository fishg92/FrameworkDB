
/*
exec GetEventTypesNamesWithSmartView 1
*/

CREATE PROC [dbo].[GetEventTypesNamesWithSmartView]
(	@pkSmartView decimal(18, 0) = NULL
)
AS

select Description from eventtype
where fkSmartView = @pkSmartView