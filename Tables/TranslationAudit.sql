CREATE TABLE [dbo].[TranslationAudit] (
    [pk]              DECIMAL (18)    IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]  DATETIME        NULL,
    [AuditEndDate]    DATETIME        NULL,
    [AuditUser]       VARCHAR (50)    NULL,
    [AuditMachine]    VARCHAR (15)    NULL,
    [AuditDeleted]    TINYINT         NULL,
    [pkTranslation]   DECIMAL (18)    NOT NULL,
    [fkScreenControl] DECIMAL (18)    NOT NULL,
    [fkLanguage]      DECIMAL (18)    NOT NULL,
    [Description]     VARCHAR (500)   CONSTRAINT [DF__Translati__Descr__31AFA360] DEFAULT ('') NULL,
    [DisplayText]     NVARCHAR (1000) NOT NULL,
    [Context]         VARCHAR (50)    CONSTRAINT [DF__Translati__Conte__32A3C799] DEFAULT ('') NULL,
    [Sequence]        INT             NULL,
    [ItemKey]         VARCHAR (200)   NULL,
    CONSTRAINT [PK_TranslationAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkTranslationAudit]
    ON [dbo].[TranslationAudit]([pkTranslation] ASC);

