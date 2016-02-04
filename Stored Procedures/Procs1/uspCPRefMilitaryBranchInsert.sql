----------------------------------------------------------------------------
-- Insert a single record into CPRefMilitaryBranch
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspCPRefMilitaryBranchInsert]
(	  @Description varchar(255) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkCPRefMilitaryBranch decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT CPRefMilitaryBranch
(	  Description
)
VALUES 
(	  @Description

)

SET @pkCPRefMilitaryBranch = SCOPE_IDENTITY()
