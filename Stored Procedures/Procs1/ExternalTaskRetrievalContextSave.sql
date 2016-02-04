CREATE proc [dbo].[ExternalTaskRetrievalContextSave]
	@fkExternalTask varchar(50)
	,@AuthenticationToken varchar(75)
	,@RetrievalUser decimal
as

update	ExternalTaskRetrievalContext
set		RetrievalUser = @RetrievalUser
		,RetrievalDate = getdate()
where	fkExternalTask = @fkExternalTask
and		AuthenticationToken = @AuthenticationToken

if @@rowcount = 0
	begin
	insert	ExternalTaskRetrievalContext
		(
			fkExternalTask
			,AuthenticationToken
			,RetrievalUser
			,RetrievalDate
		)
	values
		(
			@fkExternalTask
			,@AuthenticationToken
			,@RetrievalUser
			,getdate()
		)
	end
			
