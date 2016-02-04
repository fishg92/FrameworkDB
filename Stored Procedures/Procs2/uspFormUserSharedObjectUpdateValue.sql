-- Stored Procedure

CREATE PROCEDURE [dbo].[uspFormUserSharedObjectUpdateValue]
(
	  @fkFrameworkUserID decimal(18,0)
	, @fkFormAnnotationSharedObject decimal(18,0)
	, @Value text
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE FormUserSharedObject SET [Value] = @Value
WHERE 
fkFrameworkUserID = @fkFrameworkUserID
AND
fkFormAnnotationSharedObject = @fkFormAnnotationSharedObject
