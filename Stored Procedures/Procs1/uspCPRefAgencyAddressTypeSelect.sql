----------------------------------------------------------------------------
-- Select a single record from CPRefAgencyAddressType
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPRefAgencyAddressTypeSelect]
(	@pkCPRefAgencyAddressType decimal(18, 0) = NULL,
	@Description varchar(255) = NULL
)
AS

SELECT	pkCPRefAgencyAddressType,
	Description
FROM	CPRefAgencyAddressType
WHERE 	(@pkCPRefAgencyAddressType IS NULL OR pkCPRefAgencyAddressType = @pkCPRefAgencyAddressType)
 AND 	(@Description IS NULL OR Description LIKE @Description + '%')

