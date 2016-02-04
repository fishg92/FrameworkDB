CREATE TABLE [dbo].[CPClientPhone] (
    [pkCPClientPhone]  DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkCPRefPhoneType] DECIMAL (18) NULL,
    [Number]           VARCHAR (10) NULL,
    [Extension]        VARCHAR (10) NULL,
    [LockedUser]       VARCHAR (50) NULL,
    [LockedDate]       DATETIME     NULL,
    [LUPUser]          VARCHAR (50) NULL,
    [LUPDate]          DATETIME     NULL,
    [CreateUser]       VARCHAR (50) NULL,
    [CreateDate]       DATETIME     NULL,
    CONSTRAINT [PK_CPClientPhone] PRIMARY KEY NONCLUSTERED ([pkCPClientPhone] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkCPRefPhoneType]
    ON [dbo].[CPClientPhone]([fkCPRefPhoneType] ASC);


GO
CREATE Trigger [dbo].[tr_CPClientPhoneAudit_UI] On [dbo].[CPClientPhone]
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

Update CPClientPhone
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPClientPhone dbTable
	Inner Join Inserted i on dbtable.pkCPClientPhone = i.pkCPClientPhone
	Left Join Deleted d on d.pkCPClientPhone = d.pkCPClientPhone
	Where d.pkCPClientPhone is null

Update CPClientPhone
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPClientPhone dbTable
	Inner Join Deleted d on dbTable.pkCPClientPhone = d.pkCPClientPhone
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From CPClientPhoneAudit dbTable
Inner Join inserted i ON dbTable.[pkCPClientPhone] = i.[pkCPClientPhone]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPClientPhoneAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPClientPhone]
	,[fkCPRefPhoneType]
	,[Number]
	,[Extension]
	,[LockedUser]
	,[LockedDate]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkCPClientPhone]
	,[fkCPRefPhoneType]
	,[Number]
	,[Extension]
	,[LockedUser]
	,[LockedDate]

From  Inserted
GO
CREATE Trigger [dbo].[tr_CPClientPhoneAudit_d] On [dbo].[CPClientPhone]
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
From CPClientPhoneAudit dbTable
Inner Join deleted d ON dbTable.[pkCPClientPhone] = d.[pkCPClientPhone]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPClientPhoneAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPClientPhone]
	,[fkCPRefPhoneType]
	,[Number]
	,[Extension]
	,[LockedUser]
	,[LockedDate]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkCPClientPhone]
	,[fkCPRefPhoneType]
	,[Number]
	,[Extension]
	,[LockedUser]
	,[LockedDate]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Deprecated – This table contains phone numbers for People clients. These values are now stored directly in the CPClient table.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientPhone';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system identification number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientPhone', @level2type = N'COLUMN', @level2name = N'pkCPClientPhone';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the list of phone number types', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientPhone', @level2type = N'COLUMN', @level2name = N'fkCPRefPhoneType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Phone number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientPhone', @level2type = N'COLUMN', @level2name = N'Number';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Extension', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientPhone', @level2type = N'COLUMN', @level2name = N'Extension';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Deprecated', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientPhone', @level2type = N'COLUMN', @level2name = N'LockedUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Deprecated', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientPhone', @level2type = N'COLUMN', @level2name = N'LockedDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientPhone', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientPhone', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientPhone', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientPhone', @level2type = N'COLUMN', @level2name = N'CreateDate';

