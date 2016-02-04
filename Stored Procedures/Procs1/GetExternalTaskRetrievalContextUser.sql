
CREATE  proc [dbo].[GetExternalTaskRetrievalContextUser]
	@fkExternalTask varchar(50)
	,@AuthenticationToken varchar(75)
as

select	RetrievalUser
from	ExternalTaskRetrievalContext
where	fkExternalTask = @fkExternalTask
and		AuthenticationToken = @AuthenticationToken