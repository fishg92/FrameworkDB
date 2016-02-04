CREATE TABLE [dbo].[ExternalDataSystemQuery] (
    [pkExternalDataSystemQuery] DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [fkApplicationUser]         DECIMAL (18)  NULL,
    [fkExternalDataSystem]      DECIMAL (18)  NULL,
    [Query]                     VARCHAR (MAX) NULL,
    CONSTRAINT [PK_ExternalDataSystemRequest] PRIMARY KEY CLUSTERED ([pkExternalDataSystemQuery] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkApplicationUser]
    ON [dbo].[ExternalDataSystemQuery]([fkApplicationUser] ASC);


GO
CREATE NONCLUSTERED INDEX [fkExternalDataSystem]
    ON [dbo].[ExternalDataSystemQuery]([fkExternalDataSystem] ASC);


GO
CREATE Trigger [dbo].[tr_ExternalDataSystemQueryAudit_UI] On [dbo].[ExternalDataSystemQuery]
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
From ExternalDataSystemQueryAudit dbTable
Inner Join inserted i ON dbTable.[pkExternalDataSystemQuery] = i.[pkExternalDataSystemQuery]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into ExternalDataSystemQueryAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkExternalDataSystemQuery]
	,[fkApplicationUser]
	,[fkExternalDataSystem]
	,[Query]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkExternalDataSystemQuery]
	,[fkApplicationUser]
	,[fkExternalDataSystem]
	,[Query]

From  Inserted
GO
CREATE Trigger [dbo].[tr_ExternalDataSystemQueryAudit_d] On [dbo].[ExternalDataSystemQuery]
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
From ExternalDataSystemQueryAudit dbTable
Inner Join deleted d ON dbTable.[pkExternalDataSystemQuery] = d.[pkExternalDataSystemQuery]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into ExternalDataSystemQueryAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkExternalDataSystemQuery]
	,[fkApplicationUser]
	,[fkExternalDataSystem]
	,[Query]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkExternalDataSystemQuery]
	,[fkApplicationUser]
	,[fkExternalDataSystem]
	,[Query]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Query to run in the external data system to return information', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ExternalDataSystemQuery', @level2type = N'COLUMN', @level2name = N'Query';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table has information about queries to run against an external data source', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ExternalDataSystemQuery';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system identification number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ExternalDataSystemQuery', @level2type = N'COLUMN', @level2name = N'pkExternalDataSystemQuery';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the ApplicationUser table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ExternalDataSystemQuery', @level2type = N'COLUMN', @level2name = N'fkApplicationUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the external data system table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ExternalDataSystemQuery', @level2type = N'COLUMN', @level2name = N'fkExternalDataSystem';

