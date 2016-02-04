CREATE TABLE [dbo].[PSPDocTypeSplitAudit] (
    [pk]                               DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]                   DATETIME      NULL,
    [AuditEndDate]                     DATETIME      NULL,
    [AuditUser]                        VARCHAR (50)  NULL,
    [AuditMachine]                     VARCHAR (15)  NULL,
    [AuditDeleted]                     TINYINT       NULL,
    [pkPSPDocTypeSplit]                DECIMAL (18)  NOT NULL,
    [fkPSPDocType]                     DECIMAL (18)  NOT NULL,
    [SubmitToDMS]                      BIT           NOT NULL,
    [CopyToFolder]                     BIT           NOT NULL,
    [fkKeywordForFolderName]           VARCHAR (50)  NULL,
    [StaticFolderName]                 VARCHAR (100) NULL,
    [CreateDocumentWhenKeywordChanges] DECIMAL (18)  NOT NULL,
    [CreateDocumentEveryXPages]        INT           NOT NULL,
    [CreateXDocuments]                 INT           NOT NULL,
    [Enabled]                          BIT           NOT NULL,
    CONSTRAINT [PK_PSPDocTypeSplitAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkPSPDocTypeSplitAudit]
    ON [dbo].[PSPDocTypeSplitAudit]([pkPSPDocTypeSplit] ASC);

