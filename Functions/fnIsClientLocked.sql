




CREATE FUNCTION [dbo].[fnIsClientLocked](@pkcpClient  decimal
										 ,@pkApplicationUser  decimal
										 ,@ProgramTypeID decimal)
RETURNS bit
AS
BEGIN
declare @return bit

select @return = case when 
		 not exists (select * from LockedEntity where fkCpClient = @pkcpClient
					and fkProgramtype in (-1,@ProgramTypeID))
			then  0 
		when 
			exists ( Select *
								from 
									dbo.JoinApplicationUserSecureGroup JASG (nolock)
										inner join 
											(select * from LockedEntity where LockedEntity.fkCpClient = @pkcpClient  
										and LockedEntity.fkProgramtype in (-1,@ProgramTypeID)) ICL 
									on ICL.pkLockedEntity = JASG.fkLockedEntity
									Where JASG.fkApplicationUser = @pkApplicationUser 
							   )
			then  0 
		else
			 1
	end 

return @return
END






