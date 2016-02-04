
-- =============================================
-- Author:		Aaron Petry
-- Create date: 1/25/2012
-- Description:	Feed in a ProgramType Key and a User Key 
--              and it will add or remove the relationship
--              to the table
-- =============================================
CREATE PROCEDURE [dbo].[usp_UpdateUserProgramTypeFilter] 
	@fkApplicationUser AS DECIMAL(18, 0),
	@fkProgramType AS DECIMAL(18, 0),
	@isSelected as BIT = 0
AS
IF @isSelected = 0
BEGIN
	DELETE FROM UserProgramTypeSelected
	WHERE fkApplicationUser = @fkApplicationUser AND @fkProgramType = fkProgramType
END
ELSE
BEGIN
	IF NOT EXISTS(SELECT * FROM UserProgramTypeSelected WHERE fkApplicationUser = @fkApplicationUser AND fkProgramType = @fkProgramType)
	BEGIN
		INSERT INTO UserProgramTypeSelected(fkApplicationUser, fkProgramType)
		VALUES (@fkApplicationUser, @fkProgramType)
	END
END

