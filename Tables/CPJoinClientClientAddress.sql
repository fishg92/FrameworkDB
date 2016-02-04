CREATE TABLE [dbo].[CPJoinClientClientAddress] (
    [pkCPJoinClientClientAddress] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkCPClient]                  DECIMAL (18) NULL,
    [fkCPClientAddress]           DECIMAL (18) NULL,
    [LockedUser]                  VARCHAR (50) NULL,
    [LockedDate]                  DATETIME     NULL,
    [LUPUser]                     VARCHAR (50) NULL,
    [LUPDate]                     DATETIME     NULL,
    [CreateUser]                  VARCHAR (50) NULL,
    [CreateDate]                  DATETIME     NULL,
    [fkCPRefClientAddressType]    DECIMAL (18) NULL,
    CONSTRAINT [PK_CPJoinClientClientAddress] PRIMARY KEY NONCLUSTERED ([pkCPJoinClientClientAddress] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxfkCPClient]
    ON [dbo].[CPJoinClientClientAddress]([fkCPClient] ASC)
    INCLUDE([fkCPClientAddress]) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [fkCPRefClientAddressType]
    ON [dbo].[CPJoinClientClientAddress]([fkCPRefClientAddressType] ASC);


GO
CREATE NONCLUSTERED INDEX [idxfkCPClientAddress]
    ON [dbo].[CPJoinClientClientAddress]([fkCPClientAddress] ASC)
    INCLUDE([fkCPClient]);


GO
CREATE Trigger [dbo].[tr_CPJoinClientClientAddressAudit_UI] On [dbo].[CPJoinClientClientAddress]
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

Update CPJoinClientClientAddress
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPJoinClientClientAddress dbTable
	Inner Join Inserted i on dbtable.pkCPJoinClientClientAddress = i.pkCPJoinClientClientAddress
	Left Join Deleted d on d.pkCPJoinClientClientAddress = d.pkCPJoinClientClientAddress
	Where d.pkCPJoinClientClientAddress is null

Update CPJoinClientClientAddress
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPJoinClientClientAddress dbTable
	Inner Join Deleted d on dbTable.pkCPJoinClientClientAddress = d.pkCPJoinClientClientAddress
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From CPJoinClientClientAddressAudit dbTable
Inner Join inserted i ON dbTable.[pkCPJoinClientClientAddress] = i.[pkCPJoinClientClientAddress]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPJoinClientClientAddressAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPJoinClientClientAddress]
	,[fkCPClient]
	,[fkCPClientAddress]
	,[LockedUser]
	,[LockedDate]
	,[fkCPRefClientAddressType]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkCPJoinClientClientAddress]
	,[fkCPClient]
	,[fkCPClientAddress]
	,[LockedUser]
	,[LockedDate]
	,[fkCPRefClientAddressType]

From  Inserted
GO
CREATE Trigger [dbo].[tr_CPJoinClientClientAddressAudit_d] On [dbo].[CPJoinClientClientAddress]
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
From CPJoinClientClientAddressAudit dbTable
Inner Join deleted d ON dbTable.[pkCPJoinClientClientAddress] = d.[pkCPJoinClientClientAddress]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPJoinClientClientAddressAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPJoinClientClientAddress]
	,[fkCPClient]
	,[fkCPClientAddress]
	,[LockedUser]
	,[LockedDate]
	,[fkCPRefClientAddressType]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkCPJoinClientClientAddress]
	,[fkCPClient]
	,[fkCPClientAddress]
	,[LockedUser]
	,[LockedDate]
	,[fkCPRefClientAddressType]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This join table links People clients and their addresses.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientClientAddress';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system identification number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientClientAddress', @level2type = N'COLUMN', @level2name = N'pkCPJoinClientClientAddress';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the CPClient table (Indexed)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientClientAddress', @level2type = N'COLUMN', @level2name = N'fkCPClient';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the CPClientAddress table (Indexed)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientClientAddress', @level2type = N'COLUMN', @level2name = N'fkCPClientAddress';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Deprecated. Feature to be removed', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientClientAddress', @level2type = N'COLUMN', @level2name = N'LockedUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Deprecated. Feature to be removed', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientClientAddress', @level2type = N'COLUMN', @level2name = N'LockedDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientClientAddress', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientClientAddress', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientClientAddress', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientClientAddress', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to CPRefClientAddressType', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientClientAddress', @level2type = N'COLUMN', @level2name = N'fkCPRefClientAddressType';

