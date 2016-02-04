CREATE PROCEDURE [dbo].[uspFormGetFormImage]
(
	  @fkFormName decimal(18,0)
	, @FormImage varbinary(MAX) OUTPUT
	, @FileExtension varchar(10) OUTPUT
)
AS

	SELECT @FormImage = [Image], @FileExtension = FileExtension
	FROM FormImage
	WHERE fkFormName = @fkFormName