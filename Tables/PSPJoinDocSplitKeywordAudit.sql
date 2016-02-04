CREATE TABLE [dbo].[PSPJoinDocSplitKeywordAudit] (
    [pk]                       DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]           DATETIME     NULL,
    [AuditEndDate]             DATETIME     NULL,
    [AuditUser]                VARCHAR (50) NULL,
    [AuditMachine]             VARCHAR (15) NULL,
    [AuditDeleted]             TINYINT      NULL,
    [pkPSPJoinDocSplitKeyword] DECIMAL (18) NOT NULL,
    [fkPSPDocSplit]            DECIMAL (18) NOT NULL,
    [fkPSPKeyword]             DECIMAL (18) NOT NULL,
    CONSTRAINT [PK_PSPJoinDocSplitKeywordAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkPSPJoinDocSplitKeywordAudit]
    ON [dbo].[PSPJoinDocSplitKeywordAudit]([pkPSPJoinDocSplitKeyword] ASC);

