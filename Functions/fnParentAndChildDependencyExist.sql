-- =============================================
-- Author:		Jerrel B & James N
-- Create date: 9/20/2010
-- Description:	
-- =============================================
CREATE FUNCTION fnParentAndChildDependencyExist 
(
	-- Add the parameters for the function here
	@lookupObject varchar(500),
	@parentView varchar(500)
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result int
	declare @objid int	

	--  See if @objname exists.
	select @objid = object_id(@lookupObject)

	--  Now check for things that depend on the object.
	if exists(
	select distinct 'name' = (s.name + '.' + o.name),
		type = substring(v.name, 5, 16)
			from sys.objects o, master.dbo.spt_values v, sysdepends d,
				sys.schemas s
			where o.object_id = d.id
				and o.type = substring(v.name,1,2) collate database_default and v.type = 'O9T'
				and d.depid = @objid
				and o.schema_id = s.schema_id
				and deptype < 2	
				and UPPER(substring(v.name, 5, 16)) = 'VIEW'
				and o.name = @parentView	
				)
	begin
		set @Result = 1
	end
	else
	begin
		set @Result = 0
	end
	
	-- Return the result of the function
	RETURN @Result

END
