CREATE PROCEDURE [dbo].[uspExternalDataSystemGetQueriesForUser]
(
	@fkApplicationUser decimal(18,0)
)
AS

SELECT q.*, ISNULL(j.fkCPClient,0) AS 'pkCPClient', ISNULL(c.FirstName, '') AS 'First Name', ISNULL(c.LastName, '') AS 'Last Name', a.AuditStartDate AS 'Create Date', r.[Status]
FROM ExternalDataSystemQuery q
LEFT OUTER JOIN ExternalDataSystemJoinQueryClient j ON q.pkExternalDataSystemQuery = j.fkExternalDataSystemQuery
LEFT OUTER JOIN CPClient c ON j.fkCPClient = c.pkCPClient
LEFT OUTER JOIN ExternalDataSystemResult r ON q.pkExternalDataSystemQuery = r.fkExternalDataSystemQuery
LEFT OUTER JOIN ExternalDataSystemQueryAudit a ON q.pkExternalDataSystemQuery = a.pkExternalDataSystemQuery
WHERE q.fkApplicationUser = @fkApplicationUser
ORDER BY a.AuditStartDate


