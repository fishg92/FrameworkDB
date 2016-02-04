CREATE TABLE [dbo].[JoinApplicationUserrefTaskTypeEscalation] (
    [pkJoinApplicationUserrefTaskTypeEscalation] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkrefTaskTypeEscalation]                    DECIMAL (18) NOT NULL,
    [fkApplicationUser]                          DECIMAL (18) NOT NULL,
    [LUPUser]                                    VARCHAR (50) NULL,
    [LUPDate]                                    DATETIME     NULL,
    [CreateUser]                                 VARCHAR (50) NULL,
    [CreateDate]                                 DATETIME     NULL,
    CONSTRAINT [PK_JoinApplicationUserrefTaskTypeEscalation] PRIMARY KEY CLUSTERED ([pkJoinApplicationUserrefTaskTypeEscalation] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkApplicationUser]
    ON [dbo].[JoinApplicationUserrefTaskTypeEscalation]([fkApplicationUser] ASC)
    INCLUDE([fkrefTaskTypeEscalation]);


GO
CREATE NONCLUSTERED INDEX [fkrefTaskTypeEscalation]
    ON [dbo].[JoinApplicationUserrefTaskTypeEscalation]([fkrefTaskTypeEscalation] ASC)
    INCLUDE([fkApplicationUser]);


GO
CREATE Trigger [dbo].[tr_JoinApplicationUserrefTaskTypeEscalationAudit_UI] On [dbo].[JoinApplicationUserrefTaskTypeEscalation]
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

Update JoinApplicationUserrefTaskTypeEscalation
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From JoinApplicationUserrefTaskTypeEscalation dbTable
	Inner Join Inserted i on dbtable.pkJoinApplicationUserrefTaskTypeEscalation = i.pkJoinApplicationUserrefTaskTypeEscalation
	Left Join Deleted d on d.pkJoinApplicationUserrefTaskTypeEscalation = d.pkJoinApplicationUserrefTaskTypeEscalation
	Where d.pkJoinApplicationUserrefTaskTypeEscalation is null

Update JoinApplicationUserrefTaskTypeEscalation
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From JoinApplicationUserrefTaskTypeEscalation dbTable
	Inner Join Deleted d on dbTable.pkJoinApplicationUserrefTaskTypeEscalation = d.pkJoinApplicationUserrefTaskTypeEscalation
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From JoinApplicationUserrefTaskTypeEscalationAudit dbTable
Inner Join inserted i ON dbTable.[pkJoinApplicationUserrefTaskTypeEscalation] = i.[pkJoinApplicationUserrefTaskTypeEscalation]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinApplicationUserrefTaskTypeEscalationAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinApplicationUserrefTaskTypeEscalation]
	,[fkrefTaskTypeEscalation]
	,[fkApplicationUser]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkJoinApplicationUserrefTaskTypeEscalation]
	,[fkrefTaskTypeEscalation]
	,[fkApplicationUser]

From  Inserted
GO
CREATE Trigger [dbo].[tr_JoinApplicationUserrefTaskTypeEscalationAudit_d] On [dbo].[JoinApplicationUserrefTaskTypeEscalation]
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
From JoinApplicationUserrefTaskTypeEscalationAudit dbTable
Inner Join deleted d ON dbTable.[pkJoinApplicationUserrefTaskTypeEscalation] = d.[pkJoinApplicationUserrefTaskTypeEscalation]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinApplicationUserrefTaskTypeEscalationAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinApplicationUserrefTaskTypeEscalation]
	,[fkrefTaskTypeEscalation]
	,[fkApplicationUser]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkJoinApplicationUserrefTaskTypeEscalation]
	,[fkrefTaskTypeEscalation]
	,[fkApplicationUser]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserrefTaskTypeEscalation', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserrefTaskTypeEscalation', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserrefTaskTypeEscalation', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserrefTaskTypeEscalation', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Join tables represent a many to many relationship between two or more tables. In this case, it is the assocaition of ApplicationUser to refTaskTypeEscalation', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserrefTaskTypeEscalation';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserrefTaskTypeEscalation', @level2type = N'COLUMN', @level2name = N'pkJoinApplicationUserrefTaskTypeEscalation';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to refTaskTypeEscalation', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserrefTaskTypeEscalation', @level2type = N'COLUMN', @level2name = N'fkrefTaskTypeEscalation';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to ApplicationUser', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserrefTaskTypeEscalation', @level2type = N'COLUMN', @level2name = N'fkApplicationUser';

