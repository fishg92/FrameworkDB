CREATE PROC [dbo].[usp_GetSQLTextOfChildView]
	@dataViewName nvarchar(500)
AS
BEGIN
declare @childViewName as varchar(500)

 SELECT @childViewName = name from sysobjects where xtype='V' and name in
			( SELECT t.TABLE_NAME 
				FROM syscomments c 
				JOIN sysobjects o 
					ON c.id = o.id
				JOIN INFORMATION_SCHEMA.Tables t
					ON  c.text LIKE '%'+t.TABLE_NAME+'%' and dbo.fnParentAndChildDependencyExist(t.TABLE_NAME,@dataViewName) = 1 
				where o.name =@dataViewName )
 and name <> @dataViewName
  
 create table #GetViewText (SQLViewPart varchar(max))
	insert into #GetViewText exec sp_helptext @childViewName
	declare @CompleteViewText varchar(max)
	set @CompleteViewText = ''

		SET NOCOUNT ON 
		DECLARE @HoldViewText VARCHAR(max)
		DECLARE c CURSOR FOR 
			SELECT SQLViewPart from #GetViewText
			OPEN c 
			FETCH NEXT FROM c INTO @HoldViewText
			WHILE @@FETCH_STATUS = 0 BEGIN 
				set @CompleteViewText = @CompleteViewText + @HoldViewText
				FETCH NEXT FROM c INTO @HoldViewText 
			END 
			CLOSE c 
		DEALLOCATE c 

	
drop table #GetViewText

set @CompleteViewText = substring(@CompleteViewText,charindex('select', @CompleteViewText,1), len(@CompleteViewText))

select @CompleteViewText
--select @childViewName

 END