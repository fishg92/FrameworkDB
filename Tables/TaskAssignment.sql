CREATE TABLE [dbo].[TaskAssignment] (
    [pkTaskAssignment]             DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [fkTask]                       DECIMAL (18)  NOT NULL,
    [Description]                  VARCHAR (100) CONSTRAINT [DF_TaskAssignment_Description] DEFAULT ('') NOT NULL,
    [fkApplicationUserAssignedBy]  DECIMAL (18)  NOT NULL,
    [fkApplicationUserAssignedTo]  DECIMAL (18)  NOT NULL,
    [fkTaskAssignmentReassignedTo] DECIMAL (18)  NULL,
    [fkrefTaskAssignmentStatus]    DECIMAL (18)  NOT NULL,
    [StartDate]                    DATETIME      NULL,
    [CompleteDate]                 DATETIME      NULL,
    [UserRead]                     BIT           CONSTRAINT [DF_TaskAssignment_UserRead] DEFAULT ((0)) NOT NULL,
    [LUPUser]                      VARCHAR (50)  NULL,
    [LUPDate]                      DATETIME      NULL,
    [CreateUser]                   VARCHAR (50)  NULL,
    [CreateDate]                   DATETIME      NULL,
    [fkrefTaskAssignmentReason]    DECIMAL (18)  NULL,
    [UserReadNote]                 BIT           CONSTRAINT [DF_TaskAssignment_UserReadNote] DEFAULT ((0)) NULL,
    [RecipientHasBeenNotified]     BIT           CONSTRAINT [DF_TaskAssignment_RecipientHasBeenNotified] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_TaskAssignment] PRIMARY KEY CLUSTERED ([pkTaskAssignment] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkApplicationUserAssignedTo]
    ON [dbo].[TaskAssignment]([fkApplicationUserAssignedTo] ASC)
    INCLUDE([CompleteDate], [CreateDate], [fkApplicationUserAssignedBy], [fkrefTaskAssignmentReason], [fkrefTaskAssignmentStatus], [fkTask], [pkTaskAssignment], [UserRead], [UserReadNote]);


GO
CREATE NONCLUSTERED INDEX [fkTask_AssignedBy]
    ON [dbo].[TaskAssignment]([fkTask] ASC, [fkApplicationUserAssignedBy] ASC);


GO
CREATE NONCLUSTERED INDEX [fkTask_AssignedTo]
    ON [dbo].[TaskAssignment]([fkTask] ASC, [fkApplicationUserAssignedTo] ASC);


GO
CREATE NONCLUSTERED INDEX [fkrefTaskAssignmentStatus]
    ON [dbo].[TaskAssignment]([fkrefTaskAssignmentStatus] ASC);


GO
CREATE NONCLUSTERED INDEX [fkrefTaskAssignmentReason]
    ON [dbo].[TaskAssignment]([fkrefTaskAssignmentReason] ASC);


GO
CREATE Trigger [dbo].[tr_TaskAssignmentAudit_UI] On [dbo].[TaskAssignment]
FOR INSERT, UPDATE
As
SET NOCOUNT ON;

Declare @AuditUser varchar(50)
		,@AuditEndDate datetime
		,@AuditMachine varchar(15)
		,@Date datetime
		,@HostName varchar(50)

select @HostName = host_name()
		,@Date = getdate()

select @AuditUser = @HostName
		,@AuditMachine = ''
		
exec [dbo].[GetAuditDataFromContext] @AuditUser = @AuditUser output ,@AuditMachine = @AuditMachine output

Update TaskAssignment
	 Set [CreateUser] = @AuditUser
,[CreateDate] = @Date
,[LUPUser] = @AuditUser
,[LUPDate] = @Date
	From TaskAssignment dbTable
	Inner Join Inserted i on dbtable.pkTaskAssignment = i.pkTaskAssignment
	Left Join Deleted d on d.pkTaskAssignment = d.pkTaskAssignment
	Where d.pkTaskAssignment is null

Update TaskAssignment
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From TaskAssignment dbTable
	Inner Join Deleted d on dbTable.pkTaskAssignment = d.pkTaskAssignment

--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From TaskAssignmentAudit dbTable
Inner Join inserted i ON dbTable.[pkTaskAssignment] = i.[pkTaskAssignment]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into TaskAssignmentAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkTaskAssignment]
	,[fkTask]
	,[Description]
	,[fkApplicationUserAssignedBy]
	,[fkApplicationUserAssignedTo]
	,[fkTaskAssignmentReassignedTo]
	,[fkrefTaskAssignmentStatus]
	,[StartDate]
	,[CompleteDate]
	,[UserRead]
	,[fkrefTaskAssignmentReason]
	,[UserReadNote]
	,[RecipientHasBeenNotified]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkTaskAssignment]
	,[fkTask]
	,[Description]
	,[fkApplicationUserAssignedBy]
	,[fkApplicationUserAssignedTo]
	,[fkTaskAssignmentReassignedTo]
	,[fkrefTaskAssignmentStatus]
	,[StartDate]
	,[CompleteDate]
	,[UserRead]
	,[fkrefTaskAssignmentReason]
	,[UserReadNote]
	,[RecipientHasBeenNotified]

From  Inserted
GO
CREATE Trigger [dbo].[tr_TaskAssignmentAudit_d] On [dbo].[TaskAssignment]
FOR Delete
As
SET NOCOUNT ON;

Declare @AuditUser varchar(50)
		,@AuditMachine varchar(15)
		,@Date datetime

select @Date = getdate()
select @AuditUser = host_name()
		,@AuditMachine = ''
		
exec [dbo].[GetAuditDataFromContext] @AuditUser = @AuditUser output ,@AuditMachine = @AuditMachine output

--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From TaskAssignmentAudit dbTable
Inner Join deleted d ON dbTable.[pkTaskAssignment] = d.[pkTaskAssignment]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into TaskAssignmentAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkTaskAssignment]
	,[fkTask]
	,[Description]
	,[fkApplicationUserAssignedBy]
	,[fkApplicationUserAssignedTo]
	,[fkTaskAssignmentReassignedTo]
	,[fkrefTaskAssignmentStatus]
	,[StartDate]
	,[CompleteDate]
	,[UserRead]
	,[fkrefTaskAssignmentReason]
	,[UserReadNote]
	,[RecipientHasBeenNotified]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkTaskAssignment]
	,[fkTask]
	,[Description]
	,[fkApplicationUserAssignedBy]
	,[fkApplicationUserAssignedTo]
	,[fkTaskAssignmentReassignedTo]
	,[fkrefTaskAssignmentStatus]
	,[StartDate]
	,[CompleteDate]
	,[UserRead]
	,[fkrefTaskAssignmentReason]
	,[UserReadNote]
	,[RecipientHasBeenNotified]
From  Deleted
GO
CREATE TRIGGER [dbo].[AddNotificationMessageForTaskTracker]
ON [dbo].[TaskAssignment]
AFTER INSERT, UPDATE
AS
SET NOCOUNT ON;

DECLARE @fkApplicationUser int				-- Recipient
DECLARE @fkRefTaskType int					-- Task Type to report
DECLARE @MessageDeliveryType int			-- Polled is only type available currently
DECLARE @NCPApplicationSource int			-- Task Tracker Service
DECLARE @ShowBubbleInSecods int				-- TODO, need to get this value from config
DECLARE @MessageText varchar(500)			-- Text of the message
DECLARE @MessageTitle varchar(100)			-- Title of the message
DECLARE @pkTask int							-- Primary key of newly created task
DECLARE @CreateDate DateTime				-- Date created (also used to determine if tr_TaskAssignmentAudit_UI trigger has completed yet)

-- For Action
DECLARE @TaskID int							-- The TaskActionValue
DECLARE @UserRead bit						-- Has User Read
DECLARE @fkRefTaskAssignmentStatus int		-- Status (assigned, reassigned, complete, etc)

-- For Toast Notifications
DECLARE @UseToastNotification bit			-- Toast or Balloon Notification?
DECLARE @fkAssignedBy int					-- Assigning User
DECLARE @ClientNamesList varchar(255)		-- List of distinct last names of clients associated with the Task
DECLARE @RecipientHasBeenNotified bit		-- Added to prevent multiple notifications for same assignment
DECLARE @pkTaskAssignment decimal(18,0)		-- TaskAssignment being notified
DECLARE @IsNotificationForAssigningUser bit	-- Notification for Recipient or Assigning User?

-- Defaults
SET @MessageDeliveryType = 2
SET @NCPApplicationSource = -10
SET @ShowBubbleInSecods = isnull((SELECT ItemValue FROM dbo.Configuration WHERE ItemKey = 'NotificationBubbleDisplayInSeconds'), 5)


SELECT 
	@TaskID = fkTask,
	@fkApplicationUser = fkApplicationUserAssignedTo,
	@MessageText = [Description],
	@UserRead = UserRead,
	@fkRefTaskAssignmentStatus = fkRefTaskAssignmentStatus,
	@fkAssignedBy = fkApplicationUserAssignedBy,
	@RecipientHasBeenNotified = RecipientHasBeenNotified,
	@pkTaskAssignment = pkTaskAssignment,
	@CreateDate = [CreateDate]
FROM inserted

SET @fkRefTaskType = (SELECT fkRefTaskType FROM dbo.Task WHERE pkTask = @TaskID)

SELECT 
	@MessageTitle = [Description] ,
	@UseToastNotification = UseToastNotifications
FROM dbo.reftaskType
WHERE pkrefTaskType = @fkRefTaskType

SELECT @ClientNamesList = COALESCE(@ClientNamesList+', ' , '') + names.LastName
FROM (
	SELECT DISTINCT LastName
	FROM CPClient c
	INNER JOIN JoinTaskCPClient j ON j.fkCPClient = c.pkCPClient
	WHERE j.fkTask = @TaskID
	UNION
	SELECT DISTINCT LastName
	FROM CPClient c
	INNER JOIN CPJoinClientClientCase jc ON jc.fkCPClient = c.pkCPClient
	INNER JOIN JoinTaskCPClientCase jt ON jt.fkCPClientCase = jc.fkCPClientCase
	WHERE jt.fkTask = @TaskID
	) as names
	
If @ClientNamesList IS NULL
BEGIN
	SET @ClientNamesList = ''
END	


	IF dbo.IsNotificationExcluded(@fkApplicationUser, 'refTaskType', @fkRefTaskType) = 0 
	AND @UserRead = 0 -- Do we need to check this any longer?
	AND @fkRefTaskAssignmentStatus = 1 -- Do we need to check this any longer?
	AND @RecipientHasBeenNotified = 0 -- Added to prevent multiple notifications for same assignment
	AND @CreateDate IS NOT NULL
BEGIN

	--SELECT @ClientNamesList = COALESCE(@ClientNamesList+', ' , '') + names.LastName
	--FROM (
	--	SELECT DISTINCT LastName
	--	FROM CPClient c
	--	INNER JOIN JoinTaskCPClient j ON j.fkCPClient = c.pkCPClient
	--	WHERE j.fkTask = @TaskID
	--	UNION
	--	SELECT DISTINCT LastName
	--	FROM CPClient c
	--	INNER JOIN CPJoinClientClientCase jc ON jc.fkCPClient = c.pkCPClient
	--	INNER JOIN JoinTaskCPClientCase jt ON jt.fkCPClientCase = jc.fkCPClientCase
	--	WHERE jt.fkTask = @TaskID
	--	) as names
		
	--If @ClientNamesList IS NULL
	--BEGIN
	--	SET @ClientNamesList = ''
	--END	

	SET @IsNotificationForAssigningUser = 0

	INSERT INTO NotificationMessage
	(
		fkApplicationUser, 
		MessageDeliveryType, 
		NCPApplicationSource, 
		ShowBubbleSeconds, 
		MessageText, 
		CreateDate, 
		MessageTitle,
		fkAssignedBy,
		fkTask,
		UseToastNotification,
		ClientNamesList,
		IsNotificationForAssigningUser
	)
	VALUES
	(
		@fkApplicationUser, 
		@MessageDeliveryType, 
		@NCPApplicationSource, 
		@ShowBubbleInSecods, 
		@MessageText, 
		@CreateDate, 
		@MessageTitle,
		@fkAssignedBy,
		@TaskID,
		@UseToastNotification,
		@ClientNamesList,
		@IsNotificationForAssigningUser
	)

	SET @pkTask = Scope_Identity()

	-- 3 pieces needed: appID, taskID, action (loaddtaskitem)

	IF NOT EXISTS
	(
		SELECT * FROM NotificationMessageAction 
		WHERE fkNotificationMessage = @pkTask
		AND ActionKey = 'taskID'
		AND ActionValue = @TaskID
	)
	BEGIN

		INSERT INTO NotificationMessageAction
		(
			fkNotificationMessage,
			ActionKey,
			ActionValue
		)
		VALUES
		(
			@pkTask,
			'taskID',
			@TaskID 
		)

	END


	IF NOT EXISTS
	(
		SELECT * FROM NotificationMessageAction 
		WHERE fkNotificationMessage = @pkTask
		AND ActionKey = 'appID'
		AND ActionValue = 22
	)
	BEGIN

		INSERT INTO NotificationMessageAction
		(
			fkNotificationMessage,
			ActionKey,
			ActionValue
		)
		VALUES
		(
			@pkTask,
			'appID',
			22 
		)

	END

	IF NOT EXISTS
	(
		SELECT * FROM NotificationMessageAction 
		WHERE fkNotificationMessage = @pkTask
		AND ActionKey = 'action'
		AND ActionValue = 'LoadTaskItem'
	)
	BEGIN

		INSERT INTO NotificationMessageAction
		(
			fkNotificationMessage,
			ActionKey,
			ActionValue
		)
		VALUES
		(
			@pkTask,
			'action',
			'LoadTaskItem' 
		)

	END
	
	---- Create Notification for Assigning User as well if Notification type is Toast
	--IF @UseToastNotification = 1
	--and dbo.IsNotificationExcluded(@fkAssignedBy, 'refTaskType', @fkRefTaskType) = 0
	--BEGIN
	--	SET @IsNotificationForAssigningUser = 1
	
	--	INSERT INTO NotificationMessage
	--	(
	--		fkApplicationUser, 
	--		MessageDeliveryType, 
	--		NCPApplicationSource, 
	--		ShowBubbleSeconds, 
	--		MessageText, 
	--		CreateDate, 
	--		MessageTitle,
	--		fkAssignedBy,
	--		fkTask,
	--		UseToastNotification,
	--		ClientNamesList,
	--		IsNotificationForAssigningUser
	--	)
	--	VALUES
	--	(
	--		@fkApplicationUser, 
	--		@MessageDeliveryType, 
	--		@NCPApplicationSource, 
	--		@ShowBubbleInSecods, 
	--		@MessageText, 
	--		@CreateDate, 
	--		@MessageTitle,
	--		@fkAssignedBy,
	--		@TaskID,
	--		@UseToastNotification,
	--		@ClientNamesList,
	--		@IsNotificationForAssigningUser
	--	)

	--	SET @pkTask = Scope_Identity()

	--	-- 3 pieces needed: appID, taskID, action (loaddtaskitem)

	--	IF NOT EXISTS
	--	(
	--		SELECT * FROM NotificationMessageAction 
	--		WHERE fkNotificationMessage = @pkTask
	--		AND ActionKey = 'taskID'
	--		AND ActionValue = @TaskID
	--	)
	--	BEGIN

	--		INSERT INTO NotificationMessageAction
	--		(
	--			fkNotificationMessage,
	--			ActionKey,
	--			ActionValue
	--		)
	--		VALUES
	--		(
	--			@pkTask,
	--			'taskID',
	--			@TaskID 
	--		)

	--	END


	--	IF NOT EXISTS
	--	(
	--		SELECT * FROM NotificationMessageAction 
	--		WHERE fkNotificationMessage = @pkTask
	--		AND ActionKey = 'appID'
	--		AND ActionValue = 22
	--	)
	--	BEGIN

	--		INSERT INTO NotificationMessageAction
	--		(
	--			fkNotificationMessage,
	--			ActionKey,
	--			ActionValue
	--		)
	--		VALUES
	--		(
	--			@pkTask,
	--			'appID',
	--			22 
	--		)

	--	END

	--	IF NOT EXISTS
	--	(
	--		SELECT * FROM NotificationMessageAction 
	--		WHERE fkNotificationMessage = @pkTask
	--		AND ActionKey = 'action'
	--		AND ActionValue = 'LoadTaskItem'
	--	)
	--	BEGIN

	--		INSERT INTO NotificationMessageAction
	--		(
	--			fkNotificationMessage,
	--			ActionKey,
	--			ActionValue
	--		)
	--		VALUES
	--		(
	--			@pkTask,
	--			'action',
	--			'LoadTaskItem' 
	--		)

	--	END
	--END

	BEGIN
		UPDATE TaskAssignment
		SET RecipientHasBeenNotified = 1
		WHERE pkTaskAssignment = @pkTaskAssignment
	END
END

-- Create Notification for Assigning User as well if Notification type is Toast
IF @UseToastNotification = 1
	and dbo.IsNotificationExcluded(@fkAssignedBy, 'refTaskType', @fkRefTaskType) = 0
	AND @UserRead = 0 -- Do we need to check this any longer?
	AND @fkRefTaskAssignmentStatus = 1 -- Do we need to check this any longer?
	AND @RecipientHasBeenNotified = 0 -- Added to prevent multiple notifications for same assignment
	AND @CreateDate IS NOT NULL
BEGIN
	SET @IsNotificationForAssigningUser = 1

	INSERT INTO NotificationMessage
	(
		fkApplicationUser, 
		MessageDeliveryType, 
		NCPApplicationSource, 
		ShowBubbleSeconds, 
		MessageText, 
		CreateDate, 
		MessageTitle,
		fkAssignedBy,
		fkTask,
		UseToastNotification,
		ClientNamesList,
		IsNotificationForAssigningUser
	)
	VALUES
	(
		@fkApplicationUser, 
		@MessageDeliveryType, 
		@NCPApplicationSource, 
		@ShowBubbleInSecods, 
		@MessageText, 
		@CreateDate, 
		@MessageTitle,
		@fkAssignedBy,
		@TaskID,
		@UseToastNotification,
		@ClientNamesList,
		@IsNotificationForAssigningUser
	)

	SET @pkTask = Scope_Identity()

	-- 3 pieces needed: appID, taskID, action (loaddtaskitem)

	IF NOT EXISTS
	(
		SELECT * FROM NotificationMessageAction 
		WHERE fkNotificationMessage = @pkTask
		AND ActionKey = 'taskID'
		AND ActionValue = @TaskID
	)
	BEGIN

		INSERT INTO NotificationMessageAction
		(
			fkNotificationMessage,
			ActionKey,
			ActionValue
		)
		VALUES
		(
			@pkTask,
			'taskID',
			@TaskID 
		)

	END


	IF NOT EXISTS
	(
		SELECT * FROM NotificationMessageAction 
		WHERE fkNotificationMessage = @pkTask
		AND ActionKey = 'appID'
		AND ActionValue = 22
	)
	BEGIN

		INSERT INTO NotificationMessageAction
		(
			fkNotificationMessage,
			ActionKey,
			ActionValue
		)
		VALUES
		(
			@pkTask,
			'appID',
			22 
		)

	END

	IF NOT EXISTS
	(
		SELECT * FROM NotificationMessageAction 
		WHERE fkNotificationMessage = @pkTask
		AND ActionKey = 'action'
		AND ActionValue = 'LoadTaskItem'
	)
	BEGIN

		INSERT INTO NotificationMessageAction
		(
			fkNotificationMessage,
			ActionKey,
			ActionValue
		)
		VALUES
		(
			@pkTask,
			'action',
			'LoadTaskItem' 
		)

	END
	BEGIN
		UPDATE TaskAssignment
		SET RecipientHasBeenNotified = 1
		WHERE pkTaskAssignment = @pkTaskAssignment
		and RecipientHasBeenNotified <> 1
	END
END
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table represents the association of a task with an application user. Beyond just acting as a many to many relationship table, this table also stores information about that relationship, including the reason the task was assigned to that user, the assignment status, and who assigned the task.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaskAssignment';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaskAssignment', @level2type = N'COLUMN', @level2name = N'pkTaskAssignment';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the Task table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaskAssignment', @level2type = N'COLUMN', @level2name = N'fkTask';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Description of the task (this appears to match the description in the task table, and may be normalized out of this table at some point)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaskAssignment', @level2type = N'COLUMN', @level2name = N'Description';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to ApplicationUser indicating the user that assigned the task', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaskAssignment', @level2type = N'COLUMN', @level2name = N'fkApplicationUserAssignedBy';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to ApplicationUser indicating to whom the task was assigned', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaskAssignment', @level2type = N'COLUMN', @level2name = N'fkApplicationUserAssignedTo';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Self-referential key number. If the task has been reassignmed, then this will indicate the new relationship. Queries on this field for null values will give the current task assignments.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaskAssignment', @level2type = N'COLUMN', @level2name = N'fkTaskAssignmentReassignedTo';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to refTaskAssignmentStatus', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaskAssignment', @level2type = N'COLUMN', @level2name = N'fkrefTaskAssignmentStatus';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Datetime that the task was started', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaskAssignment', @level2type = N'COLUMN', @level2name = N'StartDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'DateTime that the task was completed. This is also identical to the information in the Task table and may be normalized out at some point.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaskAssignment', @level2type = N'COLUMN', @level2name = N'CompleteDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'1 = User has read this task. 0= Task is in unread status', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaskAssignment', @level2type = N'COLUMN', @level2name = N'UserRead';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaskAssignment', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaskAssignment', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaskAssignment', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaskAssignment', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to refTaskAssigmentReason', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaskAssignment', @level2type = N'COLUMN', @level2name = N'fkrefTaskAssignmentReason';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Indicates whether or not the user read the note for the task', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaskAssignment', @level2type = N'COLUMN', @level2name = N'UserReadNote';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Flag to determine if the recipient has already been notified. For determining whether to send Toast or Balloon notification when task is marked as unread.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaskAssignment', @level2type = N'COLUMN', @level2name = N'RecipientHasBeenNotified';

