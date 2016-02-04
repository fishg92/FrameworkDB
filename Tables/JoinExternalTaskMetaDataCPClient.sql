CREATE TABLE [dbo].[JoinExternalTaskMetaDataCPClient] (
    [pkJoinExternalTaskMetaDataCPClient] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkExternalTaskMetaData]             DECIMAL (18) NOT NULL,
    [fkCPClient]                         DECIMAL (18) NOT NULL,
    CONSTRAINT [PK_JoinExternalTaskCPClient] PRIMARY KEY CLUSTERED ([pkJoinExternalTaskMetaDataCPClient] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkCPClient_fkExternalTaskMetaData]
    ON [dbo].[JoinExternalTaskMetaDataCPClient]([fkCPClient] ASC, [fkExternalTaskMetaData] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [fkExternalTaskMetaData_fkCPClient_Unique]
    ON [dbo].[JoinExternalTaskMetaDataCPClient]([fkExternalTaskMetaData] ASC, [fkCPClient] ASC);


GO
CREATE Trigger [dbo].[tr_JoinExternalTaskMetaDataCPClientAudit_d] On [dbo].[JoinExternalTaskMetaDataCPClient]
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
From JoinExternalTaskMetaDataCPClientAudit dbTable
Inner Join deleted d ON dbTable.[pkJoinExternalTaskMetaDataCPClient] = d.[pkJoinExternalTaskMetaDataCPClient]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinExternalTaskMetaDataCPClientAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinExternalTaskMetaDataCPClient]
	,[fkExternalTaskMetaData]
	,[fkCPClient]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkJoinExternalTaskMetaDataCPClient]
	,[fkExternalTaskMetaData]
	,[fkCPClient]
From  Deleted
GO
CREATE Trigger [dbo].[tr_JoinExternalTaskMetaDataCPClientAudit_UI] On [dbo].[JoinExternalTaskMetaDataCPClient]
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
From JoinExternalTaskMetaDataCPClientAudit dbTable
Inner Join inserted i ON dbTable.[pkJoinExternalTaskMetaDataCPClient] = i.[pkJoinExternalTaskMetaDataCPClient]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinExternalTaskMetaDataCPClientAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinExternalTaskMetaDataCPClient]
	,[fkExternalTaskMetaData]
	,[fkCPClient]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkJoinExternalTaskMetaDataCPClient]
	,[fkExternalTaskMetaData]
	,[fkCPClient]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table associates metadata about a task stored in some external system (such as a document management system''s workflow, for example) and assocaites it with a client from the CPClient table.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinExternalTaskMetaDataCPClient';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system identification number.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinExternalTaskMetaDataCPClient', @level2type = N'COLUMN', @level2name = N'pkJoinExternalTaskMetaDataCPClient';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the external tasks'' metadata', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinExternalTaskMetaDataCPClient', @level2type = N'COLUMN', @level2name = N'fkExternalTaskMetaData';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to CPClient', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinExternalTaskMetaDataCPClient', @level2type = N'COLUMN', @level2name = N'fkCPClient';

