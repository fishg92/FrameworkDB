CREATE TABLE [dbo].[UserSettings] (
    [pkUserSettings]    DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [fkApplicationUser] DECIMAL (18)  NOT NULL,
    [Grouping]          VARCHAR (200) NOT NULL,
    [ItemKey]           VARCHAR (200) NOT NULL,
    [ItemValue]         VARCHAR (600) NOT NULL,
    [ItemDescription]   VARCHAR (300) NOT NULL,
    [AppID]             INT           NOT NULL,
    [Sequence]          BIGINT        CONSTRAINT [DF_Configuration_Sequence1] DEFAULT ((1)) NOT NULL,
    [LUPUser]           VARCHAR (50)  NULL,
    [LUPDate]           DATETIME      NULL,
    [CreateUser]        VARCHAR (50)  NULL,
    [CreateDate]        DATETIME      NULL,
    CONSTRAINT [PK_UserSettings] PRIMARY KEY NONCLUSTERED ([pkUserSettings] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkApplicationUser]
    ON [dbo].[UserSettings]([fkApplicationUser] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE Trigger [dbo].[tr_UserSettingsAudit_UI] On [dbo].[UserSettings]
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

Update UserSettings
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From UserSettings dbTable
	Inner Join Inserted i on dbtable.pkUserSettings = i.pkUserSettings
	Left Join Deleted d on d.pkUserSettings = d.pkUserSettings
	Where d.pkUserSettings is null

Update UserSettings
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From UserSettings dbTable
	Inner Join Deleted d on dbTable.pkUserSettings = d.pkUserSettings
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From UserSettingsAudit dbTable
Inner Join inserted i ON dbTable.[pkUserSettings] = i.[pkUserSettings]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into UserSettingsAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkUserSettings]
	,[fkApplicationUser]
	,[Grouping]
	,[ItemKey]
	,[ItemValue]
	,[ItemDescription]
	,[AppID]
	,[Sequence]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkUserSettings]
	,[fkApplicationUser]
	,[Grouping]
	,[ItemKey]
	,[ItemValue]
	,[ItemDescription]
	,[AppID]
	,[Sequence]

From  Inserted
GO
CREATE Trigger [dbo].[tr_UserSettingsAudit_d] On [dbo].[UserSettings]
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
From UserSettingsAudit dbTable
Inner Join deleted d ON dbTable.[pkUserSettings] = d.[pkUserSettings]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into UserSettingsAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkUserSettings]
	,[fkApplicationUser]
	,[Grouping]
	,[ItemKey]
	,[ItemValue]
	,[ItemDescription]
	,[AppID]
	,[Sequence]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkUserSettings]
	,[fkApplicationUser]
	,[Grouping]
	,[ItemKey]
	,[ItemValue]
	,[ItemDescription]
	,[AppID]
	,[Sequence]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table stores UI and other settings to essentially preserve a user''s session across logins.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserSettings';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserSettings', @level2type = N'COLUMN', @level2name = N'pkUserSettings';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to Application User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserSettings', @level2type = N'COLUMN', @level2name = N'fkApplicationUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Grouping for the setting', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserSettings', @level2type = N'COLUMN', @level2name = N'Grouping';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Setting key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserSettings', @level2type = N'COLUMN', @level2name = N'ItemKey';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Setting value', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserSettings', @level2type = N'COLUMN', @level2name = N'ItemValue';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User friendly description of the setting', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserSettings', @level2type = N'COLUMN', @level2name = N'ItemDescription';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Application that the setting relates to', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserSettings', @level2type = N'COLUMN', @level2name = N'AppID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Ordering for settings in the UI', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserSettings', @level2type = N'COLUMN', @level2name = N'Sequence';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserSettings', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserSettings', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserSettings', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserSettings', @level2type = N'COLUMN', @level2name = N'CreateDate';

