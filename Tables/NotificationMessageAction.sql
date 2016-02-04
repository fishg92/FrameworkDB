CREATE TABLE [dbo].[NotificationMessageAction] (
    [pkNotificationMessageAction] DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [fkNotificationMessage]       DECIMAL (18)  NOT NULL,
    [ActionKey]                   VARCHAR (255) NOT NULL,
    [ActionValue]                 VARCHAR (255) NOT NULL,
    [LUPUser]                     VARCHAR (50)  NULL,
    [LUPDate]                     DATETIME      NULL,
    [CreateUser]                  VARCHAR (50)  NULL,
    [CreateDate]                  DATETIME      NULL,
    CONSTRAINT [PK_NotificationMessageAction] PRIMARY KEY CLUSTERED ([pkNotificationMessageAction] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_NotificationMessageAction]
    ON [dbo].[NotificationMessageAction]([fkNotificationMessage] ASC, [ActionKey] ASC, [ActionValue] ASC);


GO
CREATE Trigger [dbo].[tr_NotificationMessageActionAudit_UI] On [dbo].[NotificationMessageAction]
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

Update NotificationMessageAction
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From NotificationMessageAction dbTable
	Inner Join Inserted i on dbtable.pkNotificationMessageAction = i.pkNotificationMessageAction
	Left Join Deleted d on d.pkNotificationMessageAction = d.pkNotificationMessageAction
	Where d.pkNotificationMessageAction is null

Update NotificationMessageAction
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From NotificationMessageAction dbTable
	Inner Join Deleted d on dbTable.pkNotificationMessageAction = d.pkNotificationMessageAction
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From NotificationMessageActionAudit dbTable
Inner Join inserted i ON dbTable.[pkNotificationMessageAction] = i.[pkNotificationMessageAction]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into NotificationMessageActionAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkNotificationMessageAction]
	,[fkNotificationMessage]
	,[ActionKey]
	,[ActionValue]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkNotificationMessageAction]
	,[fkNotificationMessage]
	,[ActionKey]
	,[ActionValue]

From  Inserted
GO
CREATE Trigger [dbo].[tr_NotificationMessageActionAudit_d] On [dbo].[NotificationMessageAction]
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
From NotificationMessageActionAudit dbTable
Inner Join deleted d ON dbTable.[pkNotificationMessageAction] = d.[pkNotificationMessageAction]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into NotificationMessageActionAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkNotificationMessageAction]
	,[fkNotificationMessage]
	,[ActionKey]
	,[ActionValue]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkNotificationMessageAction]
	,[fkNotificationMessage]
	,[ActionKey]
	,[ActionValue]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Actions taken for different notification messages. Each message generates a few different actions, and what those actions were, and the relevant values for those actions, are stored here.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'NotificationMessageAction';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'NotificationMessageAction', @level2type = N'COLUMN', @level2name = N'pkNotificationMessageAction';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to Notification Message', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'NotificationMessageAction', @level2type = N'COLUMN', @level2name = N'fkNotificationMessage';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Each notification message has several actions that get stored with it: the taskID, the appID, and the action that raised the message', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'NotificationMessageAction', @level2type = N'COLUMN', @level2name = N'ActionKey';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'What is the value for the corresponding key.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'NotificationMessageAction', @level2type = N'COLUMN', @level2name = N'ActionValue';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'NotificationMessageAction', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'NotificationMessageAction', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'NotificationMessageAction', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'NotificationMessageAction', @level2type = N'COLUMN', @level2name = N'CreateDate';

