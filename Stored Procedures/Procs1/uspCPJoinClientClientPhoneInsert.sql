-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into CPJoinClientClientPhone
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspCPJoinClientClientPhoneInsert]
(	  @fkCPClient decimal(18, 0) = NULL
	, @fkCPClientPhone decimal(18, 0) = NULL
	, @fkCPRefPhoneType decimal (18,0) = NULL
	, @LockedUser varchar(50) = NULL
	, @LockedDate datetime = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkCPJoinClientClientPhone decimal(18, 0) = NULL OUTPUT 
)
AS

set nocount on

exec dbo.SetAuditDataContext @LupUser, @LupMachine

--temp need to get the phone type until People starts to pass in that value---------
declare @tmpPhoneType decimal,
		@tmpPKJoin decimal

set @tmpPhoneType = isnull(@fkCPRefPhoneType, 0)
set @tmpPKJoin = -1

if @tmpPhoneType = 0
	begin
		select @tmpPhoneType = pkCPClientPhone
		from CPClientPhone
		where pkCPClientPhone = @fkCPClientPhone
	end

if isnull(@tmpPhoneType, 0) = 0
	begin
		set @tmpPhoneType = 1
	end
----------------------------------------------------------------------------------------

select @tmpPKJoin = pkCPJoinClientClientPhone
from CPJoinClientClientPhone
where fkCPClient = @fkCPClient
and fkCPClientPhone = @fkCPClientPhone
and fkCPRefPhoneType = @tmpPhoneType

if isnull(@tmpPKJoin, 0) = -1
	begin
		INSERT CPJoinClientClientPhone
		(	  fkCPClient
			, fkCPClientPhone
			, fkCPRefPhoneType
			, LockedUser
			, LockedDate
		)
		VALUES 
		(	  @fkCPClient
			, @fkCPClientPhone
			, @fkCPRefPhoneType
			, @LockedUser
			, @LockedDate

		)

		SET @pkCPJoinClientClientPhone = SCOPE_IDENTITY()
	end
else
	begin
		SET @pkCPJoinClientClientPhone = @tmpPKJoin
	end
