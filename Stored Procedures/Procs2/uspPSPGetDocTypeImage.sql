CREATE PROCEDURE [dbo].[uspPSPGetDocTypeImage]
(
	  @fkPSPDocType decimal(18,0)
	, @GetSnapShot bit
	, @Image varbinary(MAX) OUTPUT
)
AS

	IF (@GetSnapShot = 0)
	BEGIN
		SET @Image = (SELECT TOP 1 FullImage FROM PSPDocImage WHERE fkPSPDocType = @fkPSPDocType)
	END
	ELSE
	BEGIN
		SET @Image = (SELECT TOP 1 [SnapShot] FROM PSPDocType WHERE pkPSPDocType = @fkPSPDocType)
	END