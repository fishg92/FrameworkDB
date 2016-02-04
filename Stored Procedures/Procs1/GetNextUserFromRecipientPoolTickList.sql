



CREATE PROC [dbo].[GetNextUserFromRecipientPoolTickList]
(
	 @pkRecipientPool decimal(18, 0)
)
AS

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE


DELETE 
FROM JoinRecipientPoolTickListItem
WHERE fkRecipientPool = @pkRecipientPool
AND pkJoinRecipientPoolTickListItem NOT IN 
	(SELECT t.pkJoinRecipientPoolTickListItem
	FROM JoinRecipientPoolTickListItem t
	INNER JOIN JoinApplicationUserrefRole r ON t.fkApplicationUser = r.fkApplicationUser
	INNER JOIN JoinrefRolerefPermission p ON r.fkrefRole = p.fkrefRole
	WHERE t.fkRecipientPool = @pkRecipientPool
	AND p.fkrefPermission = 44)

BEGIN TRANSACTION

UPDATE JoinRecipientPoolTickListItem
SET TickListIndex = (x.IndexPlusOne - 1)
FROM 
	(SELECT pkJoinRecipientPoolTickListItem as pk
	 ,ROW_NUMBER() Over (ORDER BY TickListIndex,pkJoinRecipientPoolTickListItem) as IndexPlusOne
	FROM JoinRecipientPoolTickListItem
	inner Join ApplicationUser on JoinRecipientPoolTickListItem.fkApplicationUser = ApplicationUser.pkApplicationUser
	WHERE fkRecipientPool = @pkRecipientPool
	and isnull(ApplicationUser.IsActive,1) = 1
	) x
	WHERE x.pk = pkJoinRecipientPoolTickListItem

DECLARE @fkRecipient decimal(18, 0)
	, @TickListIndex int
	, @PreviousTickListIndex int


SET @TickListIndex = (select TOP 1 TickListIndex from JoinRecipientPoolTickListItem 
						where fkRecipientPool = @pkRecipientPool  and selected = 1)
					
set @PreviousTickListIndex = @TickListIndex

IF ((@TickListIndex + 1) < (SELECT COUNT(pkJoinRecipientPoolTickListItem) 
							FROM JoinRecipientPoolTickListItem JoinRecipient
							Inner Join ApplicationUser AppUser on JoinRecipient.fkApplicationUser = AppUser.pkApplicationUser
							WHERE fkRecipientPool = @pkRecipientPool
							And ISNULL(AppUser.IsActive,1) = 1
							))						
SET @TickListIndex = @TicklistIndex + 1
ELSE
SET @TickListIndex = 0
print 	@TickListIndex				
SET @fkRecipient = (SELECT fkApplicationUser
					FROM JoinRecipientPoolTickListItem JoinRecipient
					Inner Join ApplicationUser AppUser on JoinRecipient.fkApplicationUser = AppUser.pkApplicationUser
					WHERE fkRecipientPool = @pkRecipientPool
					AND TickListIndex = @TickListIndex
					and ISNULL(Appuser.IsActive,1) = 1
					)

update JoinRecipientPoolTickListItem 
set selected = 1
where fkRecipientPool = @pkRecipientPool and TickListIndex = @TickListIndex

update JoinRecipientPoolTickListItem 
set selected = 0
where fkRecipientPool = @pkRecipientPool and TickListIndex = @PreviousTickListIndex

SELECT @fkRecipient

COMMIT TRANSACTION
