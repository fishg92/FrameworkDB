
-- usp_CPClientCustomAttributeInitialize 4,'','','5/5/2009','','',''
CREATE PROC [dbo].[usp_CPClientCustomAttributeInitialize] 
(@fkCPClient decimal(18,0)
, @LUPUser varchar(50)
, @LUPMac char(17)
, @LUPIP varchar(15)
, @LUPMachine varchar(15)
)
As

declare @pkCPCLientCustomAttribute decimal 

if not exists(select * from CPClientCustomAttribute where fkCPClient = @fkCPClient)	BEGIN
	exec dbo.uspCPClientCustomAttributeInsert 
				@fkCPClient
				,'' --DATA1
				,''
				,''
				,''
				,''
				,''
				,''
				,''
				,''
				,''  --DATA10
				,''
				,''
				,''
				,''
				,''
				,''
				,''
				,''
				,'' 
				,'' --DATA20
				,''
				,''
				,''
				,''
				,''
				,''
				,''
				,''
				,'' 
				,'' --DATA30
				,''
				,''
				,''
				,''
				,''
				,''
				,''
				,''
				,'' 
				,''  --DATA40
				, @LUPUser
				, @LUPMac 
				, @LUPIP 
				, @LUPMachine 
				, @pkCPCLientCustomAttribute OUTPUT
END ELSE BEGIN
	select @pkCPCLientCustomAttribute = pkCPCLientCustomAttribute from CPClientCustomAttribute where fkCPClient = @fkCPClient
END

select @pkCPCLientCustomAttribute
