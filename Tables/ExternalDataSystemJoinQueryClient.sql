CREATE TABLE [dbo].[ExternalDataSystemJoinQueryClient] (
    [pkExternalDataSystemJoinQueryClient] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkCPClient]                          DECIMAL (18) NOT NULL,
    [fkExternalDataSystemQuery]           DECIMAL (18) NOT NULL,
    CONSTRAINT [PK_ExternalDataSystemJoinQueryClient] PRIMARY KEY CLUSTERED ([pkExternalDataSystemJoinQueryClient] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkCPClient_fkExternalDataSystemQuery]
    ON [dbo].[ExternalDataSystemJoinQueryClient]([fkCPClient] ASC, [fkExternalDataSystemQuery] ASC);


GO
CREATE NONCLUSTERED INDEX [fkExternalDataSystemQuery_fkCPClient]
    ON [dbo].[ExternalDataSystemJoinQueryClient]([fkExternalDataSystemQuery] ASC, [fkCPClient] ASC);


GO
CREATE Trigger [dbo].[tr_ExternalDataSystemJoinQueryClientAudit_d] On [dbo].[ExternalDataSystemJoinQueryClient]
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
From ExternalDataSystemJoinQueryClientAudit dbTable
Inner Join deleted d ON dbTable.[pkExternalDataSystemJoinQueryClient] = d.[pkExternalDataSystemJoinQueryClient]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into ExternalDataSystemJoinQueryClientAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkExternalDataSystemJoinQueryClient]
	,[fkCPClient]
	,[fkExternalDataSystemQuery]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkExternalDataSystemJoinQueryClient]
	,[fkCPClient]
	,[fkExternalDataSystemQuery]
From  Deleted
GO
CREATE Trigger [dbo].[tr_ExternalDataSystemJoinQueryClientAudit_UI] On [dbo].[ExternalDataSystemJoinQueryClient]
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
From ExternalDataSystemJoinQueryClientAudit dbTable
Inner Join inserted i ON dbTable.[pkExternalDataSystemJoinQueryClient] = i.[pkExternalDataSystemJoinQueryClient]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into ExternalDataSystemJoinQueryClientAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkExternalDataSystemJoinQueryClient]
	,[fkCPClient]
	,[fkExternalDataSystemQuery]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkExternalDataSystemJoinQueryClient]
	,[fkCPClient]
	,[fkExternalDataSystemQuery]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table represents a many to many relationship between a CPClient record and an ExternalDataSystemQuery record.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ExternalDataSystemJoinQueryClient';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ExternalDataSystemJoinQueryClient', @level2type = N'COLUMN', @level2name = N'pkExternalDataSystemJoinQueryClient';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the CPClient table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ExternalDataSystemJoinQueryClient', @level2type = N'COLUMN', @level2name = N'fkCPClient';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the ExternalDataSystemQuery table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ExternalDataSystemJoinQueryClient', @level2type = N'COLUMN', @level2name = N'fkExternalDataSystemQuery';

