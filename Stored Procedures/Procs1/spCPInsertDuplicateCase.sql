
Create PROCEDURE [dbo].[spCPInsertDuplicateCase] 
(
	@fkCPClientCaseMain decimal,
	@fkCPClientCaseDuplicate decimal
)

AS

SET NOCOUNT ON

if not exists(select pkDuplicateCases from DuplicateCases 
			  where fkCPClientCaseMain = @fkCPClientCaseMain 
			  and fkCPClientCaseDuplicate = @fkCPClientCaseDuplicate)
	begin
		insert into DuplicateCases
		(
			fkCPClientCaseMain,
			fkCPClientCaseDuplicate
		)
		values
		(
			@fkCPClientCaseMain,
			@fkCPClientCaseDuplicate
		)
	end
