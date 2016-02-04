CREATE TABLE [dbo].[CPJoinClientAlertFlagTypeNT] (
    [pkCPJoinClientAlertFlagTypeNT] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [CreateUser]                    VARCHAR (50) NULL,
    [CreateDate]                    DATETIME     NULL,
    [fkCPClient]                    DECIMAL (18) NULL,
    [fkRefCPAlertFlagTypeNT]        DECIMAL (18) NULL,
    [LockedUser]                    VARCHAR (20) NULL,
    [LockedDate]                    DATETIME     NULL,
    [LUPUser]                       VARCHAR (50) NULL,
    [LUPDate]                       DATETIME     NULL,
    CONSTRAINT [PK_CPJoinClientClientFlagTypeNT] PRIMARY KEY CLUSTERED ([pkCPJoinClientAlertFlagTypeNT] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_CPJoinClientAlertFlagTypeNT_fkCPClient_to_fkRefCPAlertFlagTypeNT]
    ON [dbo].[CPJoinClientAlertFlagTypeNT]([fkCPClient] ASC, [fkRefCPAlertFlagTypeNT] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_CPJoinClientAlertFlagTypeNT_fkRefCPAlertFlagTypeNT_to_fkCPClient]
    ON [dbo].[CPJoinClientAlertFlagTypeNT]([fkRefCPAlertFlagTypeNT] ASC, [fkCPClient] ASC);


GO
CREATE Trigger [dbo].[tr_CPJoinClientAlertFlagTypeNTAudit_UI] On [dbo].[CPJoinClientAlertFlagTypeNT]
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

Update CPJoinClientAlertFlagTypeNT
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPJoinClientAlertFlagTypeNT dbTable
	Inner Join Inserted i on dbtable.pkCPJoinClientAlertFlagTypeNT = i.pkCPJoinClientAlertFlagTypeNT
	Left Join Deleted d on d.pkCPJoinClientAlertFlagTypeNT = d.pkCPJoinClientAlertFlagTypeNT
	Where d.pkCPJoinClientAlertFlagTypeNT is null

Update CPJoinClientAlertFlagTypeNT
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPJoinClientAlertFlagTypeNT dbTable
	Inner Join Deleted d on dbTable.pkCPJoinClientAlertFlagTypeNT = d.pkCPJoinClientAlertFlagTypeNT
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From CPJoinClientAlertFlagTypeNTAudit dbTable
Inner Join inserted i ON dbTable.[pkCPJoinClientAlertFlagTypeNT] = i.[pkCPJoinClientAlertFlagTypeNT]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPJoinClientAlertFlagTypeNTAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPJoinClientAlertFlagTypeNT]
	,[fkCPClient]
	,[fkRefCPAlertFlagTypeNT]
	,[LockedUser]
	,[LockedDate]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkCPJoinClientAlertFlagTypeNT]
	,[fkCPClient]
	,[fkRefCPAlertFlagTypeNT]
	,[LockedUser]
	,[LockedDate]

From  Inserted
GO
CREATE Trigger [dbo].[tr_CPJoinClientAlertFlagTypeNTAudit_d] On [dbo].[CPJoinClientAlertFlagTypeNT]
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
From CPJoinClientAlertFlagTypeNTAudit dbTable
Inner Join deleted d ON dbTable.[pkCPJoinClientAlertFlagTypeNT] = d.[pkCPJoinClientAlertFlagTypeNT]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPJoinClientAlertFlagTypeNTAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPJoinClientAlertFlagTypeNT]
	,[fkCPClient]
	,[fkRefCPAlertFlagTypeNT]
	,[LockedUser]
	,[LockedDate]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkCPJoinClientAlertFlagTypeNT]
	,[fkCPClient]
	,[fkRefCPAlertFlagTypeNT]
	,[LockedUser]
	,[LockedDate]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Deprecated. Feature to be removed', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientAlertFlagTypeNT', @level2type = N'COLUMN', @level2name = N'LockedDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientAlertFlagTypeNT', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientAlertFlagTypeNT', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This join table links the CPClient table to the CPClientAlertFlagTypeNT table, marking a client with an alert flag in the system.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientAlertFlagTypeNT';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary, auto-incrementing system identification number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientAlertFlagTypeNT', @level2type = N'COLUMN', @level2name = N'pkCPJoinClientAlertFlagTypeNT';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientAlertFlagTypeNT', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientAlertFlagTypeNT', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to CPClient (Indexed)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientAlertFlagTypeNT', @level2type = N'COLUMN', @level2name = N'fkCPClient';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to RefCPAlertFlagTypeNT (Indexed)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientAlertFlagTypeNT', @level2type = N'COLUMN', @level2name = N'fkRefCPAlertFlagTypeNT';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Deprecated. Feature to be removed', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientAlertFlagTypeNT', @level2type = N'COLUMN', @level2name = N'LockedUser';

