CREATE TABLE [dbo].[FormAnnotationSharedObject] (
    [pkFormAnnotationSharedObject] DECIMAL (18)    IDENTITY (1, 1) NOT NULL,
    [ObjectName]                   VARCHAR (255)   NULL,
    [BinaryData]                   VARBINARY (MAX) NULL,
    [StringData]                   TEXT            NULL,
    [Active]                       BIT             NULL,
    [LUPUser]                      VARCHAR (50)    NULL,
    [LUPDate]                      DATETIME        NULL,
    [CreateUser]                   VARCHAR (50)    NULL,
    [CreateDate]                   DATETIME        NULL,
    CONSTRAINT [PK_FormAnnotationImage] PRIMARY KEY CLUSTERED ([pkFormAnnotationSharedObject] ASC)
);


GO
CREATE Trigger [dbo].[tr_FormAnnotationSharedObjectAudit_d] On [dbo].[FormAnnotationSharedObject]
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
From FormAnnotationSharedObjectAudit dbTable
Inner Join deleted d ON dbTable.[pkFormAnnotationSharedObject] = d.[pkFormAnnotationSharedObject]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormAnnotationSharedObjectAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormAnnotationSharedObject]
	,[ObjectName]
	,[BinaryData]
	,[StringData]
	,[Active]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkFormAnnotationSharedObject]
	,[ObjectName]
	,[BinaryData]
	,null
	,[Active]
From  Deleted
GO
CREATE Trigger [dbo].[tr_FormAnnotationSharedObjectAudit_UI] On [dbo].[FormAnnotationSharedObject]
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

Update FormAnnotationSharedObject
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormAnnotationSharedObject dbTable
	Inner Join Inserted i on dbtable.pkFormAnnotationSharedObject = i.pkFormAnnotationSharedObject
	Left Join Deleted d on d.pkFormAnnotationSharedObject = d.pkFormAnnotationSharedObject
	Where d.pkFormAnnotationSharedObject is null

Update FormAnnotationSharedObject
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormAnnotationSharedObject dbTable
	Inner Join Deleted d on dbTable.pkFormAnnotationSharedObject = d.pkFormAnnotationSharedObject
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From FormAnnotationSharedObjectAudit dbTable
Inner Join inserted i ON dbTable.[pkFormAnnotationSharedObject] = i.[pkFormAnnotationSharedObject]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormAnnotationSharedObjectAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormAnnotationSharedObject]
	,[ObjectName]
	,[BinaryData]
	,[StringData]
	,[Active]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkFormAnnotationSharedObject]
	,[ObjectName]
	,0
	,null
	,[Active]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Share objects on a form are either text or binary (image) objects that may appear on many different forms and can be easily added. This table tracks those objects.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotationSharedObject';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system identification number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotationSharedObject', @level2type = N'COLUMN', @level2name = N'pkFormAnnotationSharedObject';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Human readable name of the object', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotationSharedObject', @level2type = N'COLUMN', @level2name = N'ObjectName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Binary representation of the object (i.e. the bytes that make up the image)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotationSharedObject', @level2type = N'COLUMN', @level2name = N'BinaryData';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The string of text that is the object', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotationSharedObject', @level2type = N'COLUMN', @level2name = N'StringData';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Allows virtual deletion of objects from the system (removing them from current use, while maintaining their historical use)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotationSharedObject', @level2type = N'COLUMN', @level2name = N'Active';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotationSharedObject', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotationSharedObject', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotationSharedObject', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotationSharedObject', @level2type = N'COLUMN', @level2name = N'CreateDate';

