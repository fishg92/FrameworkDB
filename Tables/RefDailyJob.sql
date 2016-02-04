CREATE TABLE [dbo].[RefDailyJob] (
    [pkRefDailyJob]     DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [JobName]           VARCHAR (50)  NOT NULL,
    [Description]       VARCHAR (255) NOT NULL,
    [Query]             VARCHAR (MAX) NOT NULL,
    [StartTime]         DATETIME      NOT NULL,
    [EndTime]           DATETIME      NULL,
    [Active]            BIT           NOT NULL,
    [DateLastStarted]   DATETIME      NULL,
    [DateLastCompleted] DATETIME      NULL,
    [LUPUser]           VARCHAR (50)  NULL,
    [LUPDate]           DATETIME      NULL,
    [CreateUser]        VARCHAR (50)  NULL,
    [CreateDate]        DATETIME      NULL,
    CONSTRAINT [PK_RefDailyJob] PRIMARY KEY CLUSTERED ([pkRefDailyJob] ASC)
);


GO
CREATE Trigger [dbo].[tr_RefDailyJobAudit_d] On [dbo].[RefDailyJob]
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
From RefDailyJobAudit dbTable
Inner Join deleted d ON dbTable.[pkRefDailyJob] = d.[pkRefDailyJob]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into RefDailyJobAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkRefDailyJob]
	,[JobName]
	,[Description]
	,[Query]
	,[StartTime]
	,[EndTime]
	,[Active]
	,[DateLastStarted]
	,[DateLastCompleted]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkRefDailyJob]
	,[JobName]
	,[Description]
	,[Query]
	,[StartTime]
	,[EndTime]
	,[Active]
	,[DateLastStarted]
	,[DateLastCompleted]
From  Deleted
GO
CREATE Trigger [dbo].[tr_RefDailyJobAudit_UI] On [dbo].[RefDailyJob]
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

Update RefDailyJob
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From RefDailyJob dbTable
	Inner Join Inserted i on dbtable.pkRefDailyJob = i.pkRefDailyJob
	Left Join Deleted d on d.pkRefDailyJob = d.pkRefDailyJob
	Where d.pkRefDailyJob is null

Update RefDailyJob
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From RefDailyJob dbTable
	Inner Join Deleted d on dbTable.pkRefDailyJob = d.pkRefDailyJob
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From RefDailyJobAudit dbTable
Inner Join inserted i ON dbTable.[pkRefDailyJob] = i.[pkRefDailyJob]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into RefDailyJobAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkRefDailyJob]
	,[JobName]
	,[Description]
	,[Query]
	,[StartTime]
	,[EndTime]
	,[Active]
	,[DateLastStarted]
	,[DateLastCompleted]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkRefDailyJob]
	,[JobName]
	,[Description]
	,[Query]
	,[StartTime]
	,[EndTime]
	,[Active]
	,[DateLastStarted]
	,[DateLastCompleted]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Ref tables are reference tables that are used to populate drop downs, enumerate options, or otherwise provide a (usually) static list of items to the program. This table is a reference of daily jobs to be run against the database, including what stored procedure to run, what time it should be started, and on what date it should stop. It also keeps the last started and last completed dates and times for use in debugging these jobs.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RefDailyJob';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RefDailyJob', @level2type = N'COLUMN', @level2name = N'pkRefDailyJob';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Short name for the job', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RefDailyJob', @level2type = N'COLUMN', @level2name = N'JobName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User friendly description of what the job actually does', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RefDailyJob', @level2type = N'COLUMN', @level2name = N'Description';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The SQL to be run against the database', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RefDailyJob', @level2type = N'COLUMN', @level2name = N'Query';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date and time that the job should be started.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RefDailyJob', @level2type = N'COLUMN', @level2name = N'StartTime';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Last time the job should be run.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RefDailyJob', @level2type = N'COLUMN', @level2name = N'EndTime';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Marks whether or not the job is currently set to run, or not.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RefDailyJob', @level2type = N'COLUMN', @level2name = N'Active';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Last date the job was started', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RefDailyJob', @level2type = N'COLUMN', @level2name = N'DateLastStarted';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Last date and time the job completed.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RefDailyJob', @level2type = N'COLUMN', @level2name = N'DateLastCompleted';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RefDailyJob', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RefDailyJob', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RefDailyJob', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RefDailyJob', @level2type = N'COLUMN', @level2name = N'CreateDate';

