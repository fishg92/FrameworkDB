CREATE TABLE [dbo].[refAnnotationTypeAudit] (
    [pk]                  DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]      DATETIME     NULL,
    [AuditEndDate]        DATETIME     NULL,
    [AuditUser]           VARCHAR (50) NULL,
    [AuditMachine]        VARCHAR (15) NULL,
    [AuditDeleted]        TINYINT      NULL,
    [pkRefAnnotationType] DECIMAL (18) NOT NULL,
    [Name]                VARCHAR (50) NULL,
    CONSTRAINT [PK_refAnnotationTypeAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkrefAnnotationTypeAudit]
    ON [dbo].[refAnnotationTypeAudit]([pkRefAnnotationType] ASC);

