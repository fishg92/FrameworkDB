CREATE TABLE [dbo].[SmartView] (
    [pkSmartView] DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [Description] VARCHAR (100) NOT NULL,
    [IsDefault]   BIT           NOT NULL,
    CONSTRAINT [PK_SmartView] PRIMARY KEY CLUSTERED ([pkSmartView] ASC)
);


GO
CREATE Trigger [dbo].[tr_SmartViewAudit_d] On [dbo].[SmartView]
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
From SmartViewAudit dbTable
Inner Join deleted d ON dbTable.[pkSmartView] = d.[pkSmartView]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into SmartViewAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkSmartView]
	,[Description]
	,[IsDefault]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkSmartView]
	,[Description]
	,[IsDefault]
From  Deleted
GO
CREATE Trigger [dbo].[tr_SmartViewAudit_UI] On [dbo].[SmartView]
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
From SmartViewAudit dbTable
Inner Join inserted i ON dbTable.[pkSmartView] = i.[pkSmartView]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into SmartViewAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkSmartView]
	,[Description]
	,[IsDefault]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkSmartView]
	,[Description]
	,[IsDefault]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table stores information about the different smart views in the system and also determines which (if any) is the default.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'SmartView';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'SmartView', @level2type = N'COLUMN', @level2name = N'pkSmartView';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Friendly description of the smart view', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'SmartView', @level2type = N'COLUMN', @level2name = N'Description';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Whether or not it is the default', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'SmartView', @level2type = N'COLUMN', @level2name = N'IsDefault';

