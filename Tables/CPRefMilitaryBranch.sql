CREATE TABLE [dbo].[CPRefMilitaryBranch] (
    [pkCPRefMilitaryBranch] DECIMAL (18)  NOT NULL,
    [Description]           VARCHAR (255) NULL,
    [LUPUser]               VARCHAR (50)  NULL,
    [LUPDate]               DATETIME      NULL,
    [CreateUser]            VARCHAR (50)  NULL,
    [CreateDate]            DATETIME      NULL,
    CONSTRAINT [PK_CPRefMilitaryBranch] PRIMARY KEY CLUSTERED ([pkCPRefMilitaryBranch] ASC)
);


GO
CREATE Trigger [dbo].[tr_CPRefMilitaryBranchAudit_UI] On [dbo].[CPRefMilitaryBranch]
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

Update CPRefMilitaryBranch
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPRefMilitaryBranch dbTable
	Inner Join Inserted i on dbtable.pkCPRefMilitaryBranch = i.pkCPRefMilitaryBranch
	Left Join Deleted d on d.pkCPRefMilitaryBranch = d.pkCPRefMilitaryBranch
	Where d.pkCPRefMilitaryBranch is null

Update CPRefMilitaryBranch
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPRefMilitaryBranch dbTable
	Inner Join Deleted d on dbTable.pkCPRefMilitaryBranch = d.pkCPRefMilitaryBranch
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From CPRefMilitaryBranchAudit dbTable
Inner Join inserted i ON dbTable.[pkCPRefMilitaryBranch] = i.[pkCPRefMilitaryBranch]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPRefMilitaryBranchAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPRefMilitaryBranch]
	,[Description]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkCPRefMilitaryBranch]
	,[Description]

From  Inserted
GO
CREATE Trigger [dbo].[tr_CPRefMilitaryBranchAudit_d] On [dbo].[CPRefMilitaryBranch]
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
From CPRefMilitaryBranchAudit dbTable
Inner Join deleted d ON dbTable.[pkCPRefMilitaryBranch] = d.[pkCPRefMilitaryBranch]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPRefMilitaryBranchAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPRefMilitaryBranch]
	,[Description]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkCPRefMilitaryBranch]
	,[Description]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This reference table contains look up values for different military branches a client may be a member of (for example, Army or Navy).', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefMilitaryBranch';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system identification number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefMilitaryBranch', @level2type = N'COLUMN', @level2name = N'pkCPRefMilitaryBranch';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Text for the reference type (Army, Navy, etc.)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefMilitaryBranch', @level2type = N'COLUMN', @level2name = N'Description';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefMilitaryBranch', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefMilitaryBranch', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefMilitaryBranch', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefMilitaryBranch', @level2type = N'COLUMN', @level2name = N'CreateDate';

