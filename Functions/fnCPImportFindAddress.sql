CREATE FUNCTION [dbo].[fnCPImportFindAddress]
(
	  @Street1 varchar(50)
	, @Street2 varchar(50)
	, @City varchar(50)
	, @State varchar(50)
	, @Zip char(5)
	, @ZipPlus4 char(4)
	, @fkCPRefAddressType decimal
)

RETURNS decimal
AS
BEGIN
	DECLARE @pkCPClientAddress decimal
	SELECT @pkCPClientAddress = 0

	SELECT TOP 1 @pkCPClientAddress = pkCPClientAddress
	FROM CPClientAddress a
	WHERE RTRIM(LTRIM(ISNULL(a.Street1,''))) = ISNULL(@Street1, '')
	AND RTRIM(LTRIM(ISNULL(a.Street2,''))) = ISNULL(@Street2, '')
	AND RTRIM(LTRIM(ISNULL(a.City,''))) = ISNULL(@City, '')
	AND RTRIM(LTRIM(ISNULL(a.[State],''))) = ISNULL(@State, '')
	AND RTRIM(LTRIM(ISNULL(a.Zip,''))) = ISNULL(@Zip, '')
	AND a.fkCPRefClientAddressType = @fkCPRefAddressType
	ORDER BY  ZipPlus4 DESC, Street3 DESC

	RETURN @pkCPClientAddress
END