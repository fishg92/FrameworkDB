CREATE PROCEDURE [dbo].[uspFormGetTIFConversion]
(
	  @Username varchar(255)
	, @pkFormConversion decimal(18,0) OUTPUT
)
AS

	SELECT    @pkFormConversion = pkFormConversion
	FROM FormConversion
	WHERE Username = @Username