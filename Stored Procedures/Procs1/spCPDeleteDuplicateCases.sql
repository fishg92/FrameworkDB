
Create PROCEDURE [dbo].[spCPDeleteDuplicateCases] 
(
	@fkCPClientCaseMain decimal
)

AS

SET NOCOUNT ON

delete from DuplicateCases
where fkCPClientCaseMain = @fkCPClientCaseMain
