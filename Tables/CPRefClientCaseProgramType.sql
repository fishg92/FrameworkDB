CREATE TABLE [dbo].[CPRefClientCaseProgramType] (
    [pkCPRefClientCaseProgramType] DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [Description]                  VARCHAR (100) NULL,
    [LUPUser]                      VARCHAR (50)  NULL,
    [LUPDate]                      DATETIME      NULL,
    [CreateUser]                   VARCHAR (50)  NULL,
    [CreateDate]                   DATETIME      NULL,
    CONSTRAINT [PK_CPRefClientCaseProgramType] PRIMARY KEY CLUSTERED ([pkCPRefClientCaseProgramType] ASC)
);


GO
CREATE Trigger [dbo].[tr_CPRefClientCaseProgramTypeAudit_UI] On [dbo].[CPRefClientCaseProgramType]
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

Update CPRefClientCaseProgramType
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPRefClientCaseProgramType dbTable
	Inner Join Inserted i on dbtable.pkCPRefClientCaseProgramType = i.pkCPRefClientCaseProgramType
	Left Join Deleted d on d.pkCPRefClientCaseProgramType = d.pkCPRefClientCaseProgramType
	Where d.pkCPRefClientCaseProgramType is null

Update CPRefClientCaseProgramType
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPRefClientCaseProgramType dbTable
	Inner Join Deleted d on dbTable.pkCPRefClientCaseProgramType = d.pkCPRefClientCaseProgramType
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From CPRefClientCaseProgramTypeAudit dbTable
Inner Join inserted i ON dbTable.[pkCPRefClientCaseProgramType] = i.[pkCPRefClientCaseProgramType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPRefClientCaseProgramTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPRefClientCaseProgramType]
	,[Description]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkCPRefClientCaseProgramType]
	,[Description]

From  Inserted
GO
CREATE Trigger [dbo].[tr_CPRefClientCaseProgramTypeAudit_d] On [dbo].[CPRefClientCaseProgramType]
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
From CPRefClientCaseProgramTypeAudit dbTable
Inner Join deleted d ON dbTable.[pkCPRefClientCaseProgramType] = d.[pkCPRefClientCaseProgramType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPRefClientCaseProgramTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPRefClientCaseProgramType]
	,[Description]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkCPRefClientCaseProgramType]
	,[Description]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This reference table contains look up values for client case program types.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefClientCaseProgramType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary, auto-incrementing system id number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefClientCaseProgramType', @level2type = N'COLUMN', @level2name = N'pkCPRefClientCaseProgramType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Description of the program type', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefClientCaseProgramType', @level2type = N'COLUMN', @level2name = N'Description';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefClientCaseProgramType', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefClientCaseProgramType', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefClientCaseProgramType', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefClientCaseProgramType', @level2type = N'COLUMN', @level2name = N'CreateDate';

