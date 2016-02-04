CREATE TABLE [dbo].[SmartFillData] (
    [pkSmartFillData]   DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [PeopleID]          VARCHAR (50) NOT NULL,
    [fkApplicationUser] DECIMAL (18) NOT NULL,
    [LupUser]           VARCHAR (50) NULL,
    [LupDate]           DATETIME     NULL,
    [CreateUser]        VARCHAR (50) NULL,
    [CreateDate]        DATETIME     NULL,
    CONSTRAINT [PK_SmartFillData] PRIMARY KEY CLUSTERED ([pkSmartFillData] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkApplicationUser]
    ON [dbo].[SmartFillData]([fkApplicationUser] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE Trigger [dbo].[tr_SmartFillDataAudit_d] On [dbo].[SmartFillData]
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
From SmartFillDataAudit dbTable
Inner Join deleted d ON dbTable.[pkSmartFillData] = d.[pkSmartFillData]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into SmartFillDataAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkSmartFillData]
	,[PeopleID]
	,[fkApplicationUser]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkSmartFillData]
	,[PeopleID]
	,[fkApplicationUser]
From  Deleted
GO
CREATE Trigger [dbo].[tr_SmartFillDataAudit_UI] On [dbo].[SmartFillData]
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

Update SmartFillData
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From SmartFillData dbTable
	Inner Join Inserted i on dbtable.pkSmartFillData = i.pkSmartFillData
	Left Join Deleted d on d.pkSmartFillData = d.pkSmartFillData
	Where d.pkSmartFillData is null

Update SmartFillData
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From SmartFillData dbTable
	Inner Join Deleted d on dbTable.pkSmartFillData = d.pkSmartFillData
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From SmartFillDataAudit dbTable
Inner Join inserted i ON dbTable.[pkSmartFillData] = i.[pkSmartFillData]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into SmartFillDataAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkSmartFillData]
	,[PeopleID]
	,[fkApplicationUser]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkSmartFillData]
	,[PeopleID]
	,[fkApplicationUser]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table links users to the CPClients they have added to their "People" list to do the quick autofill options without looking them up. It''s basically a frequently used client list.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'SmartFillData';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'SmartFillData', @level2type = N'COLUMN', @level2name = N'pkSmartFillData';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'ID for a client in Compass People', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'SmartFillData', @level2type = N'COLUMN', @level2name = N'PeopleID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to ApplicationUser', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'SmartFillData', @level2type = N'COLUMN', @level2name = N'fkApplicationUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'SmartFillData', @level2type = N'COLUMN', @level2name = N'LupUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'SmartFillData', @level2type = N'COLUMN', @level2name = N'LupDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'SmartFillData', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'SmartFillData', @level2type = N'COLUMN', @level2name = N'CreateDate';

