CREATE TABLE [dbo].[CPRefClientAddressType] (
    [pkCPRefClientAddressType] DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [Description]              VARCHAR (255) NULL,
    [LUPUser]                  VARCHAR (50)  NULL,
    [LUPDate]                  DATETIME      NULL,
    [CreateUser]               VARCHAR (50)  NULL,
    [CreateDate]               DATETIME      NULL,
    CONSTRAINT [PK_CPRefClientAddressType] PRIMARY KEY CLUSTERED ([pkCPRefClientAddressType] ASC)
);


GO
CREATE Trigger [dbo].[tr_CPRefClientAddressTypeAudit_d] On [dbo].[CPRefClientAddressType]
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
From CPRefClientAddressTypeAudit dbTable
Inner Join deleted d ON dbTable.[pkCPRefClientAddressType] = d.[pkCPRefClientAddressType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPRefClientAddressTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPRefClientAddressType]
	,[Description]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkCPRefClientAddressType]
	,[Description]
From  Deleted
GO
CREATE Trigger [dbo].[tr_CPRefClientAddressTypeAudit_UI] On [dbo].[CPRefClientAddressType]
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

Update CPRefClientAddressType
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPRefClientAddressType dbTable
	Inner Join Inserted i on dbtable.pkCPRefClientAddressType = i.pkCPRefClientAddressType
	Left Join Deleted d on d.pkCPRefClientAddressType = d.pkCPRefClientAddressType
	Where d.pkCPRefClientAddressType is null

Update CPRefClientAddressType
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPRefClientAddressType dbTable
	Inner Join Deleted d on dbTable.pkCPRefClientAddressType = d.pkCPRefClientAddressType
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From CPRefClientAddressTypeAudit dbTable
Inner Join inserted i ON dbTable.[pkCPRefClientAddressType] = i.[pkCPRefClientAddressType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPRefClientAddressTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPRefClientAddressType]
	,[Description]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkCPRefClientAddressType]
	,[Description]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Depricated – This reference table contains look up values for address types attached to People clients.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefClientAddressType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary, auto-incrementing system identification number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefClientAddressType', @level2type = N'COLUMN', @level2name = N'pkCPRefClientAddressType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Description of the address type', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefClientAddressType', @level2type = N'COLUMN', @level2name = N'Description';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefClientAddressType', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefClientAddressType', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefClientAddressType', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefClientAddressType', @level2type = N'COLUMN', @level2name = N'CreateDate';

