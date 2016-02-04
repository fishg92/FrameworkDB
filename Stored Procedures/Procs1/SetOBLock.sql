
CREATE proc [dbo].[SetOBLock]
	@fkApplicationUser decimal(18,0)
as

while exists (	select	*
				from	OBLock
				where	fkApplicationUser = @fkApplicationUser)
begin
	waitfor delay '00:00:01'

	delete	OBLock
	where	fkApplicationUser = @fkApplicationUser
	and		LockTime <= dateadd(second,-30,getdate())
end

insert	OBLock with (rowlock)
	(
		fkApplicationUser
	)
values
	(
		@fkApplicationUser
	)
