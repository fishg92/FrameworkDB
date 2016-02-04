
--select dbo.fnGetClientNameFriendly(20)
--Returns clients full name
CREATE    FUNCTION [dbo].[fnGetClientNameFriendly]  
(
@pkCPClient decimal (18,0)
)

RETURNS  varchar (350)
as
begin

DECLARE @ClientFullName as varchar (350)
	
set @ClientFullName = (select 
				
				FirstName + ' '   
				
		 +		case isnull(MiddleName, '')  
					when '' then '' 
					else MiddleName + ' ' 
				end 
				
		 +		LastName

		 +		case isnull(Suffix, '')  
					when '' then '' 
					else ' ' + Suffix  
				end 
				
				from CPClient (nolock)
				where pkCPClient = @pkCPClient )

If @ClientFullName is null
 begin
		set @ClientFullName = (select top 1 
					
					FirstName + ' '   
					
			 +		case isnull(MiddleName, '')  
						when '' then '' 
						else MiddleName + ' ' 
					end 
					
			 +		LastName

			 +		case isnull(Suffix, '')  
						when '' then '' 
						else ' ' + Suffix  
					end 
					
					from CPClientAudit (nolock)
					where pkCPClient = @pkCPClient 
					order by pk desc)
end
			

return (@ClientFullName)
end






