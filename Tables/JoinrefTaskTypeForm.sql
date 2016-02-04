CREATE TABLE [dbo].[JoinrefTaskTypeForm] (
    [pkJoinrefTaskTypeForm] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkrefTaskType]         DECIMAL (18) NOT NULL,
    [fkFormName]            DECIMAL (18) NOT NULL,
    [LUPUser]               VARCHAR (50) NULL,
    [LUPDate]               DATETIME     NULL,
    [CreateUser]            VARCHAR (50) NULL,
    [CreateDate]            DATETIME     NULL,
    CONSTRAINT [PK_JoinrefTaskTypeForm] PRIMARY KEY CLUSTERED ([pkJoinrefTaskTypeForm] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkFormName]
    ON [dbo].[JoinrefTaskTypeForm]([fkFormName] ASC)
    INCLUDE([fkrefTaskType]);


GO
CREATE NONCLUSTERED INDEX [fkrefTaskType]
    ON [dbo].[JoinrefTaskTypeForm]([fkrefTaskType] ASC)
    INCLUDE([fkFormName]);


GO
CREATE Trigger [dbo].[tr_JoinrefTaskTypeFormAudit_d] On [dbo].[JoinrefTaskTypeForm]
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
From JoinrefTaskTypeFormAudit dbTable
Inner Join deleted d ON dbTable.[pkJoinrefTaskTypeForm] = d.[pkJoinrefTaskTypeForm]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinrefTaskTypeFormAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinrefTaskTypeForm]
	,[fkrefTaskType]
	,[fkFormName]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkJoinrefTaskTypeForm]
	,[fkrefTaskType]
	,[fkFormName]
From  Deleted
GO
CREATE Trigger [dbo].[tr_JoinrefTaskTypeFormAudit_UI] On [dbo].[JoinrefTaskTypeForm]
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

Update JoinrefTaskTypeForm
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From JoinrefTaskTypeForm dbTable
	Inner Join Inserted i on dbtable.pkJoinrefTaskTypeForm = i.pkJoinrefTaskTypeForm
	Left Join Deleted d on d.pkJoinrefTaskTypeForm = d.pkJoinrefTaskTypeForm
	Where d.pkJoinrefTaskTypeForm is null

Update JoinrefTaskTypeForm
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From JoinrefTaskTypeForm dbTable
	Inner Join Deleted d on dbTable.pkJoinrefTaskTypeForm = d.pkJoinrefTaskTypeForm
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From JoinrefTaskTypeFormAudit dbTable
Inner Join inserted i ON dbTable.[pkJoinrefTaskTypeForm] = i.[pkJoinrefTaskTypeForm]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinrefTaskTypeFormAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinrefTaskTypeForm]
	,[fkrefTaskType]
	,[fkFormName]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkJoinrefTaskTypeForm]
	,[fkrefTaskType]
	,[fkFormName]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table links TaskTypes to FormNames, setting the default task type for an individual form.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinrefTaskTypeForm';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinrefTaskTypeForm', @level2type = N'COLUMN', @level2name = N'pkJoinrefTaskTypeForm';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to refTaskType', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinrefTaskTypeForm', @level2type = N'COLUMN', @level2name = N'fkrefTaskType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to FormName', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinrefTaskTypeForm', @level2type = N'COLUMN', @level2name = N'fkFormName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinrefTaskTypeForm', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinrefTaskTypeForm', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinrefTaskTypeForm', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinrefTaskTypeForm', @level2type = N'COLUMN', @level2name = N'CreateDate';

