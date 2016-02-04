
/**********************************************
exec buildtriggersbatch @Execute = 1, @ShowOnly = 0
exec buildtriggersbatch @Execute = 1, @ShowOnly = 1

************************************************/

CREATE procedure [dbo].[BuildTriggersBatch]
(
	@Execute bit = 0
	,@ShowOnly bit = 1	
)
as

declare @name varchar(100)
		,@OK bit
		,@LoopCount int
	    ,@Count int
		,@ID as int

select @OK = 1
	  ,@LoopCount = 0
	  ,@Count = 0 

-- exclude tables that exist but are not used any more
Declare trigCursor insensitive cursor 
for
select name 
from sysobjects t
where 
name not like '%Audit' and 
name not like '%AuditEff' and 
name not like '%Hist' and 
--name <> 'CPJoinClientCaseNarrativeNT' and 
--name <> 'CPJoinClientNarrativeNT' and 
--name <> 'CPNarrativeNT' and 
--name <> 'ImportInformation' and 
xtype = 'U'
and exists (select * 
			from sysobjects a
			where a.name = t.name + 'Audit')
			
order by name 

open trigCursor

fetch next from trigCursor into @name
 
while  @OK = 1 and @@fetch_status = 0
begin
	select @LoopCount = @LoopCount + 1
	if (@LoopCount > 10000)
		select @OK = 0

	declare @print varchar(500)
	set @print =  'exec [dbo].[pr__SYS_MakeAuditTableUITrigger] ''' + @name + ''',' + convert(varchar(1),@Execute)
	print @print
	set @print =  'exec [dbo].[pr__SYS_MakeAuditTableDeleteTrigger] ''' +  @name + ''',' + convert(varchar(1),@Execute)
	print @print
							
	set @Count = @Count + 1

	if @ShowOnly = 0
	begin
		exec [dbo].[pr__SYS_MakeAuditTableUITrigger] @name,1
		exec [dbo].[pr__SYS_MakeAuditTableDeleteTrigger] @name,1
	end

	fetch next from trigCursor into @name
end

close trigCursor
deallocate trigCursor

select @Count



