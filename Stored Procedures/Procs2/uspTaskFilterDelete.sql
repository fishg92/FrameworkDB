----------------------------------------------------------------------------
-- Delete a single record from TaskFilter
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspTaskFilterDelete]
(	@pkTaskFilter decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15) 
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

DELETE	TaskFilter
WHERE 	pkTaskFilter = @pkTaskFilter
