-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into CPJoinClientClientCase
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspCPJoinClientClientCaseInsert]
(	  @fkCPClientCase decimal(18, 0) = NULL
	, @fkCPClient decimal(18, 0) = NULL
	, @PrimaryParticipantOnCase tinyint = NULL
	, @fkCPRefClientRelationshipType decimal(18, 0) = NULL
	, @LockedUser varchar(50) = NULL
	, @LockedDate datetime = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkCPJoinClientClientCase decimal(18, 0) = NULL OUTPUT 
)
AS

set nocount on

declare @tmppkCPJoinClientClientCase decimal
set @tmppkCPJoinClientClientCase = 0

select @tmppkCPJoinClientClientCase = pkCPJoinClientClientCase
from CPJoinClientClientCase
where fkCPClientCase = @fkCPClientCase 
and fkCPClient = @fkCPClient

if @tmppkCPJoinClientClientCase = 0 
	begin

		exec dbo.SetAuditDataContext @LupUser, @LupMachine

		INSERT CPJoinClientClientCase
		(	  fkCPClientCase
			, fkCPClient
			, PrimaryParticipantOnCase
			, fkCPRefClientRelationshipType
			, LockedUser
			, LockedDate
		)
		VALUES 
		(	  @fkCPClientCase
			, @fkCPClient
			, @PrimaryParticipantOnCase
			, @fkCPRefClientRelationshipType
			, @LockedUser
			, @LockedDate

		)

		SET @pkCPJoinClientClientCase = SCOPE_IDENTITY()
	end
else
	begin
		set @pkCPJoinClientClientCase = @tmppkCPJoinClientClientCase
	end
