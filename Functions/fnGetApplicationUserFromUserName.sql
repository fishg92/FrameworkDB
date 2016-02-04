


--select dbo.fnGetApplicationUserFromUserName('ohiouser')



--Returns fkApplicationuser
CREATE    FUNCTION [dbo].[fnGetApplicationUserFromUserName]  
	(
	@UserName varchar (200)
	)

RETURNS  decimal (18,0)
as
begin

DECLARE @fkApplicationUser as varchar (350)
set @fkApplicationUser = -1

Declare @NumberResults as decimal (18,0)

set @NumberResults = (select count(*) from ApplicationUser (nolock)  where UserName = @UserName) 

If @NumberResults = 1
	Begin
		set @fkApplicationUser = (select pkApplicationUser
						
						from ApplicationUser (nolock)
						where UserName = @UserName )
    End
 
return (@fkApplicationUser)
end






