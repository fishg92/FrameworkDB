CREATE TABLE [dbo].[JoinExternalTaskMetaDataCPClientCase] (
    [pkJoinExternalTaskMetaDataCPClientCase] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkExternalTaskMetaData]                 DECIMAL (18) NOT NULL,
    [fkCPClientCase]                         DECIMAL (18) NOT NULL,
    CONSTRAINT [PK_JoinExternalTaskCPClientCase] PRIMARY KEY CLUSTERED ([pkJoinExternalTaskMetaDataCPClientCase] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkCPClientCase_fkExternalTaskMetaData]
    ON [dbo].[JoinExternalTaskMetaDataCPClientCase]([fkCPClientCase] ASC, [fkExternalTaskMetaData] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [fkExternalTaskMetaData_fkCPClientCase_Unique]
    ON [dbo].[JoinExternalTaskMetaDataCPClientCase]([fkExternalTaskMetaData] ASC, [fkCPClientCase] ASC);


GO
CREATE Trigger [dbo].[tr_JoinExternalTaskMetaDataCPClientCaseAudit_UI] On [dbo].[JoinExternalTaskMetaDataCPClientCase]
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
From JoinExternalTaskMetaDataCPClientCaseAudit dbTable
Inner Join inserted i ON dbTable.[pkJoinExternalTaskMetaDataCPClientCase] = i.[pkJoinExternalTaskMetaDataCPClientCase]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinExternalTaskMetaDataCPClientCaseAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinExternalTaskMetaDataCPClientCase]
	,[fkExternalTaskMetaData]
	,[fkCPClientCase]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkJoinExternalTaskMetaDataCPClientCase]
	,[fkExternalTaskMetaData]
	,[fkCPClientCase]

From  Inserted
GO
CREATE Trigger [dbo].[tr_JoinExternalTaskMetaDataCPClientCaseAudit_d] On [dbo].[JoinExternalTaskMetaDataCPClientCase]
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
From JoinExternalTaskMetaDataCPClientCaseAudit dbTable
Inner Join deleted d ON dbTable.[pkJoinExternalTaskMetaDataCPClientCase] = d.[pkJoinExternalTaskMetaDataCPClientCase]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinExternalTaskMetaDataCPClientCaseAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinExternalTaskMetaDataCPClientCase]
	,[fkExternalTaskMetaData]
	,[fkCPClientCase]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkJoinExternalTaskMetaDataCPClientCase]
	,[fkExternalTaskMetaData]
	,[fkCPClientCase]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table associates metadata about a task stored in some external system (such as a document management system''s workflow, for example) and assocaites it with a client case from the CPClientCase table.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinExternalTaskMetaDataCPClientCase';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinExternalTaskMetaDataCPClientCase', @level2type = N'COLUMN', @level2name = N'pkJoinExternalTaskMetaDataCPClientCase';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the external tasks'' metadata', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinExternalTaskMetaDataCPClientCase', @level2type = N'COLUMN', @level2name = N'fkExternalTaskMetaData';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to CPClientCase', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinExternalTaskMetaDataCPClientCase', @level2type = N'COLUMN', @level2name = N'fkCPClientCase';

