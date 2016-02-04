
CREATE proc [dbo].[SelectDocServiceConfiguration]
	@pkApplicationUser decimal
	
/*************************************************************
exec SelectDocServiceConfiguration 1,1

*************************************************************/
as

select	pkConfiguration
		,ItemKey
		,ItemValue
		,ItemDescription
from	Configuration
where AppID in (1,9)


select	pkConfiguration = pkUserSettings
		,ItemKey
		,ItemValue
		,ItemDescription
from	UserSettings
where	fkApplicationUser = @pkApplicationUser
and		AppID = 1

select	pkCPRefAlertFlagTypeNT
		,Description
		,AlertDisplay
		,LockedUser
		,LockedDate
from	CPRefAlertFlagTypeNT


select	pkDocumentTypeCaseTagging
		,fkDocumentType
from	DocumentTypeCaseTagging