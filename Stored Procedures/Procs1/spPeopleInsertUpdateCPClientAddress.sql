
CREATE     Proc [dbo].[spPeopleInsertUpdateCPClientAddress]
(
	@fkCPRefClientAddressType decimal(18,0),
	@Street1 varchar(100),
	@Street2 varchar(100),
	@Street3 varchar(100),
	@City varchar(100),
	@State varchar(50),
	@Zip char(5),
	@ZipPlus4 char(4),
	@LockedUser varchar(50) = null,
	@LockedDate datetime = null,
	@LUPUser varchar(50) = null,
	@LUPMac VARCHAR(17) = NULL,
	@LUPIP VARCHAR(15) = NULL,
	@LUPMachine VARCHAR(15) = NULL,
	@pkCPClientAddress decimal(18,0) Output
)
as
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
		  BEGIN
			exec dbo.SetAuditDataContext @LupUser, @LupMachine

			Insert Into CPClientAddress
			(	fkCPRefClientAddressType,
				Street1,
				Street2,
				Street3,
				City,
				State,
				Zip,
				ZipPlus4,
				LockedUser,
				LockedDate)
			Values
			(	@fkCPRefClientAddressType,
				@Street1,
				@Street2,
				@Street3,
				@City,
				@State,
				@Zip,
				@ZipPlus4,
				@LockedUser,
				@LockedDate)
			
			Set @pkCPClientAddress = Scope_Identity()
		  END
	    else
		  BEGIN
			set @pkCPClientAddress = @pkToCheckFor
		  end
