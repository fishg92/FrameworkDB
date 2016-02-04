




CREATE PROC [dbo].[usp_CPIsCPClientLocked]
(	  @fkCPClient decimal(18, 0)
	, @fkApplicationUser decimal(18,0)
	, @fkProgramType decimal (18,0)
)
AS
SET NOCOUNT ON

--Is Client actually locked? Get Client, PT


Select 
  pkLockedEntity
, fkCPClient
, fkProgramType
into #IsClientSecure
from dbo.LockedEntity (nolock)
where fkCPClient = @fkCPClient

If not exists (Select * from #IsClientSecure)
	Select 'CompletelyUnlocked'
Else
	Begin 


		Select 
		  pkLockedEntity
		, fkCPClient
		, fkProgramType
		into #IsClientLocked
		from #IsClientSecure
		where fkProgramType = @fkProgramType

		union

		Select 
		  pkLockedEntity
		, fkCPClient
		, fkProgramType
		from #IsClientSecure
		where fkProgramType = -1

		If not exists (Select * from #IsClientLocked) 
			Select 'ProgramTypeUnlocked'
			Else
				Begin
					
					If exists ( Select 
								fkApplicationUser
								,fkLockedEntity
								from 
								dbo.JoinApplicationUserSecureGroup JASG (nolock)
								inner join #IsClientLocked ICL on ICL.pkLockedEntity = JASG.fkLockedEntity
								Where JASG.fkApplicationUser = @fkApplicationUser
							   )
						Select 'UnlockedToUser'
					Else
						Select 'LockedToUser' 
				End
	End

--drop table #IsClientLocked







