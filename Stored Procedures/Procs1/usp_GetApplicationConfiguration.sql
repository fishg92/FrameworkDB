
-- usp_GetApplicationConfiguration -1
/*******************************************
Note on parameters:
@AppID = -1 retrieves Framework records (plus special case for Documents records)
@AppID = -99 retrieves ALL records
*********************************************/
CREATE procedure [dbo].[usp_GetApplicationConfiguration]
@AppID int,
@ItemKey varchar(200) = null

as
/* The following is temporary for benefit bank pending unification of service model at which time security persistence will be possible but turned off as matter of configuration */
if exists
	(select * from ApplicationUser
		inner join JoinApplicationUserrefRole jr on fkApplicationUser = pkApplicationUser
		inner join JoinrefRolerefPermission j on j.fkrefRole = jr.fkrefRole
		where fkrefPermission = 24)
		and exists
		(select * from NCPApplication where pkNCPApplication = 18 and Registered = 'True') BEGIN
		update Configuration set ItemValue = 'False' where Itemkey = 'PersistSecurity' and ItemValue <> 'False'
    	update Configuration set ItemValue = 'True' where ItemKey = 'DoNotAllowPersistSecurityConfiguration' and ItemValue <> 'True'
END

/* Above is temporary for benefit bank pending unification of service model at which time security persistence will be possible but turned off as matter of configuration */

select	pkConfiguration
		,[Grouping]
		,ItemKey
		,ItemValue
		,ItemDescription
		,AppID
		,Sequence
From	Configuration
where	(
			AppID = @AppID
			or
			@AppID = -99
		)
and		ItemKey = isnull(@ItemKey ,ItemKey)

union

select	pkConfiguration
		,[Grouping]
		,ItemKey
		,ItemValue
		,ItemDescription
		,AppID
		,Sequence
From	Configuration
where	AppID = 1
and		@AppID = -1
and		ItemKey = isnull(@ItemKey ,ItemKey)

select Itemkey = 'SchemaVersionNumber'
,ItemValue = dbo.fnGetSchemaVersionNumber()

select * from NCPApplication

exec uspLDAPDomainSelect