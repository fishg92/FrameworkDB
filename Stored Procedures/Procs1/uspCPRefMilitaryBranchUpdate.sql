----------------------------------------------------------------------------
-- Update a single record in CPRefMilitaryBranch
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPRefMilitaryBranchUpdate]
(	  @pkCPRefMilitaryBranch decimal(18, 0)
	, @Description varchar(255) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	CPRefMilitaryBranch
SET	Description = ISNULL(@Description, Description)
WHERE 	pkCPRefMilitaryBranch = @pkCPRefMilitaryBranch
