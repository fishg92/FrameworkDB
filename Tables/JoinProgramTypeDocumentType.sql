CREATE TABLE [dbo].[JoinProgramTypeDocumentType] (
    [pkJoinProgramTypeDocumentType] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkProgramType]                 DECIMAL (18) NOT NULL,
    [fkDocumentType]                VARCHAR (50) NOT NULL,
    [LUPUser]                       VARCHAR (50) NULL,
    [LUPDate]                       DATETIME     NULL,
    [CreateUser]                    VARCHAR (50) NULL,
    [CreateDate]                    DATETIME     NULL,
    CONSTRAINT [PK_JoinProgramTypeDocumentType_1] PRIMARY KEY CLUSTERED ([pkJoinProgramTypeDocumentType] ASC)
);


GO
CREATE NONCLUSTERED INDEX [ix_JoinProgramTypeDocumentType_fkProgramType]
    ON [dbo].[JoinProgramTypeDocumentType]([fkProgramType] ASC, [fkDocumentType] ASC);


GO
CREATE NONCLUSTERED INDEX [fkDocumentType_fkProgramType]
    ON [dbo].[JoinProgramTypeDocumentType]([fkDocumentType] ASC, [fkProgramType] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE Trigger [dbo].[tr_JoinProgramTypeDocumentTypeAudit_UI] On [dbo].[JoinProgramTypeDocumentType]
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

Update JoinProgramTypeDocumentType
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From JoinProgramTypeDocumentType dbTable
	Inner Join Inserted i on dbtable.pkJoinProgramTypeDocumentType = i.pkJoinProgramTypeDocumentType
	Left Join Deleted d on d.pkJoinProgramTypeDocumentType = d.pkJoinProgramTypeDocumentType
	Where d.pkJoinProgramTypeDocumentType is null

Update JoinProgramTypeDocumentType
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From JoinProgramTypeDocumentType dbTable
	Inner Join Deleted d on dbTable.pkJoinProgramTypeDocumentType = d.pkJoinProgramTypeDocumentType
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From JoinProgramTypeDocumentTypeAudit dbTable
Inner Join inserted i ON dbTable.[pkJoinProgramTypeDocumentType] = i.[pkJoinProgramTypeDocumentType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinProgramTypeDocumentTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinProgramTypeDocumentType]
	,[fkProgramType]
	,[fkDocumentType]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkJoinProgramTypeDocumentType]
	,[fkProgramType]
	,[fkDocumentType]

From  Inserted
GO
CREATE Trigger [dbo].[tr_JoinProgramTypeDocumentTypeAudit_d] On [dbo].[JoinProgramTypeDocumentType]
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
From JoinProgramTypeDocumentTypeAudit dbTable
Inner Join deleted d ON dbTable.[pkJoinProgramTypeDocumentType] = d.[pkJoinProgramTypeDocumentType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinProgramTypeDocumentTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinProgramTypeDocumentType]
	,[fkProgramType]
	,[fkDocumentType]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkJoinProgramTypeDocumentType]
	,[fkProgramType]
	,[fkDocumentType]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table joins Program Types to Document Types.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinProgramTypeDocumentType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinProgramTypeDocumentType', @level2type = N'COLUMN', @level2name = N'pkJoinProgramTypeDocumentType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to ProgramType', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinProgramTypeDocumentType', @level2type = N'COLUMN', @level2name = N'fkProgramType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to DocumentType', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinProgramTypeDocumentType', @level2type = N'COLUMN', @level2name = N'fkDocumentType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinProgramTypeDocumentType', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinProgramTypeDocumentType', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinProgramTypeDocumentType', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinProgramTypeDocumentType', @level2type = N'COLUMN', @level2name = N'CreateDate';

