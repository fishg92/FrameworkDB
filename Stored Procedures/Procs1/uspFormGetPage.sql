CREATE PROCEDURE [dbo].[uspFormGetPage]
(
	  @pkFormName decimal(18,0)
	, @PageNumber int
	, @PageData varbinary(MAX) OUTPUT
	, @FileExtension varchar(10) OUTPUT
)
AS

SELECT    @PageData = fi.[ImageData]
		, @FileExtension = fi.[FileExtension]
FROM FormImagePage fi
WHERE fi.fkFormName = @pkFormName
AND fi.PageNumber = @PageNumber
