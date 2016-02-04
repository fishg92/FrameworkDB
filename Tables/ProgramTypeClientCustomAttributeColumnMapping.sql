CREATE TABLE [dbo].[ProgramTypeClientCustomAttributeColumnMapping] (
    [pkProgramTypeClientCustomAttributeColumnMapping] DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [fkProgramType]                                   DECIMAL (18)  NOT NULL,
    [ClientCustomAttributeColumn]                     VARCHAR (200) NOT NULL,
    [LUPUser]                                         VARCHAR (50)  NULL,
    [LUPDate]                                         DATETIME      NULL,
    [CreateUser]                                      VARCHAR (50)  NULL,
    [CreateDate]                                      DATETIME      NULL,
    CONSTRAINT [PK_ProgramTypeClientCustomAttributeColumnMapping] PRIMARY KEY CLUSTERED ([pkProgramTypeClientCustomAttributeColumnMapping] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkProgramType]
    ON [dbo].[ProgramTypeClientCustomAttributeColumnMapping]([fkProgramType] ASC);


GO
CREATE Trigger [dbo].[tr_ProgramTypeClientCustomAttributeColumnMappingAudit_d] On [dbo].[ProgramTypeClientCustomAttributeColumnMapping]
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
From ProgramTypeClientCustomAttributeColumnMappingAudit dbTable
Inner Join deleted d ON dbTable.[pkProgramTypeClientCustomAttributeColumnMapping] = d.[pkProgramTypeClientCustomAttributeColumnMapping]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into ProgramTypeClientCustomAttributeColumnMappingAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkProgramTypeClientCustomAttributeColumnMapping]
	,[fkProgramType]
	,[ClientCustomAttributeColumn]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkProgramTypeClientCustomAttributeColumnMapping]
	,[fkProgramType]
	,[ClientCustomAttributeColumn]
From  Deleted
GO
CREATE Trigger [dbo].[tr_ProgramTypeClientCustomAttributeColumnMappingAudit_UI] On [dbo].[ProgramTypeClientCustomAttributeColumnMapping]
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

Update ProgramTypeClientCustomAttributeColumnMapping
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From ProgramTypeClientCustomAttributeColumnMapping dbTable
	Inner Join Inserted i on dbtable.pkProgramTypeClientCustomAttributeColumnMapping = i.pkProgramTypeClientCustomAttributeColumnMapping
	Left Join Deleted d on d.pkProgramTypeClientCustomAttributeColumnMapping = d.pkProgramTypeClientCustomAttributeColumnMapping
	Where d.pkProgramTypeClientCustomAttributeColumnMapping is null

Update ProgramTypeClientCustomAttributeColumnMapping
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From ProgramTypeClientCustomAttributeColumnMapping dbTable
	Inner Join Deleted d on dbTable.pkProgramTypeClientCustomAttributeColumnMapping = d.pkProgramTypeClientCustomAttributeColumnMapping
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From ProgramTypeClientCustomAttributeColumnMappingAudit dbTable
Inner Join inserted i ON dbTable.[pkProgramTypeClientCustomAttributeColumnMapping] = i.[pkProgramTypeClientCustomAttributeColumnMapping]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into ProgramTypeClientCustomAttributeColumnMappingAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkProgramTypeClientCustomAttributeColumnMapping]
	,[fkProgramType]
	,[ClientCustomAttributeColumn]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkProgramTypeClientCustomAttributeColumnMapping]
	,[fkProgramType]
	,[ClientCustomAttributeColumn]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table is used to configure the import of client information.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProgramTypeClientCustomAttributeColumnMapping';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProgramTypeClientCustomAttributeColumnMapping', @level2type = N'COLUMN', @level2name = N'pkProgramTypeClientCustomAttributeColumnMapping';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to Program Type', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProgramTypeClientCustomAttributeColumnMapping', @level2type = N'COLUMN', @level2name = N'fkProgramType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The column with the data for the program', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProgramTypeClientCustomAttributeColumnMapping', @level2type = N'COLUMN', @level2name = N'ClientCustomAttributeColumn';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProgramTypeClientCustomAttributeColumnMapping', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProgramTypeClientCustomAttributeColumnMapping', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProgramTypeClientCustomAttributeColumnMapping', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProgramTypeClientCustomAttributeColumnMapping', @level2type = N'COLUMN', @level2name = N'CreateDate';

