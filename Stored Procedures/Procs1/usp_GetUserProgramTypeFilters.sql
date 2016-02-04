
-- =============================================
-- Author:		Aaron Petry
-- Create date: 1/25/2012
-- Description:	Gets a list of deselected program
--              types for a given user
-- =============================================
CREATE PROCEDURE [dbo].[usp_GetUserProgramTypeFilters]
	@fkApplicationUser AS DECIMAL(18, 0)
AS
SET NOCOUNT ON;
SELECT fkProgramType FROM UserProgramTypeSelected 
WHERE fkApplicationUser = @fkApplicationUser
