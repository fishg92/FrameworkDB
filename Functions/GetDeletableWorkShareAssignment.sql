



CREATE FUNCTION [dbo].[GetDeletableWorkShareAssignment] (
  @pk  decimal
  ,@fkSharer  decimal
  ,@fkSharee decimal
  ,@fkrefWorkSharingType decimal
)

RETURNS   decimal AS  
BEGIN 

declare @pkToDelete decimal

select @pkToDelete = case when exists (select top 1 pkWorkShareAssignment from 
	WorkShareAssignment j
	where j.fkSharer = @fkSharer
	and j.fkSharee = @fkSharee
	and j.fkrefWorkSharingType = @fkrefWorkSharingType
	and j.pkWorkShareAssignment > @pk) then 1 else 0 end

select @pkToDelete = isnull(@pkToDelete,0)

return @pkToDelete

END








