CREATE TABLE [dbo].[JoinTaskCPClientFormName] (
    [pkJoinTaskCPClientFormName] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkJoinTaskCPClient]         DECIMAL (18) NOT NULL,
    [fkFormName]                 DECIMAL (18) NOT NULL,
    [LUPUser]                    VARCHAR (50) NULL,
    [LUPDate]                    DATETIME     NULL,
    [CreateUser]                 VARCHAR (50) NULL,
    [CreateDate]                 DATETIME     NULL,
    CONSTRAINT [PK_JoinTaskCPClientFormName] PRIMARY KEY CLUSTERED ([pkJoinTaskCPClientFormName] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkFormName]
    ON [dbo].[JoinTaskCPClientFormName]([fkFormName] ASC)
    INCLUDE([fkJoinTaskCPClient]);


GO
CREATE NONCLUSTERED INDEX [fkJoinTaskCPClient]
    ON [dbo].[JoinTaskCPClientFormName]([fkJoinTaskCPClient] ASC)
    INCLUDE([fkFormName]);


GO
CREATE Trigger [dbo].[tr_JoinTaskCPClientFormNameAudit_UI] On [dbo].[JoinTaskCPClientFormName]
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

Update JoinTaskCPClientFormName
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From JoinTaskCPClientFormName dbTable
	Inner Join Inserted i on dbtable.pkJoinTaskCPClientFormName = i.pkJoinTaskCPClientFormName
	Left Join Deleted d on d.pkJoinTaskCPClientFormName = d.pkJoinTaskCPClientFormName
	Where d.pkJoinTaskCPClientFormName is null

Update JoinTaskCPClientFormName
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From JoinTaskCPClientFormName dbTable
	Inner Join Deleted d on dbTable.pkJoinTaskCPClientFormName = d.pkJoinTaskCPClientFormName
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From JoinTaskCPClientFormNameAudit dbTable
Inner Join inserted i ON dbTable.[pkJoinTaskCPClientFormName] = i.[pkJoinTaskCPClientFormName]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinTaskCPClientFormNameAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinTaskCPClientFormName]
	,[fkJoinTaskCPClient]
	,[fkFormName]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkJoinTaskCPClientFormName]
	,[fkJoinTaskCPClient]
	,[fkFormName]

From  Inserted
GO
CREATE Trigger [dbo].[tr_JoinTaskCPClientFormNameAudit_d] On [dbo].[JoinTaskCPClientFormName]
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
From JoinTaskCPClientFormNameAudit dbTable
Inner Join deleted d ON dbTable.[pkJoinTaskCPClientFormName] = d.[pkJoinTaskCPClientFormName]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinTaskCPClientFormNameAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinTaskCPClientFormName]
	,[fkJoinTaskCPClient]
	,[fkFormName]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkJoinTaskCPClientFormName]
	,[fkJoinTaskCPClient]
	,[fkFormName]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This join table links tasks, people (clients), and forms.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinTaskCPClientFormName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinTaskCPClientFormName', @level2type = N'COLUMN', @level2name = N'pkJoinTaskCPClientFormName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to CPClient', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinTaskCPClientFormName', @level2type = N'COLUMN', @level2name = N'fkJoinTaskCPClient';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to FormName', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinTaskCPClientFormName', @level2type = N'COLUMN', @level2name = N'fkFormName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinTaskCPClientFormName', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinTaskCPClientFormName', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinTaskCPClientFormName', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinTaskCPClientFormName', @level2type = N'COLUMN', @level2name = N'CreateDate';

