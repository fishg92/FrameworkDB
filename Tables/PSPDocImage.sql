CREATE TABLE [dbo].[PSPDocImage] (
    [pkPSPDocImage] DECIMAL (18)    IDENTITY (1, 1) NOT NULL,
    [fkPSPDocType]  DECIMAL (18)    NOT NULL,
    [FullImage]     VARBINARY (MAX) NOT NULL,
    [LUPUser]       VARCHAR (50)    NULL,
    [LUPDate]       DATETIME        NULL,
    [CreateUser]    VARCHAR (50)    NULL,
    [CreateDate]    DATETIME        NULL,
    CONSTRAINT [PK_PSPDocImage] PRIMARY KEY CLUSTERED ([pkPSPDocImage] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkPSPDocType]
    ON [dbo].[PSPDocImage]([fkPSPDocType] ASC);


GO
CREATE Trigger [dbo].[tr_PSPDocImageAudit_UI] On [dbo].[PSPDocImage]
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

Update PSPDocImage
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From PSPDocImage dbTable
	Inner Join Inserted i on dbtable.pkPSPDocImage = i.pkPSPDocImage
	Left Join Deleted d on d.pkPSPDocImage = d.pkPSPDocImage
	Where d.pkPSPDocImage is null

Update PSPDocImage
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From PSPDocImage dbTable
	Inner Join Deleted d on dbTable.pkPSPDocImage = d.pkPSPDocImage
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From PSPDocImageAudit dbTable
Inner Join inserted i ON dbTable.[pkPSPDocImage] = i.[pkPSPDocImage]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into PSPDocImageAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkPSPDocImage]
	,[fkPSPDocType]
	,[FullImage]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkPSPDocImage]
	,[fkPSPDocType]
	,0

From  Inserted
GO
CREATE Trigger [dbo].[tr_PSPDocImageAudit_d] On [dbo].[PSPDocImage]
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
From PSPDocImageAudit dbTable
Inner Join deleted d ON dbTable.[pkPSPDocImage] = d.[pkPSPDocImage]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into PSPDocImageAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkPSPDocImage]
	,[fkPSPDocType]
	,[FullImage]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkPSPDocImage]
	,[fkPSPDocType]
	,[FullImage]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'PSP is a way to treat any file the same as the output from Forms. The file is printed from any application, keywords are added, and a Compass Document is created. This table stores the images that are created in this print process.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPDocImage';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPDocImage', @level2type = N'COLUMN', @level2name = N'pkPSPDocImage';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to PSPDocType', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPDocImage', @level2type = N'COLUMN', @level2name = N'fkPSPDocType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Binary of the image', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPDocImage', @level2type = N'COLUMN', @level2name = N'FullImage';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPDocImage', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPDocImage', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPDocImage', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPDocImage', @level2type = N'COLUMN', @level2name = N'CreateDate';

