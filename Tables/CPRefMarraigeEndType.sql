CREATE TABLE [dbo].[CPRefMarraigeEndType] (
    [pkCPRefMarraigeEndType] DECIMAL (18)  NOT NULL,
    [Description]            VARCHAR (100) NULL,
    [LUPUser]                VARCHAR (50)  NULL,
    [LUPDate]                DATETIME      NULL,
    [CreateUser]             VARCHAR (50)  NULL,
    [CreateDate]             DATETIME      NULL,
    CONSTRAINT [PK_CPRefMarraigeEndType] PRIMARY KEY CLUSTERED ([pkCPRefMarraigeEndType] ASC)
);


GO
CREATE Trigger [dbo].[tr_CPRefMarraigeEndTypeAudit_d] On [dbo].[CPRefMarraigeEndType]
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
From CPRefMarraigeEndTypeAudit dbTable
Inner Join deleted d ON dbTable.[pkCPRefMarraigeEndType] = d.[pkCPRefMarraigeEndType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPRefMarraigeEndTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPRefMarraigeEndType]
	,[Description]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkCPRefMarraigeEndType]
	,[Description]
From  Deleted
GO
CREATE Trigger [dbo].[tr_CPRefMarraigeEndTypeAudit_UI] On [dbo].[CPRefMarraigeEndType]
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

Update CPRefMarraigeEndType
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPRefMarraigeEndType dbTable
	Inner Join Inserted i on dbtable.pkCPRefMarraigeEndType = i.pkCPRefMarraigeEndType
	Left Join Deleted d on d.pkCPRefMarraigeEndType = d.pkCPRefMarraigeEndType
	Where d.pkCPRefMarraigeEndType is null

Update CPRefMarraigeEndType
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPRefMarraigeEndType dbTable
	Inner Join Deleted d on dbTable.pkCPRefMarraigeEndType = d.pkCPRefMarraigeEndType
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From CPRefMarraigeEndTypeAudit dbTable
Inner Join inserted i ON dbTable.[pkCPRefMarraigeEndType] = i.[pkCPRefMarraigeEndType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPRefMarraigeEndTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPRefMarraigeEndType]
	,[Description]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkCPRefMarraigeEndType]
	,[Description]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This reference table contains look up values for marriage end types (for example, divorce, widow, etc.).', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefMarraigeEndType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system identification number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefMarraigeEndType', @level2type = N'COLUMN', @level2name = N'pkCPRefMarraigeEndType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Description of the marriage end type.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefMarraigeEndType', @level2type = N'COLUMN', @level2name = N'Description';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefMarraigeEndType', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefMarraigeEndType', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefMarraigeEndType', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefMarraigeEndType', @level2type = N'COLUMN', @level2name = N'CreateDate';

