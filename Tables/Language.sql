CREATE TABLE [dbo].[Language] (
    [pkLanguage]  DECIMAL (18)  NOT NULL,
    [Description] VARCHAR (50)  NOT NULL,
    [Active]      BIT           NOT NULL,
    [DisplayText] NVARCHAR (50) NULL,
    CONSTRAINT [PK_Language] PRIMARY KEY CLUSTERED ([pkLanguage] ASC)
);


GO
CREATE Trigger [dbo].[tr_LanguageAudit_d] On [dbo].[Language]
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
From LanguageAudit dbTable
Inner Join deleted d ON dbTable.[pkLanguage] = d.[pkLanguage]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into LanguageAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkLanguage]
	,[Description]
	,[Active]
	,[DisplayText]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkLanguage]
	,[Description]
	,[Active]
	,[DisplayText]
From  Deleted
GO
CREATE Trigger [dbo].[tr_LanguageAudit_UI] On [dbo].[Language]
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


--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From LanguageAudit dbTable
Inner Join inserted i ON dbTable.[pkLanguage] = i.[pkLanguage]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into LanguageAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkLanguage]
	,[Description]
	,[Active]
	,[DisplayText]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkLanguage]
	,[Description]
	,[Active]
	,[DisplayText]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'Description', @value = N'This table is essentially a reference table to get the list of languages to show for the Self-Scan Kiosk.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Language';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table is essentially a reference table to get the list of languages to show for the Self-Scan Kiosk.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Language';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Language', @level2type = N'COLUMN', @level2name = N'pkLanguage';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Text description of the language', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Language', @level2type = N'COLUMN', @level2name = N'Description';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Whether or not it is to be currently listed', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Language', @level2type = N'COLUMN', @level2name = N'Active';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Display text for the language at the kiosk (Francais rather than French for example)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Language', @level2type = N'COLUMN', @level2name = N'DisplayText';

