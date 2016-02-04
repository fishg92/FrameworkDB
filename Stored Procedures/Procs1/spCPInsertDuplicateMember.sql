
CREATE PROCEDURE [dbo].[spCPInsertDuplicateMember] 
(
	@fkCPClientMain decimal,
	@fkCPClientDuplicate decimal
)

AS

SET NOCOUNT ON

if not exists(select pkDuplicateMembers from DuplicateMembers 
			  where fkCPClientMain = @fkCPClientMain 
			  and fkCPClientDuplicate = @fkCPClientDuplicate)
	begin
		insert into DuplicateMembers
		(
			fkCPClientMain,
			fkCPClientDuplicate
		)
		values
		(
			@fkCPClientMain,
			@fkCPClientDuplicate
		)
	end
