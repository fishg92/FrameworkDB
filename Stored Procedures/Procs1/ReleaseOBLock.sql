
create proc [dbo].[ReleaseOBLock]
	@fkApplicationUser decimal(18,0)
as

delete	OBLock
where	fkApplicationUser = @fkApplicationUser
