create proc [dbo].[DocTypeUpdateStarted]
	@fkApplicationUser decimal
as

update	DocumentDocTypeCache
set		RefreshStarted = getdate()
where	fkApplicationUser = @fkApplicationUser