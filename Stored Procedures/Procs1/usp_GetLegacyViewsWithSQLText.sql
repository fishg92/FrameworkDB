CREATE PROC [dbo].[usp_GetLegacyViewsWithSQLText]
AS
BEGIN
create table #OrginalViews 
(
	pkAutofillDataView decimal,
	fkAutofillDataSource decimal,
	FriendlyName varchar(500),
	TSql varchar(500),
	SQLText  varchar(max)
)
INSERT INTO #OrginalViews(pkAutofillDataView
,fkAutofillDataSource
,FriendlyName
,TSql,SQLText)

select pkAutofillDataView
,fkAutofillDataSource
,FriendlyName
,TSql
,'' as 'SQLText' 
FROM AutoFillDataView WHERE exists (
SELECT 1 
  FROM syscomments c 
  JOIN sysobjects o 
    ON c.id = o.id
  JOIN INFORMATION_SCHEMA.Tables t
    ON  c.text LIKE '%'+t.TABLE_NAME+'%' 
    where o.name =tSQL
)


DECLARE @pkAutoFillDataView decimal
DECLARE @tSQL varchar(500)
DECLARE @sqlViewText varchar(max)

  DECLARE a CURSOR FOR 
   SELECT pkAutofillDataView, TSql from #OrginalViews
   OPEN a 
   FETCH NEXT FROM a INTO @pkAutoFillDataView, @tSQL
	   WHILE @@FETCH_STATUS = 0 BEGIN 
		EXEC GetSQLText @tSQL, @sqlViewText OUTPUT
	   	   
		UPDATE #OrginalViews
		SET SQLText = @sqlViewText
		WHERE pkAutofillDataView = @pkAutofillDataView

		FETCH NEXT FROM a INTO @pkAutoFillDataView,  @tSQL
	   END 
   CLOSE a 
  DEALLOCATE a 
   
  SELECT * FROM #OrginalViews
 DROP TABLE #OrginalViews
END