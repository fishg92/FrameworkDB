CREATE TABLE [dbo].[FormUserSharedObject] (
    [pkFormUserSharedObject]       DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkFrameworkUserID]            DECIMAL (18) NOT NULL,
    [fkFormAnnotationSharedObject] DECIMAL (18) NOT NULL,
    [Value]                        TEXT         NOT NULL,
    [LUPUser]                      VARCHAR (50) NULL,
    [LUPDate]                      DATETIME     NULL,
    [CreateUser]                   VARCHAR (50) NULL,
    [CreateDate]                   DATETIME     NULL,
    CONSTRAINT [PK_FormUserSharedObject] PRIMARY KEY CLUSTERED ([pkFormUserSharedObject] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkFormAnnotationSharedObject]
    ON [dbo].[FormUserSharedObject]([fkFormAnnotationSharedObject] ASC);


GO
CREATE Trigger [dbo].[tr_FormUserSharedObjectAudit_d] On [dbo].[FormUserSharedObject]
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
From FormUserSharedObjectAudit dbTable
Inner Join deleted d ON dbTable.[pkFormUserSharedObject] = d.[pkFormUserSharedObject]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormUserSharedObjectAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormUserSharedObject]
	,[fkFrameworkUserID]
	,[fkFormAnnotationSharedObject]
	,[Value]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkFormUserSharedObject]
	,[fkFrameworkUserID]
	,[fkFormAnnotationSharedObject]
	,''
From  Deleted
GO
CREATE Trigger [dbo].[tr_FormUserSharedObjectAudit_UI] On [dbo].[FormUserSharedObject]
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

Update FormUserSharedObject
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormUserSharedObject dbTable
	Inner Join Inserted i on dbtable.pkFormUserSharedObject = i.pkFormUserSharedObject
	Left Join Deleted d on d.pkFormUserSharedObject = d.pkFormUserSharedObject
	Where d.pkFormUserSharedObject is null

Update FormUserSharedObject
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormUserSharedObject dbTable
	Inner Join Deleted d on dbTable.pkFormUserSharedObject = d.pkFormUserSharedObject
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From FormUserSharedObjectAudit dbTable
Inner Join inserted i ON dbTable.[pkFormUserSharedObject] = i.[pkFormUserSharedObject]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormUserSharedObjectAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormUserSharedObject]
	,[fkFrameworkUserID]
	,[fkFormAnnotationSharedObject]
	,[Value]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkFormUserSharedObject]
	,[fkFrameworkUserID]
	,[fkFormAnnotationSharedObject]
	,''

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Shared objects are shared between forms by a user. So if a user has a block of text or an image they want to add to multiple forms (such as a return address or some boilerplate directions) they can create a Shared Object and keep that information there to easily access it in multiple forms. This table joins those objects with users along with some text describing the object.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormUserSharedObject';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormUserSharedObject', @level2type = N'COLUMN', @level2name = N'pkFormUserSharedObject';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to FrameworkUserID (application user)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormUserSharedObject', @level2type = N'COLUMN', @level2name = N'fkFrameworkUserID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to FormAnnotationSharedObject', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormUserSharedObject', @level2type = N'COLUMN', @level2name = N'fkFormAnnotationSharedObject';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Text description from the user for the object', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormUserSharedObject', @level2type = N'COLUMN', @level2name = N'Value';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormUserSharedObject', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormUserSharedObject', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormUserSharedObject', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormUserSharedObject', @level2type = N'COLUMN', @level2name = N'CreateDate';

