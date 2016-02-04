----------------------------------------------------------------------------
-- Delete a single record from JoinRecipientPoolMember
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspJoinRecipientPoolMemberDelete]
(	@pkJoinRecipientPoolMember decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15) 
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

DELETE	JoinRecipientPoolMember
WHERE 	pkJoinRecipientPoolMember = @pkJoinRecipientPoolMember
