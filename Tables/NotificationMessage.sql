CREATE TABLE [dbo].[NotificationMessage] (
    [pkNotificationMessage]          DECIMAL (18)   IDENTITY (1, 1) NOT NULL,
    [fkApplicationUser]              DECIMAL (18)   NOT NULL,
    [MessageDeliveryType]            INT            CONSTRAINT [DF_NotificationMessage_MessageDeliveryType] DEFAULT ((2)) NOT NULL,
    [NCPApplicationSource]           INT            CONSTRAINT [DF_NotificationMessage_NCPApplicationSource] DEFAULT ((-1)) NOT NULL,
    [ShowBubbleSeconds]              INT            CONSTRAINT [DF_NotificationMessage_ShowBubbleSeconds] DEFAULT ((-1)) NOT NULL,
    [MessageText]                    VARCHAR (200)  CONSTRAINT [DF_NotificationMessage_MessageText] DEFAULT ('') NOT NULL,
    [CreateDate]                     DATETIME       CONSTRAINT [DF_NotificationMessage_CreateDate] DEFAULT (getdate()) NOT NULL,
    [MessageTitle]                   VARCHAR (50)   NOT NULL,
    [LUPUser]                        VARCHAR (50)   NULL,
    [LUPDate]                        DATETIME       NULL,
    [CreateUser]                     VARCHAR (50)   NULL,
    [fkAssignedBy]                   DECIMAL (18)   CONSTRAINT [DF_NotificationMessage_fkAssignedBy] DEFAULT ((0)) NOT NULL,
    [fkTask]                         DECIMAL (18)   CONSTRAINT [DF_NotificationMessage_fkTask] DEFAULT ((0)) NOT NULL,
    [UseToastNotification]           BIT            CONSTRAINT [DF_NotificationMessage_UseToastNotification] DEFAULT ((0)) NOT NULL,
    [ClientNamesList]                NVARCHAR (255) CONSTRAINT [DF_NotificationMessage_ClientNamesList] DEFAULT ('') NOT NULL,
    [IsNotificationForAssigningUser] BIT            CONSTRAINT [DF_NotificationMessage_IsNotificationForAssigningUser] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_NotificationMessage] PRIMARY KEY CLUSTERED ([pkNotificationMessage] ASC),
    CONSTRAINT [CK_NotificationMessage] CHECK ([MessageDeliveryType]=(2) OR [MessageDeliveryType]=(1))
);


GO
CREATE NONCLUSTERED INDEX [fkApplicationUser]
    ON [dbo].[NotificationMessage]([fkApplicationUser] ASC);


GO
CREATE NONCLUSTERED INDEX [fkAssignedBy]
    ON [dbo].[NotificationMessage]([fkAssignedBy] ASC);


GO
CREATE NONCLUSTERED INDEX [fkTask]
    ON [dbo].[NotificationMessage]([fkTask] ASC);


GO
CREATE NONCLUSTERED INDEX [IsNotificationForAssigningUser]
    ON [dbo].[NotificationMessage]([IsNotificationForAssigningUser] ASC)
    INCLUDE([fkApplicationUser]);


GO
CREATE Trigger [dbo].[tr_NotificationMessageAudit_UI] On [dbo].[NotificationMessage]
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

Update NotificationMessage
	 Set [CreateUser] = @AuditUser
,[CreateDate] = @Date
,[LUPUser] = @AuditUser
,[LUPDate] = @Date
	From NotificationMessage dbTable
	Inner Join Inserted i on dbtable.pkNotificationMessage = i.pkNotificationMessage
	Left Join Deleted d on d.pkNotificationMessage = d.pkNotificationMessage
	Where d.pkNotificationMessage is null

Update NotificationMessage
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From NotificationMessage dbTable
	Inner Join Deleted d on dbTable.pkNotificationMessage = d.pkNotificationMessage

--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From NotificationMessageAudit dbTable
Inner Join inserted i ON dbTable.[pkNotificationMessage] = i.[pkNotificationMessage]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into NotificationMessageAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkNotificationMessage]
	,[fkApplicationUser]
	,[MessageDeliveryType]
	,[NCPApplicationSource]
	,[ShowBubbleSeconds]
	,[MessageText]
	,[MessageTitle]
	,[fkAssignedBy]
	,[fkTask]
	,[UseToastNotification]
	,[ClientNamesList]
	,[IsNotificationForAssigningUser]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkNotificationMessage]
	,[fkApplicationUser]
	,[MessageDeliveryType]
	,[NCPApplicationSource]
	,[ShowBubbleSeconds]
	,[MessageText]
	,[MessageTitle]
	,[fkAssignedBy]
	,[fkTask]
	,[UseToastNotification]
	,[ClientNamesList]
	,[IsNotificationForAssigningUser]

From  Inserted
GO
CREATE Trigger [dbo].[tr_NotificationMessageAudit_d] On [dbo].[NotificationMessage]
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
From NotificationMessageAudit dbTable
Inner Join deleted d ON dbTable.[pkNotificationMessage] = d.[pkNotificationMessage]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into NotificationMessageAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkNotificationMessage]
	,[fkApplicationUser]
	,[MessageDeliveryType]
	,[NCPApplicationSource]
	,[ShowBubbleSeconds]
	,[MessageText]
	,[MessageTitle]
	,[fkAssignedBy]
	,[fkTask]
	,[UseToastNotification]
	,[ClientNamesList]
	,[IsNotificationForAssigningUser]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkNotificationMessage]
	,[fkApplicationUser]
	,[MessageDeliveryType]
	,[NCPApplicationSource]
	,[ShowBubbleSeconds]
	,[MessageText]
	,[MessageTitle]
	,[fkAssignedBy]
	,[fkTask]
	,[UseToastNotification]
	,[ClientNamesList]
	,[IsNotificationForAssigningUser]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table stores a list of messages that have been sent to the notification area by Compass', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'NotificationMessage';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'NotificationMessage', @level2type = N'COLUMN', @level2name = N'pkNotificationMessage';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to ApplicationUser', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'NotificationMessage', @level2type = N'COLUMN', @level2name = N'fkApplicationUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Message Delivery type', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'NotificationMessage', @level2type = N'COLUMN', @level2name = N'MessageDeliveryType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Source of the message', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'NotificationMessage', @level2type = N'COLUMN', @level2name = N'NCPApplicationSource';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'How long to show the bubble in the notification tray', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'NotificationMessage', @level2type = N'COLUMN', @level2name = N'ShowBubbleSeconds';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Text of the message shown', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'NotificationMessage', @level2type = N'COLUMN', @level2name = N'MessageText';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date and time that the iteam was shown ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'NotificationMessage', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Title of the message bubble', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'NotificationMessage', @level2type = N'COLUMN', @level2name = N'MessageTitle';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'NotificationMessage', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'NotificationMessage', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'NotificationMessage', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The foreign key to the ApplicationUser record that assigned this task.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'NotificationMessage', @level2type = N'COLUMN', @level2name = N'fkAssignedBy';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The foreign key to the Task this Notification is for.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'NotificationMessage', @level2type = N'COLUMN', @level2name = N'fkTask';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Flag determining whether the Notification should be a Toast or a Balloon message. Default type is Balloon.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'NotificationMessage', @level2type = N'COLUMN', @level2name = N'UseToastNotification';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'A list of distinct last names of clients related to this Task. For use with Toast messages.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'NotificationMessage', @level2type = N'COLUMN', @level2name = N'ClientNamesList';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Flag determining if the notification is for the Recipient of the Task or for the user who assigned the task to the recipient.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'NotificationMessage', @level2type = N'COLUMN', @level2name = N'IsNotificationForAssigningUser';

