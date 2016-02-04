


--select * from dbo.fnSplitList('<row itemKey="hi" itemValue="0" /><row itemKey="there" itemValue="1" />')

CREATE FUNCTION [dbo].[fnSplitList]
(
    @xml AS XML
)
RETURNS TABLE
AS
RETURN
(
   SELECT 
		itemKey = Tbl.Col.value('@itemKey', 'varchar(max)')  
		,itemValue = Tbl.Col.value('@itemValue', 'varchar(max)')   
	FROM   @xml.nodes('//row') Tbl(Col)  
)
