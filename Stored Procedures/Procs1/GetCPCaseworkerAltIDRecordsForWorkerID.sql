
CREATE PROCEDURE [dbo].[GetCPCaseworkerAltIDRecordsForWorkerID] 
(	@WorkerID varchar(50)
)
AS

select  pkCPCaseworkerAltID
		,WorkerID
		,UserName
		
from CPCaseWorkerAltId (NoLock)
join ApplicationUser (NoLock) on fkApplicationUser = pkApplicationUser
where WorkerID = @WorkerID

