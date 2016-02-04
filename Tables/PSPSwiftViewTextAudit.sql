CREATE TABLE [dbo].[PSPSwiftViewTextAudit] (
    [pk]                 DECIMAL (18)   IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]     DATETIME       NULL,
    [AuditEndDate]       DATETIME       NULL,
    [AuditUser]          VARCHAR (50)   NULL,
    [AuditMachine]       VARCHAR (15)   NULL,
    [AuditDeleted]       TINYINT        NULL,
    [pkPSPSwiftViewText] DECIMAL (18)   NOT NULL,
    [SwiftViewText]      VARCHAR (100)  NULL,
    [PageNumber]         INT            NULL,
    [Xpos]               DECIMAL (9, 3) NULL,
    [Ypos]               DECIMAL (9, 3) NULL,
    [fkPSPDocument]      DECIMAL (18)   NULL,
    CONSTRAINT [PK_PSPSwiftViewTextAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkPSPSwiftViewTextAudit]
    ON [dbo].[PSPSwiftViewTextAudit]([pkPSPSwiftViewText] ASC);

