


CREATE Proc [dbo].[uspGetCompassNumberByPK]
(	
	@pkCPClient decimal(24,6)
)
as

Declare @northwoodsnumber as varchar(50)

SELECT @northwoodsnumber = NorthwoodsNumber 
FROM CPClient
WHERE pkCPClient = @pkCPClient

if @northwoodsnumber is null or @northwoodsnumber = ''
  Begin
SELECT @northwoodsnumber = NorthwoodsNumber
FROM CPClient
WHERE pkCPClient = (
SELECT max(fkSyncItem)
FROM CompassCloudSyncItemAudit
WHERE syncitemtype = 6 AND formallyknownas = CAST(@pkCPClient AS varchar))
  End

select @northwoodsnumber
