CREATE TABLE [dbo].[ExternalDataSystemResult] (
    [pkExternalDataSystemResult] DECIMAL (18)    IDENTITY (1, 1) NOT NULL,
    [fkExternalDataSystemQuery]  DECIMAL (18)    NULL,
    [RawResult]                  VARBINARY (MAX) NULL,
    [ProcessedResult]            VARBINARY (MAX) NULL,
    [Status]                     INT             NULL,
    CONSTRAINT [PK_ExternalDataSystemResponse] PRIMARY KEY CLUSTERED ([pkExternalDataSystemResult] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkExternalDataSystemQuery]
    ON [dbo].[ExternalDataSystemResult]([fkExternalDataSystemQuery] ASC);


GO
CREATE Trigger [dbo].[tr_ExternalDataSystemResultAudit_UI] On [dbo].[ExternalDataSystemResult]
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
From ExternalDataSystemResultAudit dbTable
Inner Join inserted i ON dbTable.[pkExternalDataSystemResult] = i.[pkExternalDataSystemResult]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into ExternalDataSystemResultAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkExternalDataSystemResult]
	,[fkExternalDataSystemQuery]
	,[RawResult]
	,[ProcessedResult]
	,[Status]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkExternalDataSystemResult]
	,[fkExternalDataSystemQuery]
	,0
	,0
	,[Status]

From  Inserted
GO
CREATE Trigger [dbo].[tr_ExternalDataSystemResultAudit_d] On [dbo].[ExternalDataSystemResult]
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
From ExternalDataSystemResultAudit dbTable
Inner Join deleted d ON dbTable.[pkExternalDataSystemResult] = d.[pkExternalDataSystemResult]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into ExternalDataSystemResultAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkExternalDataSystemResult]
	,[fkExternalDataSystemQuery]
	,[RawResult]
	,[ProcessedResult]
	,[Status]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkExternalDataSystemResult]
	,[fkExternalDataSystemQuery]
	,[RawResult]
	,[ProcessedResult]
	,[Status]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Temporarily stores results from querying an external data source', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ExternalDataSystemResult';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ExternalDataSystemResult', @level2type = N'COLUMN', @level2name = N'pkExternalDataSystemResult';

