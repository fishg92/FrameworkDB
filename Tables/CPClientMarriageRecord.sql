CREATE TABLE [dbo].[CPClientMarriageRecord] (
    [pkCPClientMarriageRecord] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkCPClient]               DECIMAL (18) NULL,
    [StartDate]                DATETIME     NULL,
    [EndDate]                  DATETIME     NULL,
    [fkCPRefMarraigeEndType]   DECIMAL (18) NULL,
    [LockedUser]               VARCHAR (50) NULL,
    [LockedDate]               DATETIME     NULL,
    [Spouse]                   VARCHAR (50) NULL,
    [LUPUser]                  VARCHAR (50) NULL,
    [LUPDate]                  DATETIME     NULL,
    [CreateUser]               VARCHAR (50) NULL,
    [CreateDate]               DATETIME     NULL,
    [EventDateFreeForm]        VARCHAR (50) NULL,
    CONSTRAINT [PK_CPClientMarriageRecord] PRIMARY KEY CLUSTERED ([pkCPClientMarriageRecord] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxfkCPClient]
    ON [dbo].[CPClientMarriageRecord]([fkCPClient] ASC)
    INCLUDE([pkCPClientMarriageRecord]) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [fkCPRefMarraigeEndType]
    ON [dbo].[CPClientMarriageRecord]([fkCPRefMarraigeEndType] ASC);


GO
CREATE Trigger [dbo].[tr_CPClientMarriageRecordAudit_UI] On [dbo].[CPClientMarriageRecord]
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

Update CPClientMarriageRecord
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPClientMarriageRecord dbTable
	Inner Join Inserted i on dbtable.pkCPClientMarriageRecord = i.pkCPClientMarriageRecord
	Left Join Deleted d on d.pkCPClientMarriageRecord = d.pkCPClientMarriageRecord
	Where d.pkCPClientMarriageRecord is null

Update CPClientMarriageRecord
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPClientMarriageRecord dbTable
	Inner Join Deleted d on dbTable.pkCPClientMarriageRecord = d.pkCPClientMarriageRecord
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From CPClientMarriageRecordAudit dbTable
Inner Join inserted i ON dbTable.[pkCPClientMarriageRecord] = i.[pkCPClientMarriageRecord]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPClientMarriageRecordAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPClientMarriageRecord]
	,[fkCPClient]
	,[StartDate]
	,[EndDate]
	,[fkCPRefMarraigeEndType]
	,[LockedUser]
	,[LockedDate]
	,[Spouse]
	,[EventDateFreeForm]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkCPClientMarriageRecord]
	,[fkCPClient]
	,[StartDate]
	,[EndDate]
	,[fkCPRefMarraigeEndType]
	,[LockedUser]
	,[LockedDate]
	,[Spouse]
	,[EventDateFreeForm]

From  Inserted
GO
CREATE Trigger [dbo].[tr_CPClientMarriageRecordAudit_d] On [dbo].[CPClientMarriageRecord]
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
From CPClientMarriageRecordAudit dbTable
Inner Join deleted d ON dbTable.[pkCPClientMarriageRecord] = d.[pkCPClientMarriageRecord]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPClientMarriageRecordAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPClientMarriageRecord]
	,[fkCPClient]
	,[StartDate]
	,[EndDate]
	,[fkCPRefMarraigeEndType]
	,[LockedUser]
	,[LockedDate]
	,[Spouse]
	,[EventDateFreeForm]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkCPClientMarriageRecord]
	,[fkCPClient]
	,[StartDate]
	,[EndDate]
	,[fkCPRefMarraigeEndType]
	,[LockedUser]
	,[LockedDate]
	,[Spouse]
	,[EventDateFreeForm]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table contains marriage records for People clients.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientMarriageRecord';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auto-incrementing, arbitrary, system identification number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientMarriageRecord', @level2type = N'COLUMN', @level2name = N'pkCPClientMarriageRecord';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the CPClient table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientMarriageRecord', @level2type = N'COLUMN', @level2name = N'fkCPClient';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date married', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientMarriageRecord', @level2type = N'COLUMN', @level2name = N'StartDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date that the marriage ended', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientMarriageRecord', @level2type = N'COLUMN', @level2name = N'EndDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to CPRefMarriageEndType', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientMarriageRecord', @level2type = N'COLUMN', @level2name = N'fkCPRefMarraigeEndType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Deprecated', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientMarriageRecord', @level2type = N'COLUMN', @level2name = N'LockedUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Deprecated', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientMarriageRecord', @level2type = N'COLUMN', @level2name = N'LockedDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Name of the spouse', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientMarriageRecord', @level2type = N'COLUMN', @level2name = N'Spouse';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientMarriageRecord', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientMarriageRecord', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientMarriageRecord', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientMarriageRecord', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Freeform date information regarding the marriage', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientMarriageRecord', @level2type = N'COLUMN', @level2name = N'EventDateFreeForm';

