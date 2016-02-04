CREATE TABLE [dbo].[JoinProfileDocumentType] (
    [pkJoinProfileDocumentType] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkProfile]                 DECIMAL (18) NOT NULL,
    [fkDocumentType]            VARCHAR (50) NOT NULL,
    [LUPUser]                   VARCHAR (50) NULL,
    [LUPDate]                   DATETIME     NULL,
    [CreateUser]                VARCHAR (50) NULL,
    [CreateDate]                DATETIME     NULL,
    CONSTRAINT [PK_JoinProfileDocumentType_1] PRIMARY KEY CLUSTERED ([pkJoinProfileDocumentType] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkDocumentType]
    ON [dbo].[JoinProfileDocumentType]([fkDocumentType] ASC)
    INCLUDE([fkProfile]);


GO
CREATE NONCLUSTERED INDEX [fkProfile]
    ON [dbo].[JoinProfileDocumentType]([fkProfile] ASC)
    INCLUDE([fkDocumentType]);


GO
CREATE Trigger [dbo].[tr_JoinProfileDocumentTypeAudit_UI] On [dbo].[JoinProfileDocumentType]
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

Update JoinProfileDocumentType
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From JoinProfileDocumentType dbTable
	Inner Join Inserted i on dbtable.pkJoinProfileDocumentType = i.pkJoinProfileDocumentType
	Left Join Deleted d on d.pkJoinProfileDocumentType = d.pkJoinProfileDocumentType
	Where d.pkJoinProfileDocumentType is null

Update JoinProfileDocumentType
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From JoinProfileDocumentType dbTable
	Inner Join Deleted d on dbTable.pkJoinProfileDocumentType = d.pkJoinProfileDocumentType
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From JoinProfileDocumentTypeAudit dbTable
Inner Join inserted i ON dbTable.[pkJoinProfileDocumentType] = i.[pkJoinProfileDocumentType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinProfileDocumentTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinProfileDocumentType]
	,[fkProfile]
	,[fkDocumentType]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkJoinProfileDocumentType]
	,[fkProfile]
	,[fkDocumentType]

From  Inserted
GO
CREATE Trigger [dbo].[tr_JoinProfileDocumentTypeAudit_d] On [dbo].[JoinProfileDocumentType]
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
From JoinProfileDocumentTypeAudit dbTable
Inner Join deleted d ON dbTable.[pkJoinProfileDocumentType] = d.[pkJoinProfileDocumentType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinProfileDocumentTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinProfileDocumentType]
	,[fkProfile]
	,[fkDocumentType]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkJoinProfileDocumentType]
	,[fkProfile]
	,[fkDocumentType]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinProfileDocumentType', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinProfileDocumentType', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table joins DocumentTypes to individual profiles', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinProfileDocumentType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinProfileDocumentType', @level2type = N'COLUMN', @level2name = N'pkJoinProfileDocumentType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key Profile', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinProfileDocumentType', @level2type = N'COLUMN', @level2name = N'fkProfile';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key DocumentType', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinProfileDocumentType', @level2type = N'COLUMN', @level2name = N'fkDocumentType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinProfileDocumentType', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinProfileDocumentType', @level2type = N'COLUMN', @level2name = N'LUPDate';

