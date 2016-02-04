CREATE TABLE [dbo].[FormImagePageAudit] (
    [pk]              DECIMAL (18)    IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]  DATETIME        NULL,
    [AuditEndDate]    DATETIME        NULL,
    [AuditUser]       VARCHAR (50)    NULL,
    [AuditMachine]    VARCHAR (15)    NULL,
    [AuditDeleted]    TINYINT         NULL,
    [pkFormImagePage] DECIMAL (18)    NOT NULL,
    [fkFormName]      DECIMAL (18)    NOT NULL,
    [PageNumber]      INT             NOT NULL,
    [ImageData]       VARBINARY (MAX) NOT NULL,
    [FileExtension]   VARCHAR (50)    NULL,
    CONSTRAINT [PK_FormImagePageAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkFormImagePageAudit]
    ON [dbo].[FormImagePageAudit]([pkFormImagePage] ASC);

