CREATE TABLE [dbo].[FormUserSettingAudit] (
    [pk]                       DECIMAL (18)   IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]           DATETIME       NULL,
    [AuditEndDate]             DATETIME       NULL,
    [AuditUser]                VARCHAR (50)   NULL,
    [AuditMachine]             VARCHAR (15)   NULL,
    [AuditDeleted]             TINYINT        NULL,
    [pkFormUserSetting]        DECIMAL (18)   NOT NULL,
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
    [AuditEffectiveUser]       VARCHAR (50)   NULL,
    [AuditEffectiveDate]       DATETIME       NULL,
    [FilterSearchString]       VARCHAR (30)   CONSTRAINT [DF__FormUserS__Filte__3382DD39] DEFAULT ('') NULL,
    [FilterSearchAllFolders]   BIT            CONSTRAINT [DF__FormUserS__Filte__34770172] DEFAULT ((0)) NOT NULL,
    [FilterShowForms]          BIT            CONSTRAINT [DF__FormUserS__Filte__356B25AB] DEFAULT ((1)) NOT NULL,
    [FilterShowGroups]         BIT            CONSTRAINT [DF__FormUserS__Filte__365F49E4] DEFAULT ((1)) NOT NULL,
    [OpenInDesignMode]         BIT            CONSTRAINT [DF__FormUserS__OpenI__37536E1D] DEFAULT ((0)) NOT NULL,
    [PrintJobSortOrder]        VARCHAR (10)   CONSTRAINT [DF__FormUserS__Print__38479256] DEFAULT ('None') NULL,
    [PrintJobSortColumn]       TINYINT        CONSTRAINT [DF__FormUserS__Print__393BB68F] DEFAULT ((0)) NOT NULL,
    [ClickReOrderDialogHeight] INT            CONSTRAINT [DF__FormUserS__Click__3A2FDAC8] DEFAULT ((523)) NOT NULL,
    [ClickReOrderDialogWidth]  INT            CONSTRAINT [DF__FormUserS__Click__3B23FF01] DEFAULT ((451)) NOT NULL,
    CONSTRAINT [PK_FormUserSettingAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkFormUserSettingAudit]
    ON [dbo].[FormUserSettingAudit]([pkFormUserSetting] ASC);

