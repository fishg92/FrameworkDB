CREATE TABLE [dbo].[AutoPopulateKeywordAudit] (
    [pk]                    DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]        DATETIME     NULL,
    [AuditEndDate]          DATETIME     NULL,
    [AuditUser]             VARCHAR (50) NULL,
    [AuditMachine]          VARCHAR (15) NULL,
    [AuditDeleted]          TINYINT      NULL,
    [pkAutoPopulateKeyword] DECIMAL (18) NOT NULL,
    [fkKeyword]             VARCHAR (50) NULL,
    [ValueID]               SMALLINT     NOT NULL,
    [CanBeOverridden]       BIT          NOT NULL,
    CONSTRAINT [PK_AutoPopulateKeywordAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkAutoPopulateKeywordAudit]
    ON [dbo].[AutoPopulateKeywordAudit]([pkAutoPopulateKeyword] ASC);

