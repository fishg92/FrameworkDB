-- =============================================
-- Author:		Jerrel Blankenship/James Neno
-- Create date: 05/21/2010
-- Description:	Returns security where clause for autofill proc
-- =============================================
CREATE FUNCTION fnGetAutoFillSecurityWhereClause 
(
	-- Add the parameters for the function here
	@IgnoreProgramTypeSecurity tinyint,
    @IgnoreSecuredClientSecurity tinyint,
    @pkApplicationUser decimal = -1
)
RETURNS varchar(max)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result varchar(max)

	if @IgnoreProgramTypeSecurity <> 1 
	BEGIN
		set @Result = ' ProgramTypeID in (select -1 union select fkProgramType from JoinApplicationUserProgramType where fkApplicationUser =  ' + cast(@pkApplicationUser as varchar(10)) + ') and'
	END

	if @IgnoreSecuredClientSecurity <> 1 
	BEGIN
		set @Result = @Result + 
		' 1 = case when 
				 not exists (select * from LockedEntity where fkCpClient = pkcpClient
							and fkProgramtype in (-1,ProgramTypeID))
					then 1
				when 
					exists ( Select *
										from 
											dbo.JoinApplicationUserSecureGroup JASG (nolock)
												inner join 
													(select * from LockedEntity where LockedEntity.fkCpClient = pkcpClient  
												and LockedEntity.fkProgramtype in (-1,ProgramTypeID)) ICL 
											on ICL.pkLockedEntity = JASG.fkLockedEntity
											Where JASG.fkApplicationUser = ' + cast(@pkApplicationUser as varchar(15)) + '
									   )
					then 1
				else
					0
			end and'
	END

	-- Return the result of the function
	RETURN @Result

END
