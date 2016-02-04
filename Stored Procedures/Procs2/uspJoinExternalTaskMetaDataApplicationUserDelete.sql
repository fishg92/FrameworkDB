----------------------------------------------------------------------------
-- Delete a single record from JoinExternalTaskMetaDataApplicationUser
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspJoinExternalTaskMetaDataApplicationUserDelete]
(	@pkJoinExternalTaskMetaDataApplicationUser decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15) 
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

DELETE	JoinExternalTaskMetaDataApplicationUser
WHERE 	pkJoinExternalTaskMetaDataApplicationUser = @pkJoinExternalTaskMetaDataApplicationUser
