----------------------------------------------------------------------------
-- Select a single record from CPRefMilitaryBranch
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPRefMilitaryBranchSelect]
(	@pkCPRefMilitaryBranch decimal(18, 0) = NULL,
	@Description varchar(255) = NULL
)
AS

SELECT	pkCPRefMilitaryBranch,
	Description
FROM	CPRefMilitaryBranch
WHERE 	(@pkCPRefMilitaryBranch IS NULL OR pkCPRefMilitaryBranch = @pkCPRefMilitaryBranch)
 AND 	(@Description IS NULL OR Description LIKE @Description + '%')
