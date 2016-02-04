
CREATE  proc [dbo].[spPSPGetSwiftViewText]
(	@pkPSPDocType decimal
)
as

SELECT 	pkPSPSwiftViewText, 
	SwiftViewText, 
	PageNumber,
	Xpos = isnull(Xpos, 0), 
	Ypos = isnull(Ypos, 0), 
	fkPSPDocument 
FROM PSPSwiftViewText
Where fkPSPDocument = @pkPSPDocType
