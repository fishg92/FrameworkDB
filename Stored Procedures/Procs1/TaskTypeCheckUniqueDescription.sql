CREATE proc [dbo].[TaskTypeCheckUniqueDescription]
	@pkrefTaskType decimal
	,@Description varchar(50)
/***************************************************
	Description must be unique. Make sure that
	we are not trying to create a duplicate
	value with another record
*************************************************/
as

if exists (	select	*
			from	refTaskType
			where	Description = @Description
			and		pkrefTaskType <> @pkrefTaskType)
	select 0
else
	select 1
