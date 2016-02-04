CREATE PROC [dbo].[usp_IsExistingViewASelectOfAnotherView]
	@dataViewName nvarchar(500)
AS
BEGIN
--declare @numRows as integer

 SELECT Count(*) from sysobjects where xtype='V' and name in
			( SELECT t.TABLE_NAME 
				FROM syscomments c 
				JOIN sysobjects o 
					ON c.id = o.id
				JOIN INFORMATION_SCHEMA.Tables t
					ON  c.text LIKE '%'+t.TABLE_NAME+'%' and dbo.fnParentAndChildDependencyExist(t.TABLE_NAME,@dataViewName) = 1
				where o.name =@dataViewName )
 and name <> @dataViewName

 END
