
CREATE   proc [dbo].[sp_findsp] 
 @s varchar(255) 
as 
DECLARE @msg varchar(255) , 
  @ul varchar(255) 
select @s='%' + @s + '%' 
select 'SP Name'=upper(o.name), 
ObjType = case o.xtype
	when 'tr' then 'Trigger'
	when 'u' then 'Table'
	when 's' then 'System table'
	when 'd' then 'Default'
	when 'pk' then 'Key'
	when 'fn' then 'Scalar function'
	when 'tf' then 'Table function'
	when 'v' then 'View'
	when 'if' then 'Indeterminate function'
	when 'p' then 'Stored proc'
end,	
  Seq=colid , 
  'SP Line'=substring(text,patindex(@s,text)-25,1000) 
from syscomments c , 
  sysobjects o 
where o.id=c.id 
and  patindex(@s,text) > 0 
order by name 
SELECT @msg='* Stored procedures containing string "' + @s + '=' + 
convert(varchar(8),@@rowcount) + ' *' 
SELECT @ul=replicate('*',datalength(@msg)) 
Print ' ' 
PRINT @ul 
PRINT @msg 
Print @ul 


