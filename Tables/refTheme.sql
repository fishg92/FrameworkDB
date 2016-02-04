CREATE TABLE [dbo].[refTheme] (
    [pkrefTheme]  DECIMAL (18) NOT NULL,
    [KeyName]     VARCHAR (50) NOT NULL,
    [Description] VARCHAR (50) NOT NULL,
    [LUPUser]     VARCHAR (50) NULL,
    [LUPDate]     DATETIME     NULL,
    [CreateUser]  VARCHAR (50) NULL,
    [CreateDate]  DATETIME     NULL,
    CONSTRAINT [PK_refTheme] PRIMARY KEY CLUSTERED ([pkrefTheme] ASC)
);


GO
CREATE Trigger [dbo].[tr_refThemeAudit_d] On [dbo].[refTheme]
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
From refThemeAudit dbTable
Inner Join deleted d ON dbTable.[pkrefTheme] = d.[pkrefTheme]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into refThemeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkrefTheme]
	,[KeyName]
	,[Description]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkrefTheme]
	,[KeyName]
	,[Description]
From  Deleted
GO
CREATE Trigger [dbo].[tr_refThemeAudit_UI] On [dbo].[refTheme]
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

Update refTheme
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From refTheme dbTable
	Inner Join Inserted i on dbtable.pkrefTheme = i.pkrefTheme
	Left Join Deleted d on d.pkrefTheme = d.pkrefTheme
	Where d.pkrefTheme is null

Update refTheme
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From refTheme dbTable
	Inner Join Deleted d on dbTable.pkrefTheme = d.pkrefTheme
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From refThemeAudit dbTable
Inner Join inserted i ON dbTable.[pkrefTheme] = i.[pkrefTheme]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into refThemeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkrefTheme]
	,[KeyName]
	,[Description]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkrefTheme]
	,[KeyName]
	,[Description]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table is a reference listing of the different UI themes within Pilot. Changes to the table will not create new themes without an associated PCR being created and completed.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTheme';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTheme', @level2type = N'COLUMN', @level2name = N'pkrefTheme';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Internal name of the theme', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTheme', @level2type = N'COLUMN', @level2name = N'KeyName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User friendly display name for the theme', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTheme', @level2type = N'COLUMN', @level2name = N'Description';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTheme', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTheme', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTheme', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTheme', @level2type = N'COLUMN', @level2name = N'CreateDate';

