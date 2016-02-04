----------------------------------------------------------------------------
-- Insert a single record into FormImagePage
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspFormImagePageInsert]
(	  @fkFormName decimal(18, 0)
	, @PageNumber int
	, @ImageData varbinary(MAX)
	, @FileExtension varchar(50)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkFormImagePage decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT FormImagePage
(	  fkFormName
	, PageNumber
	, ImageData
	, FileExtension
)
VALUES 
(	  @fkFormName
	, @PageNumber
	, @ImageData
	, @FileExtension

)

SET @pkFormImagePage = SCOPE_IDENTITY()
