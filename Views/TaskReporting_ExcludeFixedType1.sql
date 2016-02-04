
CREATE view [dbo].[TaskReporting_ExcludeFixedType1]
as

select *
from dbo.TaskReporting
where FixedType <> 1

