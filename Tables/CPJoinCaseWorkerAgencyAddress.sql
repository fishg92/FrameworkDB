CREATE TABLE [dbo].[CPJoinCaseWorkerAgencyAddress] (
    [pkCPJoinCaseWorkerAgencyAddress] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkCPCaseWorker]                  DECIMAL (18) NULL,
    [fkCPAgencyAddress]               DECIMAL (18) NULL,
    [LUPUser]                         VARCHAR (50) NULL,
    [LUPDate]                         DATETIME     NULL,
    [CreateUser]                      VARCHAR (50) NULL,
    [CreateDate]                      DATETIME     NULL,
    [fkCPRefAgencyAddressType]        DECIMAL (18) NULL,
    CONSTRAINT [PK_CPJoinCaseWorkerAgencyAddress] PRIMARY KEY NONCLUSTERED ([pkCPJoinCaseWorkerAgencyAddress] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxfkCPAgencyAddress]
    ON [dbo].[CPJoinCaseWorkerAgencyAddress]([fkCPAgencyAddress] ASC)
    INCLUDE([fkCPCaseWorker], [fkCPRefAgencyAddressType]) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [idxfkCPCaseWorker]
    ON [dbo].[CPJoinCaseWorkerAgencyAddress]([fkCPCaseWorker] ASC)
    INCLUDE([fkCPAgencyAddress], [fkCPRefAgencyAddressType]) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [fkCPRefAgencyAddressType]
    ON [dbo].[CPJoinCaseWorkerAgencyAddress]([fkCPRefAgencyAddressType] ASC);


GO
CREATE Trigger [dbo].[tr_CPJoinCaseWorkerAgencyAddressAudit_d] On [dbo].[CPJoinCaseWorkerAgencyAddress]
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
From CPJoinCaseWorkerAgencyAddressAudit dbTable
Inner Join deleted d ON dbTable.[pkCPJoinCaseWorkerAgencyAddress] = d.[pkCPJoinCaseWorkerAgencyAddress]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPJoinCaseWorkerAgencyAddressAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPJoinCaseWorkerAgencyAddress]
	,[fkCPCaseWorker]
	,[fkCPAgencyAddress]
	,[fkCPRefAgencyAddressType]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkCPJoinCaseWorkerAgencyAddress]
	,[fkCPCaseWorker]
	,[fkCPAgencyAddress]
	,[fkCPRefAgencyAddressType]
From  Deleted
GO
CREATE Trigger [dbo].[tr_CPJoinCaseWorkerAgencyAddressAudit_UI] On [dbo].[CPJoinCaseWorkerAgencyAddress]
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

Update CPJoinCaseWorkerAgencyAddress
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPJoinCaseWorkerAgencyAddress dbTable
	Inner Join Inserted i on dbtable.pkCPJoinCaseWorkerAgencyAddress = i.pkCPJoinCaseWorkerAgencyAddress
	Left Join Deleted d on d.pkCPJoinCaseWorkerAgencyAddress = d.pkCPJoinCaseWorkerAgencyAddress
	Where d.pkCPJoinCaseWorkerAgencyAddress is null

Update CPJoinCaseWorkerAgencyAddress
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPJoinCaseWorkerAgencyAddress dbTable
	Inner Join Deleted d on dbTable.pkCPJoinCaseWorkerAgencyAddress = d.pkCPJoinCaseWorkerAgencyAddress
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From CPJoinCaseWorkerAgencyAddressAudit dbTable
Inner Join inserted i ON dbTable.[pkCPJoinCaseWorkerAgencyAddress] = i.[pkCPJoinCaseWorkerAgencyAddress]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPJoinCaseWorkerAgencyAddressAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPJoinCaseWorkerAgencyAddress]
	,[fkCPCaseWorker]
	,[fkCPAgencyAddress]
	,[fkCPRefAgencyAddressType]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkCPJoinCaseWorkerAgencyAddress]
	,[fkCPCaseWorker]
	,[fkCPAgencyAddress]
	,[fkCPRefAgencyAddressType]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table, like other join tables, represents a many-to-many relationship between two other tables. In this case, the CaseWork and Agency Address tables. As CaseWorker has deprecated, this join table should be deprecated as well.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinCaseWorkerAgencyAddress';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinCaseWorkerAgencyAddress', @level2type = N'COLUMN', @level2name = N'pkCPJoinCaseWorkerAgencyAddress';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinCaseWorkerAgencyAddress', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinCaseWorkerAgencyAddress', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinCaseWorkerAgencyAddress', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinCaseWorkerAgencyAddress', @level2type = N'COLUMN', @level2name = N'CreateDate';

