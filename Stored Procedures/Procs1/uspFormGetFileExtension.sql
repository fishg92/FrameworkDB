CREATE PROCEDURE [dbo].[uspFormGetFileExtension]
(
	  @fkFormName decimal(18,0)
	, @FileExtension varchar(50) OUTPUT
)
AS

	SELECT TOP 1 @FileExtension = FileExtension
	FROM FormImagePage
	WHERE fkFormName = @fkFormName