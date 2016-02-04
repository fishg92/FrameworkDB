CREATE TABLE [dbo].[CPClientMilitaryRecord] (
    [pkCPClientMilitaryRecord] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkCPClient]               DECIMAL (18) NULL,
    [fkCPRefMilitaryBranch]    DECIMAL (18) NULL,
    [StartDate]                DATETIME     NULL,
    [EndDate]                  DATETIME     NULL,
    [DishonorablyDischarged]   BIT          NULL,
    [LockedUser]               VARCHAR (50) NULL,
    [LockedDate]               DATETIME     NULL,
    [LUPUser]                  VARCHAR (50) NULL,
    [LUPDate]                  DATETIME     NULL,
    [CreateUser]               VARCHAR (50) NULL,
    [CreateDate]               DATETIME     NULL,
    [EventStart]               VARCHAR (50) NULL,
    [EventEnd]                 VARCHAR (50) NULL,
    CONSTRAINT [PK_CPClientMilitaryRecord] PRIMARY KEY CLUSTERED ([pkCPClientMilitaryRecord] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkCPClient]
    ON [dbo].[CPClientMilitaryRecord]([fkCPClient] ASC)
    INCLUDE([fkCPRefMilitaryBranch], [pkCPClientMilitaryRecord]) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [fkCPRefMilitaryBranch]
    ON [dbo].[CPClientMilitaryRecord]([fkCPRefMilitaryBranch] ASC);


GO
CREATE Trigger [dbo].[tr_CPClientMilitaryRecordAudit_d] On [dbo].[CPClientMilitaryRecord]
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
From CPClientMilitaryRecordAudit dbTable
Inner Join deleted d ON dbTable.[pkCPClientMilitaryRecord] = d.[pkCPClientMilitaryRecord]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPClientMilitaryRecordAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPClientMilitaryRecord]
	,[fkCPClient]
	,[fkCPRefMilitaryBranch]
	,[StartDate]
	,[EndDate]
	,[DishonorablyDischarged]
	,[LockedUser]
	,[LockedDate]
	,[EventStart]
	,[EventEnd]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkCPClientMilitaryRecord]
	,[fkCPClient]
	,[fkCPRefMilitaryBranch]
	,[StartDate]
	,[EndDate]
	,[DishonorablyDischarged]
	,[LockedUser]
	,[LockedDate]
	,[EventStart]
	,[EventEnd]
From  Deleted
GO
CREATE Trigger [dbo].[tr_CPClientMilitaryRecordAudit_UI] On [dbo].[CPClientMilitaryRecord]
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

Update CPClientMilitaryRecord
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPClientMilitaryRecord dbTable
	Inner Join Inserted i on dbtable.pkCPClientMilitaryRecord = i.pkCPClientMilitaryRecord
	Left Join Deleted d on d.pkCPClientMilitaryRecord = d.pkCPClientMilitaryRecord
	Where d.pkCPClientMilitaryRecord is null

Update CPClientMilitaryRecord
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPClientMilitaryRecord dbTable
	Inner Join Deleted d on dbTable.pkCPClientMilitaryRecord = d.pkCPClientMilitaryRecord
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From CPClientMilitaryRecordAudit dbTable
Inner Join inserted i ON dbTable.[pkCPClientMilitaryRecord] = i.[pkCPClientMilitaryRecord]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPClientMilitaryRecordAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPClientMilitaryRecord]
	,[fkCPClient]
	,[fkCPRefMilitaryBranch]
	,[StartDate]
	,[EndDate]
	,[DishonorablyDischarged]
	,[LockedUser]
	,[LockedDate]
	,[EventStart]
	,[EventEnd]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkCPClientMilitaryRecord]
	,[fkCPClient]
	,[fkCPRefMilitaryBranch]
	,[StartDate]
	,[EndDate]
	,[DishonorablyDischarged]
	,[LockedUser]
	,[LockedDate]
	,[EventStart]
	,[EventEnd]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table contains military records for People clients.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientMilitaryRecord';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary, auto-incrementing system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientMilitaryRecord', @level2type = N'COLUMN', @level2name = N'pkCPClientMilitaryRecord';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the CPClient table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientMilitaryRecord', @level2type = N'COLUMN', @level2name = N'fkCPClient';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key indicating the branch of the military', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientMilitaryRecord', @level2type = N'COLUMN', @level2name = N'fkCPRefMilitaryBranch';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date of the start of the services', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientMilitaryRecord', @level2type = N'COLUMN', @level2name = N'StartDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date service ended', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientMilitaryRecord', @level2type = N'COLUMN', @level2name = N'EndDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Boolean indicating whether or not the client was dishonorable discharged (1=yes, 0=no)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientMilitaryRecord', @level2type = N'COLUMN', @level2name = N'DishonorablyDischarged';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Deprecated', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientMilitaryRecord', @level2type = N'COLUMN', @level2name = N'LockedUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Deprecated', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientMilitaryRecord', @level2type = N'COLUMN', @level2name = N'LockedDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientMilitaryRecord', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientMilitaryRecord', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientMilitaryRecord', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientMilitaryRecord', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date the service started', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientMilitaryRecord', @level2type = N'COLUMN', @level2name = N'EventStart';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date the service ended', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientMilitaryRecord', @level2type = N'COLUMN', @level2name = N'EventEnd';

