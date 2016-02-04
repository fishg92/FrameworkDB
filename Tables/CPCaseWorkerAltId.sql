CREATE TABLE [dbo].[CPCaseWorkerAltId] (
    [pkCPCaseWorkerAltId] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkCPCaseWorker]      DECIMAL (18) NULL,
    [WorkerId]            VARCHAR (50) NULL,
    [LockedDate]          DATETIME     NULL,
    [LockedUser]          VARCHAR (50) NULL,
    [LUPUser]             VARCHAR (50) NULL,
    [LUPDate]             DATETIME     NULL,
    [CreateUser]          VARCHAR (50) NULL,
    [CreateDate]          DATETIME     NULL,
    [fkApplicationUser]   DECIMAL (18) NULL,
    CONSTRAINT [PK_CPCaseWorkerAltId] PRIMARY KEY NONCLUSTERED ([pkCPCaseWorkerAltId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkApplicationUser]
    ON [dbo].[CPCaseWorkerAltId]([fkApplicationUser] ASC);


GO
CREATE NONCLUSTERED INDEX [fkCPCaseWorker]
    ON [dbo].[CPCaseWorkerAltId]([fkCPCaseWorker] ASC);


GO
CREATE Trigger [dbo].[tr_CPCaseWorkerAltIdAudit_UI] On [dbo].[CPCaseWorkerAltId]
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

Update CPCaseWorkerAltId
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPCaseWorkerAltId dbTable
	Inner Join Inserted i on dbtable.pkCPCaseWorkerAltId = i.pkCPCaseWorkerAltId
	Left Join Deleted d on d.pkCPCaseWorkerAltId = d.pkCPCaseWorkerAltId
	Where d.pkCPCaseWorkerAltId is null

Update CPCaseWorkerAltId
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPCaseWorkerAltId dbTable
	Inner Join Deleted d on dbTable.pkCPCaseWorkerAltId = d.pkCPCaseWorkerAltId
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From CPCaseWorkerAltIdAudit dbTable
Inner Join inserted i ON dbTable.[pkCPCaseWorkerAltId] = i.[pkCPCaseWorkerAltId]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPCaseWorkerAltIdAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPCaseWorkerAltId]
	,[fkCPCaseWorker]
	,[WorkerId]
	,[LockedDate]
	,[LockedUser]
	,[fkApplicationUser]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkCPCaseWorkerAltId]
	,[fkCPCaseWorker]
	,[WorkerId]
	,[LockedDate]
	,[LockedUser]
	,[fkApplicationUser]

From  Inserted
GO
CREATE Trigger [dbo].[tr_CPCaseWorkerAltIdAudit_d] On [dbo].[CPCaseWorkerAltId]
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
From CPCaseWorkerAltIdAudit dbTable
Inner Join deleted d ON dbTable.[pkCPCaseWorkerAltId] = d.[pkCPCaseWorkerAltId]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPCaseWorkerAltIdAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPCaseWorkerAltId]
	,[fkCPCaseWorker]
	,[WorkerId]
	,[LockedDate]
	,[LockedUser]
	,[fkApplicationUser]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkCPCaseWorkerAltId]
	,[fkCPCaseWorker]
	,[WorkerId]
	,[LockedDate]
	,[LockedUser]
	,[fkApplicationUser]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'table of Alternate caseworker ID values, used to match cases to the appropriate application user (who is also a caseworker) during the case import process', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPCaseWorkerAltId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPCaseWorkerAltId', @level2type = N'COLUMN', @level2name = N'pkCPCaseWorkerAltId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to Case Worker', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPCaseWorkerAltId', @level2type = N'COLUMN', @level2name = N'fkCPCaseWorker';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'State worker ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPCaseWorkerAltId', @level2type = N'COLUMN', @level2name = N'WorkerId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Deprecated', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPCaseWorkerAltId', @level2type = N'COLUMN', @level2name = N'LockedDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Deprecated', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPCaseWorkerAltId', @level2type = N'COLUMN', @level2name = N'LockedUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPCaseWorkerAltId', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPCaseWorkerAltId', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPCaseWorkerAltId', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPCaseWorkerAltId', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to ApplicationUser', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPCaseWorkerAltId', @level2type = N'COLUMN', @level2name = N'fkApplicationUser';

