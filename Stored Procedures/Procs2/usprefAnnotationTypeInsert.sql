-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into refAnnotationType
----------------------------------------------------------------------------
CREATE Proc [dbo].[usprefAnnotationTypeInsert]
(	  @Name varchar(50)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	, @pkRefAnnotationType decimal(18, 0) = NULL OUTPUT 
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT refAnnotationType
(	  Name
)
VALUES 
(	  @Name

)

SET @pkRefAnnotationType = SCOPE_IDENTITY()
