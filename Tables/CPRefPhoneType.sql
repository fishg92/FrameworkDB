CREATE TABLE [dbo].[CPRefPhoneType] (
    [pkCPRefPhoneType] DECIMAL (18)  NOT NULL,
    [Description]      VARCHAR (255) NULL,
    [LUPUser]          VARCHAR (50)  NULL,
    [LUPDate]          DATETIME      NULL,
    [CreateUser]       VARCHAR (50)  NULL,
    [CreateDate]       DATETIME      NULL,
    CONSTRAINT [PK_CPRefPhoneType] PRIMARY KEY CLUSTERED ([pkCPRefPhoneType] ASC)
);


GO
CREATE Trigger [dbo].[tr_CPRefPhoneTypeAudit_d] On [dbo].[CPRefPhoneType]
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
From CPRefPhoneTypeAudit dbTable
Inner Join deleted d ON dbTable.[pkCPRefPhoneType] = d.[pkCPRefPhoneType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPRefPhoneTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPRefPhoneType]
	,[Description]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkCPRefPhoneType]
	,[Description]
From  Deleted
GO
CREATE Trigger [dbo].[tr_CPRefPhoneTypeAudit_UI] On [dbo].[CPRefPhoneType]
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

Update CPRefPhoneType
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPRefPhoneType dbTable
	Inner Join Inserted i on dbtable.pkCPRefPhoneType = i.pkCPRefPhoneType
	Left Join Deleted d on d.pkCPRefPhoneType = d.pkCPRefPhoneType
	Where d.pkCPRefPhoneType is null

Update CPRefPhoneType
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPRefPhoneType dbTable
	Inner Join Deleted d on dbTable.pkCPRefPhoneType = d.pkCPRefPhoneType
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From CPRefPhoneTypeAudit dbTable
Inner Join inserted i ON dbTable.[pkCPRefPhoneType] = i.[pkCPRefPhoneType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPRefPhoneTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPRefPhoneType]
	,[Description]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkCPRefPhoneType]
	,[Description]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Deprecated – This reference table contains look up values for phone number types. Phone numbers are now stored directly in the CPClient table with a different column for each type.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefPhoneType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system identification number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefPhoneType', @level2type = N'COLUMN', @level2name = N'pkCPRefPhoneType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Description of the phone type', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefPhoneType', @level2type = N'COLUMN', @level2name = N'Description';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefPhoneType', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefPhoneType', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefPhoneType', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefPhoneType', @level2type = N'COLUMN', @level2name = N'CreateDate';

