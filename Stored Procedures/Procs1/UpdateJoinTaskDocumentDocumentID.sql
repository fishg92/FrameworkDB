----------------------------------------------------------------------------
-- Update all task joins related to a document
/*

*/
----------------------------------------------------------------------------
CREATE PROC [dbo].[UpdateJoinTaskDocumentDocumentID]
	@OldfkDocument varchar(50)
	, @NewfkDocument varchar(50)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)

AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	JoinTaskDocument
SET	fkDocument = @NewfkDocument
from JoinTaskDocument j
WHERE fkDocument = @OldfkDocument
and not exists 
	(
		select *
		from	JoinTaskDocument j2
		where	j.fkTask = j2.fkTask
		and		j.fkDocument = @NewfkDocument
	)

delete	JoinTaskDocument
where	fkDocument = @OldfkDocument
