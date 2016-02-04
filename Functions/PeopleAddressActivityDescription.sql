
CREATE  FUNCTION [dbo].[PeopleAddressActivityDescription]  (
	@pkCPClient decimal,
	@pkBeforeAddress decimal = null,
	@pkAfterAddress decimal = null
)

RETURNS  varchar(4000) 

as
begin
	declare @ReturnValue varchar(4000)
	declare @Name varchar(250)
	declare @BeforeStreet1 varchar(100)
	declare @BeforeStreet2 varchar(100)
	declare @BeforeStreet3 varchar(100)
	declare @BeforeCity varchar(100)
	declare @BeforeState varchar(50)
	declare @BeforeZip varchar(5)
	declare @BeforeZipPlus4 varchar(4)
	declare @AfterStreet1 varchar(100)
	declare @AfterStreet2 varchar(100)
	declare @AfterStreet3 varchar(100)
	declare @AfterCity varchar(100)
	declare @AfterState varchar(50)
	declare @AfterZip varchar(5)
	declare @AfterZipPlus4 varchar(4)
	declare @BeforeStreets varchar(350)
	declare @AfterStreets varchar(350)
	declare @BeforeCityStateZip varchar(200)
	declare @AfterCityStateZip varchar(200)

	select @BeforeStreet1 = ''
		 ,@BeforeStreet2 = ''
		 ,@BeforeStreet3 = ''
		 ,@BeforeCity = ''
		 ,@BeforeState = ''
		 ,@BeforeZip = ''
		 ,@BeforeZipPlus4 = ''
		 ,@AfterStreet1 = ''
		 ,@AfterStreet2 = ''
		 ,@AfterStreet3 = ''
		 ,@AfterCity = ''
		 ,@AfterState = ''
		 ,@AfterZip = ''
		 ,@AfterZipPlus4 = ''
		 ,@ReturnValue = ''
		 ,@BeforeStreets = ''
		 ,@AfterStreets = ''
		 ,@BeforeCityStateZip = ''
		 ,@AfterCityStateZip = ''

	select @Name = ltrim(rtrim(FirstName)) + ' ' + ltrim(rtrim(LastName))
	from CPClient
	where pkCPClient = @pkCPClient

	if isnull(@pkBeforeAddress, 0) <> 0
		begin
			select @BeforeStreet1 = Street1
				,@BeforeStreet2 = Street2
				,@BeforeStreet3 = Street3
				,@BeforeCity = City
				,@BeforeState = State
				,@BeforeZip = Zip
				,@BeforeZipPlus4 = ZipPlus4
			from CPClientAddress
			where pkCPClientAddress = @pkBeforeAddress
		
			set @BeforeStreets = @BeforeStreet1 + char(13)
			
			if @BeforeStreet2 <> ''
				begin
					set @BeforeStreets = @BeforeStreets + '         ' + @BeforeStreet2 + char(13)
				end
	
			if @BeforeStreet3 <> ''
				begin
					set @BeforeStreets = @BeforeStreets + '         ' + @BeforeStreet3 + char(13)
				end

			if @BeforeCity <> ''
				begin
					set @BeforeCityStateZip = @BeforeCity
				end
	
			if @BeforeState <> ''
				begin
					if @BeforeCityStateZip <> ''
						begin
							set @BeforeCityStateZip = ltrim(rtrim(@BeforeCityStateZip)) + ', ' + @BeforeState
						end
					else
						begin
							set @BeforeCityStateZip = @BeforeState
						end
				end

			if @BeforeZip <> ''
				begin
					if @BeforeCityStateZip <> ''
						begin
							set @BeforeCityStateZip = ltrim(rtrim(@BeforeCityStateZip)) + ' ' + @BeforeZip
						end
					else
						begin
							set @BeforeCityStateZip = @BeforeZip
						end
				end

			if @BeforeZipPlus4 <> ''
				begin
					if @BeforeCityStateZip <> ''
						begin
							set @BeforeCityStateZip = ltrim(rtrim(@BeforeCityStateZip)) + '-' + @BeforeZipPlus4
						end
					else
						begin
							set @BeforeCityStateZip = @BeforeZipPlus4
						end
				end
		end

	if isnull(@pkAfterAddress, 0) <> 0
		begin
			select @AfterStreet1 = Street1
				,@AfterStreet2 = Street2
				,@AfterStreet3 = Street3
				,@AfterCity = City
				,@AfterState = State
				,@AfterZip = Zip
				,@AfterZipPlus4 = ZipPlus4
			from CPClientAddress
			where pkCPClientAddress = @pkAfterAddress

			set @AfterStreets = @AfterStreet1 + char(13)
		
			if @AfterStreet2 <> ''
				begin
					set @AfterStreets = @AfterStreets + '         ' + @AfterStreet2 + char(13)
				end
	
			if @AfterStreet3 <> ''
				begin
					set @AfterStreets = @AfterStreets + '         ' + @AfterStreet3 + char(13)
				end

			if @AfterCity <> ''
				begin
					set @AfterCityStateZip = @AfterCity
				end
	
			if @AfterState <> ''
				begin
					if @AfterCityStateZip <> ''
						begin
							set @AfterCityStateZip = ltrim(rtrim(@AfterCityStateZip)) + ', ' + @AfterState
						end
					else
						begin
							set @AfterCityStateZip = @AfterState
						end
				end

			if @AfterZip <> ''
				begin
					if @AfterCityStateZip <> ''
						begin
							set @AfterCityStateZip = ltrim(rtrim(@AfterCityStateZip)) + ' ' + @AfterZip
						end
					else
						begin
							set @AfterCityStateZip = @AfterZip
						end
				end

			if @AfterZipPlus4 <> ''
				begin
					if @AfterCityStateZip <> ''
						begin
							set @AfterCityStateZip = ltrim(rtrim(@AfterCityStateZip)) + '-' + @AfterZipPlus4
						end
					else
						begin
							set @AfterCityStateZip = @AfterZipPlus4
						end
				end
		end

		if isnull(@pkAfterAddress, 0) = 0
			begin
				select @ReturnValue = 'Address: ' + char(13) + ' ' + char(13)
						    + '         ' + @BeforeStreets
						    + '         ' + @BeforeCityStateZip + char(13) + ' ' + char(13)
						    + 'was removed for ' + ltrim(rtrim(@Name))
			end
		else if isnull(@pkBeforeAddress, 0) = 0
			begin
				select @ReturnValue = 'Address: ' + char(13) + ' ' + char(13)
						    + '         ' + @AfterStreets
						    + '         ' + @AfterCityStateZip + char(13) + ' ' + char(13)
						    + 'was Added for ' + ltrim(rtrim(@Name))
			end
		else
			begin
				select @ReturnValue = 'Address: ' + char(13) + ' ' + char(13) 
						    + '         ' + @BeforeStreets
						    + '         ' + @BeforeCityStateZip + char(13) + ' ' + char(13)
						    + 'was changed to:' + char(13) + ' ' + char(13)
						    + '         ' + @AfterStreets
						    + '         ' + @AfterCityStateZip + char(13) + ' ' + char(13)
						    + 'for ' + ltrim(rtrim(@Name))
			end
	
	return @ReturnValue
end

