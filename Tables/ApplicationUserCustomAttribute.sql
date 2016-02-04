CREATE TABLE [dbo].[ApplicationUserCustomAttribute] (
    [pkApplicationUserCustomAttribute] DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [fkApplicationUser]                DECIMAL (18)  NOT NULL,
    [ItemKey]                          VARCHAR (200) NOT NULL,
    [ItemValue]                        VARCHAR (300) NOT NULL,
    [LUPUser]                          VARCHAR (50)  NULL,
    [LUPDate]                          DATETIME      NULL,
    [CreateUser]                       VARCHAR (50)  NULL,
    [CreateDate]                       DATETIME      NULL,
    CONSTRAINT [PK_ApplicationUserCustomAttribute] PRIMARY KEY CLUSTERED ([pkApplicationUserCustomAttribute] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkApplicationUser]
    ON [dbo].[ApplicationUserCustomAttribute]([fkApplicationUser] ASC);


GO
CREATE Trigger [dbo].[tr_ApplicationUserCustomAttributeAudit_d] On [dbo].[ApplicationUserCustomAttribute]
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
From ApplicationUserCustomAttributeAudit dbTable
Inner Join deleted d ON dbTable.[pkApplicationUserCustomAttribute] = d.[pkApplicationUserCustomAttribute]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into ApplicationUserCustomAttributeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkApplicationUserCustomAttribute]
	,[fkApplicationUser]
	,[ItemKey]
	,[ItemValue]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkApplicationUserCustomAttribute]
	,[fkApplicationUser]
	,[ItemKey]
	,[ItemValue]
From  Deleted
GO
CREATE Trigger [dbo].[tr_ApplicationUserCustomAttributeAudit_UI] On [dbo].[ApplicationUserCustomAttribute]
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

Update ApplicationUserCustomAttribute
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From ApplicationUserCustomAttribute dbTable
	Inner Join Inserted i on dbtable.pkApplicationUserCustomAttribute = i.pkApplicationUserCustomAttribute
	Left Join Deleted d on d.pkApplicationUserCustomAttribute = d.pkApplicationUserCustomAttribute
	Where d.pkApplicationUserCustomAttribute is null

Update ApplicationUserCustomAttribute
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From ApplicationUserCustomAttribute dbTable
	Inner Join Deleted d on dbTable.pkApplicationUserCustomAttribute = d.pkApplicationUserCustomAttribute
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From ApplicationUserCustomAttributeAudit dbTable
Inner Join inserted i ON dbTable.[pkApplicationUserCustomAttribute] = i.[pkApplicationUserCustomAttribute]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into ApplicationUserCustomAttributeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkApplicationUserCustomAttribute]
	,[fkApplicationUser]
	,[ItemKey]
	,[ItemValue]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkApplicationUserCustomAttribute]
	,[fkApplicationUser]
	,[ItemKey]
	,[ItemValue]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Customer-specific data about system users', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUserCustomAttribute';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUserCustomAttribute', @level2type = N'COLUMN', @level2name = N'pkApplicationUserCustomAttribute';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to ApplicationUser table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUserCustomAttribute', @level2type = N'COLUMN', @level2name = N'fkApplicationUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Type of attribute', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUserCustomAttribute', @level2type = N'COLUMN', @level2name = N'ItemKey';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Value of attribute', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUserCustomAttribute', @level2type = N'COLUMN', @level2name = N'ItemValue';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUserCustomAttribute', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUserCustomAttribute', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUserCustomAttribute', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUserCustomAttribute', @level2type = N'COLUMN', @level2name = N'CreateDate';

