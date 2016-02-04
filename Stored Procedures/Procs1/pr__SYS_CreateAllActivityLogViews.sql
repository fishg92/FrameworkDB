
create proc pr__SYS_CreateAllActivityLogViews
as

declare @pkrefActivityType decimal

declare crActivity insensitive cursor for
select pkrefActivityType from refActivityType
open crActivity
fetch next from crActivity into @pkrefActivityType
while @@fetch_status=0
	begin
	exec dbo.pr__SYS_CreateActivityLogView
		@pkrefActivityType = @pkrefActivityType
		,@exec =1
	fetch next from crActivity into @pkrefActivityType
	end

close crActivity
deallocate crActivity

