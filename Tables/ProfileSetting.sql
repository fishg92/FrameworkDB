CREATE TABLE [dbo].[ProfileSetting] (
    [pkProfileSetting] DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [Grouping]         VARCHAR (200) NOT NULL,
    [ItemKey]          VARCHAR (200) NOT NULL,
    [ItemValue]        VARCHAR (MAX) NOT NULL,
    [AppID]            INT           NOT NULL,
    [fkProfile]        DECIMAL (18)  NOT NULL,
    [LUPUser]          VARCHAR (50)  NULL,
    [LUPDate]          DATETIME      NULL,
    [CreateUser]       VARCHAR (50)  NULL,
    [CreateDate]       DATETIME      NULL,
    CONSTRAINT [PK_ProfileSetting] PRIMARY KEY NONCLUSTERED ([pkProfileSetting] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkProfile_ItemKey]
    ON [dbo].[ProfileSetting]([fkProfile] ASC, [ItemKey] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [ItemKey]
    ON [dbo].[ProfileSetting]([ItemKey] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE Trigger [dbo].[tr_ProfileSettingAudit_UI] On [dbo].[ProfileSetting]
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

Update ProfileSetting
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From ProfileSetting dbTable
	Inner Join Inserted i on dbtable.pkProfileSetting = i.pkProfileSetting
	Left Join Deleted d on d.pkProfileSetting = d.pkProfileSetting
	Where d.pkProfileSetting is null

Update ProfileSetting
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From ProfileSetting dbTable
	Inner Join Deleted d on dbTable.pkProfileSetting = d.pkProfileSetting
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From ProfileSettingAudit dbTable
Inner Join inserted i ON dbTable.[pkProfileSetting] = i.[pkProfileSetting]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into ProfileSettingAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkProfileSetting]
	,[Grouping]
	,[ItemKey]
	,[ItemValue]
	,[AppID]
	,[fkProfile]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkProfileSetting]
	,[Grouping]
	,[ItemKey]
	,[ItemValue]
	,[AppID]
	,[fkProfile]

From  Inserted
GO
CREATE Trigger [dbo].[tr_ProfileSettingAudit_d] On [dbo].[ProfileSetting]
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
From ProfileSettingAudit dbTable
Inner Join deleted d ON dbTable.[pkProfileSetting] = d.[pkProfileSetting]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into ProfileSettingAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkProfileSetting]
	,[Grouping]
	,[ItemKey]
	,[ItemValue]
	,[AppID]
	,[fkProfile]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkProfileSetting]
	,[Grouping]
	,[ItemKey]
	,[ItemValue]
	,[AppID]
	,[fkProfile]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This information stores information about how a profile relates to other features in Compass (such as keywords and dataviews).', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProfileSetting';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProfileSetting', @level2type = N'COLUMN', @level2name = N'pkProfileSetting';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Which tab should this information be displayed under?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProfileSetting', @level2type = N'COLUMN', @level2name = N'Grouping';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Key to describe the setting', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProfileSetting', @level2type = N'COLUMN', @level2name = N'ItemKey';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Value to show what the setting has been set to', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProfileSetting', @level2type = N'COLUMN', @level2name = N'ItemValue';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'To which application does this setting apply', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProfileSetting', @level2type = N'COLUMN', @level2name = N'AppID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the profile itself', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProfileSetting', @level2type = N'COLUMN', @level2name = N'fkProfile';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProfileSetting', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProfileSetting', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProfileSetting', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProfileSetting', @level2type = N'COLUMN', @level2name = N'CreateDate';

