CREATE TABLE [dbo].[CPRefAgencyAddressType] (
    [pkCPRefAgencyAddressType] DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [Description]              VARCHAR (255) NULL,
    [LUPUser]                  VARCHAR (50)  NULL,
    [LUPDate]                  DATETIME      NULL,
    [CreateUser]               VARCHAR (50)  NULL,
    [CreateDate]               DATETIME      NULL,
    CONSTRAINT [PK_CPRefAgencyAddressType] PRIMARY KEY CLUSTERED ([pkCPRefAgencyAddressType] ASC)
);


GO
CREATE Trigger [dbo].[tr_CPRefAgencyAddressTypeAudit_UI] On [dbo].[CPRefAgencyAddressType]
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

Update CPRefAgencyAddressType
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPRefAgencyAddressType dbTable
	Inner Join Inserted i on dbtable.pkCPRefAgencyAddressType = i.pkCPRefAgencyAddressType
	Left Join Deleted d on d.pkCPRefAgencyAddressType = d.pkCPRefAgencyAddressType
	Where d.pkCPRefAgencyAddressType is null

Update CPRefAgencyAddressType
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPRefAgencyAddressType dbTable
	Inner Join Deleted d on dbTable.pkCPRefAgencyAddressType = d.pkCPRefAgencyAddressType
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From CPRefAgencyAddressTypeAudit dbTable
Inner Join inserted i ON dbTable.[pkCPRefAgencyAddressType] = i.[pkCPRefAgencyAddressType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPRefAgencyAddressTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPRefAgencyAddressType]
	,[Description]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkCPRefAgencyAddressType]
	,[Description]

From  Inserted
GO
CREATE Trigger [dbo].[tr_CPRefAgencyAddressTypeAudit_d] On [dbo].[CPRefAgencyAddressType]
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
From CPRefAgencyAddressTypeAudit dbTable
Inner Join deleted d ON dbTable.[pkCPRefAgencyAddressType] = d.[pkCPRefAgencyAddressType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPRefAgencyAddressTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPRefAgencyAddressType]
	,[Description]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkCPRefAgencyAddressType]
	,[Description]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Description of the Address type', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefAgencyAddressType', @level2type = N'COLUMN', @level2name = N'Description';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefAgencyAddressType', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefAgencyAddressType', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefAgencyAddressType', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefAgencyAddressType', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Depricated – People table to store the agency address type', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefAgencyAddressType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefAgencyAddressType', @level2type = N'COLUMN', @level2name = N'pkCPRefAgencyAddressType';

