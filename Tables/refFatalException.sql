CREATE TABLE [dbo].[refFatalException] (
    [pkrefFatalException] DECIMAL (18)   IDENTITY (1, 1) NOT NULL,
    [Message]             VARCHAR (1000) NOT NULL,
    [LUPUser]             VARCHAR (50)   NULL,
    [LUPDate]             DATETIME       NULL,
    [CreateUser]          VARCHAR (50)   NULL,
    [CreateDate]          DATETIME       NULL,
    CONSTRAINT [PK_refFatalException] PRIMARY KEY CLUSTERED ([pkrefFatalException] ASC)
);


GO
CREATE Trigger [dbo].[tr_refFatalExceptionAudit_UI] On [dbo].[refFatalException]
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

Update refFatalException
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From refFatalException dbTable
	Inner Join Inserted i on dbtable.pkrefFatalException = i.pkrefFatalException
	Left Join Deleted d on d.pkrefFatalException = d.pkrefFatalException
	Where d.pkrefFatalException is null

Update refFatalException
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From refFatalException dbTable
	Inner Join Deleted d on dbTable.pkrefFatalException = d.pkrefFatalException
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From refFatalExceptionAudit dbTable
Inner Join inserted i ON dbTable.[pkrefFatalException] = i.[pkrefFatalException]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into refFatalExceptionAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkrefFatalException]
	,[Message]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkrefFatalException]
	,[Message]

From  Inserted
GO
CREATE Trigger [dbo].[tr_refFatalExceptionAudit_d] On [dbo].[refFatalException]
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
From refFatalExceptionAudit dbTable
Inner Join deleted d ON dbTable.[pkrefFatalException] = d.[pkrefFatalException]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into refFatalExceptionAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkrefFatalException]
	,[Message]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkrefFatalException]
	,[Message]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The message to compare against to check to see if it is a fatal exception', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refFatalException', @level2type = N'COLUMN', @level2name = N'Message';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refFatalException', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refFatalException', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refFatalException', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refFatalException', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table contains a list of exceptions that are meant to be fatal errors in pilot.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refFatalException';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refFatalException', @level2type = N'COLUMN', @level2name = N'pkrefFatalException';

