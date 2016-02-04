


Create proc [dbo].[GetCustomUserAttribute]
	@fkApplicationUser decimal
	,@ItemKey varchar(200)
as

select ItemValue from ApplicationUserCustomAttribute
where ItemKey = @ItemKey
and fkApplicationUser = @fkApplicationUser
