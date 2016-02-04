CREATE TABLE [dbo].[FormUserSetting] (
    [pkFormUserSetting]        DECIMAL (18)   IDENTITY (1, 1) NOT NULL,
    [fkFrameworkUserID]        DECIMAL (18)   NOT NULL,
    [ReturnAddress]            VARCHAR (1000) NULL,
    [DateFormatMask]           VARCHAR (50)   NULL,
    [Signature]                IMAGE          NULL,
    [SignatureString]          TEXT           NULL,
    [SignatureHeight]          INT            NULL,
    [SignatureWidth]           INT            NULL,
    [SignatureDPIX]            INT            NULL,
    [SignatureDPIY]            INT            NULL,
    [fkActiveAutofill]         DECIMAL (18)   NULL,
    [SignatureDensity]         INT            NULL,
    [FilterSearchString]       VARCHAR (30)   CONSTRAINT [DF_FormUserSetting_FilterSearchString] DEFAULT ('') NOT NULL,
    [FilterSearchAllFolders]   BIT            CONSTRAINT [DF_FormUserSetting_FilterSearchAllFolders] DEFAULT ((0)) NOT NULL,
    [FilterShowForms]          BIT            CONSTRAINT [DF_FormUserSetting_FilterShowForms] DEFAULT ((1)) NOT NULL,
    [FilterShowGroups]         BIT            CONSTRAINT [DF_FormUserSetting_FilterShowGroups] DEFAULT ((1)) NOT NULL,
    [OpenInDesignMode]         BIT            CONSTRAINT [DF_FormUserSetting_OpenInDesignMode] DEFAULT ((0)) NOT NULL,
    [PrintJobSortOrder]        VARCHAR (10)   CONSTRAINT [DF_FormUserSetting_PrintJobSortOrder] DEFAULT ('None') NOT NULL,
    [PrintJobSortColumn]       TINYINT        CONSTRAINT [DF_FormUserSetting_PrintJobSortColumn] DEFAULT ((0)) NOT NULL,
    [LUPUser]                  VARCHAR (50)   NULL,
    [LUPDate]                  DATETIME       NULL,
    [CreateUser]               VARCHAR (50)   NULL,
    [CreateDate]               DATETIME       NULL,
    [ClickReOrderDialogHeight] INT            CONSTRAINT [DF_FormUserSetting_ClickReOrderDialogHeight] DEFAULT ((523)) NOT NULL,
    [ClickReOrderDialogWidth]  INT            CONSTRAINT [DF_FormUserSetting_ClickReOrderDialogWidth] DEFAULT ((451)) NOT NULL,
    CONSTRAINT [PK_FormUserSetting] PRIMARY KEY CLUSTERED ([pkFormUserSetting] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkFrameworkUserID]
    ON [dbo].[FormUserSetting]([fkFrameworkUserID] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE Trigger [dbo].[tr_FormUserSettingAudit_UI] On [dbo].[FormUserSetting]
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

Update FormUserSetting
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormUserSetting dbTable
	Inner Join Inserted i on dbtable.pkFormUserSetting = i.pkFormUserSetting
	Left Join Deleted d on d.pkFormUserSetting = d.pkFormUserSetting
	Where d.pkFormUserSetting is null

Update FormUserSetting
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormUserSetting dbTable
	Inner Join Deleted d on dbTable.pkFormUserSetting = d.pkFormUserSetting

--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From FormUserSettingAudit dbTable
Inner Join inserted i ON dbTable.[pkFormUserSetting] = i.[pkFormUserSetting]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormUserSettingAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormUserSetting]
	,[fkFrameworkUserID]
	,[ReturnAddress]
	,[DateFormatMask]
	,[Signature]
	,[SignatureString]
	,[SignatureHeight]
	,[SignatureWidth]
	,[SignatureDPIX]
	,[SignatureDPIY]
	,[fkActiveAutofill]
	,[SignatureDensity]
	,[FilterSearchString]
	,[FilterSearchAllFolders]
	,[FilterShowForms]
	,[FilterShowGroups]
	,[OpenInDesignMode]
	,[PrintJobSortOrder]
	,[PrintJobSortColumn]
	,[ClickReOrderDialogHeight]
	,[ClickReOrderDialogWidth]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkFormUserSetting]
	,[fkFrameworkUserID]
	,[ReturnAddress]
	,[DateFormatMask]
	,null
	,null
	,[SignatureHeight]
	,[SignatureWidth]
	,[SignatureDPIX]
	,[SignatureDPIY]
	,[fkActiveAutofill]
	,[SignatureDensity]
	,[FilterSearchString]
	,[FilterSearchAllFolders]
	,[FilterShowForms]
	,[FilterShowGroups]
	,[OpenInDesignMode]
	,[PrintJobSortOrder]
	,[PrintJobSortColumn]
	,[ClickReOrderDialogHeight]
	,[ClickReOrderDialogWidth]

From  Inserted
GO
CREATE Trigger [dbo].[tr_FormUserSettingAudit_d] On [dbo].[FormUserSetting]
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
From FormUserSettingAudit dbTable
Inner Join deleted d ON dbTable.[pkFormUserSetting] = d.[pkFormUserSetting]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormUserSettingAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormUserSetting]
	,[fkFrameworkUserID]
	,[ReturnAddress]
	,[DateFormatMask]
	,[Signature]
	,[SignatureString]
	,[SignatureHeight]
	,[SignatureWidth]
	,[SignatureDPIX]
	,[SignatureDPIY]
	,[fkActiveAutofill]
	,[SignatureDensity]
	,[FilterSearchString]
	,[FilterSearchAllFolders]
	,[FilterShowForms]
	,[FilterShowGroups]
	,[OpenInDesignMode]
	,[PrintJobSortOrder]
	,[PrintJobSortColumn]
	,[ClickReOrderDialogHeight]
	,[ClickReOrderDialogWidth]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkFormUserSetting]
	,[fkFrameworkUserID]
	,[ReturnAddress]
	,[DateFormatMask]
	,null
	,null
	,[SignatureHeight]
	,[SignatureWidth]
	,[SignatureDPIX]
	,[SignatureDPIY]
	,[fkActiveAutofill]
	,[SignatureDensity]
	,[FilterSearchString]
	,[FilterSearchAllFolders]
	,[FilterShowForms]
	,[FilterShowGroups]
	,[OpenInDesignMode]
	,[PrintJobSortOrder]
	,[PrintJobSortColumn]
	,[ClickReOrderDialogHeight]
	,[ClickReOrderDialogWidth]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Signature for the case worker', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormUserSetting', @level2type = N'COLUMN', @level2name = N'Signature';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'DEPRECATED. String version of the signature', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormUserSetting', @level2type = N'COLUMN', @level2name = N'SignatureString';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Default height of the signature', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormUserSetting', @level2type = N'COLUMN', @level2name = N'SignatureHeight';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Default width of the signature graphic', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormUserSetting', @level2type = N'COLUMN', @level2name = N'SignatureWidth';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Default horizontal resolution of the signature graphic', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormUserSetting', @level2type = N'COLUMN', @level2name = N'SignatureDPIX';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Default vertical resolution of the signature', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormUserSetting', @level2type = N'COLUMN', @level2name = N'SignatureDPIY';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to Active Autofill', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormUserSetting', @level2type = N'COLUMN', @level2name = N'fkActiveAutofill';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The width of the line used on the signature pad', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormUserSetting', @level2type = N'COLUMN', @level2name = N'SignatureDensity';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The Filter fields are related to the "Criteria" box on the bottom of the Forms Preview pane. The filter string to use for displaying forms.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormUserSetting', @level2type = N'COLUMN', @level2name = N'FilterSearchString';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The Filter fields are related to the "Criteria" box on the bottom of the Forms Preview pane. This one indicates whether or not to search all folders, or just the current folder', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormUserSetting', @level2type = N'COLUMN', @level2name = N'FilterSearchAllFolders';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The Filter fields are related to the "Criteria" box on the bottom of the Forms Preview pane. This indicates whether or not to show forms.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormUserSetting', @level2type = N'COLUMN', @level2name = N'FilterShowForms';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The Filter fields are related to the "Criteria" box on the bottom of the Forms Preview pane. This indicates whether or not to show groups.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormUserSetting', @level2type = N'COLUMN', @level2name = N'FilterShowGroups';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This controls whether or not the user has indicated that forms should be opened in DesignMode.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormUserSetting', @level2type = N'COLUMN', @level2name = N'OpenInDesignMode';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Indicates whether to print in ascending or descending order.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormUserSetting', @level2type = N'COLUMN', @level2name = N'PrintJobSortOrder';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Which column should be used to sort the forms when printing.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormUserSetting', @level2type = N'COLUMN', @level2name = N'PrintJobSortColumn';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormUserSetting', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormUserSetting', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormUserSetting', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormUserSetting', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The height of the reorder dialog box', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormUserSetting', @level2type = N'COLUMN', @level2name = N'ClickReOrderDialogHeight';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Width of the reorder dialog box', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormUserSetting', @level2type = N'COLUMN', @level2name = N'ClickReOrderDialogWidth';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table stores the user settings from the settings screen in forms.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormUserSetting';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormUserSetting', @level2type = N'COLUMN', @level2name = N'pkFormUserSetting';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to ApplicationUser', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormUserSetting', @level2type = N'COLUMN', @level2name = N'fkFrameworkUserID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Return address for a form based on the current user (allowing forms printed by different pilot users to have different return addresses).', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormUserSetting', @level2type = N'COLUMN', @level2name = N'ReturnAddress';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date format mask for dates on these forms.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormUserSetting', @level2type = N'COLUMN', @level2name = N'DateFormatMask';

