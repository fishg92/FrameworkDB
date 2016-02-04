CREATE TABLE [dbo].[CPJoinClientClientPhone] (
    [pkCPJoinClientClientPhone] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkCPClient]                DECIMAL (18) NULL,
    [fkCPClientPhone]           DECIMAL (18) NULL,
    [LockedUser]                VARCHAR (50) NULL,
    [LockedDate]                DATETIME     NULL,
    [LUPUser]                   VARCHAR (50) NULL,
    [LUPDate]                   DATETIME     NULL,
    [CreateUser]                VARCHAR (50) NULL,
    [CreateDate]                DATETIME     NULL,
    [fkCPRefPhoneType]          DECIMAL (18) NULL,
    CONSTRAINT [PK_CPJoinClientPhone] PRIMARY KEY NONCLUSTERED ([pkCPJoinClientClientPhone] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkCPClient_fkCPClientPhone]
    ON [dbo].[CPJoinClientClientPhone]([fkCPClient] ASC)
    INCLUDE([fkCPClientPhone]) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [fkCPClientPhone_fkCPClient]
    ON [dbo].[CPJoinClientClientPhone]([fkCPClientPhone] ASC, [fkCPClient] ASC);


GO
CREATE NONCLUSTERED INDEX [fkCPRefPhoneType]
    ON [dbo].[CPJoinClientClientPhone]([fkCPRefPhoneType] ASC);


GO
CREATE Trigger [dbo].[tr_CPJoinClientClientPhoneAudit_UI] On [dbo].[CPJoinClientClientPhone]
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

Update CPJoinClientClientPhone
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPJoinClientClientPhone dbTable
	Inner Join Inserted i on dbtable.pkCPJoinClientClientPhone = i.pkCPJoinClientClientPhone
	Left Join Deleted d on d.pkCPJoinClientClientPhone = d.pkCPJoinClientClientPhone
	Where d.pkCPJoinClientClientPhone is null

Update CPJoinClientClientPhone
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPJoinClientClientPhone dbTable
	Inner Join Deleted d on dbTable.pkCPJoinClientClientPhone = d.pkCPJoinClientClientPhone
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From CPJoinClientClientPhoneAudit dbTable
Inner Join inserted i ON dbTable.[pkCPJoinClientClientPhone] = i.[pkCPJoinClientClientPhone]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPJoinClientClientPhoneAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPJoinClientClientPhone]
	,[fkCPClient]
	,[fkCPClientPhone]
	,[LockedUser]
	,[LockedDate]
	,[fkCPRefPhoneType]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkCPJoinClientClientPhone]
	,[fkCPClient]
	,[fkCPClientPhone]
	,[LockedUser]
	,[LockedDate]
	,[fkCPRefPhoneType]

From  Inserted
GO
CREATE Trigger [dbo].[tr_CPJoinClientClientPhoneAudit_d] On [dbo].[CPJoinClientClientPhone]
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
From CPJoinClientClientPhoneAudit dbTable
Inner Join deleted d ON dbTable.[pkCPJoinClientClientPhone] = d.[pkCPJoinClientClientPhone]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPJoinClientClientPhoneAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPJoinClientClientPhone]
	,[fkCPClient]
	,[fkCPClientPhone]
	,[LockedUser]
	,[LockedDate]
	,[fkCPRefPhoneType]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkCPJoinClientClientPhone]
	,[fkCPClient]
	,[fkCPClientPhone]
	,[LockedUser]
	,[LockedDate]
	,[fkCPRefPhoneType]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This join table links People clients with their phone numbers. Client phone numbers are now stored directly in the CPClient table.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientClientPhone';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system identification number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientClientPhone', @level2type = N'COLUMN', @level2name = N'pkCPJoinClientClientPhone';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'(Indexed) foreign key to CPClient', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientClientPhone', @level2type = N'COLUMN', @level2name = N'fkCPClient';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'(Indexed) Foreign key to CPClientPhone', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientClientPhone', @level2type = N'COLUMN', @level2name = N'fkCPClientPhone';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Deprecated. Feature to be removed
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientClientPhone', @level2type = N'COLUMN', @level2name = N'LockedUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Deprecated. Feature to be removed', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientClientPhone', @level2type = N'COLUMN', @level2name = N'LockedDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientClientPhone', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientClientPhone', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientClientPhone', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientClientPhone', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to CPRefPhoneType, defining the relationship between the phone number and the client', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPJoinClientClientPhone', @level2type = N'COLUMN', @level2name = N'fkCPRefPhoneType';

