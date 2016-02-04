


--select * from dbo.fnSplitList('<row itemKey="hi" /><row itemKey="there" />')

CREATE FUNCTION [dbo].[fnSplitKeysList]
(
    @xml AS XML
)
RETURNS TABLE
AS
RETURN
(
   SELECT 
		itemKey = Tbl.Col.value('@itemKey', 'varchar(max)')  		
	FROM   @xml.nodes('//row') Tbl(Col)  
)
