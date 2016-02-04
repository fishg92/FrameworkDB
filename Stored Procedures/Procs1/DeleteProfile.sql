
CREATE PROC [dbo].[DeleteProfile]
(	@pkProfile decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15) 
	, @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

Delete ProfileSetting
where fkProfile = @pkProfile

Delete ProfileStaticKeywords
where fkProfile = @pkProfile

Delete JoinProfileAutoFillDataView
where fkProfile = @pkProfile

Delete JoinProfileAutoFillSchemaDataView
where fkProfile = @pkProfile

Delete JoinProfileDocumentType
where fkProfile = @pkProfile

Delete JoinProfileSmartView
where fkProfile = @pkProfile

Delete JoinrefRoleProfile
where fkProfile = @pkProfile

Delete JoinApplicationUserRefProfile
where fkProfile = @pkProfile
	
DELETE	[Profile]
WHERE 	pkProfile = @pkProfile
