----------------------------------------------------------------------------
-- Update a single record in FormImagePage
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormImagePageUpdate]
(	  @pkFormImagePage decimal(18, 0)
	, @fkFormName decimal(18, 0) = NULL
	, @PageNumber int = NULL
	, @ImageData varbinary(MAX) = NULL
	, @FileExtension varchar(50) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	FormImagePage
SET	fkFormName = ISNULL(@fkFormName, fkFormName),
	PageNumber = ISNULL(@PageNumber, PageNumber),
	ImageData = ISNULL(@ImageData, ImageData),
	FileExtension = ISNULL(@FileExtension, FileExtension)
WHERE 	pkFormImagePage = @pkFormImagePage
