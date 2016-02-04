CREATE TABLE [dbo].[refFileNetQueue] (
    [pkrefFileNetQueue] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [QueueName]         VARCHAR (50) NOT NULL,
    [PrimaryIndex]      VARCHAR (50) NOT NULL,
    [FilterBy]          VARCHAR (50) CONSTRAINT [DF_refFileNetQueue_FilterBy] DEFAULT ('User') NOT NULL,
    [LUPUser]           VARCHAR (50) NULL,
    [LUPDate]           DATETIME     NULL,
    [CreateUser]        VARCHAR (50) NULL,
    [CreateDate]        DATETIME     NULL,
    CONSTRAINT [PK_refFileNetQueue] PRIMARY KEY CLUSTERED ([pkrefFileNetQueue] ASC),
    CONSTRAINT [CK_refFileNetQueue] CHECK ([FilterBy]='County' OR [FilterBy]='User')
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [QueueName]
    ON [dbo].[refFileNetQueue]([QueueName] ASC);


GO
CREATE Trigger [dbo].[tr_refFileNetQueueAudit_d] On [dbo].[refFileNetQueue]
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
From refFileNetQueueAudit dbTable
Inner Join deleted d ON dbTable.[pkrefFileNetQueue] = d.[pkrefFileNetQueue]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into refFileNetQueueAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkrefFileNetQueue]
	,[QueueName]
	,[PrimaryIndex]
	,[FilterBy]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkrefFileNetQueue]
	,[QueueName]
	,[PrimaryIndex]
	,[FilterBy]
From  Deleted
GO
CREATE Trigger [dbo].[tr_refFileNetQueueAudit_UI] On [dbo].[refFileNetQueue]
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

Update refFileNetQueue
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From refFileNetQueue dbTable
	Inner Join Inserted i on dbtable.pkrefFileNetQueue = i.pkrefFileNetQueue
	Left Join Deleted d on d.pkrefFileNetQueue = d.pkrefFileNetQueue
	Where d.pkrefFileNetQueue is null

Update refFileNetQueue
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From refFileNetQueue dbTable
	Inner Join Deleted d on dbTable.pkrefFileNetQueue = d.pkrefFileNetQueue
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From refFileNetQueueAudit dbTable
Inner Join inserted i ON dbTable.[pkrefFileNetQueue] = i.[pkrefFileNetQueue]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into refFileNetQueueAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkrefFileNetQueue]
	,[QueueName]
	,[PrimaryIndex]
	,[FilterBy]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkrefFileNetQueue]
	,[QueueName]
	,[PrimaryIndex]
	,[FilterBy]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table is used to cache queues from File Net', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refFileNetQueue';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refFileNetQueue', @level2type = N'COLUMN', @level2name = N'pkrefFileNetQueue';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Queue name', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refFileNetQueue', @level2type = N'COLUMN', @level2name = N'QueueName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'By what field is the queue indexed', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refFileNetQueue', @level2type = N'COLUMN', @level2name = N'PrimaryIndex';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'What should be used to filter the results of the queue', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refFileNetQueue', @level2type = N'COLUMN', @level2name = N'FilterBy';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refFileNetQueue', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refFileNetQueue', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refFileNetQueue', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refFileNetQueue', @level2type = N'COLUMN', @level2name = N'CreateDate';

