CREATE TABLE [dbo].[ScreenName] (
    [pkScreenName]        DECIMAL (18)  NOT NULL,
    [Description]         VARCHAR (50)  NOT NULL,
    [AppID]               DECIMAL (18)  NOT NULL,
    [FriendlyDescription] VARCHAR (100) NULL,
    [Sequence]            INT           CONSTRAINT [DF_ScreenName_ScreenName] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_ScreenName] PRIMARY KEY CLUSTERED ([pkScreenName] ASC)
);


GO
CREATE Trigger [dbo].[tr_ScreenNameAudit_UI] On [dbo].[ScreenName]
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
From ScreenNameAudit dbTable
Inner Join inserted i ON dbTable.[pkScreenName] = i.[pkScreenName]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into ScreenNameAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkScreenName]
	,[Description]
	,[AppID]
	,[FriendlyDescription]
	,[Sequence]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkScreenName]
	,[Description]
	,[AppID]
	,[FriendlyDescription]
	,[Sequence]

From  Inserted
GO
CREATE Trigger [dbo].[tr_ScreenNameAudit_d] On [dbo].[ScreenName]
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
From ScreenNameAudit dbTable
Inner Join deleted d ON dbTable.[pkScreenName] = d.[pkScreenName]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into ScreenNameAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkScreenName]
	,[Description]
	,[AppID]
	,[FriendlyDescription]
	,[Sequence]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkScreenName]
	,[Description]
	,[AppID]
	,[FriendlyDescription]
	,[Sequence]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table provides a mapping list for user friendly names for various components.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ScreenName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ScreenName', @level2type = N'COLUMN', @level2name = N'pkScreenName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'System name of the component', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ScreenName', @level2type = N'COLUMN', @level2name = N'Description';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Application that contains the component', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ScreenName', @level2type = N'COLUMN', @level2name = N'AppID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User Friendly name of the component', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ScreenName', @level2type = N'COLUMN', @level2name = N'FriendlyDescription';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Ordering number for the component', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ScreenName', @level2type = N'COLUMN', @level2name = N'Sequence';

