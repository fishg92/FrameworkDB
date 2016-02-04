create proc [dbo].[NightlyTempTablePurge]
as

begin try
	truncate table TempAuditPurgeNightly
end try
begin catch
	delete TempAuditPurgeNightly
end catch

delete PublicAuthenticatedSession
where KeepAlive < dateadd(day,-5,getdate())