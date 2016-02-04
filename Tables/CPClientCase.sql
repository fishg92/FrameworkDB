CREATE TABLE [dbo].[CPClientCase] (
    [pkCPClientCase]               DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [StateCaseNumber]              VARCHAR (20) NULL,
    [LocalCaseNumber]              VARCHAR (20) NULL,
    [fkCPRefClientCaseProgramType] DECIMAL (18) NULL,
    [fkCPCaseWorker]               DECIMAL (18) NULL,
    [LockedUser]                   VARCHAR (50) NULL,
    [LockedDate]                   DATETIME     NULL,
    [LUPUser]                      VARCHAR (50) NULL,
    [LUPDate]                      DATETIME     NULL,
    [CreateUser]                   VARCHAR (50) NULL,
    [CreateDate]                   DATETIME     NULL,
    [fkCPClientCaseHead]           DECIMAL (18) NULL,
    [fkApplicationUser]            DECIMAL (18) NULL,
    [DistrictId]                   VARCHAR (50) NULL,
    [CaseStatus]                   BIT          CONSTRAINT [default_active_constraint] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_ClientCase] PRIMARY KEY NONCLUSTERED ([pkCPClientCase] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxLocalCaseNumber]
    ON [dbo].[CPClientCase]([LocalCaseNumber] ASC)
    INCLUDE([pkCPClientCase]) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [fkApplicationUser]
    ON [dbo].[CPClientCase]([fkApplicationUser] ASC);


GO
CREATE NONCLUSTERED INDEX [fkCPRefClientCaseProgramType]
    ON [dbo].[CPClientCase]([fkCPRefClientCaseProgramType] ASC);


GO
CREATE NONCLUSTERED INDEX [idxStateCaseNumberLocalCaseNumber]
    ON [dbo].[CPClientCase]([StateCaseNumber] ASC, [LocalCaseNumber] ASC)
    INCLUDE([pkCPClientCase]);


GO
CREATE NONCLUSTERED INDEX [fkCPCaseWorker]
    ON [dbo].[CPClientCase]([fkCPCaseWorker] ASC)
    INCLUDE([pkCPClientCase]) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE Trigger [dbo].[tr_CPClientCaseAudit_UI] On [dbo].[CPClientCase]
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

Update CPClientCase
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPClientCase dbTable
	Inner Join Inserted i on dbtable.pkCPClientCase = i.pkCPClientCase
	Left Join Deleted d on d.pkCPClientCase = d.pkCPClientCase
	Where d.pkCPClientCase is null

Update CPClientCase
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPClientCase dbTable
	Inner Join Deleted d on dbTable.pkCPClientCase = d.pkCPClientCase
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From CPClientCaseAudit dbTable
Inner Join inserted i ON dbTable.[pkCPClientCase] = i.[pkCPClientCase]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPClientCaseAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPClientCase]
	,[StateCaseNumber]
	,[LocalCaseNumber]
	,[fkCPRefClientCaseProgramType]
	,[fkCPCaseWorker]
	,[LockedUser]
	,[LockedDate]
	,[fkCPClientCaseHead]
	,[fkApplicationUser]
	,[DistrictId]
	,[CaseStatus]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkCPClientCase]
	,[StateCaseNumber]
	,[LocalCaseNumber]
	,[fkCPRefClientCaseProgramType]
	,[fkCPCaseWorker]
	,[LockedUser]
	,[LockedDate]
	,[fkCPClientCaseHead]
	,[fkApplicationUser]
	,[DistrictId]
	,[CaseStatus]

From  Inserted

Insert Into CPCaseActivity (fkCPCaseActivityType, fkCPClientCase, Description, fkCPClient)
Select 9,
	   i.pkCPClientCase,
	   Case When i.CaseStatus = 1 Then 'Case was made active' Else 'Case was made inactive' End,
	   0 
From Inserted i 
Inner Join Deleted d On d.pkCPClientCase = i.pkCPClientCase
Where i.CaseStatus <> d.CaseStatus
GO
CREATE Trigger [dbo].[tr_CPClientCaseAudit_d] On [dbo].[CPClientCase]
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
From CPClientCaseAudit dbTable
Inner Join deleted d ON dbTable.[pkCPClientCase] = d.[pkCPClientCase]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPClientCaseAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPClientCase]
	,[StateCaseNumber]
	,[LocalCaseNumber]
	,[fkCPRefClientCaseProgramType]
	,[fkCPCaseWorker]
	,[LockedUser]
	,[LockedDate]
	,[fkCPClientCaseHead]
	,[fkApplicationUser]
	,[DistrictId]
	,[CaseStatus]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkCPClientCase]
	,[StateCaseNumber]
	,[LocalCaseNumber]
	,[fkCPRefClientCaseProgramType]
	,[fkCPCaseWorker]
	,[LockedUser]
	,[LockedDate]
	,[fkCPClientCaseHead]
	,[fkApplicationUser]
	,[DistrictId]
	,[CaseStatus]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table groups items together to create a case file.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCase';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary, auto-incrementing system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCase', @level2type = N'COLUMN', @level2name = N'pkCPClientCase';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'State Case ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCase', @level2type = N'COLUMN', @level2name = N'StateCaseNumber';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Local case ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCase', @level2type = N'COLUMN', @level2name = N'LocalCaseNumber';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the Client Case Program Type table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCase', @level2type = N'COLUMN', @level2name = N'fkCPRefClientCaseProgramType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to CPCaseWorker. This has been replaced with fkApplicationUser. Use that for joining', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCase', @level2type = N'COLUMN', @level2name = N'fkCPCaseWorker';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Deprecated', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCase', @level2type = N'COLUMN', @level2name = N'LockedUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Deprecated', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCase', @level2type = N'COLUMN', @level2name = N'LockedDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCase', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCase', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCase', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCase', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to CPClientCase indicating who is the case head', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCase', @level2type = N'COLUMN', @level2name = N'fkCPClientCaseHead';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to ApplicationUser, indicating the case worker.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCase', @level2type = N'COLUMN', @level2name = N'fkApplicationUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Optional user defined field', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCase', @level2type = N'COLUMN', @level2name = N'DistrictId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Active (1)  vs. Inactive (0) Case Flag', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCase', @level2type = N'COLUMN', @level2name = N'CaseStatus';

