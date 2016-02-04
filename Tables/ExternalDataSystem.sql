CREATE TABLE [dbo].[ExternalDataSystem] (
    [pkExternalDataSystem] DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [Name]                 VARCHAR (255) NULL,
    CONSTRAINT [PK_ExternalDataSystem] PRIMARY KEY CLUSTERED ([pkExternalDataSystem] ASC)
);


GO
CREATE Trigger [dbo].[tr_ExternalDataSystemAudit_d] On [dbo].[ExternalDataSystem]
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
From ExternalDataSystemAudit dbTable
Inner Join deleted d ON dbTable.[pkExternalDataSystem] = d.[pkExternalDataSystem]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into ExternalDataSystemAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkExternalDataSystem]
	,[Name]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkExternalDataSystem]
	,[Name]
From  Deleted
GO
CREATE Trigger [dbo].[tr_ExternalDataSystemAudit_UI] On [dbo].[ExternalDataSystem]
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
From ExternalDataSystemAudit dbTable
Inner Join inserted i ON dbTable.[pkExternalDataSystem] = i.[pkExternalDataSystem]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into ExternalDataSystemAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkExternalDataSystem]
	,[Name]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkExternalDataSystem]
	,[Name]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'List of external systems that have information about People clients.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ExternalDataSystem';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system id number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ExternalDataSystem', @level2type = N'COLUMN', @level2name = N'pkExternalDataSystem';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Description of the external system', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ExternalDataSystem', @level2type = N'COLUMN', @level2name = N'Name';

