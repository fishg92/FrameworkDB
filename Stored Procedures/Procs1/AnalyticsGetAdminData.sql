
CREATE PROCEDURE [dbo].[AnalyticsGetAdminData]
	
AS
BEGIN
	
	SET NOCOUNT ON;

   select ItemKey, ItemValue, pkConfiguration from dbo.Configuration where appid = 21


END