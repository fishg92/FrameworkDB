



/* 
[uspGetWorkSharerUserList] 84,1
*/

CREATE PROC [dbo].[uspGetWorkSharerUserList]
(	@fkApplicationUser decimal
	,@fkrefWorkSharingType decimal
)
As

SELECT distinct w.fkSharer
,a.Username
,a.Firstname
,a.LastName from WorkShareAssignment w with (NOLOCK) 
inner join ActiveApplicationUser a with (NOLOCK) 
on w.fkSharer = a.pkApplicationUser
where w.fkSharee = @fkApplicationUser
and isnull(w.fkrefWorkSharingType,1) = @fkrefWorkSharingType

