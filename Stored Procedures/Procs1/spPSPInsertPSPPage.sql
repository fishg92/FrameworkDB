
CREATE PROCEDURE [dbo].[spPSPInsertPSPPage]
(	
	  @fkPSPDocType decimal(18,0)
	, @PageNumber int
	, @pkPSPPage decimal(18,0) output
)
AS

	INSERT INTO PSPPage
	(	
		  fkPSPDocType
		, PageNumber
	) 
	VALUES
	(	
		  @fkPSPDocType
		, @PageNumber
	)

	SET @pkPSPPage = SCOPE_IDENTITY()
