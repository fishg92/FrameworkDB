CREATE TABLE [dbo].[JoinrefTaskTypeApplicationUser] (
    [pkJoinrefTaskTypeApplicationUser] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkrefTaskType]                    DECIMAL (18) NOT NULL,
    [fkApplicationUser]                DECIMAL (18) NOT NULL,
    [DisplayOrder]                     INT          CONSTRAINT [DF_JoinrefTaskTypeApplicationUser_DisplayOrder] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_JoinrefTaskTypeApplicationUser] PRIMARY KEY CLUSTERED ([pkJoinrefTaskTypeApplicationUser] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkApplicationUser]
    ON [dbo].[JoinrefTaskTypeApplicationUser]([fkApplicationUser] ASC)
    INCLUDE([fkrefTaskType]);


GO
CREATE NONCLUSTERED INDEX [fkrefTaskType]
    ON [dbo].[JoinrefTaskTypeApplicationUser]([fkrefTaskType] ASC)
    INCLUDE([fkApplicationUser]);


GO
CREATE Trigger [dbo].[tr_JoinrefTaskTypeApplicationUserAudit_UI] On [dbo].[JoinrefTaskTypeApplicationUser]
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
From JoinrefTaskTypeApplicationUserAudit dbTable
Inner Join inserted i ON dbTable.[pkJoinrefTaskTypeApplicationUser] = i.[pkJoinrefTaskTypeApplicationUser]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinrefTaskTypeApplicationUserAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinrefTaskTypeApplicationUser]
	,[fkrefTaskType]
	,[fkApplicationUser]
	,[DisplayOrder]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkJoinrefTaskTypeApplicationUser]
	,[fkrefTaskType]
	,[fkApplicationUser]
	,[DisplayOrder]

From  Inserted
GO
CREATE Trigger [dbo].[tr_JoinrefTaskTypeApplicationUserAudit_d] On [dbo].[JoinrefTaskTypeApplicationUser]
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
From JoinrefTaskTypeApplicationUserAudit dbTable
Inner Join deleted d ON dbTable.[pkJoinrefTaskTypeApplicationUser] = d.[pkJoinrefTaskTypeApplicationUser]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinrefTaskTypeApplicationUserAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinrefTaskTypeApplicationUser]
	,[fkrefTaskType]
	,[fkApplicationUser]
	,[DisplayOrder]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkJoinrefTaskTypeApplicationUser]
	,[fkrefTaskType]
	,[fkApplicationUser]
	,[DisplayOrder]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table links Application users to Task Types and manages their ordering on the user''s screen.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinrefTaskTypeApplicationUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinrefTaskTypeApplicationUser', @level2type = N'COLUMN', @level2name = N'pkJoinrefTaskTypeApplicationUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to RefTaskType', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinrefTaskTypeApplicationUser', @level2type = N'COLUMN', @level2name = N'fkrefTaskType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to Application User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinrefTaskTypeApplicationUser', @level2type = N'COLUMN', @level2name = N'fkApplicationUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Order to display task types on the screen.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinrefTaskTypeApplicationUser', @level2type = N'COLUMN', @level2name = N'DisplayOrder';

