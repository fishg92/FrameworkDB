CREATE TABLE [dbo].[TaskGridColumnSetting] (
    [pkTaskGridColumnSetting] DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [fkApplicationUser]       DECIMAL (18)  NOT NULL,
    [SettingsData]            VARCHAR (MAX) NOT NULL,
    CONSTRAINT [PK_TaskGridColumnSetting] PRIMARY KEY CLUSTERED ([pkTaskGridColumnSetting] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [fkApplicationUser]
    ON [dbo].[TaskGridColumnSetting]([fkApplicationUser] ASC);


GO
CREATE Trigger [dbo].[tr_TaskGridColumnSettingAudit_UI] On [dbo].[TaskGridColumnSetting]
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
From TaskGridColumnSettingAudit dbTable
Inner Join inserted i ON dbTable.[pkTaskGridColumnSetting] = i.[pkTaskGridColumnSetting]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into TaskGridColumnSettingAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkTaskGridColumnSetting]
	,[fkApplicationUser]
	,[SettingsData]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkTaskGridColumnSetting]
	,[fkApplicationUser]
	,[SettingsData]

From  Inserted
GO
CREATE Trigger [dbo].[tr_TaskGridColumnSettingAudit_d] On [dbo].[TaskGridColumnSetting]
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
From TaskGridColumnSettingAudit dbTable
Inner Join deleted d ON dbTable.[pkTaskGridColumnSetting] = d.[pkTaskGridColumnSetting]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into TaskGridColumnSettingAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkTaskGridColumnSetting]
	,[fkApplicationUser]
	,[SettingsData]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkTaskGridColumnSetting]
	,[fkApplicationUser]
	,[SettingsData]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table contains information that the TaskGrid uses to store a user''s last settings so that the grid is always presented in the same way to a user and their settings persist from one login to the next.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaskGridColumnSetting';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaskGridColumnSetting', @level2type = N'COLUMN', @level2name = N'pkTaskGridColumnSetting';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to ApplicationUser', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaskGridColumnSetting', @level2type = N'COLUMN', @level2name = N'fkApplicationUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Configuration options string to properly display the grid view', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaskGridColumnSetting', @level2type = N'COLUMN', @level2name = N'SettingsData';

