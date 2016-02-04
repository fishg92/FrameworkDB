
CREATE  Proc [dbo].[usp_GetCompassNumbersInCase]
(	@pkCPClientCase varchar(20) = Null
)
as

Select fkCPClient
from dbo.CPJoinClientClientCase (nolock)
Where @pkCPClientCase = fkCPClientCase

