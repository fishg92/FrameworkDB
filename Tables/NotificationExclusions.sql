CREATE TABLE [dbo].[NotificationExclusions] (
    [pkNotificationExclusions] INT           IDENTITY (1, 1) NOT NULL,
    [TableName]                VARCHAR (100) NOT NULL,
    [fkApplicationUser]        INT           NOT NULL,
    [fkType]                   INT           NOT NULL,
    [TypePkName]               VARCHAR (50)  NOT NULL,
    CONSTRAINT [PK_NotificationExclusions] PRIMARY KEY CLUSTERED ([pkNotificationExclusions] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkApplicationUser]
    ON [dbo].[NotificationExclusions]([fkApplicationUser] ASC);


GO
CREATE Trigger [dbo].[tr_NotificationExclusionsAudit_d] On [dbo].[NotificationExclusions]
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
From NotificationExclusionsAudit dbTable
Inner Join deleted d ON dbTable.[pkNotificationExclusions] = d.[pkNotificationExclusions]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into NotificationExclusionsAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkNotificationExclusions]
	,[TableName]
	,[fkApplicationUser]
	,[fkType]
	,[TypePkName]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkNotificationExclusions]
	,[TableName]
	,[fkApplicationUser]
	,[fkType]
	,[TypePkName]
From  Deleted
GO
CREATE Trigger [dbo].[tr_NotificationExclusionsAudit_UI] On [dbo].[NotificationExclusions]
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


--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From NotificationExclusionsAudit dbTable
Inner Join inserted i ON dbTable.[pkNotificationExclusions] = i.[pkNotificationExclusions]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into NotificationExclusionsAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkNotificationExclusions]
	,[TableName]
	,[fkApplicationUser]
	,[fkType]
	,[TypePkName]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkNotificationExclusions]
	,[TableName]
	,[fkApplicationUser]
	,[fkType]
	,[TypePkName]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table stores exclusion information for users and tasks.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'NotificationExclusions';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'NotificationExclusions', @level2type = N'COLUMN', @level2name = N'pkNotificationExclusions';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The table containing the Types of tasks', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'NotificationExclusions', @level2type = N'COLUMN', @level2name = N'TableName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The user this applies to', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'NotificationExclusions', @level2type = N'COLUMN', @level2name = N'fkApplicationUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The int value that will be applied for exclusion', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'NotificationExclusions', @level2type = N'COLUMN', @level2name = N'fkType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The pk in the provided table to check for fkType value', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'NotificationExclusions', @level2type = N'COLUMN', @level2name = N'TypePkName';

