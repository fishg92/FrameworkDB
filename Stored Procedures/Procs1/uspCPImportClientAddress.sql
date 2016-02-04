CREATE PROCEDURE [dbo].[uspCPImportClientAddress]
(
	  @Street1 varchar(100)
	, @Street2 varchar(100)
	, @Street3 varchar(100)
	, @City varchar(50)
	, @State varchar(10)
	, @Zip varchar(10)
	, @ZipPlus4 varchar(10)
	, @pkCPRefAddressType decimal(18,0)
	, @pkCPClientAddress decimal (18,0) = NULL output
	, @pkCPClient decimal(18,0)
)
AS

SET NOCOUNT ON

DECLARE   @HostName varchar(100)
		, @fkCPRefClientAddressTypeCurrent decimal
		, @Street1Current varchar(100)
		, @Street2Current varchar(100)
		, @Street3Current varchar(100)
		, @CityCurrent varchar(100)
		, @StateCurrent varchar(50)
		, @ZipCurrent char(5) 
		, @ZipPlus4Current char(4)
	
SELECT @HostName = HOST_NAME()

IF  ISNULL(@Street1,'') = '' 
AND ISNULL(@Street2,'') = ''
AND ISNULL(@City,'') = ''
AND ISNULL(@State,'') = ''
AND ISNULL(@Zip,'') = ''
AND ISNULL(@ZipPlus4,'') = ''
BEGIN
	SELECT @pkCPClientAddress = 0
END
ELSE
BEGIN

	SELECT @pkCPClientAddress = dbo.fnCPImportFindAddress(@Street1
														, @Street2
														, @City
														, @State
														, @Zip
														, @ZipPlus4
														, @pkCPRefAddressType
														)

	IF @pkCPClientAddress <> 0
	BEGIN

		SELECT @fkCPRefClientAddressTypeCurrent = fkCPRefClientAddressType
			 , @Street1Current = Street1
			 , @Street2Current = Street2
			 , @Street3Current = Street3
			 , @CityCurrent = City
			 , @StateCurrent = [State]
			 , @ZipCurrent = Zip
			 , @ZipPlus4Current = ZipPlus4
		FROM CPClientAddress
		WHERE pkCPClientAddress = @pkCPClientAddress

		IF ISNULL(@Street1Current,'') <> @Street1
		OR ISNULL(@Street2Current,'') <> @Street2
		OR ISNULL(@Street3Current,'') <> @Street3
		OR ISNULL(@CityCurrent,'') <> @City
		OR ISNULL(@StateCurrent,'') <> @State
		OR ISNULL(@ZipCurrent,'') <> @Zip
		OR ISNULL(@ZipPlus4Current,'') <> @ZipPlus4
		BEGIN
			EXEC dbo.uspCPClientAddressUpdate @pkCPClientAddress = @pkCPClientAddress
											, @fkCPRefClientAddressType = @fkCPRefClientAddressTypeCurrent
											, @Street1 = @Street1
											, @Street2 = @Street2
											, @Street3 = @Street3
											, @City = @City
											, @State = @State
											, @Zip = @Zip
											, @ZipPlus4 = @ZipPlus4
											, @LUPUser = @HostName
											, @LUPMac = @HostName
											, @LUPIP = @HostName
											, @LUPMachine = @HostName
		END
	END
	ELSE
	BEGIN

		EXEC dbo.uspCPClientAddressInsert @fkCPRefClientAddressType = @pkCPRefAddressType
										, @Street1 = @Street1
										, @Street2 = @Street2
										, @Street3 = @Street3
										, @City = @City
										, @State = @State
										, @Zip = @Zip
										, @ZipPlus4 = @ZipPlus4
										, @LUPUser = @HostName
										, @LUPMac = @HostName
										, @LUPIP = @HostName
										, @LUPMachine = @HostName
										, @pkCPClientAddress = @pkCPClientAddress output

	END

	EXEC uspCPJoinClientClientAddressInsert   @fkCPClient = @pkCPClient
											, @fkCPClientAddress = @pkCPClientAddress
											, @fkCPRefClientAddressType = @pkCPRefAddressType
											, @LUPUser = @HostName
											, @LUPMac = @HostName
											, @LUPIP = @HostName
											, @LUPMachine = @HostName	
	
END