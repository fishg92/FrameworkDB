CREATE TABLE [dbo].[JoinrefTaskTyperefTaskEntityType] (
    [pkJoinrefTaskTyperefTaskEntityType] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkrefTaskType]                      DECIMAL (18) NOT NULL,
    [fkrefTaskEntityType]                DECIMAL (18) NOT NULL,
    [LUPUser]                            VARCHAR (50) NULL,
    [LUPDate]                            DATETIME     NULL,
    [CreateUser]                         VARCHAR (50) NULL,
    [CreateDate]                         DATETIME     NULL,
    CONSTRAINT [PK_JoinrefTaskTyperefTaskEntityType] PRIMARY KEY CLUSTERED ([pkJoinrefTaskTyperefTaskEntityType] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkrefTaskEntityType]
    ON [dbo].[JoinrefTaskTyperefTaskEntityType]([fkrefTaskEntityType] ASC)
    INCLUDE([fkrefTaskType]);


GO
CREATE NONCLUSTERED INDEX [fkrefTaskType]
    ON [dbo].[JoinrefTaskTyperefTaskEntityType]([fkrefTaskType] ASC)
    INCLUDE([fkrefTaskEntityType]);


GO
CREATE Trigger [dbo].[tr_JoinrefTaskTyperefTaskEntityTypeAudit_d] On [dbo].[JoinrefTaskTyperefTaskEntityType]
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
From JoinrefTaskTyperefTaskEntityTypeAudit dbTable
Inner Join deleted d ON dbTable.[pkJoinrefTaskTyperefTaskEntityType] = d.[pkJoinrefTaskTyperefTaskEntityType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinrefTaskTyperefTaskEntityTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinrefTaskTyperefTaskEntityType]
	,[fkrefTaskType]
	,[fkrefTaskEntityType]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkJoinrefTaskTyperefTaskEntityType]
	,[fkrefTaskType]
	,[fkrefTaskEntityType]
From  Deleted
GO
CREATE Trigger [dbo].[tr_JoinrefTaskTyperefTaskEntityTypeAudit_UI] On [dbo].[JoinrefTaskTyperefTaskEntityType]
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

Update JoinrefTaskTyperefTaskEntityType
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From JoinrefTaskTyperefTaskEntityType dbTable
	Inner Join Inserted i on dbtable.pkJoinrefTaskTyperefTaskEntityType = i.pkJoinrefTaskTyperefTaskEntityType
	Left Join Deleted d on d.pkJoinrefTaskTyperefTaskEntityType = d.pkJoinrefTaskTyperefTaskEntityType
	Where d.pkJoinrefTaskTyperefTaskEntityType is null

Update JoinrefTaskTyperefTaskEntityType
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From JoinrefTaskTyperefTaskEntityType dbTable
	Inner Join Deleted d on dbTable.pkJoinrefTaskTyperefTaskEntityType = d.pkJoinrefTaskTyperefTaskEntityType
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From JoinrefTaskTyperefTaskEntityTypeAudit dbTable
Inner Join inserted i ON dbTable.[pkJoinrefTaskTyperefTaskEntityType] = i.[pkJoinrefTaskTyperefTaskEntityType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinrefTaskTyperefTaskEntityTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinrefTaskTyperefTaskEntityType]
	,[fkrefTaskType]
	,[fkrefTaskEntityType]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkJoinrefTaskTyperefTaskEntityType]
	,[fkrefTaskType]
	,[fkrefTaskEntityType]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This join table links TaskTypes with TaskEntityTypes (which describe where tasks come from, such as the DMS or Compass Documents).', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinrefTaskTyperefTaskEntityType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinrefTaskTyperefTaskEntityType', @level2type = N'COLUMN', @level2name = N'pkJoinrefTaskTyperefTaskEntityType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to refTaskType', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinrefTaskTyperefTaskEntityType', @level2type = N'COLUMN', @level2name = N'fkrefTaskType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to refTaskEntityType', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinrefTaskTyperefTaskEntityType', @level2type = N'COLUMN', @level2name = N'fkrefTaskEntityType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinrefTaskTyperefTaskEntityType', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinrefTaskTyperefTaskEntityType', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinrefTaskTyperefTaskEntityType', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinrefTaskTyperefTaskEntityType', @level2type = N'COLUMN', @level2name = N'CreateDate';

