


CREATE PROCEDURE [dbo].[GetCoPilotInfoFromQuickListForm] (
	@pkFormQuickListFormName as decimal(18,0)
) 
	
AS
BEGIN
	
	SET NOCOUNT ON

	select ccase.StateCaseNumber
	  ,CCase.LocalCaseNumber 
	  ,progtype.ProgramType
	   ,(select top(1) firstname + ' ' + LastName 
			 from CPJoinClientClientCase cjoin
				inner join cpclient client on cjoin.fkCPClient = client.pkCPClient
				where PrimaryParticipantOnCase = 1 and fkCPClientCase = ccase.pkCPClientCase) as CaseHead
	  
	from FormQuickListFormName formName
		inner join CPClientCase CCase on formname.fkCPClientCase = CCase.pkCPClientCase
		left outer join CPClient Client on ccase.fkCPClientCaseHead = client.pkCPClient
		inner join ProgramType progType on CCase.fkCPRefClientCaseProgramType = progType.pkProgramType
	where pkFormQuickListFormName = @pkFormQuickListFormName

	set nocount off

END
