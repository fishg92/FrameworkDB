CREATE TABLE [dbo].[KeywordTypeDisplaySettingAudit] (
    [pk]                          DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]              DATETIME     NULL,
    [AuditEndDate]                DATETIME     NULL,
    [AuditUser]                   VARCHAR (50) NULL,
    [AuditMachine]                VARCHAR (15) NULL,
    [AuditDeleted]                TINYINT      NULL,
    [pkKeywordTypeDisplaySetting] DECIMAL (18) NOT NULL,
    [fkKeywordType]               VARCHAR (50) NULL,
    [KeywordName]                 VARCHAR (50) NULL,
    [DisplayInResultGrid]         BIT          CONSTRAINT [DF__KeywordTy__Displ__1A380C82] DEFAULT ((0)) NOT NULL,
    [Sequence]                    INT          CONSTRAINT [DF__KeywordTy__Seque__1B2C30BB] DEFAULT ((0)) NOT NULL,
    [IsSearchable]                BIT          CONSTRAINT [DF__KeywordTy__IsSea__1C2054F4] DEFAULT ((1)) NOT NULL,
    [IncludeInExportManifest]     BIT          CONSTRAINT [DF__KeywordTy__Inclu__1D14792D] DEFAULT ((0)) NOT NULL,
    [IsFreeform]                  BIT          CONSTRAINT [DF__KeywordTy__IsFre__1E089D66] DEFAULT ((0)) NOT NULL,
    [fkProfile]                   DECIMAL (18) CONSTRAINT [DF__KeywordTy__fkPro__1EFCC19F] DEFAULT ((-1)) NOT NULL,
    [IsRequiredByPilot]           BIT          CONSTRAINT [DF__KeywordTy__IsReq__1FF0E5D8] DEFAULT ((0)) NOT NULL,
    [IsNotAutoIndexed]            BIT          CONSTRAINT [DF_KeywordTypeDisplaySettingAudit_IsNotAutoIndexed] DEFAULT ((0)) NOT NULL,
    [DocumentNamingSequence]      INT          CONSTRAINT [DF_KeywordTypeDisplaySettingAudit_DocumentNamingSequence] DEFAULT ((-1)) NOT NULL,
    CONSTRAINT [PK_KeywordTypeDisplaySettingAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkKeywordTypeDisplaySettingAudit]
    ON [dbo].[KeywordTypeDisplaySettingAudit]([pkKeywordTypeDisplaySetting] ASC);

