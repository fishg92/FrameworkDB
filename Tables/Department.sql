CREATE TABLE [dbo].[Department] (
    [pkDepartment]   DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [DepartmentName] VARCHAR (100) NOT NULL,
    [fkAgencyLOB]    DECIMAL (18)  NOT NULL,
    [LUPUser]        VARCHAR (50)  NULL,
    [LUPDate]        DATETIME      NULL,
    [CreateUser]     VARCHAR (50)  NULL,
    [CreateDate]     DATETIME      NULL,
    [fkSupervisor]   DECIMAL (18)  CONSTRAINT [DF_Department_fkSupervisor] DEFAULT ((-1)) NOT NULL,
    CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED ([pkDepartment] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxfkAgencyLOB]
    ON [dbo].[Department]([fkAgencyLOB] ASC)
    INCLUDE([pkDepartment]) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE Trigger [dbo].[tr_DepartmentAudit_d] On [dbo].[Department]
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
From DepartmentAudit dbTable
Inner Join deleted d ON dbTable.[pkDepartment] = d.[pkDepartment]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into DepartmentAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkDepartment]
	,[DepartmentName]
	,[fkAgencyLOB]
	,[fkSupervisor]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkDepartment]
	,[DepartmentName]
	,[fkAgencyLOB]
	,[fkSupervisor]
From  Deleted
GO
CREATE Trigger [dbo].[tr_DepartmentAudit_UI] On [dbo].[Department]
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

Update Department
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From Department dbTable
	Inner Join Inserted i on dbtable.pkDepartment = i.pkDepartment
	Left Join Deleted d on d.pkDepartment = d.pkDepartment
	Where d.pkDepartment is null

Update Department
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From Department dbTable
	Inner Join Deleted d on dbTable.pkDepartment = d.pkDepartment
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From DepartmentAudit dbTable
Inner Join inserted i ON dbTable.[pkDepartment] = i.[pkDepartment]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into DepartmentAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkDepartment]
	,[DepartmentName]
	,[fkAgencyLOB]
	,[fkSupervisor]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkDepartment]
	,[DepartmentName]
	,[fkAgencyLOB]
	,[fkSupervisor]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table lists the departments within an agency.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Department';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Department', @level2type = N'COLUMN', @level2name = N'pkDepartment';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Name of the department', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Department', @level2type = N'COLUMN', @level2name = N'DepartmentName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the Agency table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Department', @level2type = N'COLUMN', @level2name = N'fkAgencyLOB';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Department', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Department', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Department', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Department', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key that indicates the supervisor for the department', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Department', @level2type = N'COLUMN', @level2name = N'fkSupervisor';

