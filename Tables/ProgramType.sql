CREATE TABLE [dbo].[ProgramType] (
    [pkProgramType] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [ProgramType]   VARCHAR (50) NOT NULL,
    [LUPUser]       VARCHAR (50) NULL,
    [LUPDate]       DATETIME     NULL,
    [CreateUser]    VARCHAR (50) NULL,
    [CreateDate]    DATETIME     NULL,
    [ExternalName]  VARCHAR (50) NULL,
    CONSTRAINT [PK_ProgramType] PRIMARY KEY CLUSTERED ([pkProgramType] ASC)
);


GO
CREATE Trigger [dbo].[tr_ProgramTypeAudit_UI] On [dbo].[ProgramType]
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

Update ProgramType
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From ProgramType dbTable
	Inner Join Inserted i on dbtable.pkProgramType = i.pkProgramType
	Left Join Deleted d on d.pkProgramType = d.pkProgramType
	Where d.pkProgramType is null

Update ProgramType
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From ProgramType dbTable
	Inner Join Deleted d on dbTable.pkProgramType = d.pkProgramType
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From ProgramTypeAudit dbTable
Inner Join inserted i ON dbTable.[pkProgramType] = i.[pkProgramType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into ProgramTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkProgramType]
	,[ProgramType]
	,[ExternalName]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkProgramType]
	,[ProgramType]
	,[ExternalName]

From  Inserted
GO
CREATE Trigger [dbo].[tr_ProgramTypeAudit_d] On [dbo].[ProgramType]
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
From ProgramTypeAudit dbTable
Inner Join deleted d ON dbTable.[pkProgramType] = d.[pkProgramType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into ProgramTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkProgramType]
	,[ProgramType]
	,[ExternalName]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkProgramType]
	,[ProgramType]
	,[ExternalName]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table stores information about the different programs that an agency might work with (for example, Medicaid or TANF).', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProgramType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProgramType', @level2type = N'COLUMN', @level2name = N'pkProgramType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Description of the program type (E.G. TANF, Medicaid, etc.)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProgramType', @level2type = N'COLUMN', @level2name = N'ProgramType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProgramType', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProgramType', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProgramType', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProgramType', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'External description', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProgramType', @level2type = N'COLUMN', @level2name = N'ExternalName';

