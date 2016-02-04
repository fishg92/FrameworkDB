-- Stored Procedure

CREATE PROCEDURE [dbo].[uspFormHideFormFolder]
(
	  @pkFormFolder decimal(18,0)
	, @Hide int
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
) 

AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

	UPDATE FormFolder SET Hidden = @Hide WHERE pkFormFolder = @pkFormFolder
