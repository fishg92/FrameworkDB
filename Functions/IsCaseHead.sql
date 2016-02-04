



CREATE FUNCTION [dbo].[IsCaseHead] (
   @fkCPClientCase  decimal
,  @fkCPClient  decimal

)

RETURNS   tinyint AS  
BEGIN 
declare @Return tinyint
select @Return = (select top 1 PrimaryParticipantOnCase 
					from CPJoinClientClientCase 
					where fkCPClientCase = @fkCPClientCase
					and fkCPClient = @fkCPClient)

return isnull(@Return,0)
END

