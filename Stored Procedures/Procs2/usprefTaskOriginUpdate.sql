----------------------------------------------------------------------------
-- Update a single record in refTaskOrigin
----------------------------------------------------------------------------
CREATE PROC [dbo].[usprefTaskOriginUpdate]
(	  @pkrefTaskOrigin decimal(18, 0)
	, @TaskOriginName varchar(150) = NULL
	, @Active bit = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	refTaskOrigin
SET	TaskOriginName = ISNULL(@TaskOriginName, TaskOriginName),
	Active = ISNULL(@Active, Active)
WHERE 	pkrefTaskOrigin = @pkrefTaskOrigin
