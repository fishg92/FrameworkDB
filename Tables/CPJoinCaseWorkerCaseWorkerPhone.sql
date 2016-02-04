CREATE TABLE [dbo].[CPJoinCaseWorkerCaseWorkerPhone] (
    [pkCPJoinCaseWorkerCaseWorkerPhone] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkCPCaseWorker]                    DECIMAL (18) NULL,
    [fkCPCaseWorkerPhone]               DECIMAL (18) NULL,
    [LUPUser]                           VARCHAR (50) NULL,
    [LUPDate]                           DATETIME     NULL,
    [CreateUser]                        VARCHAR (50) NULL,
    [CreateDate]                        DATETIME     NULL,
    [fkCPRefPhoneType]                  DECIMAL (18) NULL,
    CONSTRAINT [PK_CPJoinCaseWorkerPhone] PRIMARY KEY NONCLUSTERED ([pkCPJoinCaseWorkerCaseWorkerPhone] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxfkCPCaseWorker]
    ON [dbo].[CPJoinCaseWorkerCaseWorkerPhone]([fkCPCaseWorker] ASC)
    INCLUDE([fkCPCaseWorkerPhone]) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [idxfkCPCaseWorkerPhone]
    ON [dbo].[CPJoinCaseWorkerCaseWorkerPhone]([fkCPCaseWorkerPhone] ASC)
    INCLUDE([fkCPCaseWorker]) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [fkCPRefPhoneType]
    ON [dbo].[CPJoinCaseWorkerCaseWorkerPhone]([fkCPRefPhoneType] ASC);


GO
CREATE Trigger [dbo].[tr_CPJoinCaseWorkerCaseWorkerPhoneAudit_d] On [dbo].[CPJoinCaseWorkerCaseWorkerPhone]
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
From CPJoinCaseWorkerCaseWorkerPhoneAudit dbTable
Inner Join deleted d ON dbTable.[pkCPJoinCaseWorkerCaseWorkerPhone] = d.[pkCPJoinCaseWorkerCaseWorkerPhone]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPJoinCaseWorkerCaseWorkerPhoneAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPJoinCaseWorkerCaseWorkerPhone]
	,[fkCPCaseWorker]
	,[fkCPCaseWorkerPhone]
	,[fkCPRefPhoneType]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkCPJoinCaseWorkerCaseWorkerPhone]
	,[fkCPCaseWorker]
	,[fkCPCaseWorkerPhone]
	,[fkCPRefPhoneType]
From  Deleted
GO
CREATE Trigger [dbo].[tr_CPJoinCaseWorkerCaseWorkerPhoneAudit_UI] On [dbo].[CPJoinCaseWorkerCaseWorkerPhone]
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

Update CPJoinCaseWorkerCaseWorkerPhone
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPJoinCaseWorkerCaseWorkerPhone dbTable
	Inner Join Inserted i on dbtable.pkCPJoinCaseWorkerCaseWorkerPhone = i.pkCPJoinCaseWorkerCaseWorkerPhone
	Left Join Deleted d on d.pkCPJoinCaseWorkerCaseWorkerPhone = d.pkCPJoinCaseWorkerCaseWorkerPhone
	Where d.pkCPJoinCaseWorkerCaseWorkerPhone is null

Update CPJoinCaseWorkerCaseWorkerPhone
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPJoinCaseWorkerCaseWorkerPhone dbTable
	Inner Join Deleted d on dbTable.pkCPJoinCaseWorkerCaseWorkerPhone = d.pkCPJoinCaseWorkerCaseWorkerPhone
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From CPJoinCaseWorkerCaseWorkerPhoneAudit dbTable
Inner Join inserted i ON dbTable.[pkCPJoinCaseWorkerCaseWorkerPhone] = i.[pkCPJoinCaseWorkerCaseWorkerPhone]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPJoinCaseWorkerCaseWorkerPhoneAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPJoinCaseWorkerCaseWorkerPhone]
	,[fkCPCaseWorker]
	,[fkCPCaseWorkerPhone]
	,[fkCPRefPhoneType]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkCPJoinCaseWorkerCaseWorkerPhone]
	,[fkCPCaseWorker]
	,[fkCPCaseWorkerPhone]
	,[fkCPRefPhoneType]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table, like other join tables, represents a many-to-many relationship between two other tables. In this case, the CaseWorker and Case Worker Phone tables. As CaseWorker has deprecated, this join table should be deprecated as well.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinCaseWorkerCaseWorkerPhone';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinCaseWorkerCaseWorkerPhone', @level2type = N'COLUMN', @level2name = N'pkCPJoinCaseWorkerCaseWorkerPhone';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinCaseWorkerCaseWorkerPhone', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinCaseWorkerCaseWorkerPhone', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinCaseWorkerCaseWorkerPhone', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinCaseWorkerCaseWorkerPhone', @level2type = N'COLUMN', @level2name = N'CreateDate';

