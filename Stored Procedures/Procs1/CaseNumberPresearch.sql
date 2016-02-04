CREATE proc [dbo].[CaseNumberPresearch]
	@CaseNumber varchar(20)
as

set nocount on

Select NorthwoodsNumber
From CPClient
Where pkCPClient in 
(
    Select j.fkCPClient
    From CPClientCase cc with (NoLock)
    Join CPJoinClientClientCase j with (NoLock) on cc.pkCPClientCase = j.fkCPClientCase
    Where cc.StateCaseNumber Like @CaseNumber + '%'
    Or cc.LocalCaseNumber Like @CaseNumber + '%'
)






