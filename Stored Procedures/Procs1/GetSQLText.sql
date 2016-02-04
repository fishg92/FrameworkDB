CREATE PROC [dbo].[GetSQLText]
@ViewName varchar(max),
@OutSQLString varchar(max) OUTPUT
AS
BEGIN
DECLARE @test varchar(max)
DECLARE @origString varchar(max)

create table #GetViewText (SQLViewPart varchar(max))
insert into #GetViewText exec sp_helptext @ViewName
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
  set @test = SUBSTRING(@CompleteViewText,1,CHARINDEX('SELECT',@CompleteViewText))
  SELECT @OutSQLString = rtrim(ltrim( substring(@CompleteViewText, len(@test),len(@CompleteViewText))))
  
END