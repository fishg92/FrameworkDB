----------------------------------------------------------------------------
-- Select a single record from CPRefPhoneType
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPRefPhoneTypeSelect]
(	@pkCPRefPhoneType decimal(18, 0) = NULL,
	@Description varchar(255) = NULL
)
AS

SELECT	pkCPRefPhoneType,
	Description
FROM	CPRefPhoneType
WHERE 	(@pkCPRefPhoneType IS NULL OR pkCPRefPhoneType = @pkCPRefPhoneType)
 AND 	(@Description IS NULL OR Description LIKE @Description + '%')

