CREATE TABLE [dbo].[CPClientAddress] (
    [pkCPClientAddress]        DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [fkCPRefClientAddressType] DECIMAL (18)  NULL,
    [Street1]                  VARCHAR (100) NULL,
    [Street2]                  VARCHAR (100) NULL,
    [Street3]                  VARCHAR (100) NULL,
    [City]                     VARCHAR (100) NULL,
    [State]                    VARCHAR (50)  NULL,
    [Zip]                      CHAR (5)      NULL,
    [ZipPlus4]                 CHAR (4)      NULL,
    [LockedUser]               VARCHAR (50)  NULL,
    [LockedDate]               DATETIME      NULL,
    [LUPUser]                  VARCHAR (50)  NULL,
    [LUPDate]                  DATETIME      NULL,
    [CreateUser]               VARCHAR (50)  NULL,
    [CreateDate]               DATETIME      NULL,
    [DataCheckSum]             AS            (checksum([Street1],[Street2],[Street3],[City],[State],[Zip],[ZipPlus4])) PERSISTED,
    CONSTRAINT [PK_CPClientAddress] PRIMARY KEY NONCLUSTERED ([pkCPClientAddress] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkCPRefClientAddressType]
    ON [dbo].[CPClientAddress]([fkCPRefClientAddressType] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_CPClientAddressCheckSum]
    ON [dbo].[CPClientAddress]([DataCheckSum] ASC);


GO
CREATE Trigger [dbo].[tr_CPClientAddressAudit_d] On [dbo].[CPClientAddress]
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
From CPClientAddressAudit dbTable
Inner Join deleted d ON dbTable.[pkCPClientAddress] = d.[pkCPClientAddress]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPClientAddressAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPClientAddress]
	,[fkCPRefClientAddressType]
	,[Street1]
	,[Street2]
	,[Street3]
	,[City]
	,[State]
	,[Zip]
	,[ZipPlus4]
	,[LockedUser]
	,[LockedDate]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkCPClientAddress]
	,[fkCPRefClientAddressType]
	,[Street1]
	,[Street2]
	,[Street3]
	,[City]
	,[State]
	,[Zip]
	,[ZipPlus4]
	,[LockedUser]
	,[LockedDate]
From  Deleted
GO
CREATE Trigger [dbo].[tr_CPClientAddressAudit_UI] On [dbo].[CPClientAddress]
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

Update CPClientAddress
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPClientAddress dbTable
	Inner Join Inserted i on dbtable.pkCPClientAddress = i.pkCPClientAddress
	Left Join Deleted d on d.pkCPClientAddress = d.pkCPClientAddress
	Where d.pkCPClientAddress is null

Update CPClientAddress
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPClientAddress dbTable
	Inner Join Deleted d on dbTable.pkCPClientAddress = d.pkCPClientAddress
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From CPClientAddressAudit dbTable
Inner Join inserted i ON dbTable.[pkCPClientAddress] = i.[pkCPClientAddress]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPClientAddressAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPClientAddress]
	,[fkCPRefClientAddressType]
	,[Street1]
	,[Street2]
	,[Street3]
	,[City]
	,[State]
	,[Zip]
	,[ZipPlus4]
	,[LockedUser]
	,[LockedDate]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkCPClientAddress]
	,[fkCPRefClientAddressType]
	,[Street1]
	,[Street2]
	,[Street3]
	,[City]
	,[State]
	,[Zip]
	,[ZipPlus4]
	,[LockedUser]
	,[LockedDate]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the Client Address Type table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientAddress', @level2type = N'COLUMN', @level2name = N'fkCPRefClientAddressType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Street address line 1', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientAddress', @level2type = N'COLUMN', @level2name = N'Street1';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Street address line 2', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientAddress', @level2type = N'COLUMN', @level2name = N'Street2';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Street address line 3', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientAddress', @level2type = N'COLUMN', @level2name = N'Street3';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Client city', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientAddress', @level2type = N'COLUMN', @level2name = N'City';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Client State', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientAddress', @level2type = N'COLUMN', @level2name = N'State';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Client zip code', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientAddress', @level2type = N'COLUMN', @level2name = N'Zip';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Client zip +4', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientAddress', @level2type = N'COLUMN', @level2name = N'ZipPlus4';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'A user may lock a client address so it is not updated, if they have done so, their user name should be here.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientAddress', @level2type = N'COLUMN', @level2name = N'LockedUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date that the client address was locked', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientAddress', @level2type = N'COLUMN', @level2name = N'LockedDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientAddress', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientAddress', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientAddress', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientAddress', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Used to evaulate whether or not the client address has been changed', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientAddress', @level2type = N'COLUMN', @level2name = N'DataCheckSum';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table contains client addresses (separated into a separate table because a single client may have many different addresses).', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientAddress';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary, auto-incrementing system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientAddress', @level2type = N'COLUMN', @level2name = N'pkCPClientAddress';

