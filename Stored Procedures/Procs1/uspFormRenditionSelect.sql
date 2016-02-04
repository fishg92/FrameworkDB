
----------------------------------------------------------------------------
-- Select a single record from FormRendition
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormRenditionSelect]
(	@pkFormRendition decimal(10, 0) = NULL,
	@fkFormName decimal(10, 0) = NULL,
	@Finished tinyint = NULL,
	@CaseNumber varchar(50) = NULL,
	@SSN varchar(50) = NULL,
	@FirstName varchar(50) = NULL,
	@LastName varchar(50) = NULL
	
)
AS

SELECT	pkFormRendition,
	fkFormName,
	Finished,
	CaseNumber,
	SSN,
	FirstName,
	LastName,
	LUPUser,
	LUPDate,
	CreateUser,
	CreateDate
	
FROM	FormRendition
WHERE 	(@pkFormRendition IS NULL OR pkFormRendition = @pkFormRendition)
 AND 	(@fkFormName IS NULL OR fkFormName = @fkFormName)
 AND 	(@Finished IS NULL OR Finished = @Finished)
 AND 	(@CaseNumber IS NULL OR CaseNumber LIKE @CaseNumber + '%')
 AND 	(@SSN IS NULL OR SSN LIKE @SSN + '%')
 AND 	(@FirstName IS NULL OR FirstName LIKE @FirstName + '%')
 AND 	(@LastName IS NULL OR LastName LIKE @LastName + '%')
