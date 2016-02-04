CREATE PROCEDURE [dbo].[uspFormGetLastFormImageUpdate]
(
	  @pkFormName decimal(18,0)
	, @LastUpdated datetime OUTPUT
)
AS

SELECT @LastUpdated = AuditStartDate 
FROM FormImagePageAudit
WHERE fkFormName = @pkFormName
AND PageNumber = 1