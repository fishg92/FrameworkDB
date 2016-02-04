CREATE TABLE [dbo].[FormRenditionAudit] (
    [pk]              DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]  DATETIME     NULL,
    [AuditEndDate]    DATETIME     NULL,
    [AuditUser]       VARCHAR (50) NULL,
    [AuditMachine]    VARCHAR (15) NULL,
    [AuditDeleted]    TINYINT      NULL,
    [pkFormRendition] DECIMAL (18) NOT NULL,
    [fkFormName]      DECIMAL (18) NOT NULL,
    [Finished]        TINYINT      NULL,
    [CaseNumber]      VARCHAR (50) NULL,
    [SSN]             VARCHAR (50) NULL,
    [FirstName]       VARCHAR (50) NULL,
    [LastName]        VARCHAR (50) NULL,
    CONSTRAINT [PK_FormRenditionAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkFormRenditionAudit]
    ON [dbo].[FormRenditionAudit]([pkFormRendition] ASC);

