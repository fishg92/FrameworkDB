CREATE Proc [dbo].[spCPGetCPClientCase]
(	@StateCaseNumber varchar(20) = Null,
	@LocalCaseNumber varchar(20) = Null,
	@fkCPCaseWorker decimal = Null,
	@fkCPRefClientCaseProgramType decimal = Null,
	@fkApplicationUser decimal = Null
)
as

Select	pkCPClientCase,
	CreateUser,
	CreateDate ,
	LUPUser,
	LUPDate ,
	StateCaseNumber ,
	LocalCaseNumber,
	fkCPRefClientCaseProgramType ,
	fkCPCaseWorker,
	fkApplicationUser,
	CaseStatus 
From	CPClientCase cc with (NoLock)
Where	(@StateCaseNumber is Null or cc.StateCaseNumber like @StateCaseNumber + '%')
and   	(@LocalCaseNumber is Null or cc.LocalCaseNumber like @LocalCaseNumber + '%')
and   	(@fkCPCaseWorker is Null or cc.fkCPCaseWorker = @fkCPCaseWorker)
and   	(@fkCPRefClientCaseProgramType is Null or cc.fkCPRefClientCaseProgramType = @fkCPRefClientCaseProgramType)
and		(@fkApplicationUser is Null or cc.fkApplicationUser = @fkApplicationUser)