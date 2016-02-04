
CREATE PROC [dbo].[GetApplicationUserFavoriteCases]
	@fkApplicationUser decimal(18, 0)
AS

SELECT	cc.pkCPClientCase
		,cc.StateCaseNumber
		,cc.LocalCaseNumber
		,cc.fkCPRefClientCaseProgramType
		,isnull(cc.fkApplicationUser,-1) as CaseworkerOfRecord 
		,fkCPClientCaseHead = j.fkCpClient
		,CaseHeadName = ISNULL((c.FirstName + ' ' + c.LastName), '') 
		,c.FirstName
		,c.MiddleName
		,c.LastName
		,c.Suffix
		,cc.CaseStatus
		,CaseWorkerFirstName = ISNULL(a.FirstName, '')
		,CaseWorkerLastName = ISNULL(a.LastName, '')
FROM CPClientCase cc with (NOLOCK)
INNER JOIN ApplicationUserFavoriteCase fav with (NOLOCK) 
	ON cc.pkCpClientCase = fav.fkCpClientCase
LEFT JOIN CPJoinClientClientCase j with (NOLOCK)
	ON j.fkCPClientCase = cc.pkCPClientCase
	and j.PrimaryParticipantOnCase = 1
LEFT JOIN CPClient c with (NOLOCK)
	ON c.pkCPClient = j.fkCPClient
LEFT JOIN ApplicationUser a with (NOLOCK)
	ON a.pkApplicationUser = cc.fkApplicationUser
WHERE  fav.fkApplicationUser = @fkApplicationUser