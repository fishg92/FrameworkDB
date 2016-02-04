CREATE TABLE [dbo].[ScreenControl] (
    [pkScreenControl] DECIMAL (18)  NOT NULL,
    [ControlName]     VARCHAR (100) NOT NULL,
    [fkScreenName]    DECIMAL (18)  NOT NULL,
    [Sequence]        INT           CONSTRAINT [DF_ScreenControl_Sequence] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_ScreenControl] PRIMARY KEY CLUSTERED ([pkScreenControl] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkScreenName]
    ON [dbo].[ScreenControl]([fkScreenName] ASC);


GO
CREATE Trigger [dbo].[tr_ScreenControlAudit_d] On [dbo].[ScreenControl]
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
From ScreenControlAudit dbTable
Inner Join deleted d ON dbTable.[pkScreenControl] = d.[pkScreenControl]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into ScreenControlAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkScreenControl]
	,[ControlName]
	,[fkScreenName]
	,[Sequence]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkScreenControl]
	,[ControlName]
	,[fkScreenName]
	,[Sequence]
From  Deleted
GO
CREATE Trigger [dbo].[tr_ScreenControlAudit_UI] On [dbo].[ScreenControl]
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
From ScreenControlAudit dbTable
Inner Join inserted i ON dbTable.[pkScreenControl] = i.[pkScreenControl]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into ScreenControlAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkScreenControl]
	,[ControlName]
	,[fkScreenName]
	,[Sequence]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkScreenControl]
	,[ControlName]
	,[fkScreenName]
	,[Sequence]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table is used to configure the controls that show on Self-Scan Kiosk screens.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ScreenControl';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ScreenControl', @level2type = N'COLUMN', @level2name = N'pkScreenControl';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Name of the control on the screen', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ScreenControl', @level2type = N'COLUMN', @level2name = N'ControlName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to Screen Name', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ScreenControl', @level2type = N'COLUMN', @level2name = N'fkScreenName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Order in which controls are to be shown', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ScreenControl', @level2type = N'COLUMN', @level2name = N'Sequence';

