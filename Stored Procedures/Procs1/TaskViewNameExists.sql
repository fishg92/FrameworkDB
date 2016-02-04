CREATE proc [dbo].[TaskViewNameExists]
	@pkTaskView decimal
	,@fkApplicationUser decimal
	,@ViewName varchar(100)
	,@IsGlobal bit
as

declare @NameExists bit
set @NameExists = 0

--For global views we have to look at all other global views
if exists (	select	*
			from	TaskView
			where	IsGlobal = 1
			and		ViewName = @ViewName
			and		pkTaskView <> @pkTaskView)
	begin
	set @NameExists = 1
	end

if @IsGlobal = 0
	begin
	--For private views, we need to look at both global
	--views and this user's views
	if exists (	select	*
				from	TaskView
				where	IsGlobal = 0
				and		fkApplicationUser = @fkApplicationUser
				and		ViewName = @ViewName
				and		pkTaskView <> @pkTaskView)
		begin
		set @NameExists = 1
		end
	end
	
select @NameExists