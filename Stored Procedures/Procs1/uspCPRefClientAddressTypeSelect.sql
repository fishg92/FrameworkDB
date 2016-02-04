----------------------------------------------------------------------------
-- Select a single record from CPRefClientAddressType
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPRefClientAddressTypeSelect]
(	@pkCPRefClientAddressType decimal(18, 0) = NULL,
	@Description varchar(255) = NULL)
AS

SELECT	pkCPRefClientAddressType,
	Description
FROM	CPRefClientAddressType
WHERE 	(@pkCPRefClientAddressType IS NULL OR pkCPRefClientAddressType = @pkCPRefClientAddressType)
 AND 	(@Description IS NULL OR Description LIKE @Description + '%')

