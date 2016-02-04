CREATE TABLE [dbo].[ColumnNameFriendlyNameMapping] (
    [pkColumnNameFriendlyNameMapping] DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [TableName]                       VARCHAR (200) NOT NULL,
    [ColumnName]                      VARCHAR (200) NOT NULL,
    [FriendlyName]                    VARCHAR (200) NOT NULL,
    [LUPUser]                         VARCHAR (50)  NULL,
    [LUPDate]                         DATETIME      NULL,
    [CreateUser]                      VARCHAR (50)  NULL,
    [CreateDate]                      DATETIME      NULL,
    CONSTRAINT [PK_ColumnNameFriendlyNameMapping] PRIMARY KEY CLUSTERED ([pkColumnNameFriendlyNameMapping] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxColumnName]
    ON [dbo].[ColumnNameFriendlyNameMapping]([ColumnName] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE Trigger [dbo].[tr_ColumnNameFriendlyNameMappingAudit_d] On [dbo].[ColumnNameFriendlyNameMapping]
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
From ColumnNameFriendlyNameMappingAudit dbTable
Inner Join deleted d ON dbTable.[pkColumnNameFriendlyNameMapping] = d.[pkColumnNameFriendlyNameMapping]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into ColumnNameFriendlyNameMappingAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkColumnNameFriendlyNameMapping]
	,[TableName]
	,[ColumnName]
	,[FriendlyName]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkColumnNameFriendlyNameMapping]
	,[TableName]
	,[ColumnName]
	,[FriendlyName]
From  Deleted
GO
CREATE Trigger [dbo].[tr_ColumnNameFriendlyNameMappingAudit_UI] On [dbo].[ColumnNameFriendlyNameMapping]
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

Update ColumnNameFriendlyNameMapping
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From ColumnNameFriendlyNameMapping dbTable
	Inner Join Inserted i on dbtable.pkColumnNameFriendlyNameMapping = i.pkColumnNameFriendlyNameMapping
	Left Join Deleted d on d.pkColumnNameFriendlyNameMapping = d.pkColumnNameFriendlyNameMapping
	Where d.pkColumnNameFriendlyNameMapping is null

Update ColumnNameFriendlyNameMapping
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From ColumnNameFriendlyNameMapping dbTable
	Inner Join Deleted d on dbTable.pkColumnNameFriendlyNameMapping = d.pkColumnNameFriendlyNameMapping
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From ColumnNameFriendlyNameMappingAudit dbTable
Inner Join inserted i ON dbTable.[pkColumnNameFriendlyNameMapping] = i.[pkColumnNameFriendlyNameMapping]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into ColumnNameFriendlyNameMappingAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkColumnNameFriendlyNameMapping]
	,[TableName]
	,[ColumnName]
	,[FriendlyName]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkColumnNameFriendlyNameMapping]
	,[TableName]
	,[ColumnName]
	,[FriendlyName]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Used to store mapping between Autofill column names and common names', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ColumnNameFriendlyNameMapping';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary, auto-incrementing sytem ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ColumnNameFriendlyNameMapping', @level2type = N'COLUMN', @level2name = N'pkColumnNameFriendlyNameMapping';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Name of the table for the column name map', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ColumnNameFriendlyNameMapping', @level2type = N'COLUMN', @level2name = N'TableName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Name of column name to alias in interface', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ColumnNameFriendlyNameMapping', @level2type = N'COLUMN', @level2name = N'ColumnName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Label to use for the column in the interface.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ColumnNameFriendlyNameMapping', @level2type = N'COLUMN', @level2name = N'FriendlyName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ColumnNameFriendlyNameMapping', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ColumnNameFriendlyNameMapping', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ColumnNameFriendlyNameMapping', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ColumnNameFriendlyNameMapping', @level2type = N'COLUMN', @level2name = N'CreateDate';

