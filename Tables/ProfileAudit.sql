CREATE TABLE [dbo].[ProfileAudit] (
    [pk]                          DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]              DATETIME      NULL,
    [AuditEndDate]                DATETIME      NULL,
    [AuditUser]                   VARCHAR (50)  NULL,
    [AuditMachine]                VARCHAR (15)  NULL,
    [AuditDeleted]                TINYINT       NULL,
    [pkProfile]                   DECIMAL (18)  NOT NULL,
    [Description]                 VARCHAR (100) NULL,
    [LongDescription]             VARCHAR (255) NULL,
    [fkrefTaskOrigin]             DECIMAL (18)  CONSTRAINT [DF_ProfileAudit_fkrefTaskOrigin] DEFAULT ((-1)) NOT NULL,
    [RecipientMappingKeywordType] VARCHAR (50)  CONSTRAINT [DF_ProfileAudit_RecipientMappingKeywordType] DEFAULT ('') NOT NULL,
    [SendDocumentToWorkflow]      BIT           CONSTRAINT [DF__ProfileAu__SendD__5B70D302] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_ProfileAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkProfileAudit]
    ON [dbo].[ProfileAudit]([pkProfile] ASC);

