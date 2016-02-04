CREATE proc [dbo].[GetUserSessionDMSEntityTypes]
	@fkApplicationUser decimal
	,@EntityTypes varbinary(max) = null output
as

declare @ExpirationMinutes decimal
		,@ExpirationDate datetime
		,@ReturnExpired bit
		

select	@ExpirationMinutes = ItemValue
from	Configuration
where	ItemKey = 'DocumentUserSessionRefreshMinutes'
and isnumeric(ItemValue) = 1

if @ExpirationMinutes is null
	set @ExpirationMinutes = 30
else
	begin
	if @ExpirationMinutes < 1
		set @ExpirationMinutes  = 1
	else if @ExpirationMinutes > 20160 --2 weeks
		set @ExpirationMinutes = 20160
	end

set @ExpirationDate = dateadd(minute,0-@ExpirationMinutes,getdate())

set @ReturnExpired = 0

if exists (	select	*
			from	DMSEntityTypeCache
			where	RefreshStarted > dateadd(minute,-3,getdate()))
	set @ReturnExpired = 1

select	@EntityTypes = DMSTypes
from	DMSEntityTypeCache
where	fkApplicationUser = @fkApplicationUser
and		
	(
		LastRefresh >= @ExpirationDate
		or
		@ReturnExpired = 1
	)

if @EntityTypes is null
	begin
	update	DMSEntityTypeCache
	set		RefreshStarted = getdate()
	where	fkApplicationUser = @fkApplicationUser
	end

