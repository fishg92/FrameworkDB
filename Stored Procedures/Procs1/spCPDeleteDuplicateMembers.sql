
CREATE PROCEDURE [dbo].[spCPDeleteDuplicateMembers] 
(
	@fkCPClientMain decimal
)

AS

SET NOCOUNT ON

delete from DuplicateMembers
where fkCPClientMain = @fkCPClientMain
