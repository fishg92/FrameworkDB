-- Stored Procedure

----------------------------------------------------------------------------
-- Update a single record in refAnnotationType
----------------------------------------------------------------------------
CREATE PROC [dbo].[usprefAnnotationTypeUpdate]
(	  @pkRefAnnotationType decimal(18, 0)
	, @Name varchar(50) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	refAnnotationType
SET	Name = ISNULL(@Name, Name)
WHERE 	pkRefAnnotationType = @pkRefAnnotationType
