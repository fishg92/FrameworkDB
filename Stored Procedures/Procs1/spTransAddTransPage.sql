


/****** Object:  Stored Procedure dbo.spTransAddTransPage    Script Date: 8/21/2006 8:02:16 AM ******/




CREATE     Proc [dbo].[spTransAddTransPage]
(	@fkTrans decimal(18,0),
	@PhysicalPageNum int,
	@pkTransPage decimal(18,0) output
, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	,@TransactionCode varchar(15) output
)
as

	exec dbo.SetAuditDataContext @LupUser, @LupMachine
	
	Declare @CountyCode varchar(5)

	Insert into TransPage
	(	fkTrans,
		PhysicalPageNum
	) 
	Values
	(	@fkTrans,
		@PhysicalPageNum
	)
	
	Set @pkTransPage = Scope_Identity()

	/*  	Create a unique transaction code for each of the pages that are printed
		as a concatenation of the transaction, county code and page in the format
		of a fixed length string  */

	Set @CountyCode = (Select IsNull(AttributeValue, '') from NCPSystem where Attribute = 'CountyCode')
	If @CountyCode = ''
	begin
		RaisError ('Error:  Must find CountyCode attribute in NCPSystem table.', 10, 1)
		Return
	end
	
	/*	Begin creating the transaction for the page */
	Set @TransactionCode = @CountyCode
	
	If DataLength(Convert(varchar(20), @pkTransPage)) > 8
	begin
		RaisError ('Error:  Overflow in Transacion Page Count, reset identity Field.', 10, 1)
		Return
	end
	Else
	begin	
		Set @TransactionCode = @TransactionCode + Replicate('0', 8 - DataLength(Convert(varchar(20), @pkTransPage))) + Convert(varchar(20), @pkTransPage)
	end

	/*   	Need to review the need for the transaction page number to be in the document
		The transcation Page ID has key relationships with the Tranasction and the keywords
		we may not need to have both the transacion and the page count present in our return. */

	/*	Pad the value of the county code to make it at least 8 characters long 
	If DataLength(Convert(varchar(20), @fkFormTrans)) > 8
	begin
		RaisError ('Error:  Overflow in Transacion Count, reset identity Field.', 10, 1)
	end
	Else
	begin	
		Set @TransactionCode = @TransactionCode + Replicate('0', 8 - DataLength(Convert(varchar(20), @fkTrans))) + Convert(varchar(20), @fkFormTrans)
	end */

	/*	Pad the Page number to three characters 
	If DataLength(Convert(varchar(20),@pkFormTransPage)) > 3 
	begin
		RaisError ('Error:  Overflow in Transacion Count, reset identity Field.', 10, 1)
	end
	Else
	begin
		Set @TransactionCode = @TransactionCode + Replicate('0', 3 - DataLength(Convert(varchar(20),@pkTransPage))) + Convert(Varchar(20), @pkTransPage)
	end
	*/
