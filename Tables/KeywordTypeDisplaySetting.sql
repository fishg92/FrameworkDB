CREATE TABLE [dbo].[KeywordTypeDisplaySetting] (
    [pkKeywordTypeDisplaySetting] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkKeywordType]               VARCHAR (50) NOT NULL,
    [KeywordName]                 VARCHAR (50) NOT NULL,
    [DisplayInResultGrid]         BIT          CONSTRAINT [DF_KeywordTypeDisplaySetting_DisplayInGrid] DEFAULT ((0)) NOT NULL,
    [Sequence]                    INT          CONSTRAINT [DF_KeywordTypeDisplaySetting_Sequence] DEFAULT ((0)) NOT NULL,
    [LUPUser]                     VARCHAR (50) NULL,
    [LUPDate]                     DATETIME     NULL,
    [CreateUser]                  VARCHAR (50) NULL,
    [CreateDate]                  DATETIME     NULL,
    [IsSearchable]                BIT          CONSTRAINT [DF_KeywordTypeDisplaySetting_IsVisible] DEFAULT ((1)) NOT NULL,
    [IncludeInExportManifest]     BIT          CONSTRAINT [DF_KeywordTypeDisplaySetting_IncludeInExportManifest] DEFAULT ((0)) NOT NULL,
    [IsFreeform]                  BIT          CONSTRAINT [DF_KeywordTypeDisplaySetting_IsFreeform] DEFAULT ((0)) NOT NULL,
    [fkProfile]                   DECIMAL (18) CONSTRAINT [DF_KeywordTypeDisplaySetting_fkProfile] DEFAULT ((-1)) NOT NULL,
    [IsRequiredByPilot]           BIT          CONSTRAINT [DF_KeywordTypeDisplaySetting_IsRequiredByPilot] DEFAULT ((0)) NOT NULL,
    [IsNotAutoIndexed]            BIT          CONSTRAINT [DF_KeywordTypeDisplaySetting_IsNotAutoIndexed] DEFAULT ((0)) NOT NULL,
    [DocumentNamingSequence]      INT          CONSTRAINT [DF_KeywordTypeDisplaySetting_DocumentNamingSequence] DEFAULT ((-1)) NOT NULL,
    CONSTRAINT [PK_KeywordTypeDisplaySetting] PRIMARY KEY CLUSTERED ([pkKeywordTypeDisplaySetting] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkKeywordType]
    ON [dbo].[KeywordTypeDisplaySetting]([fkKeywordType] ASC, [KeywordName] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [fkProfile]
    ON [dbo].[KeywordTypeDisplaySetting]([fkProfile] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [fkKeywordTypefkProfile]
    ON [dbo].[KeywordTypeDisplaySetting]([fkKeywordType] ASC, [fkProfile] ASC);


GO
CREATE Trigger [dbo].[tr_KeywordTypeDisplaySettingAudit_d] On [dbo].[KeywordTypeDisplaySetting]
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
From KeywordTypeDisplaySettingAudit dbTable
Inner Join deleted d ON dbTable.[pkKeywordTypeDisplaySetting] = d.[pkKeywordTypeDisplaySetting]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into KeywordTypeDisplaySettingAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkKeywordTypeDisplaySetting]
	,[fkKeywordType]
	,[KeywordName]
	,[DisplayInResultGrid]
	,[Sequence]
	,[IsSearchable]
	,[IncludeInExportManifest]
	,[IsFreeform]
	,[fkProfile]
	,[IsRequiredByPilot]
	,IsNotAutoIndexed
	,DocumentNamingSequence
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkKeywordTypeDisplaySetting]
	,[fkKeywordType]
	,[KeywordName]
	,[DisplayInResultGrid]
	,[Sequence]
	,[IsSearchable]
	,[IncludeInExportManifest]
	,[IsFreeform]
	,[fkProfile]
	,[IsRequiredByPilot]
	,IsNotAutoIndexed
	,DocumentNamingSequence
From  Deleted
GO
CREATE Trigger [dbo].[tr_KeywordTypeDisplaySettingAudit_UI] On [dbo].[KeywordTypeDisplaySetting]
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

Update KeywordTypeDisplaySetting
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From KeywordTypeDisplaySetting dbTable
	Inner Join Inserted i on dbtable.pkKeywordTypeDisplaySetting = i.pkKeywordTypeDisplaySetting
	Left Join Deleted d on d.pkKeywordTypeDisplaySetting = d.pkKeywordTypeDisplaySetting
	Where d.pkKeywordTypeDisplaySetting is null

Update KeywordTypeDisplaySetting
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From KeywordTypeDisplaySetting dbTable
	Inner Join Deleted d on dbTable.pkKeywordTypeDisplaySetting = d.pkKeywordTypeDisplaySetting
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From KeywordTypeDisplaySettingAudit dbTable
Inner Join inserted i ON dbTable.[pkKeywordTypeDisplaySetting] = i.[pkKeywordTypeDisplaySetting]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into KeywordTypeDisplaySettingAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkKeywordTypeDisplaySetting]
	,[fkKeywordType]
	,[KeywordName]
	,[DisplayInResultGrid]
	,[Sequence]
	,[IsSearchable]
	,[IncludeInExportManifest]
	,[IsFreeform]
	,[fkProfile]
	,[IsRequiredByPilot]
	,IsNotAutoIndexed
	,DocumentNamingSequence

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkKeywordTypeDisplaySetting]
	,[fkKeywordType]
	,[KeywordName]
	,[DisplayInResultGrid]
	,[Sequence]
	,[IsSearchable]
	,[IncludeInExportManifest]
	,[IsFreeform]
	,[fkProfile]
	,[IsRequiredByPilot]
	,IsNotAutoIndexed
	,DocumentNamingSequence

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table manages the keyword settings for both the default settings (fkProfile = -1) and for those profiles that override those default settings.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'KeywordTypeDisplaySetting';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'KeywordTypeDisplaySetting', @level2type = N'COLUMN', @level2name = N'pkKeywordTypeDisplaySetting';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to KeywordType (from DMS)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'KeywordTypeDisplaySetting', @level2type = N'COLUMN', @level2name = N'fkKeywordType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Keyword name', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'KeywordTypeDisplaySetting', @level2type = N'COLUMN', @level2name = N'KeywordName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Should this keyword be displayed in the results grid?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'KeywordTypeDisplaySetting', @level2type = N'COLUMN', @level2name = N'DisplayInResultGrid';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Used to arrange the keywords in order.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'KeywordTypeDisplaySetting', @level2type = N'COLUMN', @level2name = N'Sequence';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'KeywordTypeDisplaySetting', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'KeywordTypeDisplaySetting', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'KeywordTypeDisplaySetting', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'KeywordTypeDisplaySetting', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is this keyword to be used for searching?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'KeywordTypeDisplaySetting', @level2type = N'COLUMN', @level2name = N'IsSearchable';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is it to be included in the export manifest when documents are exported?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'KeywordTypeDisplaySetting', @level2type = N'COLUMN', @level2name = N'IncludeInExportManifest';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is this keyword freeform?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'KeywordTypeDisplaySetting', @level2type = N'COLUMN', @level2name = N'IsFreeform';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to Profiles (-1 is general settings)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'KeywordTypeDisplaySetting', @level2type = N'COLUMN', @level2name = N'fkProfile';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is this keyword required by Pilot?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'KeywordTypeDisplaySetting', @level2type = N'COLUMN', @level2name = N'IsRequiredByPilot';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'When auto-indexing, should this keyword''s value be left (1) or should it be updated (0)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'KeywordTypeDisplaySetting', @level2type = N'COLUMN', @level2name = N'IsNotAutoIndexed';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Used to determine how documents should be automatically named (-1 = don''t use)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'KeywordTypeDisplaySetting', @level2type = N'COLUMN', @level2name = N'DocumentNamingSequence';

