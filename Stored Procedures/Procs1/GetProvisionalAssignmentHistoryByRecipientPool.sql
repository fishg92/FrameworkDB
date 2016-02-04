


CREATE PROC [dbo].[GetProvisionalAssignmentHistoryByRecipientPool]
(	
	@pkRecipientPool decimal(18, 0),
	@StartDate datetime,
	@EndDate datetime
)

AS

SELECT pkProvisionalAssignment,
	   fkRecipientPool,
	   fkSuggestedUser,
	   fkAssigningUser,
	   SuggestionAccepted,
	   Provisional.CreateDate,
	   Isnull(FirstName,'') FirstName,
	   Isnull(LastName, '') LastName
FROM ProvisionalAssignment Provisional
Left Join ApplicationUser on ApplicationUser.pkApplicationUser = Provisional.fkSuggestedUser
WHERE fkRecipientPool = @pkRecipientPool
AND (dbo.DatePortion(Provisional.CreateDate) >= dbo.DatePortion(@StartDate) 
	 and dbo.DatePortion(Provisional.CreateDate) <= dbo.DatePortion(@EndDate))
