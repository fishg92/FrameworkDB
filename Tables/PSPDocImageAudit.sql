CREATE TABLE [dbo].[PSPDocImageAudit] (
    [pk]             DECIMAL (18)    IDENTITY (1, 1) NOT NULL,
    [AuditStartDate] DATETIME        NULL,
    [AuditEndDate]   DATETIME        NULL,
    [AuditUser]      VARCHAR (50)    NULL,
    [AuditMachine]   VARCHAR (15)    NULL,
    [AuditDeleted]   TINYINT         NULL,
    [pkPSPDocImage]  DECIMAL (18)    NOT NULL,
    [fkPSPDocType]   DECIMAL (18)    NOT NULL,
    [FullImage]      VARBINARY (MAX) NOT NULL,
    CONSTRAINT [PK_PSPDocImageAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkPSPDocImageAudit]
    ON [dbo].[PSPDocImageAudit]([pkPSPDocImage] ASC);

