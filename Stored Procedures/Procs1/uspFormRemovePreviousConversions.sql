CREATE PROCEDURE [dbo].[uspFormRemovePreviousConversions]
(
	@UserName varchar(255)
)
AS

	DELETE FROM FormConversion WHERE UserName = @UserName