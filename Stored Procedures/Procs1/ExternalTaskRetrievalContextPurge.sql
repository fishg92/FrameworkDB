create proc dbo.ExternalTaskRetrievalContextPurge
as

delete ExternalTaskRetrievalContext
where RetrievalDate < dateadd(day,-1,getdate())
