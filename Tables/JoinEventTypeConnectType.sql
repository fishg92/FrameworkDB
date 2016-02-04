CREATE TABLE [dbo].[JoinEventTypeConnectType] (
    [pkJoinEventTypeConnectType] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkEventType]                DECIMAL (18) NULL,
    [fkConnectType]              DECIMAL (18) NULL,
    CONSTRAINT [PK_JoinEventTypeTransferType] PRIMARY KEY CLUSTERED ([pkJoinEventTypeConnectType] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkConnectType]
    ON [dbo].[JoinEventTypeConnectType]([fkConnectType] ASC)
    INCLUDE([fkEventType]);


GO
CREATE NONCLUSTERED INDEX [fkEventType]
    ON [dbo].[JoinEventTypeConnectType]([fkEventType] ASC)
    INCLUDE([fkConnectType]);


GO
CREATE Trigger [dbo].[tr_JoinEventTypeConnectTypeAudit_UI] On [dbo].[JoinEventTypeConnectType]
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


--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From JoinEventTypeConnectTypeAudit dbTable
Inner Join inserted i ON dbTable.[pkJoinEventTypeConnectType] = i.[pkJoinEventTypeConnectType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinEventTypeConnectTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinEventTypeConnectType]
	,[fkEventType]
	,[fkConnectType]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkJoinEventTypeConnectType]
	,[fkEventType]
	,[fkConnectType]

From  Inserted
GO
CREATE Trigger [dbo].[tr_JoinEventTypeConnectTypeAudit_d] On [dbo].[JoinEventTypeConnectType]
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
From JoinEventTypeConnectTypeAudit dbTable
Inner Join deleted d ON dbTable.[pkJoinEventTypeConnectType] = d.[pkJoinEventTypeConnectType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinEventTypeConnectTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinEventTypeConnectType]
	,[fkEventType]
	,[fkConnectType]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkJoinEventTypeConnectType]
	,[fkEventType]
	,[fkConnectType]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Join tables represent a many to many relationship between two or more tables. In this case, it is the Connect Event types to the Connect Connection types.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinEventTypeConnectType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinEventTypeConnectType', @level2type = N'COLUMN', @level2name = N'pkJoinEventTypeConnectType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to Connect''s EventType', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinEventTypeConnectType', @level2type = N'COLUMN', @level2name = N'fkEventType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to Connect''s ConnectType', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinEventTypeConnectType', @level2type = N'COLUMN', @level2name = N'fkConnectType';

