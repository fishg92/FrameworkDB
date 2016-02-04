create proc [dbo].[DocTypeUpdatePermitted]
	@Permitted bit output
as

if exists (	select	* 
			from	DocumentDocTypeCache
			where	RefreshStarted > dateadd(minute,-3,getdate()))
	set @Permitted = 0
else
	set @Permitted = 1
