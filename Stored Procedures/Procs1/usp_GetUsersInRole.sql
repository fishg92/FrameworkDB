




/* 
[usp_GetUsersInRole] 1
*/

CREATE PROC [dbo].[usp_GetUsersInRole]
(	@fkrefRole decimal
)
As
SELECT FullName = LastName + ', ' + FirstName
from ApplicationUser with (NOLOCK) where pkApplicationUser in
(select fkApplicationUser from JoinApplicationUserrefRole with (NOLOCK) where fkrefRole = @fkrefRole)