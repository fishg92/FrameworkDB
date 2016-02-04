CREATE TABLE [dbo].[LockedEntity] (
    [pkLockedEntity] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkCPClient]     DECIMAL (18) NULL,
    [fkProgramType]  DECIMAL (18) NULL,
    [LUPUser]        VARCHAR (50) NULL,
    [LUPDate]        DATETIME     NULL,
    [CreateUser]     VARCHAR (50) NULL,
    [CreateDate]     DATETIME     NULL,
    CONSTRAINT [PK_LockedEntity] PRIMARY KEY CLUSTERED ([pkLockedEntity] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkCPClient]
    ON [dbo].[LockedEntity]([fkCPClient] ASC);


GO
CREATE NONCLUSTERED INDEX [fkProgramType]
    ON [dbo].[LockedEntity]([fkProgramType] ASC);


GO
CREATE Trigger [dbo].[tr_LockedEntityAudit_d] On [dbo].[LockedEntity]
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
From LockedEntityAudit dbTable
Inner Join deleted d ON dbTable.[pkLockedEntity] = d.[pkLockedEntity]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into LockedEntityAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkLockedEntity]
	,[fkCPClient]
	,[fkProgramType]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkLockedEntity]
	,[fkCPClient]
	,[fkProgramType]
From  Deleted
GO
CREATE Trigger [dbo].[tr_LockedEntityAudit_UI] On [dbo].[LockedEntity]
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

Update LockedEntity
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From LockedEntity dbTable
	Inner Join Inserted i on dbtable.pkLockedEntity = i.pkLockedEntity
	Left Join Deleted d on d.pkLockedEntity = d.pkLockedEntity
	Where d.pkLockedEntity is null

Update LockedEntity
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From LockedEntity dbTable
	Inner Join Deleted d on dbTable.pkLockedEntity = d.pkLockedEntity
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From LockedEntityAudit dbTable
Inner Join inserted i ON dbTable.[pkLockedEntity] = i.[pkLockedEntity]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into LockedEntityAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkLockedEntity]
	,[fkCPClient]
	,[fkProgramType]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkLockedEntity]
	,[fkCPClient]
	,[fkProgramType]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table manages locks on CPClients by Program Type.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LockedEntity';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LockedEntity', @level2type = N'COLUMN', @level2name = N'pkLockedEntity';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to CPClient', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LockedEntity', @level2type = N'COLUMN', @level2name = N'fkCPClient';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to ProgramType', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LockedEntity', @level2type = N'COLUMN', @level2name = N'fkProgramType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LockedEntity', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LockedEntity', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LockedEntity', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LockedEntity', @level2type = N'COLUMN', @level2name = N'CreateDate';

