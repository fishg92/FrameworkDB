CREATE TABLE [dbo].[ScannedDocTypeMapping] (
    [pkScannedDocTypeMapping] DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [ScannedDocType]          VARCHAR (100) NULL,
    [MappedDocType]           VARCHAR (100) NULL,
    [LUPUser]                 VARCHAR (50)  NULL,
    [LUPDate]                 DATETIME      NULL,
    [CreateUser]              VARCHAR (50)  NULL,
    [CreateDate]              DATETIME      NULL,
    CONSTRAINT [PK_ScannedDocTypeMapping] PRIMARY KEY CLUSTERED ([pkScannedDocTypeMapping] ASC)
);


GO
CREATE Trigger [dbo].[tr_ScannedDocTypeMappingAudit_d] On [dbo].[ScannedDocTypeMapping]
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
From ScannedDocTypeMappingAudit dbTable
Inner Join deleted d ON dbTable.[pkScannedDocTypeMapping] = d.[pkScannedDocTypeMapping]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into ScannedDocTypeMappingAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkScannedDocTypeMapping]
	,[ScannedDocType]
	,[MappedDocType]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkScannedDocTypeMapping]
	,[ScannedDocType]
	,[MappedDocType]
From  Deleted
GO
CREATE Trigger [dbo].[tr_ScannedDocTypeMappingAudit_UI] On [dbo].[ScannedDocTypeMapping]
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

Update ScannedDocTypeMapping
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From ScannedDocTypeMapping dbTable
	Inner Join Inserted i on dbtable.pkScannedDocTypeMapping = i.pkScannedDocTypeMapping
	Left Join Deleted d on d.pkScannedDocTypeMapping = d.pkScannedDocTypeMapping
	Where d.pkScannedDocTypeMapping is null

Update ScannedDocTypeMapping
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From ScannedDocTypeMapping dbTable
	Inner Join Deleted d on dbTable.pkScannedDocTypeMapping = d.pkScannedDocTypeMapping
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From ScannedDocTypeMappingAudit dbTable
Inner Join inserted i ON dbTable.[pkScannedDocTypeMapping] = i.[pkScannedDocTypeMapping]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into ScannedDocTypeMappingAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkScannedDocTypeMapping]
	,[ScannedDocType]
	,[MappedDocType]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkScannedDocTypeMapping]
	,[ScannedDocType]
	,[MappedDocType]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table appears to be deprecated.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ScannedDocTypeMapping';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ScannedDocTypeMapping', @level2type = N'COLUMN', @level2name = N'pkScannedDocTypeMapping';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ScannedDocTypeMapping', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ScannedDocTypeMapping', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ScannedDocTypeMapping', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ScannedDocTypeMapping', @level2type = N'COLUMN', @level2name = N'CreateDate';

