----------------------------------------------------------------------------
-- Select a single record from CPClientExternalID
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPClientExternalIDSelect]
(	@pkCPClientExternalID decimal(18, 0) = NULL,
	@fkCPClient decimal(18, 0) = NULL,
	@ExternalSystemName varchar(50) = NULL,
	@ExternalSystemID varchar(50) = NULL
)
AS

SELECT	pkCPClientExternalID,
	fkCPClient,
	ExternalSystemName,
	ExternalSystemID
FROM	CPClientExternalID
WHERE 	(@pkCPClientExternalID IS NULL OR pkCPClientExternalID = @pkCPClientExternalID)
 AND 	(@fkCPClient IS NULL OR fkCPClient = @fkCPClient)
 AND 	(@ExternalSystemName IS NULL OR ExternalSystemName LIKE @ExternalSystemName + '%')
 AND 	(@ExternalSystemID IS NULL OR ExternalSystemID LIKE @ExternalSystemID + '%')
