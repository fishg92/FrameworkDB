

CREATE Proc [dbo].[uspFrameworkAddApplicationUserConfiguration]
(	@pkApplicationUser decimal(18,0),
	@pkAppID decimal(10, 0),
	@ItemKey varchar(200),
	@ItemValue varchar(300),
	@ItemDescription varchar(300)
)
as

Declare @pkConfiguration decimal(18,0)

Insert Into Configuration
(	ItemKey,
	ItemValue,
	ItemDescription,
	AppID
)
Values
(	@ItemKey,
	@ItemValue,
	@ItemDescription,
	@pkAppID
)

Set @pkConfiguration = Scope_Identity()


Insert Into JoinApplicationUserConfiguration
(	fkConfiguration,
	fkApplicationUser
)
Values
(	@pkConfiguration,
	@pkApplicationUser
)

