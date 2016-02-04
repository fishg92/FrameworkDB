----------------------------------------------------------------------------
-- Update a single record in ExternalTaskMetaData
----------------------------------------------------------------------------
CREATE PROC [dbo].[ChangeExternalTaskID]
(	  @fkExternalTaskOriginal varchar(50)
	, @fkExternalTaskNew varchar(50)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

delete	ExternalTaskMetaData
where	fkExternalTask = @fkExternalTaskNew

UPDATE	ExternalTaskMetaData
SET	fkExternalTask = @fkExternalTaskNew
WHERE fkExternalTask = @fkExternalTaskOriginal
