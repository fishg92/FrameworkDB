----------------------------------------------------------------------------
-- Select a single record from JoinRecipientPoolMember
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinRecipientPoolMemberSelect]
(	@pkJoinRecipientPoolMember decimal(18, 0) = NULL,
	@fkRecipientPool decimal(18, 0) = NULL,
	@fkApplicationUser decimal(18, 0) = NULL,
	@LUPUser varchar(50) = NULL,
	@LUPDate datetime = NULL,
	@CreateUser varchar(50) = NULL,
	@CreateDate datetime = NULL
)
AS

SELECT	pkJoinRecipientPoolMember,
	fkRecipientPool,
	fkApplicationUser,
	LUPUser,
	LUPDate,
	CreateUser,
	CreateDate
FROM	JoinRecipientPoolMember
WHERE 	(@pkJoinRecipientPoolMember IS NULL OR pkJoinRecipientPoolMember = @pkJoinRecipientPoolMember)
 AND 	(@fkRecipientPool IS NULL OR fkRecipientPool = @fkRecipientPool)
 AND 	(@fkApplicationUser IS NULL OR fkApplicationUser = @fkApplicationUser)
 AND 	(@LUPUser IS NULL OR LUPUser LIKE @LUPUser + '%')
 AND 	(@LUPDate IS NULL OR LUPDate = @LUPDate)
 AND 	(@CreateUser IS NULL OR CreateUser LIKE @CreateUser + '%')
 AND 	(@CreateDate IS NULL OR CreateDate = @CreateDate)

