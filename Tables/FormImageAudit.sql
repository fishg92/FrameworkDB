CREATE TABLE [dbo].[FormImageAudit] (
    [pk]             DECIMAL (18)    IDENTITY (1, 1) NOT NULL,
    [AuditStartDate] DATETIME        NULL,
    [AuditEndDate]   DATETIME        NULL,
    [AuditUser]      VARCHAR (50)    NULL,
    [AuditMachine]   VARCHAR (15)    NULL,
    [AuditDeleted]   TINYINT         NULL,
    [pkFormImage]    DECIMAL (18)    NOT NULL,
    [fkFormName]     DECIMAL (18)    NOT NULL,
    [Image]          VARBINARY (MAX) NOT NULL,
    [FileExtension]  VARCHAR (10)    NULL,
    CONSTRAINT [PK_FormImageAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkFormImageAudit]
    ON [dbo].[FormImageAudit]([pkFormImage] ASC);

