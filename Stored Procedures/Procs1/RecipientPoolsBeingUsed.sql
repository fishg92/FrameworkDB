
--UserIsAssignedAsManagerOfRecipientPools 1

Create PROC [dbo].[RecipientPoolsBeingUsed]

AS

declare @ret tinyint
set @ret = 0

if exists (select * from JoinrefRolerefPermission 
 where fkrefPermission = 68) BEGIN
	set @ret = 1 
END
 
select @ret