-- =============================================
-- Author:		Jerrel Blankenship/James Neno
-- Create date: 06/14/2010
-- Description:	Executes AutofillSchema queries
-- =============================================


-- dbo.AutofillSchemaExecuteQuery 'select * from configuration'
CREATE PROCEDURE [dbo].[AutofillSchemaExecuteQuery] 
	-- Add the parameters for the stored procedure here
	@QueryText varchar(max) = ''
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DECLARE @InvalidKeywordFound integer
    set @InvalidKeywordFound = dbo.IsSelectStatementDestructive(@QueryText)
    
    if @InvalidKeywordFound = 0
    begin
		exec(@QueryText)
    end
    else
    begin
		select -99999
    end
END