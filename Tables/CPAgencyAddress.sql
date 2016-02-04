CREATE TABLE [dbo].[CPAgencyAddress] (
    [pkCPAgencyAddress]        DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [fkCPRefAgencyAddressType] DECIMAL (18)  NULL,
    [Street1]                  VARCHAR (100) NULL,
    [Street2]                  VARCHAR (100) NULL,
    [Street3]                  VARCHAR (100) NULL,
    [City]                     VARCHAR (100) NULL,
    [State]                    VARCHAR (50)  NULL,
    [Zip]                      CHAR (5)      NULL,
    [ZipPlus4]                 CHAR (4)      NULL,
    [LUPUser]                  VARCHAR (50)  NULL,
    [LUPDate]                  DATETIME      NULL,
    [CreateUser]               VARCHAR (50)  NULL,
    [CreateDate]               DATETIME      NULL,
    CONSTRAINT [PK_CPAgencyAddress] PRIMARY KEY NONCLUSTERED ([pkCPAgencyAddress] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkCPRefAgencyAddressType]
    ON [dbo].[CPAgencyAddress]([fkCPRefAgencyAddressType] ASC);


GO
CREATE Trigger [dbo].[tr_CPAgencyAddressAudit_UI] On [dbo].[CPAgencyAddress]
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

Update CPAgencyAddress
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPAgencyAddress dbTable
	Inner Join Inserted i on dbtable.pkCPAgencyAddress = i.pkCPAgencyAddress
	Left Join Deleted d on d.pkCPAgencyAddress = d.pkCPAgencyAddress
	Where d.pkCPAgencyAddress is null

Update CPAgencyAddress
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPAgencyAddress dbTable
	Inner Join Deleted d on dbTable.pkCPAgencyAddress = d.pkCPAgencyAddress
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From CPAgencyAddressAudit dbTable
Inner Join inserted i ON dbTable.[pkCPAgencyAddress] = i.[pkCPAgencyAddress]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPAgencyAddressAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPAgencyAddress]
	,[fkCPRefAgencyAddressType]
	,[Street1]
	,[Street2]
	,[Street3]
	,[City]
	,[State]
	,[Zip]
	,[ZipPlus4]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkCPAgencyAddress]
	,[fkCPRefAgencyAddressType]
	,[Street1]
	,[Street2]
	,[Street3]
	,[City]
	,[State]
	,[Zip]
	,[ZipPlus4]

From  Inserted
GO
CREATE Trigger [dbo].[tr_CPAgencyAddressAudit_d] On [dbo].[CPAgencyAddress]
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
From CPAgencyAddressAudit dbTable
Inner Join deleted d ON dbTable.[pkCPAgencyAddress] = d.[pkCPAgencyAddress]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPAgencyAddressAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPAgencyAddress]
	,[fkCPRefAgencyAddressType]
	,[Street1]
	,[Street2]
	,[Street3]
	,[City]
	,[State]
	,[Zip]
	,[ZipPlus4]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkCPAgencyAddress]
	,[fkCPRefAgencyAddressType]
	,[Street1]
	,[Street2]
	,[Street3]
	,[City]
	,[State]
	,[Zip]
	,[ZipPlus4]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPAgencyAddress', @level2type = N'COLUMN', @level2name = N'pkCPAgencyAddress';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to reference table: refAgencyAddressType', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPAgencyAddress', @level2type = N'COLUMN', @level2name = N'fkCPRefAgencyAddressType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Street Address', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPAgencyAddress', @level2type = N'COLUMN', @level2name = N'Street1';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Street Address', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPAgencyAddress', @level2type = N'COLUMN', @level2name = N'Street2';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Street Address', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPAgencyAddress', @level2type = N'COLUMN', @level2name = N'Street3';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'City', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPAgencyAddress', @level2type = N'COLUMN', @level2name = N'City';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'State', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPAgencyAddress', @level2type = N'COLUMN', @level2name = N'State';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Zip', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPAgencyAddress', @level2type = N'COLUMN', @level2name = N'Zip';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Zip+4 characters for full, 9 digit zip code', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPAgencyAddress', @level2type = N'COLUMN', @level2name = N'ZipPlus4';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPAgencyAddress', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPAgencyAddress', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPAgencyAddress', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPAgencyAddress', @level2type = N'COLUMN', @level2name = N'CreateDate';

