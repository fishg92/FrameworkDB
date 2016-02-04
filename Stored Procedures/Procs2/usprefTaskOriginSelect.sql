----------------------------------------------------------------------------
-- Select a single record from refTaskOrigin
----------------------------------------------------------------------------
CREATE PROC [dbo].[usprefTaskOriginSelect]
(	@pkrefTaskOrigin decimal(18, 0) = NULL,
	@TaskOriginName varchar(150) = NULL,
	@Active bit = NULL
)
AS

SELECT	pkrefTaskOrigin,
	TaskOriginName,
	Active
FROM	refTaskOrigin
WHERE 	(@pkrefTaskOrigin IS NULL OR pkrefTaskOrigin = @pkrefTaskOrigin)
 AND 	(@TaskOriginName IS NULL OR TaskOriginName LIKE @TaskOriginName + '%')
 AND 	(@Active IS NULL OR Active = @Active)
