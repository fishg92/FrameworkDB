CREATE TABLE [dbo].[CPCaseWorkerPhone] (
    [pkCPCaseWorkerPhone] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkCPRefPhoneType]    DECIMAL (18) NULL,
    [Number]              VARCHAR (10) NULL,
    [Extension]           VARCHAR (10) NULL,
    [LUPUser]             VARCHAR (50) NULL,
    [LUPDate]             DATETIME     NULL,
    [CreateUser]          VARCHAR (50) NULL,
    [CreateDate]          DATETIME     NULL,
    CONSTRAINT [PK_CPCaseWorkerPhone] PRIMARY KEY NONCLUSTERED ([pkCPCaseWorkerPhone] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkCPRefPhoneType]
    ON [dbo].[CPCaseWorkerPhone]([fkCPRefPhoneType] ASC);


GO
CREATE Trigger [dbo].[tr_CPCaseWorkerPhoneAudit_UI] On [dbo].[CPCaseWorkerPhone]
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

Update CPCaseWorkerPhone
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPCaseWorkerPhone dbTable
	Inner Join Inserted i on dbtable.pkCPCaseWorkerPhone = i.pkCPCaseWorkerPhone
	Left Join Deleted d on d.pkCPCaseWorkerPhone = d.pkCPCaseWorkerPhone
	Where d.pkCPCaseWorkerPhone is null

Update CPCaseWorkerPhone
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPCaseWorkerPhone dbTable
	Inner Join Deleted d on dbTable.pkCPCaseWorkerPhone = d.pkCPCaseWorkerPhone
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From CPCaseWorkerPhoneAudit dbTable
Inner Join inserted i ON dbTable.[pkCPCaseWorkerPhone] = i.[pkCPCaseWorkerPhone]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPCaseWorkerPhoneAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPCaseWorkerPhone]
	,[fkCPRefPhoneType]
	,[Number]
	,[Extension]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkCPCaseWorkerPhone]
	,[fkCPRefPhoneType]
	,[Number]
	,[Extension]

From  Inserted
GO
CREATE Trigger [dbo].[tr_CPCaseWorkerPhoneAudit_d] On [dbo].[CPCaseWorkerPhone]
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
From CPCaseWorkerPhoneAudit dbTable
Inner Join deleted d ON dbTable.[pkCPCaseWorkerPhone] = d.[pkCPCaseWorkerPhone]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPCaseWorkerPhoneAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPCaseWorkerPhone]
	,[fkCPRefPhoneType]
	,[Number]
	,[Extension]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkCPCaseWorkerPhone]
	,[fkCPRefPhoneType]
	,[Number]
	,[Extension]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary, auto-incrementing system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPCaseWorkerPhone', @level2type = N'COLUMN', @level2name = N'pkCPCaseWorkerPhone';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign Key to the Phone Type Reference Table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPCaseWorkerPhone', @level2type = N'COLUMN', @level2name = N'fkCPRefPhoneType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Phone number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPCaseWorkerPhone', @level2type = N'COLUMN', @level2name = N'Number';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Phone extension', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPCaseWorkerPhone', @level2type = N'COLUMN', @level2name = N'Extension';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPCaseWorkerPhone', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPCaseWorkerPhone', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPCaseWorkerPhone', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPCaseWorkerPhone', @level2type = N'COLUMN', @level2name = N'CreateDate';

