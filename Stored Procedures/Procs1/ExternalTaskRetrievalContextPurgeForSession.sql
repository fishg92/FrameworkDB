CREATE proc [dbo].[ExternalTaskRetrievalContextPurgeForSession]
	@AuthenticationToken varchar(75)
as

delete	ExternalTaskRetrievalContext
where	AuthenticationToken = @AuthenticationToken