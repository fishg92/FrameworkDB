CREATE TABLE [dbo].[PSPSetting] (
    [pkPSPSetting] DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [SettingName]  VARCHAR (200) NOT NULL,
    [SettingValue] VARCHAR (500) NOT NULL,
    [LUPUser]      VARCHAR (50)  NULL,
    [LUPDate]      DATETIME      NULL,
    [CreateUser]   VARCHAR (50)  NULL,
    [CreateDate]   DATETIME      NULL,
    CONSTRAINT [PK_PSPSetting] PRIMARY KEY CLUSTERED ([pkPSPSetting] ASC)
);


GO
CREATE Trigger [dbo].[tr_PSPSettingAudit_UI] On [dbo].[PSPSetting]
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

Update PSPSetting
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From PSPSetting dbTable
	Inner Join Inserted i on dbtable.pkPSPSetting = i.pkPSPSetting
	Left Join Deleted d on d.pkPSPSetting = d.pkPSPSetting
	Where d.pkPSPSetting is null

Update PSPSetting
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From PSPSetting dbTable
	Inner Join Deleted d on dbTable.pkPSPSetting = d.pkPSPSetting
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From PSPSettingAudit dbTable
Inner Join inserted i ON dbTable.[pkPSPSetting] = i.[pkPSPSetting]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into PSPSettingAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkPSPSetting]
	,[SettingName]
	,[SettingValue]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkPSPSetting]
	,[SettingName]
	,[SettingValue]

From  Inserted
GO
CREATE Trigger [dbo].[tr_PSPSettingAudit_d] On [dbo].[PSPSetting]
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
From PSPSettingAudit dbTable
Inner Join deleted d ON dbTable.[pkPSPSetting] = d.[pkPSPSetting]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into PSPSettingAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkPSPSetting]
	,[SettingName]
	,[SettingValue]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkPSPSetting]
	,[SettingName]
	,[SettingValue]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'PSP is a way to treat any file the same as the output from Forms. The file is printed from any application, keywords are added, and a Compass Document is created. This table manages setting to enable PSP in the client environment.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPSetting';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPSetting', @level2type = N'COLUMN', @level2name = N'pkPSPSetting';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Setting key value (description of what the setting is)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPSetting', @level2type = N'COLUMN', @level2name = N'SettingName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Setting value (What the setting is set to)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPSetting', @level2type = N'COLUMN', @level2name = N'SettingValue';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPSetting', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPSetting', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPSetting', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPSetting', @level2type = N'COLUMN', @level2name = N'CreateDate';

