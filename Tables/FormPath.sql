CREATE TABLE [dbo].[FormPath] (
    [pkFormPath] DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [fkFormName] DECIMAL (18)  NOT NULL,
    [Path]       VARCHAR (500) NULL,
    [LUPUser]    VARCHAR (50)  NULL,
    [LUPDate]    DATETIME      NULL,
    [CreateUser] VARCHAR (50)  NULL,
    [CreateDate] DATETIME      NULL,
    CONSTRAINT [PK_FormPath] PRIMARY KEY CLUSTERED ([pkFormPath] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkFormName]
    ON [dbo].[FormPath]([fkFormName] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE Trigger [dbo].[tr_FormPathAudit_d] On [dbo].[FormPath]
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
From FormPathAudit dbTable
Inner Join deleted d ON dbTable.[pkFormPath] = d.[pkFormPath]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormPathAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormPath]
	,[fkFormName]
	,[Path]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkFormPath]
	,[fkFormName]
	,[Path]
From  Deleted
GO
CREATE Trigger [dbo].[tr_FormPathAudit_UI] On [dbo].[FormPath]
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

Update FormPath
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormPath dbTable
	Inner Join Inserted i on dbtable.pkFormPath = i.pkFormPath
	Left Join Deleted d on d.pkFormPath = d.pkFormPath
	Where d.pkFormPath is null

Update FormPath
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormPath dbTable
	Inner Join Deleted d on dbTable.pkFormPath = d.pkFormPath
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From FormPathAudit dbTable
Inner Join inserted i ON dbTable.[pkFormPath] = i.[pkFormPath]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormPathAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormPath]
	,[fkFormName]
	,[Path]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkFormPath]
	,[fkFormName]
	,[Path]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Parths for the images in forms are stored in this table.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormPath';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormPath', @level2type = N'COLUMN', @level2name = N'pkFormPath';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the FormName table.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormPath', @level2type = N'COLUMN', @level2name = N'fkFormName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Path to the image in the form.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormPath', @level2type = N'COLUMN', @level2name = N'Path';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormPath', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormPath', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormPath', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormPath', @level2type = N'COLUMN', @level2name = N'CreateDate';

