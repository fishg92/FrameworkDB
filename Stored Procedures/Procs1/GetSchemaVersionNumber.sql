-- =============================================
-- Author:		James Neno
-- Create date: 1/29/2010
-- Description:	Returns the schema version number
-- =============================================
CREATE PROCEDURE [dbo].[GetSchemaVersionNumber]
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select '3.63.0.0'

END