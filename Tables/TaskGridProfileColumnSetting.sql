CREATE TABLE [dbo].[TaskGridProfileColumnSetting] (
    [pkTaskGridProfileColumnSetting] DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [fkProfile]                      DECIMAL (18)  NOT NULL,
    [SettingsData]                   VARCHAR (MAX) NOT NULL,
    CONSTRAINT [pkProfileTaskGridColumnSetting] PRIMARY KEY CLUSTERED ([pkTaskGridProfileColumnSetting] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkProfile]
    ON [dbo].[TaskGridProfileColumnSetting]([fkProfile] ASC);


GO
CREATE Trigger [dbo].[tr_TaskGridProfileColumnSettingAudit_d] On [dbo].[TaskGridProfileColumnSetting]
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
From TaskGridProfileColumnSettingAudit dbTable
Inner Join deleted d ON dbTable.[pkTaskGridProfileColumnSetting] = d.[pkTaskGridProfileColumnSetting]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into TaskGridProfileColumnSettingAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkTaskGridProfileColumnSetting]
	,[fkProfile]
	,[SettingsData]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkTaskGridProfileColumnSetting]
	,[fkProfile]
	,[SettingsData]
From  Deleted
GO
CREATE Trigger [dbo].[tr_TaskGridProfileColumnSettingAudit_UI] On [dbo].[TaskGridProfileColumnSetting]
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
From TaskGridProfileColumnSettingAudit dbTable
Inner Join inserted i ON dbTable.[pkTaskGridProfileColumnSetting] = i.[pkTaskGridProfileColumnSetting]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into TaskGridProfileColumnSettingAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkTaskGridProfileColumnSetting]
	,[fkProfile]
	,[SettingsData]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkTaskGridProfileColumnSetting]
	,[fkProfile]
	,[SettingsData]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table stores information on how to display the columns in the task grid', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaskGridProfileColumnSetting';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaskGridProfileColumnSetting', @level2type = N'COLUMN', @level2name = N'pkTaskGridProfileColumnSetting';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to Profile', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaskGridProfileColumnSetting', @level2type = N'COLUMN', @level2name = N'fkProfile';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Setting information for the column', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaskGridProfileColumnSetting', @level2type = N'COLUMN', @level2name = N'SettingsData';

