
CREATE  proc [dbo].[spCPGetCPClientAddressFromCPClientCase]
(	
	@pkCPClientCase decimal(18,0) = null,
	@pkCPClient decimal(18,0) = null
)

as

if isnull(@pkCPClientCase, -1) > 0
	begin
		Select Distinct	a.* 

		From 		CPClientCase cc with (NoLock) 
		Left Join	CPJoinClientClientCase cjcc with (NoLock) on cjcc.fkCPClientCase = cc.pkCPClientCase
		Left Join	CPClient c with (NoLock) on c.pkCPClient = cjcc.fkCPClient
		Left Join	CPJoinClientClientAddress cjca with (NoLock) on cjca.fkCPClient = c.pkCPClient
		Left Join	CPClientAddress a with (NoLock) on a.pkCPClientAddress = cjca.fkCPClientAddress

		Where		cc.pkCPClientCase = @pkCPClientCase
		and			a.[pkCPClientAddress] is not null
	end
else
	begin
		Select Distinct	a.* 

		From 		CPClient c with (NoLock) 
		Left Join	CPJoinClientClientAddress cjca with (NoLock) on cjca.fkCPClient = c.pkCPClient
		Left Join	CPClientAddress a with (NoLock) on a.pkCPClientAddress = cjca.fkCPClientAddress

		Where		c.pkCPClient = @pkCPClient
		and			a.[pkCPClientAddress] is not null
	end



