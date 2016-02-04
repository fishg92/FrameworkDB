-- Stored Procedure

CREATE PROC [dbo].[uspSmartFillDataDeleteAllByCompassNumber]
(	  @clientCompassID varchar(50)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

DELETE	SmartFillData
WHERE 	PeopleID = @clientCompassID
