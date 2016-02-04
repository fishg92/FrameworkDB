-- Stored Procedure

-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into CPClientAddress
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPClientAddressInsertCustom]
(	  @fkCPRefClientAddressType decimal(18, 0) = NULL
	, @Street1 varchar(100) = NULL
	, @Street2 varchar(100) = NULL
	, @Street3 varchar(100) = NULL
	, @City varchar(100) = NULL
	, @State varchar(50) = NULL
	, @Zip char(5) = NULL
	, @ZipPlus4 char(4) = NULL
	, @LockedUser varchar(50) = NULL
	, @LockedDate datetime = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkCPClientAddress decimal(18, 0) = NULL OUTPUT 
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

	SET NOCOUNT on
	declare @pkToCheckFor decimal
	set @pkToCheckFor = 0

	SELECT @pkToCheckFor = pkCPClientAddress FROM [CPClientAddress] WITH (NOLOCK)
	WHERE UPPER(LTRIM(RTRIM(ISNULL([Street1], '')))) = UPPER(LTRIM(RTRIM(@Street1)))
	AND UPPER(LTRIM(RTRIM(ISNULL([Street2], '')))) = UPPER(LTRIM(RTRIM(@Street2)))
	AND UPPER(LTRIM(RTRIM(ISNULL([Street3], '')))) = UPPER(LTRIM(RTRIM(@Street3)))
	AND UPPER(LTRIM(RTRIM(ISNULL([City], '')))) = UPPER(LTRIM(RTRIM(@City)))
	AND UPPER(LTRIM(RTRIM(ISNULL([State], '')))) = UPPER(LTRIM(RTRIM(@State)))
	AND UPPER(LTRIM(RTRIM(ISNULL([Zip], '')))) = UPPER(LTRIM(RTRIM(@Zip)))
	AND UPPER(LTRIM(RTRIM(ISNULL([ZipPlus4], '')))) = UPPER(LTRIM(RTRIM(@ZipPlus4)))
	AND [fkCPRefClientAddressType] = @fkCPRefClientAddressType

	IF ISNULL(@pkToCheckFor, 0) = 0
		begin

			exec dbo.uspCPClientAddressInsert 
				  @fkCPRefClientAddressType
				, @Street1 
				, @Street2 
				, @Street3 
				, @City 
				, @State
				, @Zip 
				, @ZipPlus4 
				, @LockedUser 
				, @LockedDate 
				, @LUPUser
				, @LUPMac 
				, @LUPIP 
				, @LUPMachine 
				, @pkCPClientAddress OUTPUT

		end
	else
		begin
			SET @pkCPClientAddress = @pkToCheckFor
		end
