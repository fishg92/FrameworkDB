
CREATE  PROCEDURE [dbo].[spPSPDeletePSPSwiftViewText]
(	
	@pkPSPDocType decimal(18,0) 
)
AS

	DELETE FROM PSPSwiftViewText 
	WHERE fkPSPDocument = @pkPSPDocType
