CREATE TABLE [dbo].[DocumentJoinProgramTypeDocumentType] (
    [pkDocumentJoinProgramTypeDocumentType] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkProgramType]                         DECIMAL (18) NOT NULL,
    [fkDocumentType]                        VARCHAR (50) NOT NULL,
    [LUPUser]                               VARCHAR (50) NULL,
    [LUPDate]                               DATETIME     NULL,
    [CreateUser]                            VARCHAR (50) NULL,
    [CreateDate]                            DATETIME     NULL,
    CONSTRAINT [PK_JoinProgramTypeDocumentType] PRIMARY KEY CLUSTERED ([pkDocumentJoinProgramTypeDocumentType] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkDocumentType]
    ON [dbo].[DocumentJoinProgramTypeDocumentType]([fkDocumentType] ASC)
    INCLUDE([fkProgramType]) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [fkProgramType]
    ON [dbo].[DocumentJoinProgramTypeDocumentType]([fkProgramType] ASC)
    INCLUDE([fkDocumentType]);


GO
CREATE Trigger [dbo].[tr_DocumentJoinProgramTypeDocumentTypeAudit_UI] On [dbo].[DocumentJoinProgramTypeDocumentType]
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

Update DocumentJoinProgramTypeDocumentType
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From DocumentJoinProgramTypeDocumentType dbTable
	Inner Join Inserted i on dbtable.pkDocumentJoinProgramTypeDocumentType = i.pkDocumentJoinProgramTypeDocumentType
	Left Join Deleted d on d.pkDocumentJoinProgramTypeDocumentType = d.pkDocumentJoinProgramTypeDocumentType
	Where d.pkDocumentJoinProgramTypeDocumentType is null

Update DocumentJoinProgramTypeDocumentType
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From DocumentJoinProgramTypeDocumentType dbTable
	Inner Join Deleted d on dbTable.pkDocumentJoinProgramTypeDocumentType = d.pkDocumentJoinProgramTypeDocumentType
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From DocumentJoinProgramTypeDocumentTypeAudit dbTable
Inner Join inserted i ON dbTable.[pkDocumentJoinProgramTypeDocumentType] = i.[pkDocumentJoinProgramTypeDocumentType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into DocumentJoinProgramTypeDocumentTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkDocumentJoinProgramTypeDocumentType]
	,[fkProgramType]
	,[fkDocumentType]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkDocumentJoinProgramTypeDocumentType]
	,[fkProgramType]
	,[fkDocumentType]

From  Inserted
GO
CREATE Trigger [dbo].[tr_DocumentJoinProgramTypeDocumentTypeAudit_d] On [dbo].[DocumentJoinProgramTypeDocumentType]
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
From DocumentJoinProgramTypeDocumentTypeAudit dbTable
Inner Join deleted d ON dbTable.[pkDocumentJoinProgramTypeDocumentType] = d.[pkDocumentJoinProgramTypeDocumentType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into DocumentJoinProgramTypeDocumentTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkDocumentJoinProgramTypeDocumentType]
	,[fkProgramType]
	,[fkDocumentType]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkDocumentJoinProgramTypeDocumentType]
	,[fkProgramType]
	,[fkDocumentType]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This join table defines the relationship between program types and document types.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentJoinProgramTypeDocumentType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentJoinProgramTypeDocumentType', @level2type = N'COLUMN', @level2name = N'pkDocumentJoinProgramTypeDocumentType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the ProgramType table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentJoinProgramTypeDocumentType', @level2type = N'COLUMN', @level2name = N'fkProgramType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the document type table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentJoinProgramTypeDocumentType', @level2type = N'COLUMN', @level2name = N'fkDocumentType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last update user', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentJoinProgramTypeDocumentType', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentJoinProgramTypeDocumentType', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentJoinProgramTypeDocumentType', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentJoinProgramTypeDocumentType', @level2type = N'COLUMN', @level2name = N'CreateDate';

