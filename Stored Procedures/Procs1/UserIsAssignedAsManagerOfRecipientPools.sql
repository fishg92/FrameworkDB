
--UserIsAssignedAsManagerOfRecipientPools 1

CREATE PROC [dbo].[UserIsAssignedAsManagerOfRecipientPools]
(	
	@pkApplicationUser decimal(18, 0) 
)
AS

declare @ret tinyint
set @ret = 0

if exists (select * from JoinRecipientPoolManager 
 where fkApplicationUser = @pkApplicationUser) BEGIN
	set @ret = 1 
END
 
select @ret