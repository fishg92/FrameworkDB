
----------------------------------------------------------------------------
-- Delete a single record from ServiceDirectory
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspServiceDirectoryDelete]
(	@ServiceName varchar(100)
)
AS

DELETE	ServiceDirectory
WHERE 	ServiceName = @ServiceName 


