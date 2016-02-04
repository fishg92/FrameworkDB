CREATE TABLE [dbo].[PSPSwiftViewText] (
    [pkPSPSwiftViewText] DECIMAL (18)   IDENTITY (1, 1) NOT NULL,
    [SwiftViewText]      VARCHAR (100)  NULL,
    [PageNumber]         INT            NULL,
    [Xpos]               DECIMAL (9, 3) NULL,
    [Ypos]               DECIMAL (9, 3) NULL,
    [fkPSPDocument]      DECIMAL (18)   NULL,
    [LUPUser]            VARCHAR (50)   NULL,
    [LUPDate]            DATETIME       NULL,
    [CreateUser]         VARCHAR (50)   NULL,
    [CreateDate]         DATETIME       NULL,
    CONSTRAINT [PK_PSPSwiftViewText] PRIMARY KEY CLUSTERED ([pkPSPSwiftViewText] ASC)
);


GO
CREATE Trigger [dbo].[tr_PSPSwiftViewTextAudit_d] On [dbo].[PSPSwiftViewText]
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
From PSPSwiftViewTextAudit dbTable
Inner Join deleted d ON dbTable.[pkPSPSwiftViewText] = d.[pkPSPSwiftViewText]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into PSPSwiftViewTextAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkPSPSwiftViewText]
	,[SwiftViewText]
	,[PageNumber]
	,[Xpos]
	,[Ypos]
	,[fkPSPDocument]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkPSPSwiftViewText]
	,[SwiftViewText]
	,[PageNumber]
	,[Xpos]
	,[Ypos]
	,[fkPSPDocument]
From  Deleted
GO
CREATE Trigger [dbo].[tr_PSPSwiftViewTextAudit_UI] On [dbo].[PSPSwiftViewText]
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

Update PSPSwiftViewText
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From PSPSwiftViewText dbTable
	Inner Join Inserted i on dbtable.pkPSPSwiftViewText = i.pkPSPSwiftViewText
	Left Join Deleted d on d.pkPSPSwiftViewText = d.pkPSPSwiftViewText
	Where d.pkPSPSwiftViewText is null

Update PSPSwiftViewText
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From PSPSwiftViewText dbTable
	Inner Join Deleted d on dbTable.pkPSPSwiftViewText = d.pkPSPSwiftViewText
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From PSPSwiftViewTextAudit dbTable
Inner Join inserted i ON dbTable.[pkPSPSwiftViewText] = i.[pkPSPSwiftViewText]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into PSPSwiftViewTextAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkPSPSwiftViewText]
	,[SwiftViewText]
	,[PageNumber]
	,[Xpos]
	,[Ypos]
	,[fkPSPDocument]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkPSPSwiftViewText]
	,[SwiftViewText]
	,[PageNumber]
	,[Xpos]
	,[Ypos]
	,[fkPSPDocument]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'PSP is a way to treat any file the same as the output from Forms. The file is printed from any application, keywords are added, and a Compass Document is created. The data in this table is used to index on a PSP Template the position of individual words. It''s used for template generate and verification.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPSwiftViewText';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPSwiftViewText', @level2type = N'COLUMN', @level2name = N'pkPSPSwiftViewText';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The word that is positioned on the page', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPSwiftViewText', @level2type = N'COLUMN', @level2name = N'SwiftViewText';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'What page are we looking at', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPSwiftViewText', @level2type = N'COLUMN', @level2name = N'PageNumber';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'X Position of the word', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPSwiftViewText', @level2type = N'COLUMN', @level2name = N'Xpos';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Y position of the word', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPSwiftViewText', @level2type = N'COLUMN', @level2name = N'Ypos';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to PSPDocument', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPSwiftViewText', @level2type = N'COLUMN', @level2name = N'fkPSPDocument';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPSwiftViewText', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPSwiftViewText', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPSwiftViewText', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPSwiftViewText', @level2type = N'COLUMN', @level2name = N'CreateDate';

