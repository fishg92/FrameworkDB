-- Stored Procedure

CREATE PROCEDURE [dbo].[uspFormMarkRenditionAsFinished]
(
	  @pkFormRendition decimal(10, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
) 
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

	UPDATE FormRendition SET Finished = 1 WHERE pkFormRendition = @pkFormRendition
