CREATE TABLE [dbo].[CPEmployer] (
    [pkCPEmployer] DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [EmployerName] VARCHAR (255) NULL,
    [Street1]      VARCHAR (100) NULL,
    [Street2]      VARCHAR (100) NULL,
    [Street3]      VARCHAR (100) NULL,
    [City]         VARCHAR (100) NULL,
    [State]        VARCHAR (50)  NULL,
    [Zip]          CHAR (5)      NULL,
    [ZipPlus4]     CHAR (4)      NULL,
    [Phone]        VARCHAR (10)  NULL,
    [Salary]       VARCHAR (50)  NULL,
    [LUPUser]      VARCHAR (50)  NULL,
    [LUPDate]      DATETIME      NULL,
    [CreateUser]   VARCHAR (50)  NULL,
    [CreateDate]   DATETIME      NULL,
    CONSTRAINT [PK_CPEmployer] PRIMARY KEY CLUSTERED ([pkCPEmployer] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxEmployerName]
    ON [dbo].[CPEmployer]([EmployerName] ASC)
    INCLUDE([pkCPEmployer]) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE Trigger [dbo].[tr_CPEmployerAudit_d] On [dbo].[CPEmployer]
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
From CPEmployerAudit dbTable
Inner Join deleted d ON dbTable.[pkCPEmployer] = d.[pkCPEmployer]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPEmployerAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPEmployer]
	,[EmployerName]
	,[Street1]
	,[Street2]
	,[Street3]
	,[City]
	,[State]
	,[Zip]
	,[ZipPlus4]
	,[Phone]
	,[Salary]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkCPEmployer]
	,[EmployerName]
	,[Street1]
	,[Street2]
	,[Street3]
	,[City]
	,[State]
	,[Zip]
	,[ZipPlus4]
	,[Phone]
	,[Salary]
From  Deleted
GO
CREATE Trigger [dbo].[tr_CPEmployerAudit_UI] On [dbo].[CPEmployer]
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

Update CPEmployer
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPEmployer dbTable
	Inner Join Inserted i on dbtable.pkCPEmployer = i.pkCPEmployer
	Left Join Deleted d on d.pkCPEmployer = d.pkCPEmployer
	Where d.pkCPEmployer is null

Update CPEmployer
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPEmployer dbTable
	Inner Join Deleted d on dbTable.pkCPEmployer = d.pkCPEmployer
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From CPEmployerAudit dbTable
Inner Join inserted i ON dbTable.[pkCPEmployer] = i.[pkCPEmployer]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPEmployerAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPEmployer]
	,[EmployerName]
	,[Street1]
	,[Street2]
	,[Street3]
	,[City]
	,[State]
	,[Zip]
	,[ZipPlus4]
	,[Phone]
	,[Salary]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkCPEmployer]
	,[EmployerName]
	,[Street1]
	,[Street2]
	,[Street3]
	,[City]
	,[State]
	,[Zip]
	,[ZipPlus4]
	,[Phone]
	,[Salary]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table contains a list of businesses that have employed People clients. This table is intended to list the work experience of People clients rather than to provide a unique record for each business. There is no guarantee of uniqueness within the data (even for an individual user).', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPEmployer';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary, system identification number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPEmployer', @level2type = N'COLUMN', @level2name = N'pkCPEmployer';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Employer name', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPEmployer', @level2type = N'COLUMN', @level2name = N'EmployerName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Employer street 1', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPEmployer', @level2type = N'COLUMN', @level2name = N'Street1';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Employer street 2', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPEmployer', @level2type = N'COLUMN', @level2name = N'Street2';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Employer street 3', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPEmployer', @level2type = N'COLUMN', @level2name = N'Street3';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Employer city', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPEmployer', @level2type = N'COLUMN', @level2name = N'City';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Employer State', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPEmployer', @level2type = N'COLUMN', @level2name = N'State';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Employer zip', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPEmployer', @level2type = N'COLUMN', @level2name = N'Zip';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Employer zip +4', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPEmployer', @level2type = N'COLUMN', @level2name = N'ZipPlus4';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Employer phone number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPEmployer', @level2type = N'COLUMN', @level2name = N'Phone';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'What salary the People client was paid', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPEmployer', @level2type = N'COLUMN', @level2name = N'Salary';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPEmployer', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPEmployer', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPEmployer', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPEmployer', @level2type = N'COLUMN', @level2name = N'CreateDate';

