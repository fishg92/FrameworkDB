-- Stored Procedure

CREATE PROCEDURE [dbo].[uspFormAddRendition]
(	
	  @fkFormName decimal(18, 0)
	, @Finished tinyint = null
	, @CaseNumber varchar(50) = null
	, @SSN varchar(50) = null
	, @FirstName varchar(50) = null
	, @LastName varchar(50) = null
	, @CreateUser varchar(50)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	, @pkFormRendition decimal(18, 0) output
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

	INSERT INTO FormRendition
	(	 
		 fkFormName
		,Finished
		,CaseNumber
		,SSN
		,FirstName
		,LastName
		,CreateUser
		,CreateDate
	)
	VALUES
	(	
		 @fkFormName
		,@Finished
		,@CaseNumber
		,@SSN
		,@FirstName
		,@LastName
		,@CreateUser
		,GETDATE()
	)

	SET @pkFormRendition = SCOPE_IDENTITY()
