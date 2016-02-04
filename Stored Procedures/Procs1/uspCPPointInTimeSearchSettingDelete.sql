-- Stored Procedure

----------------------------------------------------------------------------
-- Delete a single record from CPPointInTimeSearchSetting
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspCPPointInTimeSearchSettingDelete]
(	@pkCPPointInTimeSearchSetting int
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15) 
	, @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

DELETE	CPPointInTimeSearchSetting
WHERE 	pkCPPointInTimeSearchSetting = @pkCPPointInTimeSearchSetting
