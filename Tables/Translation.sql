CREATE TABLE [dbo].[Translation] (
    [pkTranslation]   DECIMAL (18)   IDENTITY (1, 1) NOT NULL,
    [fkScreenControl] DECIMAL (18)   NOT NULL,
    [fkLanguage]      DECIMAL (18)   NOT NULL,
    [Description]     VARCHAR (500)  CONSTRAINT [DF_Translation_Description] DEFAULT ('') NOT NULL,
    [DisplayText]     NVARCHAR (500) NOT NULL,
    [Context]         VARCHAR (50)   CONSTRAINT [DF_Translation_Context] DEFAULT ('') NOT NULL,
    [Sequence]        INT            NULL,
    [ItemKey]         VARCHAR (200)  NULL,
    CONSTRAINT [PK_Translation] PRIMARY KEY CLUSTERED ([pkTranslation] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkLanguage]
    ON [dbo].[Translation]([fkLanguage] ASC);


GO
CREATE NONCLUSTERED INDEX [fkScreenControl]
    ON [dbo].[Translation]([fkScreenControl] ASC);


GO
CREATE Trigger [dbo].[tr_TranslationAudit_UI] On [dbo].[Translation]
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
From TranslationAudit dbTable
Inner Join inserted i ON dbTable.[pkTranslation] = i.[pkTranslation]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into TranslationAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkTranslation]
	,[fkScreenControl]
	,[fkLanguage]
	,[Description]
	,[DisplayText]
	,[Context]
	,[Sequence]
	,[ItemKey]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkTranslation]
	,[fkScreenControl]
	,[fkLanguage]
	,[Description]
	,[DisplayText]
	,[Context]
	,[Sequence]
	,[ItemKey]

From  Inserted
GO
CREATE Trigger [dbo].[tr_TranslationAudit_d] On [dbo].[Translation]
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
From TranslationAudit dbTable
Inner Join deleted d ON dbTable.[pkTranslation] = d.[pkTranslation]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into TranslationAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkTranslation]
	,[fkScreenControl]
	,[fkLanguage]
	,[Description]
	,[DisplayText]
	,[Context]
	,[Sequence]
	,[ItemKey]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkTranslation]
	,[fkScreenControl]
	,[fkLanguage]
	,[Description]
	,[DisplayText]
	,[Context]
	,[Sequence]
	,[ItemKey]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table is used for internationalization, primarily of the Self-Scan Kiosk. It maps foreign language translations for labels and buttons so that when different languages are selected, the interface is translated property.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Translation';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Translation', @level2type = N'COLUMN', @level2name = N'pkTranslation';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to ScreenControl', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Translation', @level2type = N'COLUMN', @level2name = N'fkScreenControl';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to Language', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Translation', @level2type = N'COLUMN', @level2name = N'fkLanguage';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'English description of what the control is', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Translation', @level2type = N'COLUMN', @level2name = N'Description';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Translated text to display in the control', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Translation', @level2type = N'COLUMN', @level2name = N'DisplayText';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'In the event that a control''s display text changes based on the user''s actions, in what context should the control show this translation', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Translation', @level2type = N'COLUMN', @level2name = N'Context';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Used to order the translations within the UI for set up', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Translation', @level2type = N'COLUMN', @level2name = N'Sequence';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'A unique (within the language translation) key value to associate with this translation', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Translation', @level2type = N'COLUMN', @level2name = N'ItemKey';

