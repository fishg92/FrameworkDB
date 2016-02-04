
CREATE  proc [dbo].[spPSPInsertPSPSwiftViewText]
(	
	@fkPSPDocType decimal(18,0),
	@PageNumber int,
	@SwiftViewText varchar(100),
	@Xpos decimal(9,3),
	@Ypos decimal(9,3)
)
as

	Insert Into PSPSwiftViewText
	(	SwiftViewText,
		PageNumber,
		Xpos,
		Ypos,
		fkPSPDocument) 
	Values
	(	@SwiftViewText,
		@PageNumber,
		@Xpos,
		@Ypos,
		@fkPSPDocType)


